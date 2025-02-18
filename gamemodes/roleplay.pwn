
/*==================================================================================================
   ______                _   _   _____                           _         _____  _____   _____ 
  |  ____|              | \ | | |  __ \                         | |       |  __ \|  __ \ / ____|
  | |__ ___  __ _ _ __  |  \| | | |__) |___  ___ _ __   ___  ___| |_      | |__) | |__) | |  __ 
  |  __/ _ \/ _` | '__| | . ` | |  _  // _ \/ __| '_ \ / _ \/ __| __|     |  _  /|  ___/| | |_ |
  | | |  __/ (_| | |    | |\  | | | \ \  __/\__ \ |_) |  __/ (__| |_   _  | | \ \| |    | |__| |
  |_|  \___|\__,_|_|    |_| \_| |_|  \_\___||___/ .__/ \___|\___|\__| (_) |_|  \_\_|     \_____|
                                                | |                                             
                                                |_|  

  #Thanks to Radeetz for making this script.
  #Special thanks to Allah SWT.
================================================================================================== */

#define PP_SYNTAX

#include <a_samp>
#include <a_mysql>
#include <streamer>
#include <progress2>
#include <easyDialog>
#include <zcmd>
#include <sscanf2>
#include <physics>
#include <Pawn.RakNet>
#include <PawnPlus>
#include <eSelection>
#include <garageblock>
#include <compat>

//Database establisher:
new MySQL:ourConnection; 
new g_RaceCheck[MAX_PLAYERS char];

// CONFIG HEADERS MODULES
#include "modules\config\macro.inc"
#include "modules\config\color.inc"
#include "modules\config\variable.inc"
#include "modules\config\vardialog.inc"

main ()  {}

// VISUALS MODULES
#include "modules\visuals\enviroment.inc"
#include "modules\visuals\static_3dtext"
#include "modules\visuals\static_actor"
#include "modules\visuals\static_vehicles"
#include "modules\visuals\textdraws.inc"
#include "modules\visuals\gamebar.inc"
// CONFIG MODULES
#include "modules\config\types.inc"
#include "modules\config\pickup.inc"
#include "modules\config\messages.inc"
#include "modules\config\economy.inc"
#include "modules\config\modelselections.inc"
#include "modules\config\dialogs.inc"
#include "modules\config\savemysql.inc"
#include "modules\config\return.inc"
#include "modules\config\player.inc"
#include "modules\config\weapon.inc"
#include "modules\config\anticheat.inc"
#include "modules\config\bunnyhop.inc"
#include "modules\config\toggle.inc"
#include "modules\config\timer.inc"
#include "modules\config\zones.inc"
#include "modules\config\tips.inc"
#include "modules\config\maintenance.inc"
// TAGS MODULES
#include "modules\tags\tablist.inc"
// ANIMS MODULES
#include "modules\anims\anims.inc"
// EMMET MODULES
#include "modules\emmet\emmet.inc"
// BUSINESS MODULES
#include "modules\business\business.inc"
#include "modules\business\business_commands.inc"
#include "modules\business\business_general.inc"
#include "modules\business\business_dmv.inc"
#include "modules\business\business_gym.inc"
#include "modules\business\business_clothes.inc"
#include "modules\business\business_haircut.inc"
#include "modules\business\business_gunstore.inc"
#include "modules\business\business_extortion.inc"
#include "modules\business\business_robbery.inc"
// PROPERTY MODULES
#include "modules\properties\property.inc"
#include "modules\properties\property_storage.inc"
#include "modules\properties\property_furniture.inc"
#include "modules\properties\property_commands.inc"
#include "modules\properties\property_realty.inc"
// ENTRANCE MODULES
#include "modules\entrance\entrance.inc"
// VEHICLE MODULES
#include "modules\vehicles\vehicles.inc"
#include "modules\vehicles\vehicles_timer.inc"
#include "modules\vehicles\vehicles_storage.inc"
#include "modules\vehicles\vehicles_dealership.inc"
#include "modules\vehicles\vehicles_rental.inc"
#include "modules\vehicles\vehicles_commands.inc"
#include "modules\vehicles\vehicles_hotwire.inc"
#include "modules\vehicles\vehicles_refuel.inc"
// FACTIONS MODULES
#include "modules\faction\factions.inc"
#include "modules\faction\factions_commands.inc"
#include "modules\faction\factions_vehicle.inc"
#include "modules\faction\police\mdc.inc"
#include "modules\faction\police\alpr.inc"
#include "modules\faction\police\tackle.inc"
#include "modules\faction\police\roadblock.inc"
#include "modules\faction\police\ticket.inc"
#include "modules\faction\police\backup.inc"
#include "modules\faction\police\prison.inc"
#include "modules\faction\medic\fire.inc"
// PROPS MODULES
#include "modules\props\spraytags.inc"
#include "modules\props\advertise.inc"
#include "modules\props\tree.inc"
#include "modules\props\gate.inc"
#include "modules\props\spawnables.inc"
#include "modules\props\vending.inc"
// DRUGS MODULES
#include "modules\drugs\drugs.inc"
#include "modules\drugs\drugsdealing.inc"
// INVENTORY MODULES
#include "modules\inventory\inventory.inc"
#include "modules\inventory\dropitem.inc"
// MINIGAMES MODULES
#include "modules\minigames\basketball.inc"
#include "modules\minigames\blackjack.inc"
#include "modules\minigames\lottery.inc"
#include "modules\minigames\pool.inc"
#include "modules\minigames\physics.inc"
// PLAYERS MODULES
#include "modules\players\account.inc"
#include "modules\players\needs.inc"
#include "modules\players\damages.inc"
#include "modules\players\phone.inc"
#include "modules\players\paycheck.inc"
#include "modules\players\report.inc"
#include "modules\players\antibunny.inc"
#include "modules\players\selection.inc"
#include "modules\players\tutorial.inc"
#include "modules\players\times.inc"
#include "modules\players\stamina.inc"
#include "modules\players\gps.inc"
#include "modules\players\accessories.inc"
#include "modules\players\afk.inc"
#include "modules\players\vip.inc"
// COMPENSATION
#include "modules\competation\competation.inc"
// INDUSTRIAL MODULES
#include "modules\industry\industry.inc"
// JOBS MODULES
#include "modules\jobs\header.inc"
#include "modules\jobs\MainJobs\trucker.inc"
#include "modules\jobs\MainJobs\lumberjack.inc"
#include "modules\jobs\MainJobs\taxi.inc"
#include "modules\jobs\MainJobs\mechanic.inc"
#include "modules\jobs\MainJobs\smuggler.inc"
#include "modules\jobs\SideJobs\fishing.inc"
#include "modules\jobs\SideJobs\dockworker.inc"
#include "modules\jobs\SideJobs\sweepers.inc"
#include "modules\jobs\SideJobs\busdriver.inc"
// COMMANDS MODULES
#include "modules\commands\globalooc.inc"
#include "modules\commands\cmd_admins.inc"
#include "modules\commands\cmd_player.inc"
#include "modules\commands\cmd_faction.inc"

// Start of functions:
public OnGameModeInit()
{
	SetGameModeText(SCRIPT_REV);
	SendRconCommand("hostname "SERVER_NAME"");

	new MySQLOpt:ourOptions = mysql_init_options(); 

	mysql_set_option(ourOptions, AUTO_RECONNECT, true);
	mysql_set_option(ourOptions, POOL_SIZE, 16);

	ourConnection = mysql_connect(SQL_HOSTNAME, SQL_USERNAME, SQL_PASSWORD, SQL_DATABASE, ourOptions);
	
	if (ourConnection == MYSQL_INVALID_HANDLE || mysql_errno(ourConnection) != 0)
	{
		printf ("[DATABASE]: Connection failed to '%s'...", SQL_DATABASE);
		SendRconCommand("exit");
		return 1;
	}
	else printf ("[DATABASE]: Connection established to '%s'...", SQL_DATABASE);

	mysql_log(ERROR | WARNING);
	
	// Load Custommodels:
	LoadCustomModels();

	// Disabling singleplayer entities:
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	SetNameTagDrawDistance(20.0);
	ShowNameTags(false);
	EnableStuntBonusForAll(0);
	ManualVehicleEngineAndLights();
	DisableInteriorEnterExits();
	
	// Insert:
	InsertPolice();
	InsertObjects();
	InsertBlackjack();
	InsertJobsPoint();
	InsertAntiCheat();
	InsertAdvertise();
	InsertDealership();
	InsertStaticArea();
	Insert3DTextLabel();
	InsertAcidGunLabs();
	InsertReworkedMaps();
	InsertSidejobsMaps();
	InsertDocksWorkers();
	InsertFactionLocker();
	InsertDynamicPickup();
	InsertCharacterScene();
	InsertStaticVehicles();
	InsertVendingMachines();

	BlockGarages(true, GARAGE_TYPE_ALL);

	// Global timers:
	SetTimerEx("RandomFire", 5400000, true, "i", 1);
	SetTimer("OnPlayerUpdateEx", 1000, true); 
	SetTimer("OnPlayerVIPUpdate", 1000, true); 
	SetTimer("FunctionPaychecks", 60000, true);
	SetTimer("OnVehicleFuelUpdate", 60000, true);
	SetTimer("OnVehicleUpdate", 1000, true);
	SetTimer("OnVehicleRental", 60000, true);
	SetTimer("OnPlayerMinutesUpdate", 60000, true);
	SetTimer("OnPlayerWeaponUpdate", 1000, true);
	SetTimer("OnSprayTagsUpdate", 60000, true);
	SetTimer("OnAntiCheatUpdate", 1000, true);
	SetTimer("OnIndustryUpdate", 1800000, true);
	SetTimer("OnTreeUpdate", 60000, true);
	SetTimer("OnPlayerTaxiUpdate", 1000, true);
	SetTimer("OnPlayerPacketUpdate", 1800000, true);
	SetTimer("OnPlayerConditionUpdate", 1000, true);
	SetTimer("OnPlayerFactionUpdate", 600000, true);
	SetTimer("OnPlayerJobsUpdate", 60000, true);
	SetTimer("OnPlayerLotteryUpdate", 1800000, false);
	SetTimer("OnPlayerTipsUpdate", 600000, true);
	SetTimer("OnPlayerNeedUpdate", 60000, true);
	SetTimer("WeatherRotator", 2400000, true);

	// Loading systems:
	mysql_pquery(ourConnection, "SELECT * FROM factions ORDER BY dbid ASC", "Query_LoadFactions"); 
	mysql_pquery(ourConnection, "SELECT * FROM properties ORDER BY PropertyDBID", "Query_LoadProperties");
	mysql_pquery(ourConnection, "SELECT * FROM furniture", "Query_LoadFurniture", "i", 0);
	mysql_pquery(ourConnection, "SELECT * FROM businesses ORDER BY BusinessDBID ASC", "Query_LoadBusinesses"); 
	mysql_pquery(ourConnection, "SELECT * FROM entrance ORDER BY ID", "Query_LoadEntrance");
	mysql_pquery(ourConnection, "SELECT * FROM `court`", "Query_LoadCourt", "");
	mysql_pquery(ourConnection, "SELECT * FROM `gates`", "Query_LoadGates", "");
	mysql_pquery(ourConnection, "SELECT * FROM `tree`", "Query_LoadTree", ""); 
	mysql_pquery(ourConnection, "SELECT * FROM `dropped`", "Query_LoadDropped", "");
	mysql_pquery(ourConnection, "SELECT * FROM `spray_tags`", "Query_LoadSpraytags", "");
	mysql_pquery(ourConnection, "SELECT * FROM `server_data`", "Query_LoadServerData", "");
	mysql_pquery(ourConnection, "SELECT * FROM `compensation_codes`", "Query_LoadCompensation", "");

	Times = TextDrawCreate(67.000000, 426.000000, "");
	TextDrawFont(Times, 1);
	TextDrawLetterSize(Times, 0.174992, 0.949998);
	TextDrawTextSize(Times, 400.000000, 93.500000);
	TextDrawSetOutline(Times, 1);
	TextDrawSetShadow(Times, 0);
	TextDrawAlignment(Times, 2);
	TextDrawColor(Times, -1);
	TextDrawBackgroundColor(Times, 255);
	TextDrawBoxColor(Times, 50);
	TextDrawUseBox(Times, 0);
	TextDrawSetProportional(Times, 1);
	TextDrawSetSelectable(Times, 0);
	return 1;
}

public OnGameModeExit()
{
	#if defined DEBUG_MODE
		printf("Callback OnGameModeExit called"); 
	#endif

	foreach (new i : Player)
	{
		SetPlayerName(i, AccountInfo[i][E_MASTERS_ACCNAME]);
		if(PlayerInfo[i][E_CHARACTER_TUTORIAL] && PlayerInfo[i][E_CHARACTER_SPAWNED])
		{
			SaveCharacter(i); SaveCharacterPos(i);
		}
		
	}
	
	//Saving systems:
	SaveFactions();
	SaveProperties();
	SaveBusinesses();

	forex(i, MAX_TREES) if(TreeInfo[i][E_TREE_EXISTS])
	{
		Tree_Save(i);
	}
	
	//Closing database:
	mysql_close(ourConnection);
	return 1;
}

public OnPlayerConnect(playerid)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerConnect called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif

	g_RaceCheck{playerid}++;
	PlayAudioStreamForPlayer(playerid, "https://e.top4top.io/m_3254pyq011.mp3");

	ShowClock(playerid);
	PreloadAnimations(playerid); 
	RemoveObjects(playerid);
	RemoveDefaultVendingMachines(playerid);
	ResetPlayer(playerid);

	//Visuals:
	CreateTextdraws(playerid);
	CreateHETextDraws(playerid);
	CreateMDCTextDraws(playerid);
	CreateHUDTextDraws(playerid);
	CreatePoolTextDraws(playerid);
	CreateALPRTextdraws(playerid);
	CreatePhoneTextDraws(playerid);
	CreateVehicleTextDraws(playerid);
	CreateHotwireTextDraws(playerid);
	CreateBarInfoTextDraws(playerid);
	CreateTutorialTextDraws(playerid);
	CreateBlackJackTextDraws(playerid);
	CreateFoodOrderTextDraws(playerid);
	CreateSpectatorTextDraws(playerid);
	CreateNotificationTextDraws(playerid);
	CreateSelectFactionTextDraws(playerid);
	
	HideVehicleSpeedometer(playerid);
	DestroyGameBar(playerid);

	NameTagsConnect(playerid);

	//Player:
	SetPlayerColor(playerid, COLOR_WHITE);

	LastEnteredVehicle[playerid] = INVALID_VEHICLE_ID;

	EnablePlayerCameraTarget(playerid, true);
	TogglePlayerControllable(playerid, false);

	if(PlayerInfo[playerid][E_CHARACTER_INJURED] == 1)
	{
		SetPlayerTeam(playerid, PLAYER_STATE_WOUNDED);
	}
	else if(PlayerInfo[playerid][E_CHARACTER_DEATH] == 1)
	{
		SetPlayerTeam(playerid, PLAYER_STATE_DEAD);
	}
	else
	{
		SetPlayerTeam(playerid, PLAYER_STATE_ALIVE);
	}

	if(!IsPlayerNPC(playerid))
	{
		PlayerInfo[playerid][E_CHARACTER_ROBBERYACTOR] = -1;
		PlayerInfo[playerid][E_CHARACTER_HASROBBIZ] = false;
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerDisconnect called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif

	NameTagsDisconnect(playerid);
	
	new playerTime = NetStats_GetConnectedTime(playerid);
	new secondsConnection = (playerTime % (1000*60*60)) / (1000*60);
	
	PlayerInfo[playerid][E_CHARACTER_LASTONLINE] = secondsConnection;

	if(PlayerInfo[playerid][E_CHARACTER_SPAWNED] && PlayerInfo[playerid][E_CHARACTER_TUTORIAL])
	{
		SaveCharacter(playerid); SaveCharacterPos(playerid);
	}

	Query_UnloadPrivateVehicle(playerid);
	ResetPlayer(playerid);

	new businessid = IsPlayerInBusiness(playerid);
	if(PoolInfo[businessid][E_POOL_PLAYERAIMER] == playerid)
	{
		PoolInfo[businessid][E_POOL_PLAYERAIMER] = -1;
		DestroyDynamicObject(PoolInfo[businessid][E_POOL_AIMOBJECT]);
	}
	if(PoolInfo[businessid][E_POOL_STARTED])
	{
		foreach(new i : Player)
		{
			if(PlayingPool[i])
			{
				if(PoolInfo[businessid][E_POOL_PLAYERAIMER] != i)
				{
					PlayingPool[i] = false;

					if(PoolInfo[businessid][E_POOL_PLAYER1] == i)
					{
						PoolInfo[businessid][E_POOL_PLAYER1] = -1;
					}
					if(PoolInfo[businessid][E_POOL_PLAYER2] == i)
					{
						PoolInfo[businessid][E_POOL_PLAYER2] = -1;
					}

					if(PoolInfo[businessid][E_POOL_PLAYER1] == -1 && PoolInfo[businessid][E_POOL_PLAYER1] == -1)
					{
						PoolInfo[businessid][E_POOL_STARTED] = false;
						RespawnPoolBalls(0, businessid);
					}

					PoolInfo[businessid][E_POOL_STARTED] = false;
					RestorePoolStick(i);
					HideHeaderMessage(i);
					SendClientMessageEx(i, COLOR_PINK, "[8Ball] %s has ended pool at %s.", BusinessInfo[businessid][E_BUSINESS_NAME]);
				}
			}
		}
	}

	if(PlayerInfo[playerid][E_CHARACTER_TAKEPACKET] == true)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);

		PlayerInfo[playerid][E_CHARACTER_TAKEPACKET] = false;
		InsertPacket(x, y, z-1);
		foreach(new p : Player) if(PlayerInfo[p][E_CHARACTER_JOBS] == JOB_SMUGGLER)
		{
			SendClientMessage(p, COLOR_DARKGREEN, "[Word on the Streetz] Smuggler packet has been spawned '/findpacket' to track packet");
		}
	}
	
	if (PlayerInfo[playerid][E_CHARACTER_TAXIPLAYER] != INVALID_PLAYER_ID)
	    LeaveTaxi(playerid, PlayerInfo[playerid][E_CHARACTER_TAXIPLAYER]);

	foreach(new i : Player)
	{
		if(PlayerInfo[i][E_CHARACTER_FACTIONINVITED] == playerid)
		{
			PlayerInfo[i][E_CHARACTER_FACTIONINVITE] = 0;
			PlayerInfo[i][E_CHARACTER_FACTIONINVITED] = INVALID_PLAYER_ID;
			SendClientMessage(i, COLOR_FACTION, "Your faction invitation was disregarded. Your inviter disconnected.");
		}
	}

	if(PlayerInfo[playerid][E_CHARACTER_DOCKSWORK])
    {
        PlayerInfo[playerid][E_CHARACTER_DOCKSWORK] = false;
        ShowBoxMessage(playerid, "~r~Dockworker job stopped.", 5); 
		DestroyDynamicObject(CrateObject[PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]]);
		DestroyVehicle(PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]);
		GPS_DisablePlayerRaceCheckPoint(playerid);
    }   

	if(PlayerInfo[playerid][E_CHARACTER_SWEEPER] && PlayerSweeperIndex[playerid])
    {
        PlayerInfo[playerid][E_CHARACTER_SWEEPER] = false;
        ShowBoxMessage(playerid, "~r~Street Cleaner job stopped.", 5); 
		DestroyVehicle(PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]);
		GPS_DisablePlayerRaceCheckPoint(playerid);
    }   

	if(PlayerInfo[playerid][E_CHARACTER_BUSDRIVER] && PlayerBusDriverIndex[playerid])
    {
        PlayerInfo[playerid][E_CHARACTER_BUSDRIVER] = false;
        ShowBoxMessage(playerid, "~r~Bus Driver job stopped.", 5); 
		DestroyVehicle(PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]);
		GPS_DisablePlayerRaceCheckPoint(playerid);
    }   
	
	switch(reason)
	{
	    case 0: SendNearbyMessage(playerid, 20.0, COLOR_DARKGREEN, "** %s has left the GTA Storylines. (Timeout)", ReturnName(playerid));
	    case 1: SendNearbyMessage(playerid, 20.0, COLOR_DARKGREEN, "** %s has left the GTA Storylines. (Leaving)", ReturnName(playerid));
	    case 2: SendNearbyMessage(playerid, 20.0, COLOR_DARKGREEN, "** %s has left the GTA Storylines. (Kicked)", ReturnName(playerid));
	}

	return 1; 
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerEnterRaceCheckpoint called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif

	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
		if(PlayerTakingLicense[playerid])
		{
			if(PlayerCheckpoint[playerid] == GPS_DMVFINISH)
			{
				new Cents = floatround(100 * 100, floatround_round);
				StopDriverstest(playerid);
				GiveMoney(playerid, -Cents);
				SendInfoMessage(playerid, "[DMV] Congratulations %s, you've passed your test.", ReturnName(playerid)); 
				
				PlayerInfo[playerid][E_CHARACTER_DRIVELICENSE] = 1;
				SaveCharacter(playerid);
				
				PlayerCheckpoint[playerid] = GPS_NONE; 
				SetPlayerNeeds(playerid, -0.5);
				return 1; 
			}
		}

		if(PlayerLicensePoint[playerid] < sizeof LicensetestInfo && PlayerCheckpoint[playerid] == GPS_DMV)
		{
			SendClientMessage(playerid, COLOR_GREY, "License instructor says: Head to the next checkpoint."); 
			PlayerLicensePoint[playerid]++; 
			
			new idx = PlayerLicensePoint[playerid];
			
			GPS_SetPlayerRaceCheckPoint(playerid, 1, LicensetestInfo[idx][E_CHECKPOINTX], LicensetestInfo[idx][E_CHECKPOINTY], LicensetestInfo[idx][E_CHECKPOINTZ], 0.0, 0.0, 0.0, GPS_DMV);
			if(LicensetestInfo[idx][E_CHECKPOINT_FINISH])
			{
				PlayerCheckpoint[playerid] = GPS_DMVFINISH;
			}
		}

		if(PlayerInfo[playerid][E_CHARACTER_JOBS] == JOB_TRUCKER && PlayerTruckIndex[playerid])
		{
			if(PlayerCheckpoint[playerid] == GPS_TRUCKERS)
			{
				AttachVehicleFreight(playerid, vehicleid);
			}

			if(PlayerCheckpoint[playerid] == GPS_TRUCKERSFINISH && IsTrailerAttachedToVehicle(vehicleid))
			{
				DettachVehicleFreight(playerid, vehicleid);
			}
		}
		if(PlayerInfo[playerid][E_CHARACTER_SWEEPER] == true && PlayerCheckpoint[playerid] == GPS_SWEEPER)
		{
			new gstr[128];
			PlayerSweeperIndex[playerid]++;
			format(gstr, sizeof(gstr),"~w~Trash Collected~n~~r~%i~w~/~g~16", PlayerSweeperIndex[playerid]);
			ShowBoxMessage(playerid, gstr, 5);

			if(PlayerSweeperIndex[playerid] == 2) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[1][0], Sweeper_Index[1][1], Sweeper_Index[1][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint2
			else if(PlayerSweeperIndex[playerid] == 3) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[2][0], Sweeper_Index[2][1], Sweeper_Index[2][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint3
			else if(PlayerSweeperIndex[playerid] == 4) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[3][0], Sweeper_Index[3][1], Sweeper_Index[3][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint4
			else if(PlayerSweeperIndex[playerid] == 5) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[4][0], Sweeper_Index[4][1], Sweeper_Index[4][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint5
			else if(PlayerSweeperIndex[playerid] == 6) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[5][0], Sweeper_Index[5][1], Sweeper_Index[5][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint6
			else if(PlayerSweeperIndex[playerid] == 7) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[6][0], Sweeper_Index[6][1], Sweeper_Index[6][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint7
			else if(PlayerSweeperIndex[playerid] == 8) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[7][0], Sweeper_Index[7][1], Sweeper_Index[7][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint8
			else if(PlayerSweeperIndex[playerid] == 9) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[8][0], Sweeper_Index[8][1], Sweeper_Index[8][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint9
			else if(PlayerSweeperIndex[playerid] == 10) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[9][0], Sweeper_Index[9][1], Sweeper_Index[9][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint10
			else if(PlayerSweeperIndex[playerid] == 11) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[10][0], Sweeper_Index[10][1], Sweeper_Index[10][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint11
			else if(PlayerSweeperIndex[playerid] == 12) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[11][0], Sweeper_Index[11][1], Sweeper_Index[11][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint12
			else if(PlayerSweeperIndex[playerid] == 13) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[12][0], Sweeper_Index[12][1], Sweeper_Index[12][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint13
			else if(PlayerSweeperIndex[playerid] == 14) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[13][0], Sweeper_Index[13][1], Sweeper_Index[13][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint14
			else if(PlayerSweeperIndex[playerid] == 15) 
				GPS_SetPlayerRaceCheckPoint(playerid, 1, Sweeper_Index[14][0], Sweeper_Index[14][1], Sweeper_Index[14][2], 0.0, 0.0, 0.0, GPS_SWEEPER); // SweepCheckPoint15

			else if(PlayerSweeperIndex[playerid] == 16)
			{
				new rand = randomEx(6, 8);
				new total = (PlayerSweeperIndex[playerid] * rand);

            	new Cents = floatround(total * 100, floatround_round);

    			GiveMoney(playerid, Cents);

				ShowBoxMessage(playerid, "~r~Street Cleaner job ended.", 5); 
				SendJobsMessage(playerid, "[Street Cleaner] You've cleaned the street, current cleaned rubbish %d x rubbish and earn $%s.", PlayerSweeperIndex[playerid], FormatMoney(Cents));

				PlayerInfo[playerid][E_CHARACTER_SWEEPER] = false;
				PlayerSweeperIndex[playerid] = 0;
				PlayerInfo[playerid][E_CHARACTER_SWEEPERCD] = 8;

				SetPlayerNeeds(playerid, -0.2);
                    
				GPS_DisablePlayerRaceCheckPoint(playerid);
				DestroyVehicle(PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]);
			}
		}

		if(PlayerInfo[playerid][E_CHARACTER_BUSDRIVER] == true && PlayerCheckpoint[playerid] == GPS_BUSDRIVER)
		{
			SendJobsMessage(playerid, "[Bus Driver] Wait at this stop for a few seconds, The marker will disappear when ready.");

			new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);

            PlayerInfo[playerid][E_CHARACTER_LOADING] = true;
	        PlayerInfo[playerid][E_CHARACTER_LOADINGCOUNT] = 1;
	        PlayerInfo[playerid][E_CHARACTER_LOADINGDISPLAY] = Create3DTextLabel("Loading passenger entering process\n(( |------ ))", COLOR_3DTEXT, x, y, z, 25.0, 0, 1);
	        PlayerInfo[playerid][E_CHARACTER_LOADINGTIMER] = SetTimerEx("BusDrivers", 100, true, "ii", playerid, 0);
	        TogglePlayerControllable(playerid, false);
		}
		return 1;
    }

	if(PlayerCheckpoint[playerid] == GPS_NONE)
	{
    	GPS_DisablePlayerRaceCheckPoint(playerid);
		PlayerPlaySound(playerid, 1138, 0.0, 0.0, 0.0);
		return 1;
	}
    return 1;
}

public OnPlayerEnterDynamicArea(playerid, areaid)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerEnterDynamicArea called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif
	
	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
	{
		new i = Item_Nearest(playerid);
		if (areaid == BoomboxInfo[i][E_BOOMBOX_AREA] && BoomboxInfo[i][E_BOOMBOX_STATUS] == true)
		{
			PlayAudioStreamForPlayer(playerid, BoomboxInfo[i][E_BOOMBOX_URL], 
				DroppedInfo[i][E_DROPPED_POS][0], DroppedInfo[i][E_DROPPED_POS][1], 
				DroppedInfo[i][E_DROPPED_POS][2], 30.0, true); 
		}
	}

	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
	{
		for(new i = 0; i < sizeof(sc_VendingMachines); i++) 
		{
			if (s_VendingMachineArea[i] == areaid ) {

				OnPlayerApproachVending(playerid, i ) ;
				break;
			}
			else continue ;
		}
	}

	forex(i, MAX_TREES) if(TreeInfo[i][E_TREE_EXISTS])
	{
		if(areaid == TreeInfo[i][E_TREE_AREA])
		{
			new str[152];
			if(PlayerInfo[playerid][E_CHARACTER_JOBS] == JOB_LUMBERJACK)
			{
				if(TreeInfo[i][E_TREE_CUTTED])
				{
					format(str, sizeof(str), "Press '~r~ALT~w~' to load the timber.");
				}
				else
				{
					if(TreeInfo[i][E_TREE_TIMER] < 1)
					{
						format(str, sizeof(str), "Available to cut~n~Press '~r~ALT~w~' to begin.");
					}
					else
					{
						format(str, sizeof(str), "Available in: ~g~%d~w~ minutes", TreeInfo[i][E_TREE_TIMER]);
					}
				}
				ShowBoxMessage(playerid, str, 5);
			}
		}
	}
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, areaid)
{
	#if defined DEBUG_MODE
		printf("Callback OnLeaveDynamicArea called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif

	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
	{
		for(new i = 0; i < sizeof(sc_VendingMachines); i++) 
		{
			if(s_VendingMachineArea[i] == areaid) 
			{
				OnPlayerLeaveVending(playerid) ;
				break ;
			}
			else continue;
		}
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerRequestClass called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif

	if (IsPlayerNPC(playerid))
	    return 1;

	if (!AccountInfo[playerid][E_MASTERS_LOGGED])
	{
		TogglePlayerSpectating(playerid, true);
		SetTimerEx("LoginTimer", 500, false, "ii", playerid, g_RaceCheck{playerid});
	}
    return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerRequestSpawn called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif

    if (!IsPlayerAdmin(playerid))
    {
		SendErrorMessage(playerid, "You don't have permission to using Spawn Button");
        return 0;
    }
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	new Float: vehicle_health;
	GetVehicleHealth(vehicleid, vehicle_health); 

	#if defined DEBUG_MODE
		printf("Callback OnVehicleDeath called for Vehicle ID: %i (%s) (Health: %.2f) destroyed by %s", vehicleid, ReturnVehicleName(vehicleid), vehicle_health, ReturnName(killerid, killerid)); 
	#endif

	TotalledCheck(vehicleid);

	foreach(new i : Player) if(PlayerInfo[i][E_CHARACTER_DBID] == VehicleInfo[vehicleid][E_VEHICLE_OWNERDBID])
	{
		SendClientMessageEx(i, COLOR_RED, "Your %s was destroyed.", ReturnVehicleName(vehicleid)); 
	}
	return 1; 
}

public OnPlayerDeath(playerid, killerid, reason)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerDeath called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif
	
	foreach(new ii : Player)
    {
        if(IsPlayerAdmins(ii) && PlayerInfo[playerid][E_CHARACTER_ADMINDUTY])
        {
            SendDeathMessageToPlayer(ii, killerid, playerid, reason);
        }
    }
	
	if(PlayerInfo[playerid][E_CHARACTER_SPAWNED] && (gettime() - LastSpawn[playerid]) < 15 && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
	{
		SaveCharacterPos(playerid);
		SendClientMessage(playerid, COLOR_RED, "Died at spawn.[Just logged in]");
		CallLocalFunction("OnPlayerWounded", "ddd", playerid, playerid, 0);
		return 0;
	}
	
	if(reason == 51)
	{
		if(PlayerInfo[playerid][E_CHARACTER_SPAWNED] && GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{	
			SaveCharacterPos(playerid);
			CallLocalFunction("OnPlayerWounded", "ddd", playerid, playerid, 0);
			SendServerMessage(playerid, "You has been killed by Exploded at %s.", ReturnLocationStreet(playerid));
			return 0;
		}
	}
	if(reason == 50)
	{
		if(PlayerInfo[playerid][E_CHARACTER_SPAWNED] && GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{	
			SaveCharacterPos(playerid);
			CallLocalFunction("OnPlayerWounded", "ddd", playerid, playerid, 0);
			SendServerMessage(playerid, "You has been killed by Helicopter Bladed at %s.", ReturnLocationStreet(playerid));
			return 0;
		}
	}
	if(reason == 53)
	{
		if(PlayerInfo[playerid][E_CHARACTER_SPAWNED] && GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{	
			SetPlayerTeam(playerid, PLAYER_STATE_ALIVE); 
			SetPlayerHealthEx(playerid, 100.0);
			SetPlayerPosEx(playerid, 2032.9578,-1416.1289,16.9922);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SendServerMessage(playerid, "You has been killed by Drowning at %s.", ReturnLocationStreet(playerid));
			return 0;
		}	
	}
	if(reason == 54)
	{
		if(PlayerInfo[playerid][E_CHARACTER_SPAWNED] && GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{	
			SaveCharacterPos(playerid);
			CallLocalFunction("OnPlayerWounded", "ddd", playerid, playerid, 0);
			SendServerMessage(playerid, "You has been killed by Splat at %s.", ReturnLocationStreet(playerid));
			return 0;
		}	
	}
	if(reason == 255)
	{
		if(PlayerInfo[playerid][E_CHARACTER_SPAWNED] && GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
		{
			SaveCharacterPos(playerid);
			CallLocalFunction("OnPlayerWounded", "dud", playerid, playerid, 0);
			SendServerMessage(playerid, "You has been killed by Suicide at %s.", ReturnLocationStreet(playerid));
			return 0;
		}
	}

	PlayerInfo[playerid][E_CHARACTER_COURT] = 0;
	PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
    PlayerInfo[playerid][E_CHARACTER_ANIMBALL] = 0;
	PlayerInfo[playerid][E_CHARACTER_COURTTEAM] = 0;
    if(PlayerInfo[playerid][E_CHARACTER_HAVEBALL]) CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALLER] = 999;
	return 1; 
}	


public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerTakeDamage called for player %s (ID: %i) issuerid %s (ID: %i) weaponid %i", ReturnName(playerid), playerid, ReturnName(issuerid), issuerid, weaponid); 
	#endif

	switch(weaponid)
	{
		case 0:
		{
			amount = 2.0;
		}
		//Baseball bat
		case 4:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 1)
			{
				amount = 4.0;
			}
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 2)
			{
				amount = 4.0;
			}
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 3)
			{
				amount = 5.0;
			}
		}
		//Knife
		case 5:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 1)
			{
				amount = 6.0;
			}
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 2)
			{
				amount = 6.0;
			}
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 3)
			{
				amount = 5.0;
			}
		}
		//Glove
		case 1:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 1)
			{
				amount = 4.0;
			}
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 2)
			{
				amount = 4.0;
			}
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 3)
			{
				amount = 5.0;
			}
		}
		case 11:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 1)
			{
				amount = 5.0;
			}
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 2)
			{
				amount = 5.5;
			}
			if (PlayerInfo[issuerid][E_CHARACTER_WEAPONTYPE] == 3)
			{
				amount = 6.0;
			}
		}
		//Colt
		case 22:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 6.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 6.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 8.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 4.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 3.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 3.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 3.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 3.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//Silence
	    case 23:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 6.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 6.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 8.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 4.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 3.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 3.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 3.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 3.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//Deagle
		case 24:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 18.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 18.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 5.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//Shotgun
		case 25:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 18.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 18.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 5.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//Uzi
		case 28:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 8.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 5.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//TEC9
		case 32:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 8.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 5.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//MP5
		case 29:
		{
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 12.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 12.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 18.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 18.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 15.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 15.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 15.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[issuerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 6.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 6.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		case 54:
		{
			new randx = randomEx(1, 2);
			PlayerInfo[playerid][E_CHARACTER_BODYPART][5] -= 25;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][6] -= 25;

			if(PlayerInfo[playerid][E_CHARACTER_BODYPART][5] == WOUND_TYPE_BROKEN)
			{
				return PlayerInfo[playerid][E_CHARACTER_BODYPART][5] = WOUND_TYPE_BROKEN;
			}
			
			if(PlayerInfo[playerid][E_CHARACTER_BODYPART][6] == WOUND_TYPE_BROKEN)
			{
				return PlayerInfo[playerid][E_CHARACTER_BODYPART][6] = WOUND_TYPE_BROKEN;
			}	

			PlayerInfo[playerid][E_CHARACTER_BODYPART][6] = randx;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][5] = randx;
		}
		case 49:
		{
			new rand = randomEx(20, 30);
			new randx = randomEx(1, 2);
			PlayerInfo[playerid][E_CHARACTER_BODYPART][0] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][1] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][2] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][3] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][4] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][5] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][6] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][7] -= rand;

			for(new i; i < 8; i++)
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][i] = randx;
			}
		}
		case 51:
		{
			new rand = randomEx(40, 70);
			PlayerInfo[playerid][E_CHARACTER_BODYPART][0] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][1] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][2] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][3] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][4] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][5] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][6] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][7] -= rand;

			for(new i; i < 8; i++)
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][i] = 4;
			}
		}
	}

	new Float: healths = PlayerInfo[playerid][E_CHARACTER_HEALTH];
	if(healths >= 11 && healths <= 30 && PlayerInfo[playerid][E_CHARACTER_SPAWNED])
	{
		SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 200);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 500);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 200);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 200);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 200);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 200);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 50);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 250);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 200);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 200);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 300);

		SendServerMessage(playerid, "Low health, shooting skills at medium.");
	}
	if(healths <= 10 && PlayerInfo[playerid][E_CHARACTER_SPAWNED])
	{
		SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 0);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 100);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 100);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 100);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 100);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 100);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 0);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 100);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 100);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 100);
		SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 100);

		SendServerMessage(playerid, "Critical low health, shooting skills at minimum.");
	}

	if(GetPlayerWeapon(issuerid) > 21 && GetPlayerWeapon(issuerid) < 35)
	{
		switch(bodypart)
		{
			case BODY_PART_CHEST:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][0] = WOUND_TYPE_BULLET;
				PlayerInfo[playerid][E_CHARACTER_WOUND][1] = WOUND_TYPE_BULLET;
			}
			case BODY_PART_GROIN:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][2] = WOUND_TYPE_BULLET;
			}
			case BODY_PART_LEFT_ARM:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][4] = WOUND_TYPE_BULLET;
			}
			case BODY_PART_RIGHT_ARM:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][3] = WOUND_TYPE_BULLET;
			}
			case BODY_PART_LEFT_LEG:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][6] = WOUND_TYPE_BULLET;
			}
			case BODY_PART_RIGHT_LEG:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][5] = WOUND_TYPE_BULLET;
			}
			case BODY_PART_HEAD:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][7] = WOUND_TYPE_BULLET;
			}
		}
	}
	else
	{
		switch(bodypart)
		{
			case BODY_PART_CHEST:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][0] = WOUND_TYPE_BLEED;
				PlayerInfo[playerid][E_CHARACTER_WOUND][1] = WOUND_TYPE_BLEED;
			}
			case BODY_PART_GROIN:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][2] = WOUND_TYPE_BLEED;
			}
			case BODY_PART_LEFT_ARM:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][4] = WOUND_TYPE_BLEED;
			}
			case BODY_PART_RIGHT_ARM:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][3] = WOUND_TYPE_BLEED;
			}
			case BODY_PART_LEFT_LEG:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][6] = WOUND_TYPE_BLEED;
			}
			case BODY_PART_RIGHT_LEG:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][5] = WOUND_TYPE_BLEED;
			}
			case BODY_PART_HEAD:
			{
				PlayerInfo[playerid][E_CHARACTER_WOUND][7] = WOUND_TYPE_BLEED;
			}
		}
	}
	
	new rand = randomEx(5, 10);
	switch(bodypart)
	{
		case BODY_PART_CHEST:
		{
			PlayerInfo[playerid][E_CHARACTER_BODYPART][0] -= rand;
			PlayerInfo[playerid][E_CHARACTER_BODYPART][1] -= rand;
		}
		case BODY_PART_GROIN:
		{
			PlayerInfo[playerid][E_CHARACTER_BODYPART][2] -= rand;
		}
		case BODY_PART_LEFT_ARM:
		{
			PlayerInfo[playerid][E_CHARACTER_BODYPART][4] -= rand;
		}
		case BODY_PART_RIGHT_ARM:
		{
			PlayerInfo[playerid][E_CHARACTER_BODYPART][3] -= rand;
		}
		case BODY_PART_LEFT_LEG:
		{
			PlayerInfo[playerid][E_CHARACTER_BODYPART][6] -= rand;
		}
		case BODY_PART_RIGHT_LEG:
		{
			PlayerInfo[playerid][E_CHARACTER_BODYPART][5] -= rand;
		}
		case BODY_PART_HEAD:
		{
			PlayerInfo[playerid][E_CHARACTER_BODYPART][7] -= 50;
		}
	}

	if(issuerid != INVALID_PLAYER_ID)
	{
		new
			Float:health
		;
		
		PlayerInfo[playerid][E_CHARACTER_LASTDAMAGE] = gettime();
		GetPlayerHealth(playerid, health); 
		
		if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
			return 0;
		
		if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
		{
			SetPlayerHealthEx(playerid, health - amount); 
			CallbackDamages(playerid, issuerid, bodypart, weaponid, amount); 
		}
		
		if(health - amount <= 4)
		{
			if(weaponid == 49)
			{
				if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
				{	
					CallLocalFunction("OnPlayerWounded", "dud", playerid, issuerid, weaponid);
					SendServerMessage(issuerid, "You have been killed %s at %s.", ReturnName(playerid), ReturnLocationStreet(playerid));
					SendServerMessage(playerid, "You has been killed by %s at %s.", ReturnName(issuerid), ReturnLocationStreet(playerid));
					return 0;
				}
			}
			else
			{
				if(GetPlayerTeam(playerid) == PLAYER_STATE_ALIVE)
				{	
					CallLocalFunction("OnPlayerWounded", "dud", playerid, issuerid, weaponid); 
					return 0;
				}
			}
			return 0;
		}
		
		if(GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED)
		{		
			CallLocalFunction("OnPlayerDead", "dddd", playerid, issuerid, weaponid, 1);
			return 0;
		}
		
		if(GetPlayerTeam(playerid) != PLAYER_STATE_ALIVE)
		{
			SetPlayerHealthEx(playerid, health);
			return 0;
		}
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerWeaponShot called for player %s (ID: %i) hitid %s (ID: %i) weaponid %i", ReturnName(playerid), playerid, ReturnName(hitid), hitid, weaponid); 
	#endif

	if(hittype != BULLET_HIT_TYPE_NONE) // Bullet Crashing uses just this hittype
    {
        if(!(-1000.0 <= fX <= 1000.0) || !(-1000.0 <= fY <= 1000.0) || !(-1000.0 <= fZ <= 1000.0) )
        {
            KickEx(playerid);
            return false;
        }
    }

	if(hittype == BULLET_HIT_TYPE_PLAYER) //Death system; 
	{	
		if(GetPlayerTeam(hitid) == PLAYER_STATE_WOUNDED)
		{	
			CallLocalFunction("OnPlayerDead", "ddd", hitid, playerid, weaponid);
			return 0;
		} 
		else if(GetPlayerTeam(hitid) != PLAYER_STATE_ALIVE)
			return 0; 	
	}
	
	if(GetPlayerWeapon(playerid) == 22 || GetPlayerWeapon(playerid) == 23 || GetPlayerWeapon(playerid) == 24 || GetPlayerWeapon(playerid) == 25
	 || GetPlayerWeapon(playerid) == 26 || GetPlayerWeapon(playerid) == 28 || GetPlayerWeapon(playerid) == 29 || GetPlayerWeapon(playerid) == 32)
	{
		if(PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
		{
			new tstr[128];
			if(Inventory_Count(playerid, "Regular Ammo"))
			{
				Inventory_Remove(playerid, "Regular Ammo", 1);
				format(tstr, sizeof(tstr), "Weapons - %s - %d Regular", ReturnWeaponName(GetPlayerWeapon(playerid)), Inventory_Count(playerid, "Regular Ammo"));
				PlayerTextDrawSetString(playerid, WeaponType[playerid], tstr);
				PlayerTextDrawShow(playerid, WeaponType[playerid]);
			}
			else
			{
				PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = INVENTORY_NONE;
				ResetPlayerWeapons(playerid);
			}
		}
		if(PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
		{
			new tstr[128];
			if(Inventory_Count(playerid, "Surplus Ammo"))
			{
				Inventory_Remove(playerid, "Surplus Ammo", 1);
				format(tstr, sizeof(tstr), "Weapons - %s - %d Surplus", ReturnWeaponName(GetPlayerWeapon(playerid)), Inventory_Count(playerid, "Surplus Ammo"));
				PlayerTextDrawSetString(playerid, WeaponType[playerid], tstr);
				PlayerTextDrawShow(playerid, WeaponType[playerid]);
			}
			else
			{
				PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = INVENTORY_NONE;
				ResetPlayerWeapons(playerid);
			}
		}
		if(PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
		{
			new tstr[128];
			if(Inventory_Count(playerid, "JHP Ammo"))
			{
				Inventory_Remove(playerid, "JHP Ammo", 1);
				format(tstr, sizeof(tstr), "Weapons - %s - %d Jacket Hollow Point", ReturnWeaponName(GetPlayerWeapon(playerid)), Inventory_Count(playerid, "JHP Ammo"));
				PlayerTextDrawSetString(playerid, WeaponType[playerid], tstr);
				PlayerTextDrawShow(playerid, WeaponType[playerid]);
			}
			else
			{
				PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = INVENTORY_NONE;
				ResetPlayerWeapons(playerid);
			}
		}
		if(PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
		{
			new tstr[128];
			if(Inventory_Count(playerid, "Rubber Ammo"))
			{
				Inventory_Remove(playerid, "Rubber Ammo", 1);
				format(tstr, sizeof(tstr), "Weapons - %s - %d Rubber", ReturnWeaponName(GetPlayerWeapon(playerid)), Inventory_Count(playerid, "JHP Ammo"));
				PlayerTextDrawSetString(playerid, WeaponType[playerid], tstr);
				PlayerTextDrawShow(playerid, WeaponType[playerid]);
			}
			else
			{
				PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = INVENTORY_NONE;
				ResetPlayerWeapons(playerid);
			}
		}
	}

	if(PlayerInfo[playerid][E_CHARACTER_POLICEGUN] && weaponid == 23)
	{
		SetPlayerArmedWeapon(playerid, 0); 
		
		ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid, "SILENCED", "Silence_reload", 4.1, 0, 1, 1, 1, 1, 1);
		
		SetTimerEx("OnTaserShoot", 1100, false, "i", playerid); 
	}
	
	if(hittype == BULLET_HIT_TYPE_PLAYER) //Taser system; 
	{
		if(PlayerInfo[playerid][E_CHARACTER_POLICEGUN] && weaponid == 23)
		{
			if(!IsPlayerNearPlayer(playerid, hitid, 15.0))
			{
				SendServerMessage(playerid, "You aren't close enough to hit %s with your taser.", ReturnName(hitid, hitid));
				return 0;
			}
			
			SetPlayerDrunkLevel(hitid, 4000); 
			TogglePlayerControllable(playerid, true);
			
			SendNearbyMessage(hitid, 20.0, COLOR_EMOTE, "* %s falls on the ground after being hit by %s's taser.", ReturnName(hitid, hitid), ReturnName(playerid)); 
			GameTextForPlayer(hitid, "~b~You Are Tasered", 2500, 3);
			
			SendServerMessage(hitid, "You were just hit by a taser. 10,000 volts go through your body.");
			SendServerMessage(playerid, "You hit %s with your taser!", ReturnName(hitid, hitid)); 
			
			ClearAnimations(playerid, 1);
			SetTimerEx("OnPlayerTasered", 1200, false, "i", hitid); 
			return 0;
		}
	}
	else if(hittype == BULLET_HIT_TYPE_PLAYER) //Rubber 
	{
		if(PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER && weaponid == 25)
		{
			if(!IsPlayerNearPlayer(playerid, hitid, 15.0))
			{
				SendServerMessage(playerid, "You aren't close enough to hit %s with your rubber gun.", ReturnName(hitid, hitid));
				return 0;
			}
			
			TogglePlayerControllable(playerid, true);
			
			SendNearbyMessage(hitid, 20.0, COLOR_EMOTE, "* %s falls on the ground after being hit by %s's rubber gun.", ReturnName(hitid, hitid), ReturnName(playerid)); 
			
			SendServerMessage(hitid, "You were just hit by a rubber gun. rubber bullet go through your body.");
			SendServerMessage(playerid, "You hit %s with your taser!", ReturnName(hitid, hitid)); 
			
			ClearAnimations(playerid, 1);
			SetTimerEx("OnPlayerRubber", 1200, false, "i", hitid); 
			return 0;
		}
	}

	if(IsPlayerInProperty(playerid) != -1)
	{
		new i = IsPlayerInProperty(playerid);

		if((gettime() - PropertyInfo[i][E_PROPERTY_SHOOTINGTIMER]) >= 180)
		{
			PropertyInfo[i][E_PROPERTY_SHOOTINGTIMER] = gettime();
			
			new street[60];
			Get2DPosZone(PropertyInfo[i][E_PROPERTY_ENTRANCEPOS][0], PropertyInfo[i][E_PROPERTY_ENTRANCEPOS][1], street, MAX_ZONE_NAME);

			foreach (new x : Player)
			{
				if(IsPlayerInProperty(x) == i) continue;

				if(IsPlayerInRangeOfPoint(x, 30.0, PropertyInfo[i][E_PROPERTY_ENTRANCEPOS][0], PropertyInfo[i][E_PROPERTY_ENTRANCEPOS][1], PropertyInfo[i][E_PROPERTY_ENTRANCEPOS][2]))
				{
					SendClientMessageEx(x, COLOR_EMOTE, "* [%s %s] A gun goes off inside and the shot being fired is heard.", PropertyInfo[i][E_PROPERTY_ADDRESS], street);
				}
			}
		}
	}
	if(IsPlayerInBusiness(playerid) != -1)
	{
		new i = IsPlayerInBusiness(playerid);

		if((gettime() - BusinessInfo[i][E_BUSINESS_SHOOTINGTIMER]) >= 180)
		{
			BusinessInfo[i][E_BUSINESS_SHOOTINGTIMER] = gettime();
			
			foreach (new x : Player)
			{
				if(IsPlayerInBusiness(x) == i) continue;

				if(IsPlayerInRangeOfPoint(x, 30.0, BusinessInfo[i][E_BUSINESS_ENTRANCEPOS][0], BusinessInfo[i][E_BUSINESS_ENTRANCEPOS][1], BusinessInfo[i][E_BUSINESS_ENTRANCEPOS][2]))
				{
					SendClientMessageEx(x, COLOR_PURPLE, "* [%s] A gun goes off inside and the shot being fired is heard.", BusinessInfo[i][E_BUSINESS_NAME]);
				}
			}
		}
	}
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerGiveDamage called for player %s (ID: %i) issuerid %s (ID: %i) weaponid %i", ReturnName(playerid), playerid, ReturnName(damagedid), damagedid, weaponid); 
	#endif

	switch(weaponid)
	{
		case 0:
		{
			amount = 2.0;

			if(TackleMode[playerid])
			{
				TacklePlayer(playerid, damagedid);
				return 0;
			}
		}
		//Baseball bat
		case 4:
		{
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 1)
			{
				amount = 4.0;
			}
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 2)
			{
				amount = 4.0;
			}
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 3)
			{
				amount = 5.0;
			}
		}
		//Knife
		case 5:
		{
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 1)
			{
				amount = 6.0;
			}
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 2)
			{
				amount = 6.0;
			}
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 3)
			{
				amount = 5.0;
			}
		}
		//Glove
		case 1:
		{
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 1)
			{
				amount = 4.0;
			}
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 2)
			{
				amount = 4.0;
			}
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 3)
			{
				amount = 5.0;
			}
		}
		//DILDO AOWKKWKWKWK
		case 11:
		{
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 1)
			{
				amount = 5.0;
			}
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 2)
			{
				amount = 5.5;
			}
			if (PlayerInfo[playerid][E_CHARACTER_WEAPONTYPE] == 3)
			{
				amount = 6.0;
			}
		}
		//Colt
		case 22:
		{
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 6.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 6.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 8.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 4.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 3.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 3.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 3.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 3.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//Silence
	    case 23:
		{
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 6.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 6.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 8.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 4.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 3.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 3.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 3.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 3.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//Deagle
		case 24:
		{
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 18.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 18.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 5.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//Shotgun
		case 25:
		{
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 18.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 18.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 5.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//Uzi
		case 28:
		{
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 8.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 5.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//TEC9
		case 32:
		{
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 8.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 7.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 7.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 10.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 8.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 8.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 5.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 4.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 4.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
		//MP5
		case 29:
		{
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_NORMAL)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 12.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 12.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 10.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 10.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 40.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_SURPLUS)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 15.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 12.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 12.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_JHP)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 18.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 18.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 15.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 15.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 15.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 15.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
			if (PlayerInfo[playerid][E_CHARACTER_AMMOTYPE] == AMMO_TYPE_RUBBER)
			{
				switch(bodypart)
				{
					case BODY_PART_CHEST:
					{
						amount = 6.0;
					}
					case BODY_PART_GROIN:
					{
						amount = 6.0;
					}
					case BODY_PART_LEFT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_ARM:
					{
						amount = 5.0;
					}
					case BODY_PART_LEFT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_RIGHT_LEG:
					{
						amount = 5.0;
					}
					case BODY_PART_HEAD:
					{
						amount = 50.0;
					}
				}
			}
		}
	}

	if(PlayerInfo[playerid][E_CHARACTER_TOGDMS] == false)
	{
		if(GetPlayerWeapon(playerid) > 21)
		{
			switch(bodypart)
			{
				case 3:
				{
					new string[128], victim[MAX_PLAYER_NAME];
					GetPlayerName(damagedid, victim, sizeof (victim));
					format(string, sizeof(string), "* You shot at %s on Torso and made him loose %.0f health.", victim, amount);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
				}
				case 4:
				{
					new string[128], victim[MAX_PLAYER_NAME];
					GetPlayerName(damagedid, victim, sizeof (victim));
					format(string, sizeof(string), "* You shot at %s on Groin and made him loose %.0f health.", victim, amount);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
				}
				case 5:
				{
					new string[128], victim[MAX_PLAYER_NAME];
					GetPlayerName(damagedid, victim, sizeof (victim));
					format(string, sizeof(string), "* You shot at %s on LeftArm and made him loose %.0f health.", victim, amount);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
				}
				case 6:
				{
					new string[128], victim[MAX_PLAYER_NAME];
					GetPlayerName(damagedid, victim, sizeof (victim));
					format(string, sizeof(string), "* You shot at %s on RightArm and made him loose %.0f health.", victim, amount);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
				}
				case 7:
				{
					new string[128], victim[MAX_PLAYER_NAME];
					GetPlayerName(damagedid, victim, sizeof (victim));
					format(string, sizeof(string), "* You shot at %s on LeftLeg and made him loose %.0f health.", victim, amount);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
				}
				case 8:
				{
					new string[128], victim[MAX_PLAYER_NAME];
					GetPlayerName(damagedid, victim, sizeof (victim));
					format(string, sizeof(string), "* You shot at %s on RightLeg and made him loose %.0f health.", victim, amount);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
				}
				case 9:
				{
					new string[128], victim[MAX_PLAYER_NAME];
					GetPlayerName(damagedid, victim, sizeof (victim));
					format(string, sizeof(string), "* You shot at %s on Head and made him loose %.0f health.", victim, amount);
					SendClientMessageEx(playerid, COLOR_WHITE, string);
				}
			}
		}	
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{	
	#if defined DEBUG_MODE
		printf("Callback OnPlayerSpawn called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif

	LastSpawn[playerid] = gettime();
	
	if(PlayerInfo[playerid][E_CHARACTER_INJURED] == 1)
	{
		SetPlayerTeam(playerid, PLAYER_STATE_WOUNDED);
	}
	else if(PlayerInfo[playerid][E_CHARACTER_DEATH] == 1)
	{
		SetPlayerTeam(playerid, PLAYER_STATE_DEAD);
	}
	else
	{
		SetPlayerTeam(playerid, PLAYER_STATE_ALIVE);
	}

	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 250);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 250);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 200);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 500);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 500);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, 500);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 50);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 250);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 300);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, 200);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 300);

	SetCameraBehindPlayer(playerid); 

	if(PlayerInfo[playerid][E_CHARACTER_ADMINJAILED] == true)
	{
		ClearAnimations(playerid); 
		
		SetPlayerPosEx(playerid, -10.5146,2337.2961,24.3034);
		SetPlayerInteriorEx(playerid, 0); SetPlayerVirtualWorldEx(playerid, 1338);
		
		SendInfoMessage(playerid, "[JAIL] You're currently admin jailed. You have %i minutes left.", PlayerInfo[playerid][E_CHARACTER_ADMINJAIL] / 60);
	}
	else if(PlayerInfo[playerid][E_CHARACTER_PRISONED] == true)
	{
		ClearAnimations(playerid); 
		
		SetPlayerInPrison(playerid);
		
		SendInfoMessage(playerid, "[PRISON] You're currently prison. You have %i minutes left.", PlayerInfo[playerid][E_CHARACTER_PRISON] / 60);
	}
	else
	{
		if(PlayerInfo[playerid][E_CHARACTER_SPECTATE] != INVALID_PLAYER_ID)
		{
			SetPlayerPos(playerid, PlayerInfo[playerid][E_CHARACTER_LASTPOS][0], PlayerInfo[playerid][E_CHARACTER_LASTPOS][1], PlayerInfo[playerid][E_CHARACTER_LASTPOS][2]);
			PlayerInfo[playerid][E_CHARACTER_SPECTATE] = INVALID_PLAYER_ID;
		}
		if(PlayerInfo[playerid][E_CHARACTER_DIEUNKNOWN] == true)
		{
			SetPlayerHealthEx(playerid, 100);
			SetPlayerPosEx(playerid, 2032.9578,-1416.1289,16.9922);
			SetPlayerInteriorEx(playerid, 0);
			SetPlayerVirtualWorldEx(playerid, 0);
			PlayerInfo[playerid][E_CHARACTER_DIEUNKNOWN] = false;
			SetPlayerTeam(playerid, PLAYER_STATE_ALIVE); 
		}
		if(GetPlayerTeam(playerid) == PLAYER_STATE_WOUNDED && PlayerInfo[playerid][E_CHARACTER_INJURED])
		{	
			CallLocalFunction("OnPlayerWounded", "ddd", playerid, playerid, 0);
		}
		if(GetPlayerTeam(playerid) == PLAYER_STATE_DEAD && PlayerInfo[playerid][E_CHARACTER_DEATH])
		{	
			CallLocalFunction("OnPlayerDead", "dddd", playerid, playerid, 0, 0);
		}
		else SetPlayersSpawn(playerid); 
	}

	if(!PlayerInfo[playerid][E_CHARACTER_TUTORIAL])
	{
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][E_CHARACTER_LASTSKIN], 1684.4392, 1771.6658, 10.8203, 270.0000, 0, 0, 0, 0, 0, 0);
		TogglePlayerSpectating(playerid, true);
		
		InterpolateCameraPos(playerid, 1413.479736, -1727.495483, 32.772384, 1551.484497, -1726.705932, 32.781917, 8000, 1);
        InterpolateCameraLookAt(playerid, 1415.520385, -1730.730590, 31.602050, 1548.272216, -1729.019531, 32.208690, 8000, 1);
		SetPlayerPos(playerid, PlayerInfo[playerid][E_CHARACTER_LASTPOS][0], PlayerInfo[playerid][E_CHARACTER_LASTPOS][1], PlayerInfo[playerid][E_CHARACTER_LASTPOS][2]);
		PlayerInfo[playerid][E_CHARACTER_TUTORIALSTEP] = 1;
		TogglePlayerControllable(playerid, false);
		SelectTextDraw(playerid, COLOR_YELLOW);
		ShowTutorial(playerid);
	}

	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 300);
	Streamer_Update(playerid, STREAMER_TYPE_OBJECT);
	PlayerTextDrawShow(playerid, servername[playerid]);
	ShowMoneyFormat(playerid);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerText called for player %s (ID: %i) says : %s", ReturnName(playerid), playerid, text); 
	#endif

	SendPlayerChatText(playerid, text);

	PlayerInfo[playerid][E_CHARACTER_AFKPOS][0] = 0.0;
	PlayerInfo[playerid][E_CHARACTER_AFKPOS][1] = 0.0;
	PlayerInfo[playerid][E_CHARACTER_AFKPOS][2] = 0.0;
	return 0;
}

public OnPlayerUpdate(playerid)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerUpdate called for player %s (ID: %i)", ReturnName(playerid), playerid); 
	#endif

	if(PlayerInfo[playerid][E_CHARACTER_ADMINDUTY])
	{
		PauseAC(playerid);
	}

	if(!PlayerInfo[playerid][E_CHARACTER_SPAWNED])
	{
		SetPlayerHealthEx(playerid, 100.0);
		TogglePlayerControllable(playerid, false);
	}

	if(PlayerInfo[playerid][E_CHARACTER_SPAWNED] == true)
	{
		if(Inventory_Count(playerid, "Fabric Cargo") > 0 || Inventory_Count(playerid, "Steel Cargo") > 0 || Inventory_Count(playerid, "Woods Cargo") > 0 
		|| Inventory_Count(playerid, "Foods Cargo") > 0 || Inventory_Count(playerid, "Clothes Cargo") > 0 || Inventory_Count(playerid, "Appliances Cargo") > 0
		|| Inventory_Count(playerid, "Fish Cargo") > 0)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerAttachedObject(playerid, ATTACH_CARGO, 2912, 1, -0.293999, 0.497999, -0.006000, -99.500007, 90.300033, 99.600013, 0.620999, 0.673000, 0.648999);
			PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = CRATES;

		}
		else if(Inventory_Count(playerid, "Woods") > 0)
		{
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerAttachedObject(playerid, ATTACH_CARGO, 1463, 1, 0.000000, 0.465000, 0.000000, 0.000000, 89.699958, 0.000000, 0.348999, 0.340999, 0.444999);
			PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = WOODS;
		}
		else
		{
			if(PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] == CRATES || PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] == WOODS)
			{
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
				RemovePlayerAttachedObject(playerid, ATTACH_CARGO);
				PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = INVENTORY_NONE;
				
			}
		}
		if(PlayerJump[playerid][JumpPressed])
		{
			if (gettime() - PlayerJump[playerid][JumpPressed] >= 5)
			{
				PlayerJump[playerid][JumpPressed] = 0;
				return 1;
			}
		
			if (GetPlayerAnimationIndex(playerid) == 1197 || GetPlayerAnimationIndex(playerid) == 1198)
			{
				PlayerJump[playerid][JumpAt] = gettime();
				PlayerJump[playerid][JumpPressed] = 0;
			}
		}
		
		if (PlayerJump[playerid][JumpAt])
		{
			if (GetPlayerAnimationIndex(playerid) == 1196)
			{
				if (PlayerJump[playerid][JumpCD] && gettime() - PlayerJump[playerid][JumpCD] < 5)
				{
					PauseAC(playerid);
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "ped", "fall_collapse", 4.1, 0, 1, 1, 0, 0);
				}
				
				PlayerJump[playerid][JumpAt] = 0;
				PlayerJump[playerid][JumpCD] = gettime();
			}
		}
	}

	new keys, ud, lr;
	GetPlayerKeys(playerid, keys, ud, lr);
	if((keys & KEY_FIRE) && IsFireActive() && ReturnFactionType(playerid) == FACTION_TYPE_MEDICAL)
	{
		new Float:x, Float:y, Float:z, Float:vx, Float:vy, Float:vz, Float:cx, Float:cy, Float:cz;

		if(PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] == FEXTINGUISHER && GetPlayerWeapon(playerid) == 42 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
		{
		    for(new i = 0; i < MAX_FIRES; i ++)
		    {
		        if(IsPlayerInRangeOfDynamicObject(playerid, gFireObjects[i], 4.0))
		        {
		            gFireHealth[i] = gFireHealth[i] - 1.0;

		            if(gFireHealth[i] <= 0.0)
		            {
			            GetDynamicObjectPos(gFireObjects[i], x, y, z);
			            ShowBoxMessage(playerid, "~r~Fire extinguished", 3);

						SetTimerEx("DestroyWater", 2000, false, "i", CreateDynamicObject(18744, x, y, z - 0.2, 0.0, 0.0, 0.0));
						DestroyDynamicObject(gFireObjects[i]);

						gFireObjects[i] = INVALID_OBJECT_ID;
						gFireHealth[i] = 0.0;
					}
		        }
			}
		}
		else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 407 || GetVehicleModel(GetPlayerVehicleID(playerid)) == 544)
		{
		    GetPlayerCameraFrontVector(playerid, vx, vy, vz);
		    GetPlayerCameraPos(playerid, cx, cy, cz);

		    for(new i = 0; i < MAX_FIRES; i ++)
		    {
		        if(IsPlayerInRangeOfDynamicObject(playerid, gFireObjects[i], 12.0))
		        {
		            GetDynamicObjectPos(gFireObjects[i], x, y, z);

					if(DistanceCameraTargetToLocation(cx, cy, cz, x, y, z + 2.5, vx, vy, vz) < 12.0)
	   				{
	   				    gFireHealth[i] = gFireHealth[i] - 0.5;

	   				    if(gFireHealth[i] <= 0.0)
		            	{
		   			    	GetDynamicObjectPos(gFireObjects[i], x, y, z);
		   			    	ShowBoxMessage(playerid, "~r~Fire extinguished", 3);
							
							SetTimerEx("DestroyWater", 2000, false, "i", CreateDynamicObject(18744, x, y, z - 0.2, 0.0, 0.0, 0.0));
							DestroyDynamicObject(gFireObjects[i]);

							gFireObjects[i] = INVALID_OBJECT_ID;
							gFireHealth[i] = 0.0;
						}
					}
			  	}
		    }
		}
		if(!IsFireActive())
		{
		    new Float:amount = gFires;
			new Cents = floatround(amount * 100, floatround_round);
		    foreach(new i : Player)
		    {
		        if(ReturnFactionType(i) == FACTION_TYPE_MEDICAL && IsPlayerInRangeOfPoint(playerid, 20.0, x, y, z))
		        {
		            SendInfoMessage(i, "[FIRE] Well done! You helped put out the fire and received $%s on your paycheck.", FormatMoney(Cents));
		            GivePaycheck(i, Cents);
		        }
			}

			gFires = 0;
		}
	}

	foreach(new i : Player)
	{
		if(PlayerInfo[playerid][E_CHARACTER_SPECTATE] == i)
		{
			UpdateSpectatorPanel(playerid, i);
		}
	}

	//Anti-Money Hack
	if(GetPlayerMoney(playerid) > PlayerInfo[playerid][E_CHARACTER_MONEY])
	{
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, PlayerInfo[playerid][E_CHARACTER_MONEY]);
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerClickPlayerTextDraw called for player %s (ID: %i) TextDraw : %d", ReturnName(playerid), playerid, playertextid); 
	#endif

	// CHARACTER SELECTIONS:
	if (playertextid == SelectFactionClick[0][playerid]) //PREV
	{
		SwitchPrevCharacterSelection(playerid);
	}
	if (playertextid == SelectFactionClick[1][playerid]) //NEXT
	{	
		SwitchNextCharacterSelection(playerid);
	}
	if (playertextid == SelectFactionClick[2][playerid]) //SELECT
	{
		if(characterSelection[playerid])
		{
			if(PlayerInfo[playerid][E_CHARACTER_SELECTCHAR] == 0)
			{
				/*if (characterLister[playerid][0][0] == EOS)
					return ShowCharacterSelection(playerid);*/

				SelectCharacter(playerid, 0);
			}
			else if(PlayerInfo[playerid][E_CHARACTER_SELECTCHAR] == 1)
			{
				/*if (characterLister[playerid][0][0] == EOS)
					return ShowCharacterSelection(playerid);*/

				SelectCharacter(playerid, 1);
			}
			else if(PlayerInfo[playerid][E_CHARACTER_SELECTCHAR] == 2)
			{
				/*if (characterLister[playerid][0][0] == EOS)
					return ShowCharacterSelection(playerid);*/

				SelectCharacter(playerid, 2);
			}
			else if(PlayerInfo[playerid][E_CHARACTER_SELECTCHAR] == 3)
			{
				/*if (characterLister[playerid][0][0] == EOS)
					return ShowCharacterSelection(playerid);*/

				SelectCharacter(playerid, 3);
			}
		}
	}
	// Tutorial:
	if (playertextid == tutorialclick[playerid])
    {
		if(PlayerInfo[playerid][E_CHARACTER_TUTORIAL] == 0 && PlayerInfo[playerid][E_CHARACTER_TUTORIALSTEP] != 16)
		{
			NextTutorial(playerid);
		}
		return 1;
    }

	if (playertextid == tutorialskip[playerid])
    {
		if(PlayerInfo[playerid][E_CHARACTER_TUTORIAL] == 0 && PlayerInfo[playerid][E_CHARACTER_TUTORIALSTEP] != 16)
		{
			PlayerInfo[playerid][E_CHARACTER_TUTORIALSTEP] = 0;
			PlayerInfo[playerid][E_CHARACTER_TUTORIAL] = 1;
			SaveCharacter(playerid);

			PlayerTextDrawHide(playerid, tutorialtext[playerid]);
			PlayerTextDrawHide(playerid, tutorialbox[playerid]);
			PlayerTextDrawHide(playerid, tutorialheader[playerid]);
			PlayerTextDrawHide(playerid, tutorialclick[playerid]);
			PlayerTextDrawHide(playerid, tutorialskip[playerid]);
			CancelSelectTextDraw(playerid);

			SetCameraBehindPlayer(playerid);
			LoadCharacter(playerid);
			TogglePlayerSpectating(playerid, false);
		}
		return 1;
    }

	//POOL
	if (playertextid == pool[0][playerid]) //Shoot
    {
		new businessid = IsPlayerInBusiness(playerid);
		if(PoolInfo[businessid][E_POOL_PLAYERAIMER] == playerid)
		{
			new
				Float:speed;
			ApplyAnimation(playerid, "POOL", "POOL_Med_Shot",3.0,0,0,0,0,0,1);
			speed = 0.4 + (PoolInfo[businessid][E_POOL_POWER] * 2.0) / 100.0;
			PHY_SetObjectVelocity(PoolBall[0][businessid][E_POOLBALL_OBJECT], speed * floatsin(-AimAngle[playerid][0], degrees), speed * floatcos(-AimAngle[playerid][0], degrees));
			if(PoolCamera[playerid] == 0)
			{
				switch(random(2))
				{
					case 0: SetPlayerCameraPos(playerid, 511.84469604492, -84.831642150879, 1001.4904174805);
					case 1: SetPlayerCameraPos(playerid, 508.7971496582, -84.831642150879, 1001.4904174805);
				}
				SetPlayerCameraLookAt(playerid,510.11267089844, -84.831642150879, 998.86785888672);
			}
			
			for(new a; a < 5; a++)
			{
				PlayerTextDrawHide(playerid, pool[a][playerid]);
			}
			CancelSelectTextDraw(playerid);
			PoolInfo[businessid][E_POOL_PLAYERAIMER] = -1;
			DestroyObject(PoolInfo[businessid][E_POOL_AIMOBJECT]);
			PoolInfo[businessid][E_POOL_LASTSHOOTER] = playerid;
		}
		return 1;
    }
	if (playertextid == pool[1][playerid]) //Left
    {
		ProcessPoolMovement(playerid, -1);
		return 1;
    }
	if (playertextid == pool[2][playerid]) //Right
    {
		ProcessPoolMovement(playerid, 1);
		return 1;
    }
	if (playertextid == pool[4][playerid]) //Exit
    {
		new businessid = IsPlayerInBusiness(playerid);
		for(new a; a < 5; a++)
		{
			PlayerTextDrawHide(playerid, pool[a][playerid]);
		}
		CancelSelectTextDraw(playerid);
		TogglePlayerControllable(playerid, 1);
		ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0, 1);
		SetCameraBehindPlayer(playerid);
		PoolInfo[businessid][E_POOL_PLAYERAIMER] = -1;
		DestroyObject(PoolInfo[businessid][E_POOL_AIMOBJECT]);
		return 1;
    }

	//HOTWIRE
	for (new i = 0; i < 8; i++)
    {
        if (playertextid == HotwireTD[playerid][i])
        {
            if (HotwireFirstClick[playerid] == -1)
            {
                HotwireFirstClick[playerid] = i;
            }
            else if (HotwireFirstClick[playerid] != i)
            {
                if (HotwireActive[playerid][i] == HotwireActive[playerid][HotwireFirstClick[playerid]])
                {
                    HotwireClicked[playerid]++;

                    if (HotwireClicked[playerid] == 8 / 2)
					{
						new str[128], vehicleid = GetPlayerVehicleID(playerid);
						if(VehicleInfo[vehicleid][E_VEHICLE_FUEL] < 1 && !VehicleInfo[vehicleid][E_VEHICLE_ADMIN])
							return SendClientMessage(playerid, COLOR_RED, "Vehicle is out of fuel!"); 
						
						if(!VehicleInfo[vehicleid][E_VEHICLE_ENGINE])
						{	ShowBoxMessage(playerid, "~g~Turn on engine.", 5);
							PlayerEngineValue[playerid] = 0;
							PlayerEngineTimer[playerid] = SetTimerEx("TurnEngine", 500, true, "dd", playerid, vehicleid);
							format(str, sizeof(str), "twists the key turning the engine of the %s on", ReturnVehicleName(vehicleid));
							cmd_me(playerid, str);
						}
                        StopHotwire(playerid);
                    }
                }
                else
                {
                    SendVehicleMessage(playerid, "[HOTWIRE] Hotwire failed.");
                }
                HotwireFirstClick[playerid] = -1;
            }
            return 1;
        }
    }

	//Hit BlackJack
	if (playertextid == blackjack[13][playerid])
    {
		new businessid = IsPlayerInBusiness(playerid);

		if (!blackjackInProgress[playerid])
			return SendErrorMessage(playerid, "You aren't started a blackjack.");
			
		if (blackjackPlayerCardsCount[playerid] >= MAX_CARDS)
			return SendErrorMessage(playerid, "You can't draw more cards.");

		blackjackPlayerCards[playerid][blackjackPlayerCardsCount[playerid]++] = cardDeck[blackjackPlayerCardsCount[playerid] + BusinessInfo[businessid][E_BUSINESS_DEALER_CARDCOUNT]];
		blackjackPlayerScore[playerid] = CalculateScore(blackjackPlayerCards[playerid], blackjackPlayerCardsCount[playerid]);

		ShowCards(playerid, blackjackPlayerCards[playerid], blackjackPlayerCardsCount[playerid], "Player");
		ShowCards(playerid, BusinessInfo[businessid][E_BUSINESS_DEALER_CARD], BusinessInfo[businessid][E_BUSINESS_DEALER_CARDCOUNT], "Dealer");

		if (blackjackPlayerScore[playerid] > 21)
		{
			SendClientMessageEx(playerid, COLOR_PINK, "[Blackjack] You lost! Your cards exceeded 21 (Bust).");
			ResetBlackjack(playerid);
			return 1;
		}
	}

	//Stand BlackJack
	if (playertextid == blackjack[14][playerid])
    {
		new businessid = IsPlayerInBusiness(playerid);

		if (!blackjackInProgress[playerid])
			return SendErrorMessage(playerid, "You aren't started a blackjack.");
			
		while (BusinessInfo[businessid][E_BUSINESS_DEALER_SCORE] < 17 && BusinessInfo[businessid][E_BUSINESS_DEALER_CARDCOUNT] < MAX_CARDS)
		{
			BusinessInfo[businessid][E_BUSINESS_DEALER_CARD][BusinessInfo[businessid][E_BUSINESS_DEALER_CARDCOUNT]++] = cardDeck[blackjackPlayerCardsCount[playerid] + BusinessInfo[businessid][E_BUSINESS_DEALER_CARDCOUNT]];
			BusinessInfo[businessid][E_BUSINESS_DEALER_SCORE] = CalculateScore(BusinessInfo[businessid][E_BUSINESS_DEALER_CARD], BusinessInfo[businessid][E_BUSINESS_DEALER_CARDCOUNT]);
		}

		ShowCards(playerid, BusinessInfo[businessid][E_BUSINESS_DEALER_CARD], BusinessInfo[businessid][E_BUSINESS_DEALER_CARDCOUNT], "Dealer");

		if (BusinessInfo[businessid][E_BUSINESS_DEALER_SCORE] > 21 || blackjackPlayerScore[playerid] > BusinessInfo[businessid][E_BUSINESS_DEALER_SCORE])
		{
			GiveMoney(playerid, blackjackPlayerBet[playerid] * 2);
			SendClientMessageEx(playerid, COLOR_PINK, "[Blackjack] You won and earn your bet x2 for $%s.", FormatMoney(blackjackPlayerBet[playerid] * 2));
		}
		else if (blackjackPlayerScore[playerid] == BusinessInfo[businessid][E_BUSINESS_DEALER_SCORE])
		{
			SendClientMessageEx(playerid, COLOR_PINK, "[Blackjack] It's draw! There are no winners (Push).");
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_PINK, "[Blackjack] You lost! Dealer has a higher score (Bust).");
		}

		ResetBlackjack(playerid);
	}

	// Dial Number
	if (playertextid == Phone[3][playerid])
    {
        if(PlayerInfo[playerid][E_CHARACTER_PHONEOFF])
			return SendErrorMessage(playerid, "Your cellphone is turned off.");

		Dialog_Show(playerid, DialogDialNumber, DIALOG_STYLE_INPUT, "Dial Number:", "Please enter the number that you wish to dial below:", "Submit", "Cancel");
        return 1;
    }

	// Send Text
	if (playertextid == Phone[4][playerid])
    {
        if(PlayerInfo[playerid][E_CHARACTER_PHONEOFF])
			return SendErrorMessage(playerid, "Your cellphone is turned off.");

		Dialog_Show(playerid, DialogSMS, DIALOG_STYLE_INPUT, "Send Text Message:", "Please enter the number that you wish to send a text message to:", "Submit", "Cancel");
        return 1;
    }
	if (playertextid == Phone[5][playerid])
    {
		if(PlayerInfo[playerid][E_CHARACTER_PHONEOFF])
			return SendErrorMessage(playerid, "Your cellphone is turned off.");

        ShowContacts(playerid);
        return 1;
    }

	if (playertextid == Phone[6][playerid])
    {
        if(PlayerInfo[playerid][E_CHARACTER_PHONEOFF])
			return SendErrorMessage(playerid, "Your cellphone is turned off.");

		Dialog_Show(playerid, DialogBackground, DIALOG_STYLE_LIST, "Choose Wallpaper Color:", "(1) Default\n(2) Red\n(3) Yellow\n(4) Blue\n(5) Purple\n(6) Green", "Select", "Cancel");
        return 1;
    }
	if (playertextid == Phone[7][playerid])
    {
        if (!PlayerInfo[playerid][E_CHARACTER_PHONEOFF])
		{
			if (PlayerInfo[playerid][E_CHARACTER_PHONELINE] != INVALID_PLAYER_ID) {
				cmd_hangup(playerid, "");
			}

			CancelSelectTextDraw(playerid);
			HidePlayerPhone(playerid);
			PlayerInfo[playerid][E_CHARACTER_PHONEOFF] = true;
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "** %s has powered off their cellphone.", ReturnName(playerid));
		}
		else
		{
			PlayerInfo[playerid][E_CHARACTER_PHONEOFF] = false;
			SendNearbyMessage(playerid, 20.0, COLOR_EMOTE, "** %s has powered on their cellphone.", ReturnName(playerid));
		}
        return 1;
    }

	if (playertextid == MDC[9][playerid])
    {
        if (ReturnFactionType(playerid) != FACTION_TYPE_POLICE || !IsPoliceVehicle(GetPlayerVehicleID(playerid)))
			return 0;

		Dialog_Show(playerid, DialogMDCName, DIALOG_STYLE_INPUT, "Place Charges:", "Please enter the name of the player:", "Search", "Back");
        return 1;
    }
	if (playertextid == MDC[10][playerid])
    {
        if (ReturnFactionType(playerid) != FACTION_TYPE_POLICE || !IsPoliceVehicle(GetPlayerVehicleID(playerid)))
			return 0;

		Dialog_Show(playerid, DialogMDCView, DIALOG_STYLE_INPUT, "View Charges:", "Please enter the name of the player:", "Search", "Back");
        return 1;
    }
	if (playertextid == MDC[11][playerid])
    {
        if (ReturnFactionType(playerid) != FACTION_TYPE_POLICE || !IsPoliceVehicle(GetPlayerVehicleID(playerid)))
			return 0;

		Dialog_Show(playerid, DialogMDCPlate, DIALOG_STYLE_INPUT, "View Plates:", "Please enter the vehicle plates:", "Search", "Back"); 
        return 1;
    }
	if (playertextid == MDC[12][playerid])
    {
        if (ReturnFactionType(playerid) != FACTION_TYPE_POLICE || !IsPoliceVehicle(GetPlayerVehicleID(playerid)))
			return 0;
		
		RequestPoliceBackup(playerid);
        return 1;
    }
	if (playertextid == MDC[13][playerid])
    {
        if (ReturnFactionType(playerid) != FACTION_TYPE_POLICE || !IsPoliceVehicle(GetPlayerVehicleID(playerid)))
			return 0;

		CancelSelectTextDraw(playerid);
		HidePlayerMDC(playerid);
        return 1;
    }

	//Business Dinners
	if (playertextid == FoodOrder[2][playerid])
    {
		new businessid = IsPlayerInBusiness(playerid);
		if(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][1] > PlayerInfo[playerid][E_CHARACTER_MONEY])
		{
			SendErrorMessage(playerid, "You can't afford a buster meals.");
			return 1;
		}

		SendPropertyMessage(playerid, "[BUSINESS] You bought buster meals and eat it");
		GiveMoney(playerid, -BusinessInfo[businessid][E_BUSINESS_PRODUCTS][1]); 

		new Float:health;
		GetPlayerHealth(playerid, health);
		SetPlayerHealthEx(playerid, health+10.0);
		SetPlayerNeeds(playerid, 10.0);
		BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_STOCK]--;
		BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_CASH] += BusinessInfo[businessid][E_BUSINESS_PRODUCTS][1];
		ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);

		if(PlayerInfo[playerid][E_CHARACTER_HUNGRY] > 100 || PlayerInfo[playerid][E_CHARACTER_HUNGRY] > 100)
		{
			ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 0, 0, 0, 0, 1);
		}

		for(new i; i < 10; i++)
		{
			PlayerTextDrawHide(playerid, FoodOrder[i][playerid]);
		}
		CancelSelectTextDraw(playerid);
        return 1;
    }
	if (playertextid == FoodOrder[3][playerid])
    {
		new businessid = IsPlayerInBusiness(playerid);
		if(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][2] > PlayerInfo[playerid][E_CHARACTER_MONEY])
		{
			SendErrorMessage(playerid, "You can't afford a duoble d-luxe meals.");
			return 1;
		}

		SendPropertyMessage(playerid, "[BUSINESS] You bought duoble d-luxe meals and eat it");
		GiveMoney(playerid, -BusinessInfo[businessid][E_BUSINESS_PRODUCTS][2]); 

		new Float:health;
		GetPlayerHealth(playerid, health);
		SetPlayerHealthEx(playerid, health+15.0);
		SetPlayerNeeds(playerid, 15.0);
		BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_STOCK]--;
		BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_CASH] += BusinessInfo[businessid][E_BUSINESS_PRODUCTS][2];
		ApplyAnimation(playerid, "FOOD", "EAT_Chicken", 4.1, 0, 0, 0, 0, 0, 1);

		if(PlayerInfo[playerid][E_CHARACTER_HUNGRY] > 100 || PlayerInfo[playerid][E_CHARACTER_HUNGRY] > 100)
		{
			ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 0, 0, 0, 0, 1);
		}

		for(new i; i < 10; i++)
		{
			PlayerTextDrawHide(playerid, FoodOrder[i][playerid]);
		}
		CancelSelectTextDraw(playerid);
        return 1;
    }
	if (playertextid == FoodOrder[4][playerid])
    {
		new businessid = IsPlayerInBusiness(playerid);
		if(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][3] > PlayerInfo[playerid][E_CHARACTER_MONEY])
		{
			SendErrorMessage(playerid, "You can't afford a duoble d-luxe meals.");
			return 1;
		}

		SendPropertyMessage(playerid, "[BUSINESS] You bought duoble d-luxe meals and eat it");
		GiveMoney(playerid, -BusinessInfo[businessid][E_BUSINESS_PRODUCTS][3]); 

		new Float:health;
		GetPlayerHealth(playerid, health);
		SetPlayerHealthEx(playerid, health+20.0);
		SetPlayerNeeds(playerid, 20.0);
		BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_STOCK]--;
		BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_CASH] += BusinessInfo[businessid][E_BUSINESS_PRODUCTS][3];
		ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, 0, 0, 0, 0, 0, 1);

		if(PlayerInfo[playerid][E_CHARACTER_HUNGRY] > 100 || PlayerInfo[playerid][E_CHARACTER_HUNGRY] > 100)
		{
			ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 4.1, 0, 0, 0, 0, 0, 1);
		}

		for(new i; i < 10; i++)
		{
			PlayerTextDrawHide(playerid, FoodOrder[i][playerid]);
		}
		CancelSelectTextDraw(playerid);
        return 1;
    }
	if (playertextid == FoodOrder[9][playerid])
    {
		for(new i; i < 10; i++)
		{
			PlayerTextDrawHide(playerid, FoodOrder[i][playerid]);
		}
		CancelSelectTextDraw(playerid);
        return 1;
    }

	// Vehicle Selection:
	if (playertextid == VehicleSelection[14][playerid])
    {
		for(new i; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][E_VEHICLE_DBID] == PlayerInfo[playerid][E_CHARACTER_OWNEDVEHICLE][1])
			{
				GPS_SetPlayerRaceCheckPoint(playerid, 1, VehicleInfo[i][E_VEHICLE_POS][0], VehicleInfo[i][E_VEHICLE_POS][1], VehicleInfo[i][E_VEHICLE_POS][2], 0.0, 0.0, 0.0);
				return 1;
			}
		}
        return 1;
    }
	if (playertextid == VehicleSelection[15][playerid])
    {
		for(new i; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][E_VEHICLE_DBID] == PlayerInfo[playerid][E_CHARACTER_OWNEDVEHICLE][2])
			{
				GPS_SetPlayerRaceCheckPoint(playerid, 1, VehicleInfo[i][E_VEHICLE_POS][0], VehicleInfo[i][E_VEHICLE_POS][1], VehicleInfo[i][E_VEHICLE_POS][2], 0.0, 0.0, 0.0);
				return 1;
			}
		}
        return 1;
    }
	if (playertextid == VehicleSelection[16][playerid])
    {
		for(new i; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][E_VEHICLE_DBID] == PlayerInfo[playerid][E_CHARACTER_OWNEDVEHICLE][3])
			{
				GPS_SetPlayerRaceCheckPoint(playerid, 1, VehicleInfo[i][E_VEHICLE_POS][0], VehicleInfo[i][E_VEHICLE_POS][1], VehicleInfo[i][E_VEHICLE_POS][2], 0.0, 0.0, 0.0);
				return 1;
			}
		}
        return 1;
    }
	if (playertextid == VehicleSelection[17][playerid])
    {
		for(new i; i < MAX_VEHICLES; i++)
		{
			if(VehicleInfo[i][E_VEHICLE_DBID] == PlayerInfo[playerid][E_CHARACTER_OWNEDVEHICLE][4])
			{
				GPS_SetPlayerRaceCheckPoint(playerid, 1, VehicleInfo[i][E_VEHICLE_POS][0], VehicleInfo[i][E_VEHICLE_POS][1], VehicleInfo[i][E_VEHICLE_POS][2], 0.0, 0.0, 0.0);
				return 1;
			}
		}
        return 1;
    }

	if (playertextid == VehicleSelection[18][playerid])
    {
		for(new i; i < 19; i++)
		{
			PlayerTextDrawHide(playerid, VehicleSelection[i][playerid]);
		}
		CancelSelectTextDraw(playerid);
        return 1;
    }

	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerCommandReceived called for player %s (ID: %i) CommandReceived : %s", ReturnName(playerid), playerid, cmdtext); 
	#endif

	if(AccountInfo[playerid][E_MASTERS_LOGGED] == true)
	{
		if(AntiSpam[playerid]-gettime() > 0)
	    {
	        SendErrorMessage(playerid, "CALM DOWN FOO. STOP SPAMMING!.");
	        return 0;
	    }
		
	    AntiSpam[playerid] = gettime() + 1;

	    PlayerInfo[playerid][E_CHARACTER_AFKPOS][0] = 0.0;
    	PlayerInfo[playerid][E_CHARACTER_AFKPOS][1] = 0.0;
    	PlayerInfo[playerid][E_CHARACTER_AFKPOS][2] = 0.0;
		printf("Player [%s] sent command: %s", ReturnName(playerid), cmdtext);
		return 1;
	}
	else
	{
		SendErrorMessage(playerid, "You need to be logged in to use commands.");
		printf("Player [%s] tried to send command: %s (During login, denied access)", ReturnName(playerid), cmdtext);
		return 0;
	}
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)
	{
		if(strlen(cmdtext) > 50)
		{
			SendClientMessage(playerid, COLOR_RED, "[ERROR] The command you entered doesn't exist. Use /help to see a list of available commands."); 
			PlayerInfo[playerid][E_CHARACTER_AFKPOS][0] = 0.0;
    		PlayerInfo[playerid][E_CHARACTER_AFKPOS][1] = 0.0;
    		PlayerInfo[playerid][E_CHARACTER_AFKPOS][2] = 0.0;
		}
			
		else
		{
			PlayerInfo[playerid][E_CHARACTER_AFKPOS][0] = 0.0;
    		PlayerInfo[playerid][E_CHARACTER_AFKPOS][1] = 0.0;
    		PlayerInfo[playerid][E_CHARACTER_AFKPOS][2] = 0.0;
			SendClientMessageEx(playerid, COLOR_RED, "[ERROR] The command you entered \"%s\" doesn't exist. Use /help to see a list of available commands.", cmdtext);
		}
	}
	return 1;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerKeyStateChange called for player %s (ID: %i) Newkeys : %d | OldKeys : %d", ReturnName(playerid), playerid, newkeys, oldkeys); 
	#endif

	new businessid = IsPlayerInBusiness(playerid);

	if(newkeys & KEY_CROUCH && IsPlayerInAnyVehicle(playerid))
	{
		cmd_gate(playerid, "");
	}
	if(newkeys & KEY_WALK)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, packetpos[0], packetpos[1], packetpos[2]))
		{
			if(PlayerInfo[playerid][E_CHARACTER_JOBS] != JOB_SMUGGLER) 
        		return SendErrorMessage(playerid, "You aren't smugglers.");

			if(IsValidDynamic3DTextLabel(packetLabel))
				DestroyDynamic3DTextLabel(packetLabel), packetLabel = Text3D: -1;

			if(IsValidDynamicObject(packetObject))
				DestroyDynamicObject(packetObject), packetObject = INVALID_OBJECT_ID;

			PlayerInfo[playerid][E_CHARACTER_TAKEPACKET] = true;
			RemovePlayerAttachedObject(playerid, ATTACH_HAND);
			PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] = INVENTORY_NONE;
			SetPlayerAttachedObject(playerid, ATTACH_HAND, 11745, 6, 0.129999, 0.051000, 0.000000, 103.700004, -64.600059, 0.000000, 0.501999, 1.0, 1.0);

			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s has picked up a Packet.", ReturnName(playerid));

			SendTipMessage(playerid, "You've picked up packet, Type '/storepacket' to materials / drugs point.");
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
			packetpos[0] = 0.0;
			packetpos[1] = 0.0;
			packetpos[2] = -10.0;
		}

		if(IsPlayerNearestTree(playerid) != -1)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);

			new id;
			id = IsPlayerNearestTree(playerid);

			if(PlayerInfo[playerid][E_CHARACTER_JOBS] != JOB_LUMBERJACK)
				return SendErrorMessage(playerid, "You aren't lumberjack.");

			if(PlayerInfo[playerid][E_CHARACTER_HUNGRY] < 20)
				return SendErrorMessage(playerid, "You're hungry or thirsty right now.");

			if(!Inventory_Count(playerid, "Chainsaw"))
				return SendErrorMessage(playerid, "You don't have any chainsaw in inventory.");

			if(PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] != CHAINSAW)
				return SendErrorMessage(playerid, "You must hold the chainsaw in your hands.");

			if(TreeInfo[id][E_TREE_TIMER] > 0)
				return SendErrorMessage(playerid, "This tree still unavailable.");

			if(TreeInfo[id][E_TREE_CUT])
				return SendErrorMessage(playerid, "Unable to execute this tree! (being interacted with another player)");

			if(PlayerInfo[playerid][E_CHARACTER_LOADING] == true)
				return SendErrorMessage(playerid, "You can't use this right now"); 

			if(!TreeInfo[id][E_TREE_CUTTED])
			{
				if(TreeInfo[id][E_TREE_PROGRESS] < 100)
				{
					PlayerInfo[playerid][E_CHARACTER_LOADING] = true;
					PlayerInfo[playerid][E_CHARACTER_LOADINGCOUNT] = 1;
					PlayerInfo[playerid][E_CHARACTER_LOADINGDISPLAY] = Create3DTextLabel("Loading cutting trees process\n(( |------ ))", COLOR_3DTEXT, x, y, z, 25.0, 0, 1);
					PlayerInfo[playerid][E_CHARACTER_LOADINGTIMER] = SetTimerEx("CutTree", 500, true, "dd", playerid, id);
					TogglePlayerControllable(playerid, false);
					ApplyAnimation(playerid,"CHAINSAW", "CSAW_G", 4.1, 1, 0, 0, 1, 0, 1);
					TreeInfo[id][E_TREE_CUT] = true;
				}
			}
			else
			{
				if(Inventory_Count(playerid, "Woods"))
					return SendErrorMessage(playerid, "You already carrying woods");

				PlayerInfo[playerid][E_CHARACTER_LOADING] = true;
				PlayerInfo[playerid][E_CHARACTER_LOADINGCOUNT] = 1;
				PlayerInfo[playerid][E_CHARACTER_LOADINGDISPLAY] = Create3DTextLabel("Loading take timber process\n(( |------ ))", COLOR_3DTEXT, x, y, z, 25.0, 0, 1);
				PlayerInfo[playerid][E_CHARACTER_LOADINGTIMER] = SetTimerEx("CreateTimber", 1000, true, "dd", playerid, id);
				TogglePlayerControllable(playerid, false);
				TreeInfo[id][E_TREE_CUT] = true;
				ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop", 4.1, 1, 0, 0, 1, 0, 1);
			}
		}
	}
	if((newkeys & KEY_AIM) == KEY_AIM && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_CASH] > 500 && BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH] == false)
	{
		if(GetPlayerWeapon(playerid) >= 22 && GetPlayerWeapon(playerid) <= 33)
		{
			new Float:aimX, Float:aimY, Float:aimZ;
			GetPlayerPos(playerid, aimX, aimY, aimZ);

			new nearbyPlayers = 0;
			for (new i = 0; i < MAX_PLAYERS; i++)
			{
				if (IsPlayerConnected(i) && i != playerid && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
				{
					new Float:playerX, Float:playerY, Float:playerZ;
					GetPlayerPos(i, playerX, playerY, playerZ);

					if (GetDistanceBetweenPoints(aimX, aimY, aimZ, playerX, playerY, playerZ) <= 5.0)
					{
						nearbyPlayers++;
					}
				}
			}

        	if (nearbyPlayers < 3)
            	return SendErrorMessage(playerid, "You need at least 3 players nearby to start a robbery.");


			new id = IsPlayerInBusiness(playerid);
			if(IsPlayerInBusiness(playerid))
			{
				if(BusinessInfo[id][E_BUSINESS_TYPE] == BUSINESS_TYPE_BANK)
					return SendErrorMessage(playerid, "You can't robbery business bank.");

				if(BusinessInfo[id][E_BUSINESS_ROBBERYTIME] > 0)
					return SendErrorMessage(playerid, "This Business has recently robbery.");

				if(PlayerInfo[playerid][E_CHARACTER_HASROBBIZ] == true)
					return SendErrorMessage(playerid, "You already robbery at this time.");

				CallLocalFunction("OnPlayerStartRobbery", "dd", playerid, BusinessInfo[id][E_BUSINESS_ACTOR]);
				SetTimerEx("RunActorAnimationSequence", 1000, false, "iii", playerid, BusinessInfo[id][E_BUSINESS_ACTOR], 0);
				
			}
		}
	}
	// POOL:
	if(PoolInfo[businessid][E_POOL_STARTED] && PlayingPool[playerid])
	{
		if(GetPlayerPing(playerid) > 100) 
		{
			SendClientMessage(playerid, COLOR_YELLOW, "Due to your high ping (100+), the game may desync. If this occurs please leave the game A.S.A.P. or contact an admin." ) ;
		}

		if(IsKeyJustUp(KEY_SECONDARY_ATTACK, newkeys, oldkeys))
		{
			if(!PlayerUsingChalk[playerid])
			{
				if(PlayingPool[playerid] && PoolInfo[businessid][E_POOL_PLAYERAIMER] != playerid)
				{
					SetTimerEx("PlayPoolSound", 1400, 0, "d", 31807);
					SetPlayerArmedWeapon(playerid, 0);
					SetPlayerAttachedObject(playerid, ATTACH_HAND, 338, 6, 0, 0.07, -0.85, 0, 0, 0);
					ApplyAnimation(playerid, "POOL", "POOL_ChalkCue",3.0,0,0,0,0,0,1);
					PlayerUsingChalk[playerid] = 1;
					SetTimerEx("RestoreWeapon", 3500, 0, "d", playerid);
				}
			}
			else
			{
				if(AreAllBallsStopped(businessid))
				{		
					if(PoolInfo[businessid][E_POOL_PLAYERAIMER] != playerid)
					{
						if(PlayerUsingChalk[playerid] && PoolBall[0][businessid][E_POOLBALL_EXISTS])
						{
							if(PoolInfo[businessid][E_POOL_TURN] != playerid)
								return SendErrorMessage(playerid, "Wait for the other player's turn.");

							new
								Float:poolrot,
								Float:X,
								Float:Y,
								Float:Z,
								Float:Xa,
								Float:Ya,
								Float:Za,
								Float:x,
								Float:y;
								
							GetPlayerPos(playerid, X, Y, Z);
							GetObjectPos(PoolBall[0][businessid][E_POOLBALL_OBJECT], Xa, Ya, Za);
							if(Is2DPointInRangeOfPoint(X, Y, Xa, Ya, 1.5) && Z < 999.5)
							{
								TogglePlayerControllable(playerid, 0);
								GetAngleToXY(Xa, Ya, X, Y, poolrot);
								SetPlayerFacingAngle(playerid, poolrot);
								AimAngle[playerid][0] = poolrot;
								AimAngle[playerid][1] = poolrot;
								GetXYInFrontOfPos(Xa, Ya, poolrot+180, x, y, 0.085);
								PoolInfo[businessid][E_POOL_AIMOBJECT] = CreateObject(3004, x, y, Za, 7.0, 0, poolrot+180);
								PHY_SetObjectWorld(PoolInfo[businessid][E_POOL_AIMOBJECT], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD]);
								switch(PoolCamera[playerid])
								{
									case 0:
									{
										GetXYBehindObjectInAngle(PoolBall[0][businessid][E_POOLBALL_OBJECT], poolrot, x, y, 0.675);
										SetPlayerCameraPos(playerid, x, y, 998.86785888672+0.28);
										SetPlayerCameraLookAt(playerid, Xa, Ya, Za+0.170);
									}
									case 1:
									{
										SetPlayerCameraPos(playerid, 511.84469604492, -84.831642150879, 1001.4904174805);
										SetPlayerCameraLookAt(playerid,510.11267089844, -84.831642150879, 998.86785888672);
									}
									case 2:
									{
										SetPlayerCameraPos(playerid, 508.7971496582, -84.831642150879, 1001.4904174805);
										SetPlayerCameraLookAt(playerid,510.11267089844, -84.831642150879, 998.86785888672);
									}
								}
								ApplyAnimation(playerid, "POOL", "POOL_Med_Start",50.0,0,0,0,1,1,1);
								PoolInfo[businessid][E_POOL_PLAYERAIMER] = playerid;
								PoolInfo[businessid][E_POOL_POWER] = 1.0;
								PoolInfo[businessid][E_POOL_DIRECTION] = 0;
								SelectTextDraw(playerid, COLOR_YELLOW);
							}
						}
					}
				}
			}
		}
		if (IsKeyJustUp(KEY_JUMP, newkeys, oldkeys))
		{
			if(PoolInfo[businessid][E_POOL_PLAYERAIMER] == playerid)
			{
				if(PoolCamera[playerid] < 2) PoolCamera[playerid]++;
				else PoolCamera[playerid] = 0;
				new
					Float:poolrot = AimAngle[playerid][0],
					Float:Xa,
					Float:Ya,
					Float:Za,
					Float:x,
					Float:y;
				GetObjectPos(PoolBall[0][businessid][E_POOLBALL_OBJECT], Xa, Ya, Za);
				switch(PoolCamera[playerid])
				{
					case 0:
					{
						GetXYBehindObjectInAngle(PoolBall[0][businessid][E_POOLBALL_OBJECT], poolrot, x, y, 0.675);
						SetPlayerCameraPos(playerid, x, y, 998.86785888672+0.28);
						SetPlayerCameraLookAt(playerid, Xa, Ya, Za+0.170);
					}
					case 1:
					{
						SetPlayerCameraPos(playerid, 511.84469604492, -84.831642150879, 1001.4904174805);
						SetPlayerCameraLookAt(playerid,510.11267089844, -84.831642150879, 998.86785888672);
					}
					case 2:
					{
						SetPlayerCameraPos(playerid, 508.7971496582, -84.831642150879, 1001.4904174805);
						SetPlayerCameraLookAt(playerid,510.11267089844, -84.831642150879, 998.86785888672);
					}
				}
			}
		}
	}

	if(newkeys == KEY_WALK && !IsPlayerInAnyVehicle(playerid))
    {
		if(PlayerUsingGym[playerid] == true)
		{
			if(PlayerInfo[playerid][E_CHARACTER_HUNGRY] < 20)
				return SendErrorMessage(playerid, "You're hungry or thirsty right now.");

			IsPlayerPlayingMachine(playerid);
		}
	}

	// FISHING:
	if(newkeys == KEY_WALK && !IsPlayerInAnyVehicle(playerid))
    {
		if(PlayerInfo[playerid][E_CHARACTER_FISHINGSTART] == true)
		{
			if(PlayerInfo[playerid][E_CHARACTER_FISHINGVALUE] < 100.0)
			{
				PlayerInfo[playerid][E_CHARACTER_FISHINGVALUE] += 10.0;
				SetPlayerGameBar(playerid, PlayerInfo[playerid][E_CHARACTER_FISHINGVALUE]);
			}
			if(PlayerInfo[playerid][E_CHARACTER_FISHINGVALUE] == 100.0)
			{
				new rand = randomEx(1, 5);

				ClearAnimations(playerid);
				
				PlayerInfo[playerid][E_CHARACTER_FISHING] = false;
				PlayerInfo[playerid][E_CHARACTER_FISHINGSTART] = false;
				PlayerInfo[playerid][E_CHARACTER_FISHINGVALUE] = 0;

				SetPlayerNeeds(playerid, -0.2);

				DestroyGameBar(playerid);
				KillTimer(PlayerInfo[playerid][E_CHARACTER_FISHINGTIMER]);
				TogglePlayerControllable(playerid, true);
				ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
				switch(rand)
				{
					case 1:	
					{
						Inventory_Add(playerid, "Cod", 19630, 1); 
						SendJobsMessage(playerid, "[Fishing] You caught a 12.5.kg of Cod.");
					}
					case 2:	
					{
						Inventory_Add(playerid, "Carp", 19630, 1); 
						SendJobsMessage(playerid, "[Fishing] You caught a 10.5.kg of Carp.");
					}
					case 3:	
					{
						Inventory_Add(playerid, "Salmon", 19630, 1); 
						SendJobsMessage(playerid, "[Fishing] You caught a 8.5 lbs of Salmon.");
					}
					case 4:	
					{
						Inventory_Add(playerid, "Cat Fish", 19630, 1); 
						SendJobsMessage(playerid, "[Fishing] You caught a 15.5 lbs of Cat fish.");
					}
					case 5:	
					{
						Inventory_Add(playerid, "Herring", 19630, 1); 
						SendJobsMessage(playerid, "[Fishing] You caught a 1.5 lbs of Herring.");
					}
				}
			}
		}
	}

	// BUNNY HOP:
	if(PRESSED(KEY_JUMP) && !PlayerInfo[playerid][E_CHARACTER_ADMINDUTY])
	{
	    PlayerJump[playerid][JumpPressed] = gettime();
		return 1;
	}

	if(PRESSED(KEY_JUMP) && PlayerInfo[playerid][E_CHARACTER_WOUND][5] == 2 || PlayerInfo[playerid][E_CHARACTER_WOUND][5] == 3 || PlayerInfo[playerid][E_CHARACTER_WOUND][6] == 2 || PlayerInfo[playerid][E_CHARACTER_WOUND][6] == 3 && !PlayerInfo[playerid][E_CHARACTER_ADMINDUTY])
	{
	    ApplyAnimation(playerid, "ped", "fall_collapse", 4.1, 0, 1, 1, 0, 0);
		return 1;
	}

	//Tackle
	if(PRESSED(KEY_FIRE))
	{
		new weaponid = GetPlayerWeapon(playerid);

	    if(weaponid == 0)
		{
			if(TackleMode[playerid])
			{
				if(GetPlayerAnimationIndex(playerid) != 1120 && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
				{
					SetTimerEx("TackleModes", 1000, false, "i", playerid);
					return true;
				}
			}
		}
	}
	// CBUG:
	if(!pCBugging[playerid] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if(PRESSED(KEY_FIRE))
		{
			switch(GetPlayerWeapon(playerid))
			{
				case WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SNIPER:
				{
					ptsLastFiredWeapon[playerid] = gettime();
				}
			}
		}
		else if(PRESSED(KEY_CROUCH))
		{
			if((gettime() - ptsLastFiredWeapon[playerid]) < 1)
			{
				TogglePlayerControllable(playerid, false);
				ApplyAnimation(playerid, "PAULNMAC", "wank_loop", 4.1, 0, 0, 0, 0, 0, 1);
				pCBugging[playerid] = true;

				ShowBoxMessage(playerid, "CBUG FOO!", 5);

				KillTimer(ptmCBugFreezeOver[playerid]);
				ptmCBugFreezeOver[playerid] = SetTimerEx("CBugFreezeOver", 1500, false, "i", playerid);
			}
		}
	}
	// Basketball:
	if ((newkeys & KEY_WALK) && !(oldkeys & KEY_WALK) && !IsPlayerInAnyVehicle(playerid))
    {
		if(PlayerInfo[playerid][E_CHARACTER_COURT])
		{	
			if(PlayerInfo[playerid][E_CHARACTER_HAVEBALL])
			{
				ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1);
			}
			else
			{
				ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
			}
			PlayerInfo[playerid][E_CHARACTER_ANIMBALL] = 1;
		}
    }
    if (!(newkeys & KEY_WALK) && (oldkeys & KEY_WALK) && !IsPlayerInAnyVehicle(playerid))
    {
		if(PlayerInfo[playerid][E_CHARACTER_COURT])
		{	
			ClearAnimations(playerid);
			PlayerInfo[playerid][E_CHARACTER_ANIMBALL] = 0;
		}
    }
	if(newkeys & KEY_SECONDARY_ATTACK && !IsPlayerInAnyVehicle(playerid))
    {
		if(PlayerInfo[playerid][E_CHARACTER_COURT])
		{
			if(GetPlayerPing(playerid) > 100) 
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Due to your high ping (100+), the game may desync. If this occurs please leave the game A.S.A.P. or contact an admin." ) ;
			}
			if(!PlayerInfo[playerid][E_CHARACTER_HAVEBALL])
			{
				new Float:x, Float:y, Float:z;
				GetDynamicObjectPos(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], x, y, z);

				if(IsPlayerInRangeOfPoint(playerid, 1.5, x, y, z))
				{
					PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 1;
					ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);

					if(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALLER] != 999)
					{
						PlayerInfo[CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALLER]][E_CHARACTER_HAVEBALL] = 0;
						ClearAnimations(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALLER]);
						ApplyAnimation(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALLER], "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1);
					}

					CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALLER] = playerid;
					CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_STATUS] = 1;
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(playerid, x2, y2, 0.8);
					GetPlayerPos(playerid, x, y, z);
					StopDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT]);
					MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], x2, y2, z, 7.0);
					PlayerInfo[playerid][E_CHARACTER_ANIMBALL] = 0;
					CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_BOUNCE] = 0;
				}
			}
			else
			{
				// PASS & STEAL:
				for(new i; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerFacingPlayer(playerid, i, 15))
						{
							new Float:x, Float:y, Float:z;
							GetPlayerPos(i, x, y, z);
							if(IsPlayerInRangeOfPoint(playerid, 20.0, x, y, z))
							{
								CourtInfo[PlayerInfo[i][E_CHARACTER_COURT]][E_BALLER] = i;
								PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
								ClearAnimations(playerid);
								ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
								SetTimerEx("ClearAnim", 700, 0, "d", playerid);
								MoveDynamicObject(CourtInfo[PlayerInfo[i][E_CHARACTER_COURT]][E_BALL_OBJECT], x, y, z, 7.0);
								PlayerInfo[i][E_CHARACTER_ANIMBALL] = 0;
								CourtInfo[PlayerInfo[i][E_CHARACTER_COURT]][E_BALL_SHOOT] = 6;
								ApplyAnimation(i,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);

								new str[128];
								format(str, sizeof(str), "passes the basketball to %s.", ReturnName(i));
								cmd_me(playerid, str);
								return 1;
							}
						}
					}
				}
			}
		}
	}
	if(newkeys & KEY_FIRE && !IsPlayerInAnyVehicle(playerid))
    {
		if(PlayerInfo[playerid][E_CHARACTER_COURT])
		{	
			if(GetPlayerPing(playerid) > 100) 
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Due to your high ping (100+), the game may desync. If this occurs please leave the game A.S.A.P. or contact an admin." ) ;
			}
			if(PlayerInfo[playerid][E_CHARACTER_HAVEBALL])
			{
				// Blue Team:
				if(IsPlayerInRangeOfPoint(playerid, 2, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]))
				{
					MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_BALL][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_BALL][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_BALL][2], 7.0);
					SetPlayerPosEx(playerid, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]+2);
					ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0);
					PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
					SetTimerEx("ClearAnim", 1100, 0, "d", playerid);
					SetTimerEx("PlayerBallShoot", 1100, 0, "dd", playerid, 1);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid, 4, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]) && IsPlayerFacingPoint(playerid, 20, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]))
				{
					new rand = random(1);
					if(rand == 0)
					{
						MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]+3, 7.0);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
						CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_SHOOT] = 2;
						PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
						return 1;
					}
					PlayerShootMiss(playerid, 1);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid, 7, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]) && IsPlayerFacingPoint(playerid, 20, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]))
				{
					new rand = random(2);
					if(rand == 0)
					{
						MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]+3, 7.0);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
						CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_SHOOT] = 2;
						PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
						return 1;
					}
					PlayerShootMiss(playerid, 1);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid, 10, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]) && IsPlayerFacingPoint(playerid, 20, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]))
				{
					new rand = random(3);
					if(rand == 0)
					{
						MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][0]-1, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BLUE_POS][2]+3, 7.0);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
						CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_SHOOT] = 2;
						PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
						return 1;
					}
					PlayerShootMiss(playerid, 1);
					return 1;
				}

				// Red Team:
				else if(IsPlayerInRangeOfPoint(playerid, 2, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]))
				{
					MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_BALL][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_BALL][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_BALL][2], 7.0);
					SetPlayerPosEx(playerid, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]+2);
					ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0);
					PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
					SetTimerEx("ClearAnim", 1100, 0, "d", playerid);
					SetTimerEx("PlayerBallShoot", 1000, 0, "dd", playerid, 2);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid, 4, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]) && IsPlayerFacingPoint(playerid, 20, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]))
				{
					new rand = random(1);
					if(rand == 0)
					{
						MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]+3, 7.0);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
						CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_SHOOT] = 3;
						PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
						return 1;
					}
					PlayerShootMiss(playerid, 2);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid, 7, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]) && IsPlayerFacingPoint(playerid, 20, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]))
				{
					new rand = random(2);
					if(rand == 0)
					{
						MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]+3, 7.0);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
						CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_SHOOT] = 3;
						PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
						return 1;
					}
					PlayerShootMiss(playerid, 2);
					return 1;
				}
				else if(IsPlayerInRangeOfPoint(playerid, 10, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]) && IsPlayerFacingPoint(playerid, 20, CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]))
				{
					new rand = random(3);
					if(rand == 0)
					{
						MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][0], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][1], CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_RED_POS][2]+3, 7.0);
						ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
						CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_SHOOT] = 3;
						PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
						return 1;
					}
					PlayerShootMiss(playerid, 2);
					return 1;
				}
				
				// THROW:
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				PlayerInfo[playerid][E_CHARACTER_HAVEBALL] = 0;
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(playerid, x2, y2, 6.0);
				SetTimerEx("PlayerBallDown", 500, 0, "df", playerid, z);
				MoveDynamicObject(CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_OBJECT], x2, y2, z+randomEx(5, 6), 7.0);
				ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
				CourtInfo[PlayerInfo[playerid][E_CHARACTER_COURT]][E_BALL_SHOOT] = 0;
			}
		}
	}
	if ((newkeys & KEY_FIRE) && (IsPlayerInAnyVehicle(playerid)))
	{
		cmd_engine(playerid, "");
	}
	if ((newkeys & KEY_LOOK_BEHIND) && (IsPlayerInAnyVehicle(playerid)))
	{
		cmd_carlock(playerid, "");
	}
	if(newkeys == KEY_FIRE)
	{
		if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_SPRUNK)
		{
			SetPlayerNeeds(playerid, 4.5);
		}
		else if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DRINK_BEER)
		{
			SetPlayerNeeds(playerid, 5.5);
		}
	}
	if (newkeys & KEY_SECONDARY_ATTACK && !IsPlayerInAnyVehicle(playerid))
	{
		for (new i = 0; i < sizeof(sc_VendingMachines); i++) {

			if(IsPlayerInDynamicArea(playerid, s_VendingMachineArea[i])) 
			{
				OnPlayerUseVending(playerid, i);
			}
		}
		if(PlayerInfo[playerid][E_CHARACTER_DRINKING] > 0)
		{
			PlayerInfo[playerid][E_CHARACTER_DRINKCD] = gettime();
			PlayerInfo[playerid][E_CHARACTER_DRINKING] = 0;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
		if(PlayerInfo[playerid][E_CHARACTER_LOOPANIM])
		{
			cmd_stopanim(playerid, "");
		}

		cmd_enter(playerid, "");
	}
	else if (newkeys & KEY_NO && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
	{
		if (GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_DUCK)
		{
		   	new
				count = 0,
				id = Item_Nearest(playerid);
			new string[128];

			if (id != -1)
			{
				if(DroppedInfo[id][E_DROPPED_LOADING] == true)
					return SendErrorMessage(playerid, "You can't pickup this items.");

				string = "";

				for (new i = 0; i < MAX_DROPPED_ITEMS; i ++) if (count < MAX_LISTED_ITEMS && DroppedInfo[i][E_DROPPED_MODEL] && IsPlayerInRangeOfPoint(playerid, 1.5, DroppedInfo[i][E_DROPPED_POS][0], DroppedInfo[i][E_DROPPED_POS][1], DroppedInfo[i][E_DROPPED_POS][2]) && GetPlayerInterior(playerid) == DroppedInfo[i][E_DROPPED_INTERIOR] && GetPlayerVirtualWorld(playerid) == DroppedInfo[i][E_DROPPED_WORLD]) {
					NearestItems[playerid][count++] = i;

					strcat(string, DroppedInfo[i][E_DROPPED_ITEM]);
					strcat(string, "\n");
				}
				if (count == 1)
				{
					if (PickupItem(playerid, id))
					{
						SendInventoryMessage(playerid, "%s added to inventory!", DroppedInfo[id][E_DROPPED_ITEM]);
					}
					else
						SendErrorMessage(playerid, "You don't have any slot in your inventory.");
				}
				else Dialog_Show(playerid, DialogPickup, DIALOG_STYLE_LIST, "Pickup Items:", string, "Pickup", "Cancel");
			}
		}
		else
		{
			if(!BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYTIME])
			{
				for(new ii; ii < sizeof(BusinessPoint); ii++)
				{
					if(IsPlayerInRangeOfPoint(playerid, 2.0, BusinessPoint[ii][E_BUSINESS_POINT_POS][0], BusinessPoint[ii][E_BUSINESS_POINT_POS][1], BusinessPoint[ii][E_BUSINESS_POINT_POS][2]))
					{
						new string[128];
						format(string, sizeof(string), "Inventory\n%s", BusinessPoint[ii][E_BUSINESS_POINT_NAME]);
						return Dialog_Show(playerid, DialogShop, DIALOG_STYLE_LIST, "Choose an option:", string, "Select", "Close");
					}
				}
			}
			if(IsPlayerNearCashiers(playerid)) //Payclerk
			{
				return ShowBusinessShop(playerid, IsPlayerInBusiness(playerid));
			}
			else
			{
				return cmd_inventory(playerid, "");
			}
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerStateChange called for player %s (ID: %i) newstate %d oldstate %d", ReturnName(playerid), playerid, newstate, oldstate); 
	#endif

	new vehicleid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_DRIVER)
	{
		if(!VehicleInfo[GetPlayerVehicleID(playerid)][E_VEHICLE_ENGINE] && IsEngineVehicle(vehicleid)){
			SendVehicleMessage(playerid, "[VEHICLE] To switch the ignition use /engine or /hotwire to steal it");
	   	}

	   	if (ReturnVehicleHealth(vehicleid) <= 350){
			SendVehicleMessage(playerid, "[VEHICLE] This vehicle is totalled and needs repairing call mechanic or buy repairkits in pawnshop.");
		}
	
		if(!PlayerInfo[playerid][E_CHARACTER_DRIVELICENSE])
			SendClientMessage(playerid, COLOR_RED, "You don't own a driver license, drive safety or the cops may issue you a ticket.");
			
		if(VehicleInfo[GetPlayerVehicleID(playerid)][E_VEHICLE_OWNERDBID] == PlayerInfo[playerid][E_CHARACTER_DBID])
			SendClientMessage(playerid, COLOR_VEHICLE, "This vehicle is owned by you.");
			
		for(new i = 0; i < sizeof DMV_Vehicles; i++) if(GetPlayerVehicleID(playerid) == DMV_Vehicles[i])
			SendVehicleMessage(playerid, "[VEHICLE] This vehicle is part of departement of motor vehicles. in order to start it '/licenseexam'.");

		if((JOBS_Vehicles[7] <= vehicleid <= JOBS_Vehicles[11]))
			SendVehicleMessage(playerid, "[VEHICLE] This vehicle is part of dockworker job. in order to start it '/jobduty'.");

		if(ReturnFactionType(playerid) != FACTION_TYPE_POLICE && IsPoliceVehicle(vehicleid))
		{
			RemovePlayerFromVehicle(playerid);
			SendErrorMessage(playerid, "You aren't apart of police departement.");
			return 1;
		}
		if(ReturnFactionType(playerid) != FACTION_TYPE_MEDICAL && IsMedicalVehicle(vehicleid))
		{
			RemovePlayerFromVehicle(playerid);
			SendErrorMessage(playerid, "You aren't apart of medical departement.");
			return 1;
		}

		ShowVehicleSpeedometer(playerid);
	}

	if (newstate == PLAYER_STATE_PASSENGER && IsPlayerInsideTaxi(playerid))
	{
	    new driverid = GetVehicleDriver(GetPlayerVehicleID(playerid));

	    PlayerInfo[playerid][E_CHARACTER_TAXIFARE] = PlayerInfo[driverid][E_CHARACTER_DRIVERFARE];
	    PlayerInfo[playerid][E_CHARACTER_TAXITIMER] = 0;
	    PlayerInfo[playerid][E_CHARACTER_TAXIPLAYER] = driverid;

	    SendJobsMessage(driverid, "[Taxi] %s has entered your taxi as a passenger.", ReturnName(playerid, driverid));
		SendJobsMessage(playerid, "[Taxi] You have entered %s's taxi.", ReturnName(driverid, playerid));
	}
 	if (oldstate == PLAYER_STATE_PASSENGER && PlayerInfo[playerid][E_CHARACTER_TAXITIMER] != 0 && PlayerInfo[playerid][E_CHARACTER_TAXIPLAYER] != INVALID_PLAYER_ID)
	{
	    LeaveTaxi(playerid, PlayerInfo[playerid][E_CHARACTER_TAXIPLAYER]);
	}
	
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		if(VehicleInfo[GetPlayerVehicleID(playerid)][E_VEHICLE_RADIO] == true)
		{
			PlayAudioStreamForPlayer(playerid, VehicleInfo[GetPlayerVehicleID(playerid)][E_VEHICLE_RADIOURL]);
		}
	}
	
	if(!IsEngineVehicle(GetPlayerVehicleID(playerid)))
		ToggleVehicleEngine(GetPlayerVehicleID(playerid), true); 

	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT)
	{
		StopAudioStreamForPlayer(playerid); 
		HideVehicleSpeedometer(playerid);

		forex(i, 12)
		{
			DestroyDynamicMapIcon(FishAreaMap[playerid][i]);
		}
	}
	
	if(oldstate == PLAYER_STATE_DRIVER)
	{
		if(DealershipPlayerCar[playerid] != INVALID_VEHICLE_ID)
		{
			if(IsValidVehicle(DealershipPlayerCar[playerid]) && !VehicleInfo[DealershipPlayerCar[playerid]][E_VEHICLE_DBID])
			{
				DestroyVehicle(DealershipPlayerCar[playerid]); 
			}
			
			if(!PlayerPurchasingVehicle[playerid])
				ResetDealershipVars(playerid); 
		}
		
		if(PlayerTakingLicense[playerid])
			StopDriverstest(playerid);
	}
	
	return 1; 
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	#if defined DEBUG_MODE
		printf("Callback OnPlayerExitVehicle called for player %s (ID: %i) vehicle %s (ID: %i)", ReturnName(playerid), playerid, ReturnVehicleName(vehicleid), vehicleid); 
	#endif

	if (PlayerInfo[playerid][E_CHARACTER_TAXIDUTY])
	{
        foreach (new i : Player) if (PlayerInfo[i][E_CHARACTER_TAXIPLAYER] == playerid && IsPlayerInVehicle(i, GetPlayerVehicleID(playerid))) {
	        LeaveTaxi(i, playerid);
	    }
	    
        PlayerInfo[playerid][E_CHARACTER_TAXIDUTY] = false;
        SendJobsMessage(playerid, "[taxi] You are no longer on taxi duty!");
	}

    if(PlayerInfo[playerid][E_CHARACTER_DOCKSWORK])
    {
        PlayerInfo[playerid][E_CHARACTER_DOCKSWORK] = false;
        ShowBoxMessage(playerid, "~r~Dockworker job stopped.", 5); 
		DestroyDynamicObject(CrateObject[PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]]);
		DestroyVehicle(PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]);
		GPS_DisablePlayerRaceCheckPoint(playerid);
    }   

	if(PlayerInfo[playerid][E_CHARACTER_SWEEPER] && PlayerSweeperIndex[playerid])
    {
        PlayerInfo[playerid][E_CHARACTER_SWEEPER] = false;
        ShowBoxMessage(playerid, "~r~Street Cleaner job stopped.", 5); 
		DestroyVehicle(PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]);
		GPS_DisablePlayerRaceCheckPoint(playerid);
    }   

	if(PlayerInfo[playerid][E_CHARACTER_BUSDRIVER] && PlayerBusDriverIndex[playerid])
    {
        PlayerInfo[playerid][E_CHARACTER_BUSDRIVER] = false;
        ShowBoxMessage(playerid, "~r~Bus Driver job stopped.", 5); 
		DestroyVehicle(PlayerInfo[playerid][E_CHARACTER_JOBSVEHICLE]);
		GPS_DisablePlayerRaceCheckPoint(playerid);
    }   
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger)
	{
		for(new i = 0; i < sizeof DMV_Vehicles; i++) if(vehicleid == DMV_Vehicles[i])
		{
			if(PlayerInfo[playerid][E_CHARACTER_DRIVELICENSE])
			{
				SendErrorMessage(playerid, "You already have a driver's license.");
				return ClearAnimations(playerid);
			}
		}
	}

	LastEnteredVehicle[playerid] = vehicleid;
	return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(response == 1)
	{
		pToys[playerid][index][E_TOY_TYPE] = ACC_TOYS;
		pToys[playerid][index][E_TOY_X] = fOffsetX;
		pToys[playerid][index][E_TOY_Y] = fOffsetY;
		pToys[playerid][index][E_TOY_Z] = fOffsetZ;
		pToys[playerid][index][E_TOY_RX] = fRotX;
		pToys[playerid][index][E_TOY_RY] = fRotY;
		pToys[playerid][index][E_TOY_RZ] = fRotZ;
		pToys[playerid][index][E_TOY_SX] = fScaleX;
		pToys[playerid][index][E_TOY_SY] = fScaleY;
		pToys[playerid][index][E_TOY_SZ] = fScaleZ;
			
		SavePlayerToys(playerid);
	}
	else if(response == 0)
	{
		SetPlayerAttachedObject(playerid,
			index,
			modelid,
			boneid,
			pToys[playerid][index][E_TOY_X],
			pToys[playerid][index][E_TOY_Y],
			pToys[playerid][index][E_TOY_Z],
			pToys[playerid][index][E_TOY_RX],
			pToys[playerid][index][E_TOY_RY],
			pToys[playerid][index][E_TOY_RZ],
			pToys[playerid][index][E_TOY_SX],
			pToys[playerid][index][E_TOY_SY],
			pToys[playerid][index][E_TOY_SZ]);
	}
    return 1;
}

public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT])
	{
		switch(PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT])
		{
			case 1:
			{
				if(response == EDIT_RESPONSE_CANCEL)
				{
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
		
					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
		
					SendErrorMessage(playerid, "You're no longer place a spraytags."); 
					return 1;
				}

				if(response == EDIT_RESPONSE_FINAL)
				{
					new str[32];
					format(str, sizeof(str), "Static");
					SetTimerEx("SprayingTags", 10000, false, "isiffffff", playerid, str, 1, x, y, z, rx, ry, rz);
						
					ApplyAnimation(playerid, "GRAFFITI", "null", 4.0, 0, 0, 0, 0, 0, 0);
					ApplyAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.0, 1, 0, 0, 0, 0, 1);
				    ApplyAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.0, 1, 0, 0, 0, 0, 1);

					SetPlayerAttachedObject(playerid, ATTACH_HAND, 365, 6, 0.0000, 0.0000, 0.0360, 0.0000, 0.0000, 0.0000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF); // spraycan
					SetPlayerAttachedObject(playerid, ATTACH_HAND2, 18729, 6, 0.0460, 1.6179, 0.1640, 92.2999, 0.0000, -78.4000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF); //spraycan	
				}
			}
			case 2:
			{
				if(response == EDIT_RESPONSE_CANCEL)
				{
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
		
					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
		
					SendErrorMessage(playerid, "You're no longer editing a shooting ball blue team."); 
					return 1;
				}
				
				if(response == EDIT_RESPONSE_FINAL)
				{
					CourtInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_BLUE_BALL][0] = x;
					CourtInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_BLUE_BALL][1] = y;
					CourtInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_BLUE_BALL][2] = z;
					Court_Save(PlayerInfo[playerid][E_CHARACTER_OBJECTID]);
					Court_Refresh(PlayerInfo[playerid][E_CHARACTER_OBJECTID]);

					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);

					SendServerMessage(playerid, "You're set shooting ball red team."); 
					return 1;
				}
			}
			case 3:
			{
				if(response == EDIT_RESPONSE_CANCEL)
				{
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);

					SendErrorMessage(playerid, "You're no longer editing a shooting ball blue team."); 
					return 1;
				}
				if(response == EDIT_RESPONSE_FINAL)
				{
					CourtInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_RED_BALL][0] = x;
					CourtInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_RED_BALL][1] = y;
					CourtInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_RED_BALL][2] = z;
					Court_Save(PlayerInfo[playerid][E_CHARACTER_OBJECTID]);
					Court_Refresh(PlayerInfo[playerid][E_CHARACTER_OBJECTID]);

					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;

					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
					SendServerMessage(playerid, "You're set shooting ball blue team."); 
					return 1;
				}
			}
			case 4:
			{
				if(response == EDIT_RESPONSE_CANCEL)
				{
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
		
					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
		
					SendErrorMessage(playerid, "You're no longer editing tree."); 
					return 1;
				}

				if(response == EDIT_RESPONSE_FINAL)
				{
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 

					TreeInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_TREE_POS][0] = x;
					TreeInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_TREE_POS][1] = y;
					TreeInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_TREE_POS][2] = z;
					TreeInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_TREE_POS][3] = rx;
					TreeInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_TREE_POS][4] = ry;
					TreeInfo[PlayerInfo[playerid][E_CHARACTER_OBJECTID]][E_TREE_POS][5] = rz;

					Tree_Save(PlayerInfo[playerid][E_CHARACTER_OBJECTID]);
					Tree_Refresh(PlayerInfo[playerid][E_CHARACTER_OBJECTID]);
					SendServerMessage(playerid, "You're created tree ID #%d", PlayerInfo[playerid][E_CHARACTER_OBJECTID]);
					return 1;
				}
			}
			case 5:
			{
				if(response == EDIT_RESPONSE_CANCEL)
				{
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTQUANTITY] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
					format(PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], 512, "");

					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
					SendErrorMessage(playerid, "You're no longer moved a dropped items."); 
					return 1;
				}

				if(response == EDIT_RESPONSE_FINAL)
				{
					DropItem(PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], ReturnName(playerid), PlayerInfo[playerid][E_CHARACTER_OBJECTID], PlayerInfo[playerid][E_CHARACTER_OBJECTQUANTITY], x, y, z, rx, ry, rz, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE], PlayerInfo[playerid][E_CHARACTER_OBJECTAMOUNT]);
					Inventory_Remove(playerid, PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], PlayerInfo[playerid][E_CHARACTER_OBJECTQUANTITY]);
					ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0, 1);

					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTQUANTITY] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
					format(PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], 512, "");
					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
					SendServerMessage(playerid, "You're moved dropped items."); 

					if(PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] > INVENTORY_NONE)
					{
						ResetVarInventory(playerid);
					}
					return 1;
				}
			}
			case 6:
			{
				if(response == EDIT_RESPONSE_CANCEL)
				{
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTQUANTITY] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
					format(PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], 512, "");

					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
					SendErrorMessage(playerid, "You're no longer moved a business point."); 
				}
				if(response == EDIT_RESPONSE_FINAL)
				{
					ConfirmDialog(playerid, "Confirmation", "Are you sure you want to change this businesses point?", "OnBusinessPointChange", IsPlayerInBusiness(playerid), x, y, z); 

					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTQUANTITY] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
					format(PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], 512, "");

					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
					SendServerMessage(playerid, "You're moved business point."); 
				}
			}
			case 7:
			{
				if(response == EDIT_RESPONSE_CANCEL)
				{
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTQUANTITY] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
					format(PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], 512, "");

					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
					SendErrorMessage(playerid, "You're no longer moved a furniture."); 
				}
				if(response == EDIT_RESPONSE_FINAL)
				{
					new houseid = IsPlayerInProperty(playerid);

					if(houseid >= 0 && PropertyInfo[houseid][E_PROPERTY_OWNERDBID] == PlayerInfo[playerid][E_CHARACTER_DBID])
					{
					    if(PlayerInfo[playerid][E_CHARACTER_MONEY] < g_aFurnitureArray[PlayerInfo[playerid][E_CHARACTER_LISTITEM]][E_FURNITUREVAR_PRICE])
		                    return SendErrorMessage(playerid, "You can't afford this. (Cost: $%s, Total: $%s)", FormatMoney(g_aFurnitureArray[PlayerInfo[playerid][E_CHARACTER_LISTITEM]][E_FURNITUREVAR_PRICE]), FormatMoney(PlayerInfo[playerid][E_CHARACTER_MONEY]));

					    new
					        queryBuffer[512];

					    GiveMoney(playerid, -g_aFurnitureArray[PlayerInfo[playerid][E_CHARACTER_LISTITEM]][E_FURNITUREVAR_PRICE]);

						mysql_format(ourConnection, queryBuffer, sizeof(queryBuffer), "INSERT INTO furniture (`propertydbid`, `modelid`, `name`, `price`, `pos_x`, `pos_y`, `pos_z`, `rot_x`, `rot_y`, `rot_z`, `interior`, `world`) VALUES(%i, %i, '%e', %i, '%f', '%f', '%f', '%f', '%f', '%f', %i, %i)", PropertyInfo[houseid][E_PROPERTY_DBID], g_aFurnitureArray[PlayerInfo[playerid][E_CHARACTER_LISTITEM]][E_FURNITUREVAR_MODEL], g_aFurnitureArray[PlayerInfo[playerid][E_CHARACTER_LISTITEM]][E_FURNITUREVAR_NAME], g_aFurnitureArray[PlayerInfo[playerid][E_CHARACTER_LISTITEM]][E_FURNITUREVAR_PRICE], x, y, z, rx, ry, rz, PropertyInfo[houseid][E_PROPERTY_INTERIORINTERIOR], PropertyInfo[houseid][E_PROPERTY_INTERIORWORLD]);
						mysql_pquery(ourConnection, queryBuffer);

						mysql_pquery(ourConnection, "SELECT * FROM furniture WHERE id = LAST_INSERT_ID()", "Query_LoadFurniture", "i", PropertyInfo[houseid][E_PROPERTY_LABELS]);

						SendPropertyMessage(playerid, "[FURNITURE] Type '/prop furniture labels' to refresh the objects.");
						ReloadAllFurniture(houseid);
					}

					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTQUANTITY] = 0;
					PlayerInfo[playerid][E_CHARACTER_OBJECTOWN] = 0;
					format(PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], 512, "");
					DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]);
				}
			}
			case 8:
			{
				if(response == EDIT_RESPONSE_FINAL)
				{
					new queryBuffer[512];
					mysql_format(ourConnection, queryBuffer, sizeof(queryBuffer), "UPDATE furniture SET pos_x = '%f', pos_y = '%f', pos_z = '%f', rot_x = '%f', rot_y = '%f', rot_z = '%f' WHERE id = %i", x, y, z, rx, ry, rz, Streamer_GetExtraInt(objectid, E_OBJECT_INDEX_ID));
					mysql_tquery(ourConnection, queryBuffer);

					ReloadFurniture(objectid, PropertyInfo[IsPlayerInProperty(playerid)][E_PROPERTY_LABELS]);
				}
				if(response == EDIT_RESPONSE_CANCEL)
				{
					ReloadFurniture(objectid, PropertyInfo[IsPlayerInProperty(playerid)][E_PROPERTY_LABELS]);
				}
			}
			case 9:
			{
				if(response == EDIT_RESPONSE_FINAL)
				{
					new id = PlayerInfo[playerid][E_CHARACTER_OBJECTID];
					GateInfo[id][E_GATE_POS][0] = x;
					GateInfo[id][E_GATE_POS][1] = y;
					GateInfo[id][E_GATE_POS][2] = z;
					GateInfo[id][E_GATE_POS][3] = rx;
					GateInfo[id][E_GATE_POS][4] = ry;
					GateInfo[id][E_GATE_POS][5] = rz;

					Gates_Save(id);
					Gates_Refresh(id);
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					SendServerMessage(playerid, "You have edited the position of gate ID: #%d.", id);
				}
				if(response == EDIT_RESPONSE_CANCEL)
				{
					new id = PlayerInfo[playerid][E_CHARACTER_OBJECTID];
					Gates_Refresh(id);
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					SendErrorMessage(playerid, "You're no longer moved a gates."); 
				}
			}
			case 10:
			{
				if(response == EDIT_RESPONSE_FINAL)
				{
					new id = PlayerInfo[playerid][E_CHARACTER_OBJECTID];
					GateInfo[id][E_GATE_MOVE][0] = x;
					GateInfo[id][E_GATE_MOVE][1] = y;
					GateInfo[id][E_GATE_MOVE][2] = z;
					GateInfo[id][E_GATE_MOVE][3] = rx;
					GateInfo[id][E_GATE_MOVE][4] = ry;
					GateInfo[id][E_GATE_MOVE][5] = rz;

					Gates_Save(id);
					Gates_Refresh(id);
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					SendServerMessage(playerid, "You have edited the moving of gate ID: #%d.", id);
				}
				if(response == EDIT_RESPONSE_CANCEL)
				{
					new id = PlayerInfo[playerid][E_CHARACTER_OBJECTID];
					Gates_Refresh(id);
					PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
					SendErrorMessage(playerid, "You're no longer moved a gates."); 
				}
			}
		}
		
	}

	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	#if defined DEBUG_MODE
		printf("Callback OnVehicleSpawn called for vehicles %s (ID: %i)", ReturnVehicleName(vehicleid), vehicleid); 
	#endif

	if(HasNoEngine(vehicleid))
		ToggleVehicleEngine(vehicleid, true);
	return 1;
}

function:RefreshCharacters(playerid)
{
	if (!IsPlayerConnected(playerid))
	    return 0;

	SendServerMessage(playerid, "Your character list has been refreshed."); 
	
	new 
		fetchChars[128];
	
	mysql_format(ourConnection, fetchChars, sizeof(fetchChars), "SELECT * FROM characters WHERE `master_dbid` = '%d' LIMIT 4", AccountInfo[playerid][E_MASTERS_DBID]);
	mysql_pquery(ourConnection, fetchChars, "DB_ListCharacters", "i", playerid);
	return 1; 
}

function:Query_CreateStreetNames(playerid)
{
	if(cache_num_rows())
	{
		return SendClientMessage(playerid, COLOR_RED, "[ERROR]: That streetname already exists. Please try again."); 
	}
	else
	{
		new
			string[128]
		;
		
		for (new i = 0; i < 20; i++){SendClientMessage(playerid, -1, " "); }
		
		format (string, sizeof(string), "Your new characters street name will be: {33AA33}%s", playerCharactersStreetName[playerid]);
		SendClientMessage(playerid, -1, string); 

		SendClientMessage(playerid, -1, " "); 
		SendClientMessage(playerid, -1, "The next steps will require a background for your new character.");
		SendClientMessage(playerid, -1, "Please provide your characters date of birth. The format: {33AA33}02/02/1960");
		SendClientMessage(playerid, -1, "Press {33AA33}'T'{ffffff} to inputtext for character creation.");
		playerCharacterStep[playerid] = 3; 
	}
	return 1;
}

function:Query_CreateCharacter(playerid)
{
	if(cache_num_rows())
	{
		Dialog_Show(playerid, DialogCharName, DIALOG_STYLE_MSGBOX, "Character Name:", "Insert a full name of your character.\nInfo: Required in format of Firstname_Lastname", "Confirm", "");	
		SendErrorMessage(playerid, "That character already exists. Please try again."); 
		return 1; 
	}
	else
	{
		ShowCharacterPreview(playerid);
	}
	return 1;
}

function:Query_ChangeCharacter(playerid)
{
	if(cache_num_rows())
	{
		Dialog_Show(playerid, DialogChangeName, DIALOG_STYLE_INPUT, "Change Character Name:", "Insert a full name of your character.\n{33AA33}Info:{ffffff} Required in format of Firstname_Lastname", "Confirm", "Close");	
		SendErrorMessage(playerid, "That character already exists. Please try again."); 
		return 1; 
	}
	else
	{
		new query[256];
		mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET char_name = '%s' WHERE char_dbid = %d", playerCharactersName[playerid], PlayerInfo[playerid][E_CHARACTER_DBID]);
		mysql_tquery(ourConnection, query);

		SetPlayerName(playerid, playerCharactersName[playerid]);
		AccountInfo[playerid][E_MASTERS_STREETCREDITS] -= 150;
		SendServerMessage(playerid, "You has change character name to %s for 150 street credits.", playerCharactersName[playerid]);
	}
	return 1;
}

function:SaveCharacterPos(playerid)
{
	new thread[1024]; 
	
	if(PlayerInfo[playerid][E_CHARACTER_ADMINDUTY] || GetPlayerState(playerid) == PLAYER_STATE_SPECTATING || !PlayerInfo[playerid][E_CHARACTER_SPAWNED])
		return 0;

	GetPlayerPos(playerid, PlayerInfo[playerid][E_CHARACTER_LASTPOS][0], PlayerInfo[playerid][E_CHARACTER_LASTPOS][1], PlayerInfo[playerid][E_CHARACTER_LASTPOS][2]);
	PlayerInfo[playerid][E_CHARACTER_LASTINTERIOR] = GetPlayerInterior(playerid);
	PlayerInfo[playerid][E_CHARACTER_LASTWORLD] = GetPlayerVirtualWorld(playerid);
	GetPlayerHealth(playerid, PlayerInfo[playerid][E_CHARACTER_HEALTH]);
	GetPlayerArmour(playerid, PlayerInfo[playerid][E_CHARACTER_ARMOUR]);

	mysql_format(ourConnection, thread, sizeof(thread), "UPDATE characters SET pLastPosX = %f, pLastPosY = %f, pLastPosZ = %f, pLastInterior = %i, pLastWorld = %i, pInProperty = %i, pInBusiness = %i, pInEntrance = %i, pHasInjured = %i, pHasDeath = %i, pHealth = %f, pMaxHealth = %f, pArmor = %f WHERE char_dbid = %i",
		PlayerInfo[playerid][E_CHARACTER_LASTPOS][0],
		PlayerInfo[playerid][E_CHARACTER_LASTPOS][1],
		PlayerInfo[playerid][E_CHARACTER_LASTPOS][2],
		PlayerInfo[playerid][E_CHARACTER_LASTINTERIOR],
		PlayerInfo[playerid][E_CHARACTER_LASTWORLD],
		PlayerInfo[playerid][E_CHARACTER_INSIDEPROP],
		PlayerInfo[playerid][E_CHARACTER_INSIDEBIZ],
		PlayerInfo[playerid][E_CHARACTER_INSIDEENT],
		PlayerInfo[playerid][E_CHARACTER_INJURED],
		PlayerInfo[playerid][E_CHARACTER_DEATH],
		PlayerInfo[playerid][E_CHARACTER_HEALTH],
		PlayerInfo[playerid][E_CHARACTER_MAXHEALTH],
		PlayerInfo[playerid][E_CHARACTER_ARMOUR],
		PlayerInfo[playerid][E_CHARACTER_DBID]);
	
	return mysql_pquery(ourConnection, thread);
}

function:SaveCharacter(playerid)
{
	new query[2024];

	if(PlayerInfo[playerid][E_CHARACTER_ADMINDUTY] || GetPlayerState(playerid) == PLAYER_STATE_SPECTATING || !PlayerInfo[playerid][E_CHARACTER_SPAWNED])
		return 0;
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE masters SET forum_name = '%e', acc_admin = '%i', active_ip = '%e', vip = '%d', vip_time = '%d', street_credits = '%d' WHERE acc_dbid = %i",	
		AccountInfo[playerid][E_MASTERS_FORUMNAME],
		AccountInfo[playerid][E_MASTERS_ADMINS],
		PlayerInfo[playerid][E_CHARACTER_ACTIVEIP],
		AccountInfo[playerid][E_MASTERS_VIP],
		AccountInfo[playerid][E_MASTERS_VIPTIMER],
		AccountInfo[playerid][E_MASTERS_STREETCREDITS],
		AccountInfo[playerid][E_MASTERS_DBID]);
	mysql_pquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pAdmin = %i, pLastSkin = %i, pGender = %i, pFacSkin = %i, pLevel = %i, pMoney = %i, pBank = %i, pPaycheck = %i, pPhone = %i, pLastOnline = '%e', pLastOnlineTime = %i, pAdminjailed = %i, pAdminJailTime = %i WHERE char_dbid = %i",
		PlayerInfo[playerid][E_CHARACTER_ADMIN],
		PlayerInfo[playerid][E_CHARACTER_LASTSKIN],
		PlayerInfo[playerid][E_CHARACTER_GENDER],
		PlayerInfo[playerid][E_CHARACTER_FACSKIN],
		PlayerInfo[playerid][E_CHARACTER_LEVEL],
		PlayerInfo[playerid][E_CHARACTER_MONEY],
		PlayerInfo[playerid][E_CHARACTER_BANK],
		PlayerInfo[playerid][E_CHARACTER_PAYCHECK],
		PlayerInfo[playerid][E_CHARACTER_PHONE],
		ReturnDate(),
		PlayerInfo[playerid][E_CHARACTER_LASTONLINE],
		PlayerInfo[playerid][E_CHARACTER_ADMINJAILED],
		PlayerInfo[playerid][E_CHARACTER_ADMINJAIL],
		PlayerInfo[playerid][E_CHARACTER_DBID]);
	mysql_pquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pFaction = %i, pFactionRank = %i, pFactionSubsets = %i, pVehicleSpawned = %i, pVehicleSpawnedID = %i, pTimeplayed = %i, pMaskID = %i, pOfflinejailed = 0, pHasAoe = %i WHERE char_dbid = %i", 
		PlayerInfo[playerid][E_CHARACTER_FACTION], 
		PlayerInfo[playerid][E_CHARACTER_FACTIONRANK], 
		PlayerInfo[playerid][E_CHARACTER_FACTIONSUBSETS], 
		PlayerInfo[playerid][E_CHARACTER_VEHICLESPAWNED],
		PlayerInfo[playerid][E_CHARACTER_VEHICLESPAWN],
		PlayerInfo[playerid][E_CHARACTER_TIMEPLAYED],
		PlayerInfo[playerid][E_CHARACTER_MASKID],
		PlayerInfo[playerid][E_CHARACTER_AOE],
		PlayerInfo[playerid][E_CHARACTER_DBID]);
	mysql_pquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pMainSlot = %i, pRobberyCooldown = %i, pSpawnPoint = %i, pWeaponsLicense = %i, pDriversLicense = %i, pTruckerLicense = %i, pPrison = %i, pPrisonTimes = %i, pFightstyle = %i WHERE char_dbid = %i",
		PlayerInfo[playerid][E_CHARACTER_MAINSLOT],
		PlayerInfo[playerid][E_CHARACTER_ROBBERYCD],
		PlayerInfo[playerid][E_CHARACTER_SPAWNPOINT],
		PlayerInfo[playerid][E_CHARACTER_WEAPLICENSE],
		PlayerInfo[playerid][E_CHARACTER_DRIVELICENSE],
		PlayerInfo[playerid][E_CHARACTER_TRUCKERLICENSE],
		PlayerInfo[playerid][E_CHARACTER_PRISONED],
		PlayerInfo[playerid][E_CHARACTER_PRISON],
		PlayerInfo[playerid][E_CHARACTER_FIGHTSTYLE],
		PlayerInfo[playerid][E_CHARACTER_DBID]);
	mysql_pquery(ourConnection, query);

	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pJobs = %d, pJobsCD = %d, pSweeperCD = %d, pGarbageCD = %d, pBusdriverCD = %d, pDockworkerCD = %d,  pTutorial = %d, pEXP = %d WHERE char_dbid = %i",
		PlayerInfo[playerid][E_CHARACTER_JOBS],
		PlayerInfo[playerid][E_CHARACTER_JOBSCD],
		PlayerInfo[playerid][E_CHARACTER_SWEEPERCD],
		PlayerInfo[playerid][E_CHARACTER_GARBAGECD],
		PlayerInfo[playerid][E_CHARACTER_BUSDRIVERCD],
		PlayerInfo[playerid][E_CHARACTER_DOCKWORKERCD],
		PlayerInfo[playerid][E_CHARACTER_TUTORIAL],
		PlayerInfo[playerid][E_CHARACTER_EXP],
		PlayerInfo[playerid][E_CHARACTER_DBID]);
	mysql_pquery(ourConnection, query);
	
	mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pHungry = %f WHERE char_dbid = %i", 
		PlayerInfo[playerid][E_CHARACTER_HUNGRY],
		PlayerInfo[playerid][E_CHARACTER_DBID]);
	mysql_pquery(ourConnection, query);

	for(new i = 1; i < 3; i++)
	{
		mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pRadio%i = %i WHERE char_dbid = %i", 
			i, 
			PlayerInfo[playerid][E_CHARACTER_RADIO][i],
			PlayerInfo[playerid][E_CHARACTER_DBID]);
		mysql_pquery(ourConnection, query);
	}

	for(new i = 1; i < 8; i++)
	{
		mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pBodyPart%i = %i, pWound%i = %i WHERE char_dbid = %i", 
			i, 
			PlayerInfo[playerid][E_CHARACTER_BODYPART][i],
			i, 
			PlayerInfo[playerid][E_CHARACTER_WOUND][i],
			PlayerInfo[playerid][E_CHARACTER_DBID]);
		mysql_pquery(ourConnection, query);
	}
	
	for(new i = 1; i < MAX_PLAYER_VEHICLES; i++)
	{
		mysql_format(ourConnection, query, sizeof(query), "UPDATE characters SET pOwnedVehicles%d = %i WHERE char_dbid = %i", i, PlayerInfo[playerid][E_CHARACTER_OWNEDVEHICLE][i], PlayerInfo[playerid][E_CHARACTER_DBID]);
		mysql_pquery(ourConnection, query);
	}
	return 1;
}

public OnDynamicObjectMoved(objectid)
{
	#if defined DEBUG_MODE
		printf("Callback OnDynamicObjectMoved called for object (ID: %i)", objectid); 
	#endif

	// Basketball:
	foreach(new pid : Player)
	{
		new court = PlayerInfo[pid][E_CHARACTER_COURT];
		new i = CourtInfo[court][E_BALLER];
		
		if(CourtInfo[court][E_BALL_SHOOT] == 2)
		{
			PlayerBallShoot(i, 1);
			return 1;
		}
		else if(CourtInfo[court][E_BALL_SHOOT] == 3)
		{
			PlayerBallShoot(i, 2);
			return 1;
		}
		else if(CourtInfo[court][E_BALL_SHOOT] == 4)
		{
			PlayerBallShoot(i, 3);
			return 1;
		}
		else if(CourtInfo[court][E_BALL_SHOOT] == 5)
		{
			PlayerBallShoot(i, 4);
			return 1;
		}
		else if(CourtInfo[court][E_BALL_SHOOT] == 6)
		{
			ApplyAnimation(i,"BSKTBALL","BBALL_walk",4.1,1,1,1,1,1);
			PlayerInfo[i][E_CHARACTER_HAVEBALL] = 1;
			PlayerInfo[i][E_CHARACTER_ANIMBALL] = 0;
		}
		else if(CourtInfo[court][E_BALL_SHOOT] == 7)
		{
			PlayerShootMiss(i, 3);
			return 1;
		}
		else if(CourtInfo[court][E_BALL_SHOOT] == 8)
		{
			PlayerShootMiss(i, 4);
			return 1;
		}
		if(CourtInfo[court][E_BALL_BOUNCE] == 1)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2]+1.0, 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 2;
		}
		else if(CourtInfo[court][E_BALL_BOUNCE] == 2)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2], 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 3;
		}
		else if(CourtInfo[court][E_BALL_BOUNCE] == 3)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2]+0.8, 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 4;
		}
		else if(CourtInfo[court][E_BALL_BOUNCE] == 4)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2], 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 5;
		}
		else if(CourtInfo[court][E_BALL_BOUNCE] == 5)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2]+0.6, 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 6;
		}
		else if(CourtInfo[court][E_BALL_BOUNCE] == 6)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2], 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 7;
		}
		else if(CourtInfo[court][E_BALL_BOUNCE] == 7)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2]+0.4, 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 8;
		}
		else if(CourtInfo[court][E_BALL_BOUNCE] == 8)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2], 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 0;
		}
		else if(CourtInfo[court][E_BALL_BOUNCE] == 9)
		{
			new Float:x, Float:y, Float:z;
			GetDynamicObjectPos(CourtInfo[court][E_BALL_OBJECT], x, y, z);
			MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x, y, CourtInfo[court][E_BALL_POS][2], 7.0);
			CourtInfo[court][E_BALL_BOUNCE] = 1;
		}

		// Have Ball:
		if(!PlayerInfo[i][E_CHARACTER_HAVEBALL]) return 1;
		new Keys, ud, lr;
		GetPlayerKeys(i, Keys, ud, lr);
		if(PlayerInfo[i][E_CHARACTER_ANIMBALL])
		{
			switch(CourtInfo[court][E_BALL_STATUS])
			{
				case 0:
				{
					CourtInfo[court][E_BALL_STATUS] = 1;
					new Float:x, Float:y, Float:z;
					GetPlayerPos(i, x, y, z);
					StopDynamicObject(CourtInfo[court][E_BALL_OBJECT]);
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(i, x2, y2, 0.4);
					MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x2, y2, z+0.1, 8.0);
					PlayNearbySound(i, 4600);
				}
				case 1:
				{
					CourtInfo[court][E_BALL_STATUS] = 0;
					new Float:x, Float:y, Float:z;
					GetPlayerPos(i, x, y, z);
					StopDynamicObject(CourtInfo[court][E_BALL_OBJECT]);
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(i, x2, y2, 0.4);
					MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x2, y2, CourtInfo[court][E_BALL_POS][2], 8.0);
					PlayNearbySound(i, 4600);
				}
			}
			return 1;
		}
		if(Keys & KEY_SPRINT)
		{
			ApplyAnimation(i,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
			switch(CourtInfo[court][E_BALL_STATUS])
			{
				case 0:
				{
					CourtInfo[court][E_BALL_STATUS] = 1;
					new Float:x, Float:y, Float:z;
					GetPlayerPos(i, x, y, z);
					StopDynamicObject(CourtInfo[court][E_BALL_OBJECT]);
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(i, x2, y2, 1.5);
					MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x2, y2, z+0.1, 10.0);
					PlayNearbySound(i, 4600);
				}
				case 1:
				{
					CourtInfo[court][E_BALL_STATUS] = 0;
					new Float:x, Float:y, Float:z;
					GetPlayerPos(i, x, y, z);
					StopDynamicObject(CourtInfo[court][E_BALL_OBJECT]);
					new Float:x2, Float:y2;
					GetXYInFrontOfPlayer(i, x2, y2, 1.5);
					MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x2, y2, CourtInfo[court][E_BALL_POS][2], 10.0);
					PlayNearbySound(i, 4600);
				}
			}
			return 1;
		}
		else
		{
			ApplyAnimation(i, "BSKTBALL","BBALL_walk",4.1,1,1,1,1,1);
		}
		switch(CourtInfo[court][E_BALL_STATUS])
		{
			case 0:
			{
				CourtInfo[court][E_BALL_STATUS] = 1;
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x, y, z);
				StopDynamicObject(CourtInfo[court][E_BALL_OBJECT]);
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(i, x2, y2, 1.2);
				MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x2, y2, z+0.1, 8.0);
				PlayNearbySound(i, 4600);
			}
			case 1:
			{
				CourtInfo[court][E_BALL_STATUS] = 0;
				new Float:x, Float:y, Float:z;
				GetPlayerPos(i, x, y, z);
				StopDynamicObject(CourtInfo[court][E_BALL_OBJECT]);
				new Float:x2, Float:y2;
				GetXYInFrontOfPlayer(i, x2, y2, 1.2);
				MoveDynamicObject(CourtInfo[court][E_BALL_OBJECT], x2, y2, CourtInfo[court][E_BALL_POS][2], 8.0);
				PlayNearbySound(i, 4600);
			}
		}
	}
	return 1;
}

public OnPlayerGiveDamageDynamicActor(playerid, actorid, Float:amount, weaponid, bodypart)
{
	if(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ACTOR] == actorid  && PlayerInfo[playerid][E_CHARACTER_EXTORTION] == true)
	{
		if(PlayerInfo[playerid][E_CHARACTER_EXTORTIONPOINT] < 100.0)
			PlayerInfo[playerid][E_CHARACTER_EXTORTIONPOINT] += 2.5;

		else if(PlayerInfo[playerid][E_CHARACTER_EXTORTIONPOINT] > 100.0)
			PlayerInfo[playerid][E_CHARACTER_EXTORTIONPOINT] = 100.0;

		SetPlayerGameBar(playerid, PlayerInfo[playerid][E_CHARACTER_EXTORTIONPOINT]);
	}
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	if(IsPoliceVehicle(vehicleid))
	{
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);

		if(newstate == 1) // Siren ON
		{
			SetVehicleParamsEx(vehicleid, engine, 1, alarm, doors, bonnet, boot, objective); 
			VehicleTimers[vehicleid] = SetTimerEx("ToggleVehicleSirenLights", 250, true, "i", vehicleid);
		}
		else if(newstate == 0) // Siren OFF
		{
			KillTimer(VehicleTimers[vehicleid]); 
			SetVehicleParamsEx(vehicleid, engine, 0, alarm, doors, bonnet, boot, objective); 
		}
	}
	return 1;
}