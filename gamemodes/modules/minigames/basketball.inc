stock IsPlayerNearCourt(playerid, type)
{
	for(new i = 1; i < MAX_COURT; i++)
	{
		switch(type)
		{
			case 1:
			{
				if(IsPlayerInRangeOfPoint(playerid, 5.0, CourtInfo[i][E_BLUE_POS][0], CourtInfo[i][E_BLUE_POS][1], CourtInfo[i][E_BLUE_POS][2]))
				return i;
			}
			case 2:
			{
				if(IsPlayerInRangeOfPoint(playerid, 5.0, CourtInfo[i][E_RED_POS][0], CourtInfo[i][E_RED_POS][1], CourtInfo[i][E_RED_POS][2]))
				return i;
			}
		}
	} 
	return 0; 
}

stock Court_Refresh(cid)
{
	if (IsValidDynamicObject(CourtInfo[cid][E_BALL_OBJECT]))
	    DestroyDynamicObject(CourtInfo[cid][E_BALL_OBJECT]);

	CourtInfo[cid][E_BALLER] = 999;
	CourtInfo[cid][E_BALL_BOUNCE] = 0;
	CourtInfo[cid][E_BALL_STATUS] = 0;
	CourtInfo[cid][E_BALL_SHOOT] = 0;

	CourtInfo[cid][E_BALL_OBJECT] = CreateDynamicObject(2114, CourtInfo[cid][E_BALL_POS][0], CourtInfo[cid][E_BALL_POS][1], CourtInfo[cid][E_BALL_POS][2], 0.0, 0.0, 0.0);
	return 0;
}

function:Query_LoadCourt()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No court were loaded from \"%s\" database...", SQL_DATABASE);
	
	new rows, fields; 
	cache_get_row_count(rows);
	cache_get_field_count(fields);

	new countCourt = 0;

	for(new i = 0; i < rows && i < MAX_COURT; i++)
	{
	    cache_get_value_name_int(i, "ID", CourtInfo[i+1][E_COURT_DBID]);

		cache_get_value_name_float(i, "ballx", CourtInfo[i+1][E_BALL_POS][0]);
        cache_get_value_name_float(i, "bally", CourtInfo[i+1][E_BALL_POS][1]);
        cache_get_value_name_float(i, "ballz", CourtInfo[i+1][E_BALL_POS][2]);

	    cache_get_value_name_float(i, "bluex", CourtInfo[i+1][E_BLUE_POS][0]);
        cache_get_value_name_float(i, "bluey", CourtInfo[i+1][E_BLUE_POS][1]);
        cache_get_value_name_float(i, "bluez", CourtInfo[i+1][E_BLUE_POS][2]);

		cache_get_value_name_float(i, "redx", CourtInfo[i+1][E_RED_POS][0]);
        cache_get_value_name_float(i, "redy", CourtInfo[i+1][E_RED_POS][1]);
        cache_get_value_name_float(i, "redz", CourtInfo[i+1][E_RED_POS][2]);

		cache_get_value_name_float(i, "bluebx", CourtInfo[i+1][E_BLUE_BALL][0]);
        cache_get_value_name_float(i, "blueby", CourtInfo[i+1][E_BLUE_BALL][1]);
        cache_get_value_name_float(i, "bluebz", CourtInfo[i+1][E_BLUE_BALL][2]);

		cache_get_value_name_float(i, "redbx", CourtInfo[i+1][E_RED_BALL][0]);
        cache_get_value_name_float(i, "redby", CourtInfo[i+1][E_RED_BALL][1]);
        cache_get_value_name_float(i, "redbz", CourtInfo[i+1][E_RED_BALL][2]);

		Court_Refresh(i+1);
		countCourt++;
	}
	printf("[SERVER]: %i court were loaded from \"%s\" database...", countCourt, SQL_DATABASE);
	return 1;
}

function:OnCourtCreate(playerid, cid, Float:posx, Float:posy, Float:posz)
{	
	CourtInfo[cid][E_COURT_DBID] = cache_insert_id(); 
	
	CourtInfo[cid][E_BALL_POS][0] = posx;
    CourtInfo[cid][E_BALL_POS][1] = posy;
    CourtInfo[cid][E_BALL_POS][2] = posz;

	CourtInfo[cid][E_BLUE_POS][0] = 0.0;
    CourtInfo[cid][E_BLUE_POS][1] = 0.0;
    CourtInfo[cid][E_BLUE_POS][2] = 0.0;

	CourtInfo[cid][E_RED_POS][0] = 0.0;
    CourtInfo[cid][E_RED_POS][1] = 0.0;
    CourtInfo[cid][E_RED_POS][2] = 0.0;

	CourtInfo[cid][E_BLUE_BALL][0] = 0.0;
    CourtInfo[cid][E_BLUE_BALL][1] = 0.0;
    CourtInfo[cid][E_BLUE_BALL][2] = 0.0;

	CourtInfo[cid][E_RED_BALL][0] = 0.0;
    CourtInfo[cid][E_RED_BALL][1] = 0.0;
    CourtInfo[cid][E_RED_BALL][2] = 0.0;

	Court_Refresh(cid);
	SendServerMessage(playerid, "You created court ID #%i. To configure, use \"/editcourt\". ", cid); 
	return 1;
}

function:PlayerShootMiss(playerid, type)
{
	new cid = PlayerInfo[playerid][E_CHARACTER_COURT];
	switch(type)
	{
		case 1:
		{
			MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], CourtInfo[cid][E_BLUE_POS][0], CourtInfo[cid][E_BLUE_POS][1], CourtInfo[cid][E_BLUE_POS][2]+2, 7.0);
			ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
			CourtInfo[cid][E_BALL_SHOOT] = 7;
			PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
		}
		case 2:
		{
			MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], CourtInfo[cid][E_RED_POS][0],CourtInfo[cid][E_RED_POS][1], CourtInfo[cid][E_RED_POS][2]+2, 7.0);
			ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
			CourtInfo[cid][E_BALL_SHOOT] = 8;
			PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
		}
		case 3:
		{
			MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], CourtInfo[cid][E_BLUE_POS][0]-randomEx(1, 2), CourtInfo[cid][E_BLUE_POS][1]-random(2), CourtInfo[cid][E_BLUE_POS][2]+2, 7.0);
			ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
			CourtInfo[cid][E_BALL_SHOOT] = 4;
			PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
		}
		case 4:
		{
			MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], CourtInfo[cid][E_RED_POS][0]+randomEx(1, 2),CourtInfo[cid][E_RED_POS][1]+random(2), CourtInfo[cid][E_RED_POS][2]+2, 7.0);
			ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
			CourtInfo[cid][E_BALL_SHOOT] = 5;
			PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
		}
	}
	return 1;
}

function:PlayerBallDown(playerid, Float:oldz)
{
	new cid = PlayerInfo[playerid][E_CHARACTER_COURT];

    new Float:x, Float:y, Float:z, Float:a, Float:x2, Float:y2;
    GetDynamicObjectPos(CourtInfo[cid][E_BALL_OBJECT], x, y, z);
    GetPlayerPos(playerid, x2, y2, a);
    GetPlayerFacingAngle(playerid, a);
    x2 += (16 * floatsin(-a, degrees));
    y2 += (16 * floatcos(-a, degrees));

    MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], x2, y2, CourtInfo[cid][E_BALL_POS][2], 7.0);
    CourtInfo[cid][E_BALLER] = 999;
    CourtInfo[cid][E_BALL_SHOOT] = 0;
    CourtInfo[cid][E_BALL_BOUNCE] = 1;
    return 1;
}

function:PlayerBallShoot(playerid, type)
{
	new cid = PlayerInfo[playerid][E_CHARACTER_COURT];
	
	switch(type)
	{
		case 1:
		{
			MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], CourtInfo[cid][E_BLUE_BALL][0], CourtInfo[cid][E_BLUE_BALL][1], CourtInfo[cid][E_BLUE_BALL][2], 7.0);
			CourtInfo[cid][E_BALLER] = 999;
			CourtInfo[cid][E_BALL_SHOOT] = 0;
			CourtInfo[cid][E_BALL_BOUNCE] = 9;
			PlayNearbySound(playerid, 4604);

			new Float:shot[3], str[128];
			GetPlayerPos(playerid, shot[0], shot[1], shot[2]);
			new Float: fDistance = GetPlayerDistanceFromPoint(playerid, CourtInfo[cid][E_BLUE_POS][0], CourtInfo[cid][E_BLUE_POS][1], CourtInfo[cid][E_BLUE_POS][2]);
			
			format(str, sizeof(str), "shoots the basketball over %0.2f yards and SCORES.", fDistance);
			cmd_me(playerid, str);
		}
		case 2:
		{
			MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], CourtInfo[cid][E_RED_BALL][0], CourtInfo[cid][E_RED_BALL][1], CourtInfo[cid][E_RED_BALL][2], 7.0);
			CourtInfo[cid][E_BALLER] = 999;
			CourtInfo[cid][E_BALL_SHOOT] = 0;
			CourtInfo[cid][E_BALL_BOUNCE] = 9;
			PlayNearbySound(playerid, 4604);

			new Float:shot[3], str[128];
			GetPlayerPos(playerid, shot[0], shot[1], shot[2]);
			new Float: fDistance = GetPlayerDistanceFromPoint(playerid, CourtInfo[cid][E_RED_POS][0], CourtInfo[cid][E_RED_POS][1], CourtInfo[cid][E_RED_POS][2]);
			
			format(str, sizeof(str), "shoots the basketball over %0.2f yards and SCORES.", fDistance);
			cmd_me(playerid, str);
		}
		case 3:
		{
			new Float:pos[3];
			GetDynamicObjectPos(CourtInfo[cid][E_BALL_OBJECT], pos[0], pos[1], pos[2]);

			MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], pos[0], pos[1], CourtInfo[cid][E_BLUE_POS][2]+2, 7.0);
			CourtInfo[cid][E_BALLER] = 999;
			CourtInfo[cid][E_BALL_SHOOT] = 0;
			CourtInfo[cid][E_BALL_BOUNCE] = 1;
			PlayNearbySound(playerid, 4603);

			new Float:shot[3], str[128];
			GetPlayerPos(playerid, shot[0], shot[1], shot[2]);
			new Float: fDistance = GetPlayerDistanceFromPoint(playerid, CourtInfo[cid][E_BLUE_POS][0], CourtInfo[cid][E_BLUE_POS][1], CourtInfo[cid][E_BLUE_POS][2]);
			
			format(str, sizeof(str), "shoots the basketball over %0.2f yards and MISSES.", fDistance);
			cmd_me(playerid, str);
		}
		case 4:
		{
			new Float:pos[3];
			GetDynamicObjectPos(CourtInfo[cid][E_BALL_OBJECT], pos[0], pos[1], pos[2]);

			MoveDynamicObject(CourtInfo[cid][E_BALL_OBJECT], pos[0], pos[1],CourtInfo[cid][E_RED_POS][2]+2, 7.0);
			CourtInfo[cid][E_BALLER] = 999;
			CourtInfo[cid][E_BALL_SHOOT] = 0;
			CourtInfo[cid][E_BALL_BOUNCE] = 1;
			PlayNearbySound(playerid, 4603);

			new Float:shot[3], str[128];
			GetPlayerPos(playerid, shot[0], shot[1], shot[2]);
			new Float: fDistance = GetPlayerDistanceFromPoint(playerid, CourtInfo[cid][E_RED_POS][0], CourtInfo[cid][E_RED_POS][1], CourtInfo[cid][E_RED_POS][2]);
			
			format(str, sizeof(str), "shoots the basketball over %0.2f yards and MISSES.", fDistance);
			cmd_me(playerid, str);
		}
	}
    
    return 1;
}

CMD:court(playerid, params[])
{
	new cid = PlayerInfo[playerid][E_CHARACTER_COURT];
	if(!PlayerInfo[playerid][E_CHARACTER_COURT])
	{
		if(GetPlayerPing(playerid) > 100) 
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Due to your high ping (100+), the game may desync. If this occurs please leave the game A.S.A.P. or contact an admin." ) ;
		}
		if(IsPlayerNearCourt(playerid, 1))
		{
			PlayerInfo[playerid][E_CHARACTER_COURT] = IsPlayerNearCourt(playerid, 1);
			PlayerInfo[playerid][E_CHARACTER_COURTTEAM] = 1;
			SendClientMessageEx(playerid, COLOR_PINK, "[Basketball] You've joined the basketball as blue team.");

			new str[256];
			format(str, sizeof(str), "To play, press 'RETURN' near a basketball or have someone pass it.~n~~n~To steal and shoot, press 'LMB'. To block, use 'SHIFT'.");
			ShowHeaderMessage(playerid, "Basketball", str, 1);
		}
		else if(IsPlayerNearCourt(playerid, 2))
		{
			PlayerInfo[playerid][E_CHARACTER_COURT] = IsPlayerNearCourt(playerid, 2);
			PlayerInfo[playerid][E_CHARACTER_COURTTEAM] = 2;
			SendClientMessageEx(playerid, COLOR_PINK, "[Basketball] You've joined the basketball as red team.");

			new str[256];
			format(str, sizeof(str), "To play, press 'RETURN' near a basketball or have someone pass it.~n~~n~To steal and shoot, press 'LMB'. To block, use 'SHIFT'.");
			ShowHeaderMessage(playerid, "Basketball", str, 1);
		}
		else return SendErrorMessage(playerid, "You aren't near court.");
	}
	else
	{
		PlayerInfo[playerid][E_CHARACTER_COURT] = 0;
		PlayerInfo[playerid][E_CHARACTER_COURTTEAM] = 0;
		CourtInfo[cid][E_BALLER] = 999;
		CourtInfo[cid][E_BALL_SHOOT] = 0;
		SendClientMessageEx(playerid, COLOR_PINK, "[Basketball] You've leave the game.");

		HideHeaderMessage(playerid);
	}
	return 1;
}

CMD:resetcourt(playerid, params[])
{
	if(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALLER] == 999)
	{
		PlayerInfo[playerid][E_CHARACTER_COURT] = 0;
		PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
		PlayerInfo[playerid][E_CHARACTER_ANIMBALL] = 0;
		PlayerInfo[playerid][E_CHARACTER_COURTTEAM] = 0;
		
		Court_Refresh(PlayerInfo[playerid][E_CHARACTER_COURT]);
		SendServerMessage(playerid, "You've reset the basketball court.");
	}
	return 1;
}

CMD:createcourt(playerid, params[])
{
	if(IsPlayerAdmins(playerid) < ADMINS_OWNER)
		return SendUnauthMessage(playerid);
		
	new idx, query[128]; 
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

	for(new i = 1; i < MAX_COURT; i++)
	{
		if(!CourtInfo[i][E_COURT_DBID])
		{
			idx = i;
			break;
		}
	}
		
	if(idx == 0)
		return SendErrorMessage(playerid, "You can't make anymore court."); 

	mysql_format(ourConnection, query, sizeof(query), "INSERT INTO court (`ballx`, `bally`, `ballz`) VALUES(%.4f, %.4f, %.4f)", pos[0], pos[1], pos[2]);
	mysql_pquery(ourConnection, query, "OnCourtCreate", "iifff", playerid, idx, pos[0], pos[1], pos[2]);
	return 1;
}

CMD:editcourt(playerid, params[])
{
	if(IsPlayerAdmins(playerid) < ADMINS_OWNER)
		return SendUnauthMessage(playerid);
		
	new id, indx[128];
	
	if(sscanf(params, "is[128]", id, indx))
	{
		SendUsageMessage(playerid, "/editcourt [court id] [configuration]");
		SendTipMessage(playerid, "ballpos, bluepos, redpos, bluering, redring");
		return 1; 
	}
	
	if(!CourtInfo[id][E_COURT_DBID] || id > MAX_COURT)
		return SendErrorMessage(playerid, "That court doesn't exist.");
	
	if(!strcmp(indx, "ballpos"))
	{
		new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

		CourtInfo[id][E_BALL_POS][0] = pos[0];
		CourtInfo[id][E_BALL_POS][1] = pos[1];
		CourtInfo[id][E_BALL_POS][2] = pos[2]-0.8;

		Court_Save(id);
		Court_Refresh(id);
	}
	else if(!strcmp(indx, "bluepos"))
	{
		new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

		CourtInfo[id][E_BLUE_POS][0] = pos[0];
		CourtInfo[id][E_BLUE_POS][1] = pos[1];
		CourtInfo[id][E_BLUE_POS][2] = pos[2]-0.8;

		Court_Save(id);
		Court_Refresh(id);
		SendServerMessage(playerid, "You're set position blue team in %f, %f, %f.", pos[0], pos[1], pos[2]);
	}
	else if(!strcmp(indx, "redpos"))
	{
		new Float:pos[3];
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

		CourtInfo[id][E_RED_POS][0] = pos[0];
		CourtInfo[id][E_RED_POS][1] = pos[1];
		CourtInfo[id][E_RED_POS][2] = pos[2]-0.8;

		Court_Save(id);
		Court_Refresh(id);
		SendServerMessage(playerid, "You're set position red team in %f, %f, %f.", pos[0], pos[1], pos[2]);
	}
	else if(!strcmp(indx, "bluering"))
	{
		new Float:x, Float:y, Float:z; 
			
		GetPlayerPos(playerid, x, y, z); 
		PlayerInfo[playerid][E_CHARACTER_ADDOBJECT] = CreateDynamicObject(2114, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)); 
		EditDynamicObject(playerid, PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]); 
		PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 2;
		PlayerInfo[playerid][E_CHARACTER_OBJECTID] = id;
	}
	else if(!strcmp(indx, "redring"))
	{
		new Float:x, Float:y, Float:z; 
			
		GetPlayerPos(playerid, x, y, z); 
		PlayerInfo[playerid][E_CHARACTER_ADDOBJECT] = CreateDynamicObject(2114, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)); 
		EditDynamicObject(playerid, PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]); 
		PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 3;
		PlayerInfo[playerid][E_CHARACTER_OBJECTID] = id;
	}
	else return SendErrorMessage(playerid, "Invalid Paramater.");	
	return 1;
}