// Taxi:
IsPlayerInsideTaxi(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);

	if (GetVehicleModel(vehicleid) == 420 || GetVehicleModel(vehicleid) == 438)
	{
	    foreach (new i : Player)
		{
			if ((i != playerid) && (PlayerInfo[i][E_CHARACTER_JOBS] == JOB_TAXI && PlayerInfo[i][E_CHARACTER_TAXIDUTY] && GetPlayerState(i) == PLAYER_STATE_DRIVER) && GetPlayerVehicleID(i) == vehicleid)
				return 1;
		}
	}
	return 0;
}

stock Taxi_ShowCalls(playerid)
{
    static
	    string[2048];

	string[0] = 0;

	foreach (new i : Player) if (PlayerInfo[i][E_CHARACTER_TAXICALLED]) {
	    format(string, sizeof(string), "%s%d: %s\t%s\t%s\n", string, i, ReturnName(i, playerid), ReturnLocation(i), ReturnLocationStreet(i));
	}
	if (!strlen(string)) {
	    SendErrorMessage(playerid, "There are no taxi calls to accept.");
	}
	else Dialog_Show(playerid, DialogAcceptTaxi, DIALOG_STYLE_TABLIST, "Taxi Calls:", string, "Accept", "Cancel");
	return 1;
}

stock LeaveTaxi(playerid, driverid)
{
	if (driverid != INVALID_PLAYER_ID && IsPlayerConnected(driverid))
	{
	    GiveMoney(playerid, -PlayerInfo[playerid][E_CHARACTER_TAXIFARE]);
   		GiveMoney(driverid, PlayerInfo[playerid][E_CHARACTER_TAXIFARE]);

        SendJobsMessage(driverid, "[Taxi] %s has exit your taxi and paid $%s.", ReturnName(playerid, driverid), FormatMoney(PlayerInfo[playerid][E_CHARACTER_TAXIFARE]));
		SendNearbyMessage(playerid, 30.0, COLOR_EMOTE, "** %s has paid $%s to the taxi driver.", ReturnName(playerid, driverid), FormatMoney(PlayerInfo[playerid][E_CHARACTER_TAXIFARE]));

	    PlayerInfo[playerid][E_CHARACTER_TAXIFARE] = 0;
	    PlayerInfo[playerid][E_CHARACTER_TAXITIMER] = 0;
	    PlayerInfo[playerid][E_CHARACTER_TAXIPLAYER] = INVALID_PLAYER_ID;
	}
	return 1;
}

function:OnPlayerTaxiUpdate()
{
    foreach(new i : Player)
    {
        if (IsPlayerInsideTaxi(i))
		{
		    PlayerInfo[i][E_CHARACTER_TAXITIMER]++;

		    if (PlayerInfo[i][E_CHARACTER_TAXITIMER] == 10)
		    {
		        PlayerInfo[i][E_CHARACTER_TAXITIMER] = 0;
		        PlayerInfo[i][E_CHARACTER_TAXIFARE] += PlayerInfo[i][E_CHARACTER_DRIVERFARE];
		    }
            new str[64];
		    format(str, sizeof(str), "~y~Taxi Fare: ~g~$%d", PlayerInfo[i][E_CHARACTER_DRIVERFARE]);
            ShowBoxMessage(i, str, 5);
            ShowBoxMessage(GetVehicleDriver(GetPlayerVehicleID(i)), str, 5);
		}
    }
	return 1;
}

CMD:setfare(playerid, params[])
{
	new Float:value;
	new vehicleid = GetPlayerVehicleID(playerid);
    
    if (sscanf(params, "f", value))
	{
		SendUsageMessage(playerid, "/setfare [amount]");
		SendTipMessage(playerid, "Taxi price range maximum {33AA33}$2.50{cdcdcd} and minimum {33AA33}$1.00{cdcdcd}.");
        return 1;
	}

	if (PlayerInfo[playerid][E_CHARACTER_JOBS] != JOB_TAXI)
	    return SendErrorMessage(playerid, "You don't have the appropriate job.");

	if (!PlayerInfo[playerid][E_CHARACTER_TAXIDUTY])
	    return SendErrorMessage(playerid, "You must be on taxi duty to accept calls.");

	if(!IsPlayerInAnyVehicle(playerid) && GetVehicleModel(vehicleid) == 420 || GetVehicleModel(vehicleid) == 438)
		return SendErrorMessage(playerid, "You aren't inside vehicle.");

	if (value < 1.00 || value > 2.50)
        return SendErrorMessage(playerid, "Your taxi fare cannot be less than $1.00 or more than $2.50");

	new Cents = floatround(value * 100, floatround_round);

    PlayerInfo[playerid][E_CHARACTER_DRIVERFARE] = Cents;
	SendJobsMessage(playerid, "[Taxi] You has set your taxi fare to $%s.", FormatMoney(Cents));
	return 1;
}

CMD:taxicall(playerid, params[])
{
    if (PlayerInfo[playerid][E_CHARACTER_JOBS] != JOB_TAXI)
	    return SendErrorMessage(playerid, "You don't have the appropriate job.");

	if (!PlayerInfo[playerid][E_CHARACTER_TAXIDUTY])
	    return SendErrorMessage(playerid, "You must be on taxi duty to accept calls.");

	if(PlayerInfo[playerid][E_CHARACTER_HUNGRY] < 20 )
		return SendErrorMessage(playerid, "You're hungry or thirsty right now.");

	Taxi_ShowCalls(playerid);
	return 1;
}

Dialog:DialogAcceptTaxi(playerid, response, listitem, inputtext[])
{
	if (response)
	{
		new targetid = strval(inputtext);

		if (!IsPlayerConnected(targetid))
			return SendErrorMessage(playerid, "The specified player has disconnected.");

		if (!PlayerInfo[targetid][E_CHARACTER_TAXICALLED])
			return SendErrorMessage(playerid, "That player's call was accepted by another taxi driver.");

		if(PlayerInfo[playerid][E_CHARACTER_HUNGRY] < 20)
			return SendErrorMessage(playerid, "You're hungry or thirsty right now.");

		static
			Float:x,
			Float:y,
			Float:z;

		GetPlayerPos(targetid, x, y, z);

		PlayerInfo[targetid][E_CHARACTER_TAXICALLED] = 0;
		GPS_SetPlayerRaceCheckPoint(playerid, 1, x, y, z, 0.0, 0.0, 0.0);

		SendJobsMessage(playerid, "[Taxi] You have accepted %s's taxi call.", ReturnName(targetid));
		SendJobsMessage(targetid, "[Taxi] %s has accepted your taxi call and is on their way.", ReturnName(playerid, targetid));
	}
	return 1;
}