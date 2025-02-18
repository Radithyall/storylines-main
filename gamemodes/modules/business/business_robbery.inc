#define KEY_AIM KEY_HANDBRAKE

function:OnPlayerStartRobbery(playerid, actorid)
{
	PlayerInfo[playerid][E_CHARACTER_ROBBERYACTOR] = actorid;
	PlayerInfo[playerid][E_CHARACTER_HASROBBIZ] = true;

	new Float: x, Float: y, Float: z;
	GetDynamicActorPos(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ACTOR], x, y, z);
	new world = GetDynamicActorVirtualWorld(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ACTOR]);
	new interior = GetPlayerInterior(playerid);

	switch (random(5)) {
		case 0: ProxDetectorXYZ ( x, y, z, interior, world, 10.0, 0xcdcdcdFF, "Cashiers says: W-woah! Don't point that thing at me! I ain't done nuffin'!");
		case 1: ProxDetectorXYZ ( x, y, z, interior, world, 10.0, 0xcdcdcdFF, "Cashiers says: W-woah! Brozza please don't shoot... Just take the cash!");
		case 2: ProxDetectorXYZ ( x, y, z, interior, world, 10.0, 0xcdcdcdFF, "Cashiers says: Don't shoot! Take the cash, it ain't mine anyway!");
		case 3: ProxDetectorXYZ ( x, y, z, interior, world, 10.0, 0xcdcdcdFF, "Cashiers says: You makin' a big mistake.. Just take the cash and don't shoot!");
		case 4: ProxDetectorXYZ ( x, y, z, interior, world, 10.0, 0xcdcdcdFF, "Cashiers says: Please don't take my money! I need to feed my children!");
	}
	SendStreetMessage("Street's News: business at %s %s has been robbed.", GetZoneName(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ENTRANCEPOS][0], BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ENTRANCEPOS][1], BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ENTRANCEPOS][2]), BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME]);
	return 1;
}

function:OnPlayerFinishRobbery(playerid, actorid, type)
{
	if(PlayerInfo[playerid][E_CHARACTER_HASROBBIZ] == true)
	{
		PlayerInfo[playerid][E_CHARACTER_HASROBBIZ] = false;
		PlayerInfo[playerid][E_CHARACTER_ROBBERYACTOR] = -1;

		if(type == TYPE_FAILED)
		{
			
			return SendErrorMessage(playerid, "You have failed to rob the business.");
		}
		else
		{
			SendPropertyMessage(playerid, "[BUSINESS] You have successfully robbed the business for take the cash from cashiers!");

			BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH] = true;
			BusinessRefresh(IsPlayerInBusiness(playerid));
			BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYTIME] = 10;
			PlayerInfo[playerid][E_CHARACTER_ROBBERYCD] = 10;
			SaveBusiness(IsPlayerInBusiness(playerid));
			SaveCharacter(playerid);
			Relations_Remove(playerid, BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME], 80);
		}
	}
	return 1;
}

function:RunActorAnimationSequence(playerid, actorid, animation_pattern) 
{
	switch(animation_pattern) 
	{
		case 0: 
		{
			ClearDynamicActorAnimations(actorid);
			ApplyDynamicActorAnimation(actorid, "SHOP", "SHP_Serve_Loop", 4.1, 0, 0, 0, 1, 0);

			SetTimerEx("RunActorAnimationSequence", 10000, false, "iii", playerid, actorid, 1);
		}
		case 1: 
		{
			ClearDynamicActorAnimations(actorid);
			ApplyDynamicActorAnimation(actorid, "SHOP", "SHP_Rob_GiveCash", 4.1, 0, 0, 0, 1, 0);

			SetTimerEx("RunActorAnimationSequence", 20000, false, "iii", playerid, actorid, 2);
		}
		case 2: 
		{
			ClearDynamicActorAnimations(actorid);
			ApplyDynamicActorAnimation(actorid, "PED", "DUCK_cower", 4.1, 0, 0, 0, 1, 0);

			SetTimerEx("RunActorAnimationSequence", 10000, false, "iii", playerid, actorid, 3);

			CallLocalFunction("OnPlayerFinishRobbery", "ddd", playerid, actorid, TYPE_SUCCESS);
		}
		case 3: 
		{
			ClearDynamicActorAnimations(actorid);
			ApplyDynamicActorAnimation(actorid, "PED", "DUCK_cower", 4.1, 0, 0, 0, 1, 0);
		}
	}
	return 1;
}