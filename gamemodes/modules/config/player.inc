
//Function
function:SetPlayerCamera(playerid)
{
    new rand = randomEx(1, 3);

	switch(rand)
	{
		case 1:
		{
			InterpolateCameraPos(playerid, 1368.013671, -949.489013, 35.609745, 1368.013671, -949.489013, 82.879753, 15000, 1);
			InterpolateCameraLookAt(playerid, 1369.147827, -945.724914, 36.348087, 1369.125000, -945.677185, 83.364494, 15000, 1);
		}
		case 2:
		{
			InterpolateCameraPos(playerid, 231.056640, -1864.201293, 34.755920, 231.056640, -1864.201293, 34.755920, 3000, 1);
			InterpolateCameraLookAt(playerid, 228.553604, -1867.319580, 34.651535, 228.490478, -1867.267089, 34.631008, 3000, 1);
		}
		case 3:
		{
			InterpolateCameraPos(playerid, 1631.904907, -1159.781616, 138.438232, 1602.145507, -1518.966308, 98.418022, 15000, 1);
			InterpolateCameraLookAt(playerid, 1631.338500, -1163.728759, 138.123687, 1601.992065, -1522.941528, 98.001243, 15000, 1);
		}
	}
	return 1;
}

function:OnOfflineAjail(playerid, jailing[], reason[], length)
{
	SendInfoMessage(playerid, "[JAIL] %s was successfully admin jailed.", jailing); 
	
	new
		logQuery[256]
	;
	
	mysql_format(ourConnection, logQuery, sizeof(logQuery), "INSERT INTO ajail_logs (JailedDBID, JailedName, Reason, Date, JailedBy) VALUES(%i, '%e', '%e', '%e', '%e')", ReturnDBIDFromName(jailing), jailing, reason, ReturnDate(), ReturnName(playerid));
	mysql_pquery(ourConnection, logQuery); 
	return 1;
}

function:OnOfflineBan(playerid, banning[], dbid, masterdbid, reason[], date[])
{
	SendInfoMessage(playerid, "[BANNED] %s was successfully banned.", banning);
	
	new
		logQuery[256]
	;
	
	mysql_format(ourConnection, logQuery, sizeof(logQuery), "INSERT INTO ban_logs (CharacterDBID, MasterDBID, CharacterName, Reason, BannedBy, Date) VALUES(%i, %i, '%e', '%e', '%e', '%e')",
		dbid, masterdbid, banning, reason, date);
		
	mysql_pquery(ourConnection, logQuery);
	return 1;
}

stock RespawnPlayer(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
        new
		    Float:x,
		    Float:y,
	    	Float:z;

	    GetPlayerPos(playerid, x, y, z);
	    SetPlayerPos(playerid, x, y, z + 1);
	}
	SpawnPlayer(playerid);
	SetPlayersSpawn(playerid);
	return 1;
}

function:SetPlayersSpawn(playerid)
{
	if(PlayerInfo[playerid][E_CHARACTER_SPAWNPOINT] == SPAWN_POINT_LAST)
	{
		SetPlayerPosEx(playerid, PlayerInfo[playerid][E_CHARACTER_LASTPOS][0], PlayerInfo[playerid][E_CHARACTER_LASTPOS][1], PlayerInfo[playerid][E_CHARACTER_LASTPOS][2]);
		SetPlayerInteriorEx(playerid, PlayerInfo[playerid][E_CHARACTER_LASTINTERIOR]);
		SetPlayerVirtualWorldEx(playerid, PlayerInfo[playerid][E_CHARACTER_LASTWORLD]);
	}
	else
	{
		SetPlayerPosEx(playerid, BusStop_Index[PlayerInfo[playerid][E_CHARACTER_SPAWNPOINT]][0], BusStop_Index[PlayerInfo[playerid][E_CHARACTER_SPAWNPOINT]][1], BusStop_Index[PlayerInfo[playerid][E_CHARACTER_SPAWNPOINT]][2]);
		SetPlayerInteriorEx(playerid, 0);
		SetPlayerVirtualWorldEx(playerid, 0);
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerInfo[playerid][E_CHARACTER_ADMINDUTY])
	{
    	new vehicleid = GetPlayerVehicleID(playerid);
        if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            SetVehiclePos(vehicleid, fX, fY, fZ+10);
        }
        else
        {
            SetPlayerPosFindZ(playerid, fX, fY, fZ+10);
        }
    }

	new vehicleid = GetPlayerVehicleID(playerid);
	new playerb = GetVehicleDriver(vehicleid);
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{
		if(PlayerInfo[playerb][E_CHARACTER_TAXIDUTY])
		{
			GPS_SetPlayerRaceCheckPoint(playerb, 1, fX, fY, fZ, 0.0, 0.0, 0.0);
			SendJobsMessage(playerid, "[Taxi] You has marked destination in driver map!");
			SendJobsMessage(playerb, "[Taxi] Passanger has marked the destination in your map!");
		}
	}
    return 1;
}

function:Float:GetDistanceBetweenPoints(Float:rx1,Float:ry1,Float:rz1,Float:rx2,Float:ry2,Float:rz2)
{
	return floatadd(floatadd(floatsqroot(floatpower(floatsub(rx1,rx2),2)),floatsqroot(floatpower(floatsub(ry1,ry2),2))),floatsqroot(floatpower(floatsub(rz1,rz2),2)));
}

function:OnAjailRecord(playerid)
{
	if(!cache_num_rows())
		return SendErrorMessage(playerid, "This player hasn't been admin jailed.");
	
	new rows, fields;
	cache_get_row_count(rows);
	cache_get_field_count(fields);
	
	new
		JailedName[32], 
		Reason[128],
		Date[90],
		JailedBy[32],
		Time
	;
	
	for(new i = 0; i < rows; i++)
	{
		cache_get_value_name(i, "JailedName", JailedName, 32); 
		cache_get_value_name(i, "Reason", Reason, 128);
		
		cache_get_value_name(i, "Date", Date, 90);
		cache_get_value_name(i, "JailedBy", JailedBy, 32); 
		
		cache_get_value_name_int(i, "Time", Time); 
		
		SendInfoMessage(playerid, "[JAIL] [%s] %s was admin jailed by %s for %d minutes, Reason: %d", Date, JailedName, JailedBy, Time, Reason);
	}
		
	return 1;
}

function:KickTimer(playerid) { return Kick(playerid); }

ResetVarInventory(playerid)
{
	PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = INVENTORY_NONE;
	PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] = 0;
	PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] = AMMO_TYPE_NONE;
	RemovePlayerAttachedObject(playerid, ATTACH_HAND);
	RemovePlayerAttachedObject(playerid, ATTACH_HAND2);
	RemovePlayerAttachedObject(playerid, ATTACH_CARGO);
	RemovePlayerAttachedObject(playerid, ATTACH_WEAPONS);
	RemovePlayerAttachedObject(playerid, ATTACH_WEAPONS2);
	ResetPlayerWeapons(playerid);
	
	CancelSelectTextDraw(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}
function:ResetPlayer(playerid)
{
	for (new i = 0; i < MAX_LISTED_ITEMS; i ++) {
	    NearestItems[playerid][i] = -1;
	}

	for (new i = 0; i < 4; i ++) {
	    characterLister[playerid][i][0] = 0;
	}

	for (new i = 0; i != MAX_INVENTORY; i ++) {
	    InventoryInfo[playerid][i][E_INVENTORY_EXISTS] = false;
	    InventoryInfo[playerid][i][E_INVENTORY_MODEL] = 0;
	    InventoryInfo[playerid][i][E_INVENTORY_QUANTITY] = 0;
	}
	for (new i = 0; i != MAX_CONTACTS; i ++) {
	    ContactInfo[playerid][i][E_CONTACT_EXISTS] = false;
	    ContactInfo[playerid][i][E_CONTACT_DBID] = 0;
	    ContactInfo[playerid][i][E_CONTACT_NUMBER] = 0;
	    ListedContacts[playerid][i] = -1;
	}
	
	for (new i = 0; i != MAX_TICKETS; i ++) {
	    TicketInfo[playerid][i][E_TICKET_DBID] = 0;
		TicketInfo[playerid][i][E_TICKET_EXISTS] = false;
		TicketInfo[playerid][i][E_TICKET_FEE] = 0;
	}

	for(new i; i < 4; i++)
	{
		format(characterLister[playerid][i], 128, "");
		characterSkin[playerid][i] = 0;
		characterFaction[playerid][i] = 0;
	}
	for (new i = 0; i < sizeof(ReportInfo); i ++)
	{
		if(ReportInfo[i][E_REPORT_BY] == playerid)
		{
			ReportInfo[i][E_REPORT_EXISTS] = false; 
			ReportInfo[i][E_REPORT_BY] = INVALID_PLAYER_ID;
		}
	}

	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++) { 
		PlayerInfo[playerid][E_CHARACTER_OWNEDVEHICLE][i] = 0; 
	}

	
	
	//Anticheat
	CurrentHealthVar[playerid] = 0;
	CurrentArmourVar[playerid] = 0;
	KillTimer(playerRefillTimer[playerid]);
	playerRefillingVehicle[playerid] = false; 
	KillTimer(PlayerEngineTimer[playerid]);
	PlayerEngineValue[playerid] = 0;
	ResetPlayerJump(playerid);
	ResetTeleportAC(playerid);

	ResetDealershipVars(playerid);
	DestroyVehicle(DealershipPlayerCar[playerid]);

	HeaderBar[playerid] = INVALID_PLAYER_BAR_ID;
	HEBAR[0][playerid] = INVALID_PLAYER_BAR_ID;
	
	//Master accounts:
	AccountInfo[playerid][E_MASTERS_DBID] = 0;
	AccountInfo[playerid][E_MASTERS_LOGGED] = false; 
	
	playerLogin[playerid] = 0; 
	playerMakingCharacter[playerid] = false;
	playerCharacterStep[playerid] = 0;
	
	//Prevents;
	loginTime[playerid] = 0;
	registerTime[playerid] = 0;
	characterPickTime[playerid] = 0;
	
	ResetDealershipVars(playerid);
	ClearDamages(playerid);
	
	playerPhone[playerid] = 0;
	
	format(PlayerInfo[playerid][E_CHARACTER_MDCPLAYER], 32, "");
	
	//Player characters:
	PlayerInfo[playerid][E_CHARACTER_DBID] = 0; 
	PlayerInfo[playerid][E_CHARACTER_ADMIN] = 0;
	PlayerInfo[playerid][E_CHARACTER_ADMINDUTY] = false; 
	
	PlayerInfo[playerid][E_CHARACTER_PHONEOFF] = false; 
	PlayerInfo[playerid][E_CHARACTER_PHONESPEAKER] = false; 
	PlayerInfo[playerid][E_CHARACTER_CALL] = 0;
	PlayerInfo[playerid][E_CHARACTER_PHONELINE] = INVALID_PLAYER_ID;

	PlayerInfo[playerid][E_CHARACTER_SPECTATE] = INVALID_PLAYER_ID;

	PlayerInfo[playerid][E_CHARACTER_PRISON] = 0;
	PlayerInfo[playerid][E_CHARACTER_PRISONED] = false;
	PlayerInfo[playerid][E_CHARACTER_ADMINJAIL] = 0;
	PlayerInfo[playerid][E_CHARACTER_ADMINJAILED] = false;

	PlayerInfo[playerid][E_CHARACTER_FACTION] = 0;
	PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] = 0;
	PlayerInfo[playerid][E_CHARACTER_FACTIONINVITE] = 0;
	PlayerInfo[playerid][E_CHARACTER_FACTIONINVITED] = INVALID_PLAYER_ID;

	PlayerInfo[playerid][E_CHARACTER_TAXICALLED] = 0;
	PlayerInfo[playerid][E_CHARACTER_TAXIFARE] = 0;
	PlayerInfo[playerid][E_CHARACTER_TAXITIMER] = 0;
	PlayerInfo[playerid][E_CHARACTER_TAXIPLAYER] = INVALID_PLAYER_ID;

	PlayerInfo[playerid][E_CHARACTER_VEHICLESPAWNED] = false;
	PlayerInfo[playerid][E_CHARACTER_VEHICLESPAWN] = INVALID_VEHICLE_ID;
	PlayerInfo[playerid][E_CHARACTER_DUPLICATEKEY] = INVALID_VEHICLE_ID;

	PlayerInfo[playerid][E_CHARACTER_POLICEDUTY] = false;
	PlayerInfo[playerid][E_CHARACTER_MEDICDUTY] = false;
	PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
	PlayerInfo[playerid][E_CHARACTER_TIMEPLAYED] = 0;

	PlayerInfo[playerid][E_CHARACTER_LOOPANIM] = 0;

	PlayerInfo[playerid][E_CHARACTER_DRINKING] = 0;

	PlayerInfo[playerid][E_CHARACTER_TARGET] = 0;
	PlayerInfo[playerid][E_CHARACTER_LISTITEM] = 0;
	PlayerInfo[playerid][E_CHARACTER_STORAGESELECT] = 0;
	PlayerInfo[playerid][E_CHARACTER_STORAGEITEM] = 0;

	PlayerInfo[playerid][E_CHARACTER_LASTDAMAGE] = 0;
	
	PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
	PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
	PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
	PlayerInfo[playerid][E_CHARACTER_OBJECTAMOUNT] = 0;
	PlayerInfo[playerid][E_CHARACTER_ADDOBJECT] = INVALID_OBJECT_ID;
	PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0;
	
	PlayerInfo[playerid][E_CHARACTER_SELECTITEMS] = 0;
	
	PlayerInfo[playerid][E_CHARACTER_RESPAWNTIME] = 0;
	PlayerInfo[playerid][E_CHARACTER_DRINKCD] = 0;
	PlayerInfo[playerid][E_CHARACTER_DRUGSCD] = 0;

	PlayerInfo[playerid][E_CHARACTER_SPAWNPOINT] = 0; 

	PlayerInfo[playerid][E_CHARACTER_ACTIVELIST] = 0;

	PlayerMenuSelection[playerid] = -1;
	PlayerHasMenuSelection[playerid] = 0;
	PlayerLastMenuSelectionTick[playerid] = GetTickCount();

	PlayerInfo[playerid][E_CHARACTER_SELECTCHAR] = -1;
	PlayerInfo[playerid][E_CHARACTER_HASROBBIZ] = false;
	PlayerInfo[playerid][E_CHARACTER_ROBBERYACTOR] = -1;
	PlayerInfo[playerid][E_CHARACTER_HASROBBERY] = -1;
	PlayerInfo[playerid][E_CHARACTER_PURCHASE] = 0;
	PlayerInfo[playerid][E_CHARACTER_FISHING] = false;
	PlayerInfo[playerid][E_CHARACTER_LOADINGCOUNT] = 0;
	PlayerInfo[playerid][E_CHARACTER_LOADINGTIMER] = false;
	PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] = 0;
	PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = INVENTORY_NONE;
	PlayerInfo[playerid][E_CHARACTER_TEMPMODEL] = 0;
	PlayerInfo[playerid][E_CHARACTER_EXTORTION] = false;
	PlayerInfo[playerid][E_CHARACTER_EXTORTIONID] = 0;
	PlayerInfo[playerid][E_CHARACTER_EXTORTIONPOINT] = 0;

	PlayerInfo[playerid][E_CHARACTER_TOGPHONE] = true;
	PlayerInfo[playerid][E_CHARACTER_TOGALPR] = true;

	pCBugging[playerid] = false;
	KillTimer(ptmCBugFreezeOver[playerid]);
	ptsLastFiredWeapon[playerid] = 0;

	//Offer
	PlayerInfo[playerid][E_CHARACTER_FRISKOFFER] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][E_CHARACTER_SHAKEOFFER] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][E_CHARACTER_PROPOFFER] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][E_CHARACTER_BIZOFFER] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][E_CHARACTER_SELLOFFER] = INVALID_PLAYER_ID;
	PlayerInfo[playerid][E_CHARACTER_SHAKETYPE] = 0;
	PlayerInfo[playerid][E_CHARACTER_PROPOFFERID] = 0;
	PlayerInfo[playerid][E_CHARACTER_BIZOFFERID] = 0;
	PlayerInfo[playerid][E_CHARACTER_PRICEOFFER] = 0;
	PlayerInfo[playerid][E_CHARACTER_SELLVOFFER] = 0;

	PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE] = INVALID_VEHICLE_ID;

	KillTimer(PlayerEngineTimer[playerid]);
	KillTimer(PlayerTimerGym[playerid]);
	KillTimer(PlayerTimerUsingGym[playerid]);
	KillTimer(playerPhone[playerid]);
	KillTimer(playerText[playerid]);
	KillTimer(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_LOADINGTIMER]);

	PlayerInfo[playerid][E_CHARACTER_LOADING] = false;
    PlayerInfo[playerid][E_CHARACTER_LOADINGCOUNT] = 0;
	PlayerInfo[playerid][E_CHARACTER_SPAWNED] = false;
	AccountInfo[playerid][E_MASTERS_LOGGED] = false;

    Delete3DTextLabel(PlayerInfo[playerid][E_CHARACTER_LOADINGDISPLAY]); 
    KillTimer(PlayerInfo[playerid][E_CHARACTER_LOADINGTIMER]);
	ResetPlayerJump(playerid);

	PlayerInfo[playerid][E_CHARACTER_COURT] = 0;
	PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
    PlayerInfo[playerid][E_CHARACTER_ANIMBALL] = 0;
	PlayerInfo[playerid][E_CHARACTER_COURTTEAM] = 0;
    if(PlayerInfo[playerid][E_CHARACTER_HAVEBALL]) CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALLER] = 999;
	
    PlayerGymMachine[playerid] = -1;
    PlayerPointGym[playerid] = 0;  
    PlayerUsingGym[playerid] = false;

	PlayerInfo[playerid][E_CHARACTER_TOGMENU] = false;
	PlayerInfo[playerid][E_CHARACTER_TOGADMIN] = false;
	PlayerInfo[playerid][E_CHARACTER_TOGHUD] = false;
	PlayerInfo[playerid][E_CHARACTER_TOGJOIN] = false;
	PlayerInfo[playerid][E_CHARACTER_TOGFMS] = false;
	PlayerInfo[playerid][E_CHARACTER_TOGDMS] = false;
	PlayerInfo[playerid][E_CHARACTER_TOGPMS] = false;
	PlayerInfo[playerid][E_CHARACTER_TOGDD] = false;
	PlayerInfo[playerid][E_CHARACTER_TOGTIPS] = false;

	PlayerInfo[playerid][E_CHARACTER_DIEUNKNOWN] = false;

	PlayerInfo[playerid][E_CHARACTER_AFK] = 0;
    PlayerInfo[playerid][E_CHARACTER_AFKTIME] = 0;

    PlayerInfo[playerid][E_CHARACTER_GARBAGEMAN] = false;
	PlayerInfo[playerid][E_CHARACTER_DOCKSWORK] = false;
	PlayerInfo[playerid][E_CHARACTER_BUSDRIVER] = false;
	PlayerInfo[playerid][E_CHARACTER_SWEEPER] = false;
	PlayerInfo[playerid][E_CHARACTER_GARBAGEMAN_VALUE] = 0;

	PlayerInfo[playerid][E_CHARACTER_TUTORIALSTEP] = 0;
	ResetLotteryVar(playerid);
	ResetBlackjack(playerid);

	PlayerInfo[playerid][E_CHARACTER_COURT] = 0;
	PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
    PlayerInfo[playerid][E_CHARACTER_ANIMBALL] = 0;
	PlayerInfo[playerid][E_CHARACTER_COURTTEAM] = 0;
    if(PlayerInfo[playerid][E_CHARACTER_HAVEBALL]) Court_Refresh(PlayerInfo[playerid][E_CHARACTER_COURT]);
	return 1;
}

//Stock functions:

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock IsValidRoleplayName(const name[]) {
	if (!name[0] || strfind(name, "_") == -1)
	    return 0;

	else for (new i = 0, len = strlen(name); i != len; i ++) {
	    if ((i == 0) && (name[i] < 'A' || name[i] > 'Z'))
	        return 0;

		else if ((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z'))
		    return 0;

		else if ((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.')
		    return 0;
	}
	return 1;
}

stock KickEx(playerid)
{
	SetTimerEx("KickTimer", 100, false, "i", playerid);
	return 1;
}

stock ClearLines(playerid, lines)
{
	if (lines > 20 || lines < 1)
		return 0;
		
	for (new i = 0; i < lines; i++)
	{
		SendClientMessage(playerid, -1, " ");
	}
	return 1;
}

stock ShowIDCARD(playerid, playerb)
{
	new gender[10], 
	drivelic[3], weaponlic[3], truckerlic[3];


	if(PlayerInfo[playerb][E_CHARACTER_GENDER] == 1)
	{
		format(gender, 10, "Male");
	}
	else if(PlayerInfo[playerb][E_CHARACTER_GENDER] == 2)
	{
		format(gender, 10, "Female");
	}

	if(PlayerInfo[playerb][E_CHARACTER_DRIVELICENSE] == 1)
	{
		format(drivelic, 10, "Yes");
	}
	else
	{
		format(drivelic, 10, "No");
	}

	if(PlayerInfo[playerb][E_CHARACTER_WEAPLICENSE] == 1)
	{
		format(weaponlic, 10, "Yes");
	}
	else
	{
		format(weaponlic, 10, "No");
	}

	if(PlayerInfo[playerb][E_CHARACTER_TRUCKERLICENSE] == 1)
	{
		format(truckerlic, 10, "Yes");
	}
	else
	{
		format(truckerlic, 10, "No");
	}

	SendClientMessage(playerid, COLOR_GREEN, "|__________ SAN ANDREAS IDENTIFICATION ");
	SendClientMessageEx(playerid, 0xA37EBEFF, "[Social Security Number]: {FFFFFF}SA-%d", PlayerInfo[playerb][E_CHARACTER_DBID]);
	SendClientMessageEx(playerid, 0x98D988FF, "[Fullname]: {FFFFFF}%s_%s", ReturnFirstName(playerb), ReturnLastName(playerb));
	SendClientMessageEx(playerid, 0xD39483FF, "[Sex]: {FFFFFF}%s", gender);
	SendClientMessageEx(playerid, 0x88D9D8FF, "[Age]: {FFFFFF}%s", PlayerInfo[playerb][E_CHARACTER_AGE]);
	SendClientMessageEx(playerid, 0xD9C388FF, "[Ethnic]: {FFFFFF}%s", PlayerInfo[playerb][E_CHARACTER_ETHNIC]);
	if(ReturnFactionType(playerid) == FACTION_TYPE_POLICE)
	{
		SendClientMessage(playerid, COLOR_GREEN, "|______ MOBILE DATA COMPUTER PRINT OUT ______|");
		SendClientMessageEx(playerid, 0x3A84C4FF, "[Driving License]: {FFFFFF} %s", drivelic);
		SendClientMessageEx(playerid, 0x3A84C4FF, "[Trucker License]: {FFFFFF} %s", truckerlic);	
		SendClientMessageEx(playerid, 0x3A84C4FF, "[Weapons License]: {FFFFFF} %s", weaponlic);
	}
	return 1;
}

stock ShowCharacterStats(playerid, playerb)
{
	new 
		duplicate_key[20],
		business_key[20] = "None",
		gender[20];

	if(PlayerInfo[playerid][E_CHARACTER_GENDER] == 1) format(gender, 20, "Male");
	else if(PlayerInfo[playerid][E_CHARACTER_GENDER] == 2) format(gender, 20, "Female");
	else format(gender, 20, "Unknown");
	
	if(PlayerInfo[playerid][E_CHARACTER_DUPLICATEKEY] == INVALID_VEHICLE_ID)
		duplicate_key = "None";
	else format(duplicate_key, 32, "%d", PlayerInfo[playerid][E_CHARACTER_DUPLICATEKEY]); 
	
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(!BusinessInfo[i][E_BUSINESS_DBID])
			continue;
			
		if(BusinessInfo[i][E_BUSINESS_OWNERDBID] == PlayerInfo[playerid][E_CHARACTER_DBID])
			format(business_key, 20, "%d", BusinessInfo[i][E_BUSINESS_DBID]); 
	}
	
	SendClientMessageEx(playerid, COLOR_GREEN, "|__________ (%d) %s Statistics __________|", playerid, ReturnMixedName(playerid));
	SendClientMessageEx(playerid, 0xA37EBEFF, "[ACCOUNT]:{ffffff} [Characters: %s] - [Account: %s] - [Date: %s]\n", ReturnName(playerid), AccountInfo[playerid][E_MASTERS_ACCNAME], ReturnDate());
	SendClientMessageEx(playerid, 0x98D988FF, "[PREMIUM]:{ffffff} [VIP: %s] - [Time: %d]\n", ReturnVIPLevel(playerid), AccountInfo[playerid][E_MASTERS_VIPTIMER]);		
	SendClientMessageEx(playerid, 0xD39483FF, "[PLAYERS]:{ffffff} [Health: %0.1f/%0.1f] - [Armour: %0.1f/100]\n", PlayerInfo[playerid][E_CHARACTER_HEALTH], PlayerInfo[playerid][E_CHARACTER_MAXHEALTH], PlayerInfo[playerid][E_CHARACTER_ARMOUR]);	
	SendClientMessageEx(playerid, 0x88D9D8FF, "[SESSION]:{ffffff} [Gender: %s] [Level: %d] [EXP: %d/10] [Time played: %d hours]\n", gender, PlayerInfo[playerid][E_CHARACTER_LEVEL], PlayerInfo[playerid][E_CHARACTER_EXP], PlayerInfo[playerid][E_CHARACTER_TIMEPLAYED]);
	SendClientMessageEx(playerid, 0xD9C388FF, "[FINANCIAL]:{ffffff} [Cash Hand: $%s] [Cash Bank: $%s] [Paycheck: $%s]\n", FormatMoney(PlayerInfo[playerid][E_CHARACTER_MONEY]), FormatMoney(PlayerInfo[playerid][E_CHARACTER_BANK]), FormatMoney(PlayerInfo[playerid][E_CHARACTER_PAYCHECK]));
	SendClientMessageEx(playerid, 0xA37EBEFF, "[JOBS]:{ffffff} [Jobs: %s] [Skills: %s]\n", ReturnJobName(PlayerInfo[playerid][E_CHARACTER_JOBS]), ReturnJobSkill(playerid, PlayerInfo[playerid][E_CHARACTER_JOBS]));
	SendClientMessageEx(playerid, 0x98D988FF, "[KEYS]:{ffffff} DuplicateKey:[%s] BusinessKey:[%s]\n", duplicate_key, business_key);	
	if(PlayerInfo[playerb][E_CHARACTER_FACTION])
	{
		SendClientMessageEx(playerid, 0xD39483FF, "[FACTION]:{ffffff} [Faction: %s] [Rank: %s]\n", ReturnFactionName(playerid), IsPlayerFactionRank(playerid));
	}
	
	if(PlayerInfo[playerb][E_CHARACTER_ADMINDUTY])
	{
		SendClientMessageEx(playerid, 0x88D9D8FF, "[FOR ADMIN]: DBID:[%d] Master:[%s (%d)] Interior:[%d] Local:[%d]\n", PlayerInfo[playerid][E_CHARACTER_DBID], AccountInfo[playerid][E_MASTERS_ACCNAME], AccountInfo[playerid][E_MASTERS_DBID], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
		
		SendClientMessageEx(playerid, 0xD9C388FF, "[CONNECTION]: IP:[%s] Last Online:[%s] Duration:[%d Minutes]\n", ReturnIP(playerid), ReturnLastOnline(playerid), PlayerInfo[playerid][E_CHARACTER_LASTONLINE]);
		
		SendClientMessageEx(playerid, 0xA37EBEFF, "[MISC]: InsideProperty:[%i] InsideBusiness:[%i]\n", IsPlayerInProperty(playerid), IsPlayerInBusiness(playerid)); 
	}
	SendTipMessage(playerid, "To see your inventory type '/inventory' or press 'N'\n");
	SendTipMessage(playerid, "To see your vehicles type '/mycars'");
	return 1;
}


stock PlayNearbySound(playerid, sound)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (new i : Player) if (IsPlayerInRangeOfPoint(i, 15.0, x, y, z)) {
	    PlayerPlaySound(i, sound, x, y, z);
	}
	return 1;
}

stock SetMoney(playerid, cash)
{
	PauseAC(playerid);
	PlayerInfo[playerid][E_CHARACTER_MONEY] = cash;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, cash);
}

stock GiveMoney(playerid, amount)
{
	PauseAC(playerid);
	PlayerInfo[playerid][E_CHARACTER_MONEY] += amount;
	GivePlayerMoney(playerid, amount);
	
	new string[128]; 
	
	if(amount < 0) 
	{
		format(string, sizeof(string), "~r~$%d", amount);
		PlayerTextDrawSetString(playerid, money[playerid], string);
		PlayerTextDrawShow(playerid, money[playerid]);
	}
	else
	{
		format(string, sizeof(string), "~g~$%d", amount);
		PlayerTextDrawSetString(playerid, money[playerid], string);
		PlayerTextDrawShow(playerid, money[playerid]);
	}
	SetTimerEx("GiveMoneys", 3000, false, "i", playerid);
	SaveCharacter(playerid);
	return 1;
}

function:GiveMoneys(playerid)
{
	return PlayerTextDrawHide(playerid, money[playerid]);
}

stock HexToInt(string[])
{
    if(!string[0]) return 0;
    new cur = 1, res = 0;
    for(new i = strlen(string); i > 0; i--)
    {
        res += cur * (string[i - 1] - ((string[i - 1] < 58) ? (48) : (55)));
        cur = cur * 16;
    }
    return res;
}

stock DoesBannedPlayerExist(name[])
{
    new checkQuery[128];
    
    mysql_format(ourConnection, checkQuery, sizeof(checkQuery), "SELECT CharacterName FROM bannedlist WHERE CharacterName = '%e'", name); 
    new Cache:cache = mysql_query(ourConnection, checkQuery); 
    
    if (cache_num_rows())
    {
        cache_delete(cache); 
        return 1;
    }
    
    cache_delete(cache);
    return 0;
}


stock DoesCharactersPlayerExist(name[])
{
	new checkQuery[128];
	
	mysql_format(ourConnection, checkQuery, sizeof(checkQuery), "SELECT char_name FROM characters WHERE char_name = '%e'", name); 
	new Cache:cache = mysql_query(ourConnection, checkQuery); 
	
	if(cache_num_rows())
	{
		cache_delete(cache); 
		return 1; 
	}
	
	cache_delete(cache);
	return 0;	
}

function:DoesPlayerExist(playerid, character[])
{
    new name[32];
	
	if (!cache_num_rows())
 		return SendErrorMessage(playerid, "There is no account linked with the specified name.");

	cache_get_value_name(0, "char_masters", name, 32);
	SendClientMessageEx(playerid, COLOR_YELLOW, "Characters Name: %s - Masters Name: %s", character, name);
	return 1;
}

stock DoesMastersPlayerExist(name[])
{
	new checkQuery[128];
	
	mysql_format(ourConnection, checkQuery, sizeof(checkQuery), "SELECT acc_name FROM masters WHERE acc_name = '%e'", name); 
	new Cache:cache = mysql_query(ourConnection, checkQuery); 
	
	if(cache_num_rows())
	{
		cache_delete(cache); 
		return 1; 
	}
	
	cache_delete(cache);
	return 0;	
}

stock SQL_ReturnEscaped(const string[])
{
	new
	    entry[256];

	mysql_escape_string(string, entry, ourConnection);
	return entry;
}

stock FormatMoney(integer)
{
    new result[32];
    new cents = integer % 100;
    new dollars = integer / 100;
    new formattedDollars[32];
    
    
    new temp[32];
    format(temp, sizeof(temp), "%d", dollars);
    
    
    new len = strlen(temp);
    new dotPos = len - 3;
    
    
    new idx = 0, formattedIdx = 0;
    while (idx < len)
    {
        formattedDollars[formattedIdx++] = temp[idx++];
        
        if (idx == dotPos && idx < len)
        {
            formattedDollars[formattedIdx++] = '.';
            dotPos -= 3;
        }
    }
    formattedDollars[formattedIdx] = '\0';
    
    
    format(result, sizeof(result), "%s.%02d", formattedDollars, cents);
    
    return result;
}

stock IsChannelSlot(playerid, chan)
{
	for(new i = 1; i < 3; i++)
	{
		if(PlayerInfo[playerid][E_CHARACTER_RADIO][i] == chan)
			return i;
	}
	return 0; 
}

stock FilterInputText(const inputtext[])
{
    new len = strlen(inputtext);
    for (new i = 0; i < len; i++)
    {
        new c = inputtext[i];
        if (!(c >= 'A' && c <= 'Z') &&  // Huruf A-Z
			!(c >= 'a' && c <= 'z') && // Huruf a-z
            !(c >= '0' && c <= '9') &&  // Angka 0-9
            !(c == '(' || c == ')' || c == '?' || c == '!' || c == '-' || c == '=' || c == ' ')) // Simbol !?-= SPASI
        {
            return false;
        }
    }
    return true; // Semua karakter valid
}

stock FilterInputFont(const inputtext[])
{
    new len = strlen(inputtext);
    for (new i = 0; i < len; i++)
    {
        new c = inputtext[i];
        if (!(c >= 'A' && c <= 'Z') &&  // Huruf A-Z
			!(c >= 'a' && c <= 'z') && // Huruf a-z
            !(c >= '0' && c <= '9'))
        {
            return false;
        }
    }
    return true; // Semua karakter valid
}

stock IsNumeric(const str[])
{
	for (new i = 0, l = strlen(str); i != l; i ++)
	{
	    if (i == 0 && str[0] == '-')
			continue;

	    else if (str[i] < '0' || str[i] > '9')
			return 0;
	}
	return 1;
}

stock ShowPlayerPlates(playerid, str[])
{
	ShowBoxMessage(playerid, str, 5);
	return 1;
}

stock ShowFightStyleMenu(playerid)
{ 
	new id = IsPlayerInBusiness(playerid), str[128];

	format(str, sizeof(str), "%s:", BusinessInfo[id][E_BUSINESS_NAME]);
	Dialog_Show(playerid, DialogGym, DIALOG_STYLE_TABLIST_HEADERS, str, "Product\tPrice\nBoxing\t$150.00\nKneehead\t$200.00\nGrabKick\t$300.00\nReset\t$100.00\nSprunk\t$2.00", "Select", "Cancel");
	return 1;
}

stock IsPlayerAdmins(playerid)
{
	return AccountInfo[playerid][E_MASTERS_ADMINS];
}

stock IsPlayerFaction(playerid)
{
	return PlayerInfo[playerid][E_CHARACTER_FACTION];
}

stock IsPlayerStreetName(playerid)
{
 	new astring[28];
 	if(PlayerInfo[playerid][E_CHARACTER_FACTION] == 0) format(astring, sizeof(astring), "");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 1)format(astring, sizeof(astring), "[LSPD]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 2)format(astring, sizeof(astring), "[LSMD]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 3)
	{
		if (PlayerInfo[playerid][E_CHARACTER_FACTIONSUBSETS] == 1)
		{
			format(astring, sizeof(astring), "[OGF]");
		}
		else
			format(astring, sizeof(astring), "[GSF]");
	}
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 4)format(astring, sizeof(astring), "[KTB]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 5)format(astring, sizeof(astring), "[RHB]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 6)format(astring, sizeof(astring), "[SBF]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 7)format(astring, sizeof(astring), "[LSV]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 8)format(astring, sizeof(astring), "[VLA]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 9)format(astring, sizeof(astring), "[FYB]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 10)format(astring, sizeof(astring), "[TDF]");
	else if (PlayerInfo[playerid][E_CHARACTER_FACTION] == 11)format(astring, sizeof(astring), "[TDB]");
	return astring;
}

stock IsPlayerFactionRank(playerid)
{
 	new astring[28];
 	if(FactionInfo[PlayerInfo[playerid][E_CHARACTER_FACTION]][E_FACTION_TYPE] == FACTION_TYPE_ILLEGAL)
 	{ 
 		if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 0)format(astring, sizeof(astring), "Hoodrats");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 1)format(astring, sizeof(astring), "Local");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 2)format(astring, sizeof(astring), "Official Members");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 3)format(astring, sizeof(astring), "Original Baby Gangster");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 4)format(astring, sizeof(astring), "Original Gangster");
	}
	else if(FactionInfo[PlayerInfo[playerid][E_CHARACTER_FACTION]][E_FACTION_TYPE] == FACTION_TYPE_POLICE)
 	{ 
 		if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 0)format(astring, sizeof(astring), "Training");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 1)format(astring, sizeof(astring), "Police Officer");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 2)format(astring, sizeof(astring), "Police Commander");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 3)format(astring, sizeof(astring), "Deputy Chief of Police");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 4)format(astring, sizeof(astring), "Chief of Police");
	}
	else if(FactionInfo[PlayerInfo[playerid][E_CHARACTER_FACTION]][E_FACTION_TYPE] == FACTION_TYPE_MEDICAL)
 	{ 
 		if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 0)format(astring, sizeof(astring), "Training");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 1)format(astring, sizeof(astring), "Doctor");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 2)format(astring, sizeof(astring), "Hospital Executive");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 3)format(astring, sizeof(astring), "Deputy Chief of Medical");
 		else if (PlayerInfo[playerid][E_CHARACTER_FACTIONRANK] == 4)format(astring, sizeof(astring), "Chief of Medical");
	}
	else
	{
		format(astring, sizeof(astring), "Hoodrats");
	}
	return astring;
}

stock randomEx(min, max)
{
    return random(max - min) + min;
}

Float:randomFloat(Float:maxValue)
{
    return float(random(100)) / 100.0 * maxValue;
}

stock GetCount() { return GetTickCount(); }

stock SetPlayerToFacePlayer(playerid, targetid)
{
	new
	    Float:x[2],
	    Float:y[2],
	    Float:z[2],
	    Float:angle;

	GetPlayerPos(targetid, x[0], y[0], z[0]);
	GetPlayerPos(playerid, x[1], y[1], z[1]);

	angle = (180.0 - atan2(x[1] - x[0], y[1] - y[0]));
	SetPlayerFacingAngle(playerid, angle + (5.0 * -1));
}

function:StopChatting(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
	{
		if(GetPlayerAnimationIndex(playerid) != 0)
		{
			ApplyAnimationEx(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
		}
	}
}

stock ChatAnimation(playerid, lenght)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
	{
		if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
		{

			ApplyAnimation(playerid, "GANGS", "prtial_gngtlkC", 4.0, 1, 1, 1, 1, 1, 1);

			SetTimerEx("StopChatting", floatround(lenght) * 100, false, "i", playerid);
		}
	}
	return 1;
}

stock SetDynamicActorAngleToPlayer(actorid, playerid)
{
	new Float:pX, Float:pY, Float:pZ;
    GetPlayerPos(playerid, pX, pY, pZ);

    return SetFacingPoint(actorid, pX, pY);
}

stock SetFacingPoint(actorid, Float:x, Float:y)
{

    new Float:pX, Float:pY, Float:pZ;
    GetDynamicActorPos(actorid, pX, pY, pZ);

    new Float:angle;

    if( y > pY ) angle = (-acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 90.0);
    else if( y < pY && x < pX ) angle = (acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 450.0);
    else if( y < pY ) angle = (acos((x - pX) / floatsqroot((x - pX)*(x - pX) + (y - pY)*(y - pY))) - 90.0);

    if(x > pX) angle = (floatabs(floatabs(angle) + 180.0));
    else angle = (floatabs(angle) - 180.0);

    return SetDynamicActorFacingAngle(actorid, angle);
}

stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z)
{	
	PauseAC(playerid);
    SetPlayerPos(playerid, x, y, z - 0.3);
	TogglePlayerControllable(playerid, false);
	ShowBoxMessage(playerid, "Please wait....", 3);
	SetTimerEx("PlayerPosTimer", 2500, false, "i", playerid);
    return 1;
}

stock SetPlayerVirtualWorldEx(playerid, value)
{	
	PauseAC(playerid);
    SetPlayerVirtualWorld(playerid, value);
	PlayerInfo[playerid][E_CHARACTER_LASTWORLD] = value;
	
	new thread[256];
	mysql_format(ourConnection, thread, sizeof(thread), "UPDATE characters SET pLastWorld = %i WHERE char_dbid = %i",
		PlayerInfo[playerid][E_CHARACTER_LASTWORLD],
		PlayerInfo[playerid][E_CHARACTER_DBID]);
	mysql_pquery(ourConnection, thread);
    return 1;
}

stock SetPlayerInteriorEx(playerid, value)
{	
	PauseAC(playerid);
    SetPlayerInterior(playerid, value);
	PlayerInfo[playerid][E_CHARACTER_LASTINTERIOR] = value;

	new thread[256];
	mysql_format(ourConnection, thread, sizeof(thread), "UPDATE characters SET pLastInterior = %i WHERE char_dbid = %i",
		PlayerInfo[playerid][E_CHARACTER_LASTINTERIOR],
		PlayerInfo[playerid][E_CHARACTER_DBID]);
	mysql_pquery(ourConnection, thread);
    return 1;
}

function:PlayerPosTimer(playerid)
{
	PlayerEnterTimer[playerid] = false;
	TogglePlayerControllable(playerid, true);
	return 1;
}

stock ConvertHBEColor(Float:value) 
{
    new color;
    if(value >= 90 && value <= 100.0)
        color = 0x15a014FF;
    else if(value >= 80 && value < 90.0)
        color = 0x1b9913FF;
    else if(value >= 70 && value < 80.0)
        color = 0x1a7f08FF;
    else if(value >= 60 && value < 70.0)
        color = 0x326305FF;
    else if(value >= 50 && value < 60.0)
        color = 0x375d04FF;
    else if(value >= 40 && value < 50.0)
        color = 0x603304FF;
    else if(value >= 30 && value < 40.0)
        color = 0xd72800FF;
    else if(value >= 10 && value < 30.0)
        color = 0xfb3508FF;
    else if(value >= 0 && value < 10.0)
        color = 0xFF0000FF;
    else 
        color = COLOR_WHITE;

    return color;
}

stock ConvertVehicleColor(Float:value) 
{
    new color;
    if(value >= 90 && value <= 1000.0)
        color = 0x15a014FF;
    else if(value >= 80 && value < 900.0)
        color = 0x1b9913FF;
    else if(value >= 70 && value < 800.0)
        color = 0x1a7f08FF;
    else if(value >= 60 && value < 700.0)
        color = 0x326305FF;
    else if(value >= 50 && value < 600.0)
        color = 0x375d04FF;
    else if(value >= 40 && value < 500.0)
        color = 0x603304FF;
    else if(value >= 30 && value < 400.0)
        color = 0xd72800FF;
    else if(value >= 10 && value < 300.0)
        color = 0xfb3508FF;
    else if(value >= 0 && value < 100.0)
        color = 0xFF0000FF;
    else 
        color = COLOR_WHITE;

    return color;
}

stock Repeat(const text[], count)
{
    new result[32];
    for (new i = 0; i < count; i++) 
	{
        strcat(result, text);
    }
    return result;
}

stock IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

stock IsKeyJustUp(key, newkeys, oldkeys)
{
	if(!(newkeys & key) && (oldkeys & key)) return 1;
	return 0;
}

stock GenerateShuffledWord(const input[], output[])
{
    const MAX_WORD_LENGTH = 32; // Panjang maksimum kata
    new len = strlen(input);
    new indices[MAX_WORD_LENGTH];
    
    if (len >= MAX_WORD_LENGTH)
    {
        len = MAX_WORD_LENGTH - 1; // Batasi panjang untuk menghindari buffer overflow
    }

    for (new i = 0; i < len; i++) 
        indices[i] = i;

    // Shuffle indices
    for (new i = 0; i < len; i++)
    {
        new randIndex = random(len);
        new temp = indices[i];
        indices[i] = indices[randIndex];
        indices[randIndex] = temp;
    }

    // Buat output berdasarkan indeks yang telah diacak
    for (new i = 0; i < len; i++) 
        output[i] = input[indices[i]];
    output[len] = '\0';
}
