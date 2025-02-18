InsertFactionLocker()
{
	FactionLockerPickup[0] = CreateDynamicPickup(1239, 1, 253.9264,79.1226,1003.6406, -1, -1, -1, 5.0);
	FactionLockerPickup[1] = CreateDynamicPickup(1239, 1, 1833.1627,-1072.3607,41.6537, -1, -1, -1, 5.0);
	FactionLockerPickup[2] = CreateDynamicPickup(1239, 1, 1269.3730,-1307.3560,1061.1392, -1, -1, -1, 5.0);
}

stock IsPoliceVehicle(vehicleid)
{
	for(new i = 0; i < 27; i++)
	{
		if(vehicleid == FactionVehicle[i][E_FACVEHICLE_VEH]) return 1;
	}	
	return 0;
}

stock IsMedicalVehicle(carid)
{
	for(new i = 27; i < 38; i++)
	{
	    if(carid == FactionVehicle[i][E_FACVEHICLE_VEH]) return 1;
	}
	return 0;
}

function:OnPlayerAddCharge(playerid, playerb, charge[])
{
	SendPoliceMessage(COLOR_COP, "Wanted: Suspect: %s Charger: %s Reason: %s", ReturnName(playerb), ReturnName(playerid), charge);
	PlayerInfo[playerb][E_CHARACTER_ACTIVELIST]++; 
	
	new 
		query[128];
	 
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pActiveListings = %i WHERE char_dbid = %i", PlayerInfo[playerb][E_CHARACTER_ACTIVELIST], PlayerInfo[playerb][E_CHARACTER_DBID]);
	mysql_pquery(ourConnection, query);
	return 1; 
}

function:Query_InsertFaction(playerid, varName, varAbbrev, idx)
{
	new insertRanks[128], str[128];
	format(FactionInfo[idx][E_FACTION_NAME], 128, "%s", varName);
	format(FactionInfo[idx][E_FACTION_ABBREV], 32, "%s", varAbbrev); 

	mysql_format(ourConnection, insertRanks, sizeof(insertRanks), "INSERT INTO faction_ranks (`factionid`) VALUES(%i)", cache_insert_id()); 
	mysql_pquery(ourConnection, insertRanks); 
	
	FactionInfo[idx][E_FACTION_DBID] = cache_insert_id();
			
	format(str, sizeof(str), "%s has created Faction ID %d.", ReturnName(playerid), idx);
	SendAdminMessage(4, str);
	
	SendTipMessage(playerid, "To configure the faction, use /editfaction. "); 
	return 1;
}

function:Query_LoadFactions()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No factions were loaded from %s database...", SQL_DATABASE);
		
	new newThread[256], rows, fields; 
	cache_get_row_count(rows);
	cache_get_field_count(fields);
	
	for (new i = 0; i < rows && i < MAX_FACTIONS; i ++)
	{
		cache_get_value_name_int(i, "DBID", FactionInfo[i+1][E_FACTION_DBID]);
		
		cache_get_value_name(i, "FactionName", FactionInfo[i+1][E_FACTION_NAME], 90);
		cache_get_value_name(i, "FactionAbbrev", FactionInfo[i+1][E_FACTION_ABBREV], 30);
		cache_get_value_name_float(i, "FactionSpawnX", FactionInfo[i+1][E_FACTION_SPAWN][0]);
		cache_get_value_name_float(i, "FactionSpawnY", FactionInfo[i+1][E_FACTION_SPAWN][1]);
		cache_get_value_name_float(i, "FactionSpawnZ", FactionInfo[i+1][E_FACTION_SPAWN][2]);
		cache_get_value_name_int(i, "FactionInterior", FactionInfo[i+1][E_FACTION_SPAWNINT]);
		cache_get_value_name_int(i, "FactionWorld", FactionInfo[i+1][E_FACTION_SPAWNWORLD]);
		cache_get_value_name_int(i, "FactionJoinRank", FactionInfo[i+1][E_FACTION_LOCALRANK]);
		cache_get_value_name_int(i, "FactionAlterRank", FactionInfo[i+1][E_FACTION_OFFICIALRANK]);
		cache_get_value_name_int(i, "FactionChatRank", FactionInfo[i+1][E_FACTION_HIGHRANK]);
		cache_get_value_name_int(i, "FactionTowRank", FactionInfo[i+1][E_FACTION_LEADERRANK]);
		cache_get_value_name_int(i, "FactionDrugs", FactionInfo[i+1][E_FACTION_STORAGE]);
		cache_get_value_name_int(i, "FactionChatColor", FactionInfo[i+1][E_FACTION_COLORHEX]);
		cache_get_value_name_int(i, "FactionType", FactionInfo[i+1][E_FACTION_TYPE]);

		FactionInfo[i+1][E_FACTION_SPAWNPICKUP] = CreateDynamicPickup(1314, 1, FactionInfo[i+1][E_FACTION_SPAWN][0], FactionInfo[i+1][E_FACTION_SPAWN][1], FactionInfo[i+1][E_FACTION_SPAWN][2], FactionInfo[i+1][E_FACTION_SPAWNWORLD], FactionInfo[i+1][E_FACTION_SPAWNINT], -1, 5.0);
		
		if(FactionInfo[i+1][E_FACTION_TYPE] == FACTION_TYPE_ILLEGAL)
		{
			new str[64];
			format(str, sizeof(str), "[Faction Spawn Point]");
			FactionInfo[i+1][E_FACTION_SPAWNTEXT] = CreateDynamic3DTextLabel(str, COLOR_3DTEXT, FactionInfo[i+1][E_FACTION_SPAWN][0], FactionInfo[i+1][E_FACTION_SPAWN][1], FactionInfo[i+1][E_FACTION_SPAWN][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, FactionInfo[i+1][E_FACTION_SPAWNWORLD], FactionInfo[i+1][E_FACTION_SPAWNINT]);
		}
		else
		{
			new str[64];
			format(str, sizeof(str), "[Faction Spawn Point]");
			FactionInfo[i+1][E_FACTION_SPAWNTEXT] = CreateDynamic3DTextLabel(str, COLOR_3DTEXT, FactionInfo[i+1][E_FACTION_SPAWN][0], FactionInfo[i+1][E_FACTION_SPAWN][1], FactionInfo[i+1][E_FACTION_SPAWN][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, FactionInfo[i+1][E_FACTION_SPAWNWORLD], FactionInfo[i+1][E_FACTION_SPAWNINT]);
		}
		mysql_format(ourConnection, newThread, sizeof(newThread), "SELECT * FROM faction_ranks WHERE factionid = %i", i+1); 
		mysql_pquery(ourConnection, newThread, "Query_LoadFactionRanks", "i", i+1);
	}
	printf("[SERVER]: %i factions were loaded from \"%s\" database...", rows, SQL_DATABASE);
	return 1;
}

function:Query_LoadFactionRanks(factionid)
{
	new str[128];
	
	new rows, fields; 
	cache_get_row_count(rows);
	cache_get_field_count(fields);
	
	for (new i = 0; i < rows; i++)
	{
		for (new j = 1; j < MAX_FACTION_RANKS; j++)
		{
			format(str, sizeof(str), "FactionRank%i", j); 
			cache_get_value_name(i, str, FactionRanks[factionid][j], 60);
		}
	}
	return 1;
}

function:OnTaserShoot(playerid)
{
	return SetPlayerArmedWeapon(playerid, WEAPON_SILENCED); 
}

function:OnPlayerTasered(playerid)
{
	SetPlayerDrunkLevel(playerid, 1000);
	TogglePlayerControllable(playerid, true);
	
	ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
	ApplyAnimation(playerid, "PED", "KO_skid_front", 4.1, 0, 1, 1, 1, 0);
	return 1; 
}

function:OnPlayerRubber(playerid)
{
	TogglePlayerControllable(playerid, true);
	
	ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_falloff", 4.1, 0, 1, 1, 1, 0);
	ApplyAnimation(playerid, "GYMNASIUM", "gym_tread_falloff", 4.1, 0, 1, 1, 1, 0);
	return 1; 
}

function:OnSetFaction(playerid, response, playerb, factionid)
{
	if(response)
	{
		PlayerInfo[playerb][E_CHARACTER_FACTION] = factionid;
		if(PlayerInfo[playerb][E_CHARACTER_FACTION] == 3 || PlayerInfo[playerb][E_CHARACTER_FACTION] == 5)
		{
			new rand = randomEx(1, 4);
			PlayerInfo[playerb][E_CHARACTER_FACTIONSUBSETS] = rand;
		}
		else if(PlayerInfo[playerb][E_CHARACTER_FACTION] == 4 || PlayerInfo[playerb][E_CHARACTER_FACTION] == 6 || PlayerInfo[playerb][E_CHARACTER_FACTION] == 7 || PlayerInfo[playerb][E_CHARACTER_FACTION] == 9)
		{
			new rand = randomEx(1, 4);
			PlayerInfo[playerb][E_CHARACTER_FACTIONSUBSETS] = rand;
		}
		
		PlayerInfo[playerb][E_CHARACTER_FACTIONRANK] = 4; 

		new str[128];
		
		format(str, sizeof(str), "%s set %s's faction to %d.", ReturnName(playerid), ReturnName(playerb), factionid);
		SendAdminMessage(4, str); SendClientMessage(playerb, COLOR_YELLOW, str);
		
		SendServerMessage(playerb, "You were set to faction %d by Admin %s.", factionid, ReturnName(playerid));
		
		SaveCharacter(playerb);
	}
	else return SendErrorMessage(playerid, "You disregarded the faction set.");
	return 1;
}

stock IsPlayerNearFaction(playerid)
{
	for(new i = 1; i < MAX_FACTIONS; i++)
	{
		if(!FactionInfo[i][E_FACTION_DBID])
			continue;
			
		if(IsPlayerInRangeOfPoint(playerid, 3.0, FactionInfo[i][E_FACTION_SPAWN][0], FactionInfo[i][E_FACTION_SPAWN][1], FactionInfo[i][E_FACTION_SPAWN][2]))
			return i;
	}
	return 0;
}

function:OnPlayerFactionUpdate()
{
	foreach(new i : Player)
	{
		if(PlayerInfo[i][E_CHARACTER_POLICEDUTY])
		{
			new Cents = floatround(10 * 100, floatround_round);
			GivePaycheck(i, Cents);
			SendInfoMessage(i, "[FACTION] You has earn $%s into your paycheck from faction duty.", FormatMoney(Cents));
		}
		if(PlayerInfo[i][E_CHARACTER_MEDICDUTY])
		{
			new Cents = floatround(8 * 100, floatround_round);
			GivePaycheck(i, Cents);
			SendInfoMessage(i, "[FACTION] You has earn $%s into your paycheck from faction duty.", FormatMoney(Cents));
		}
	}
	return 1;
}