stock ShowBusinessShop(playerid, businessid)
{
	new str[128], str2[128], str3[128], str4[128];
	if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_BAR)
	{
		if(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH])
		{
			Dialog_Show(playerid, DialogClerk, DIALOG_STYLE_LIST, "Choose an option:", "Inventory\nPay to clerk\nTake Cash", "Select", "Close");
			return 1;
		}

		format(str, sizeof(str), "%s:", BusinessInfo[businessid][E_BUSINESS_NAME]);
		format(str2, sizeof(str2), "Product\tPrice\n");
		format(str2, sizeof(str2), "%sPisswasher (Beer)\t$%s\n", str2, FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][1]));
		format(str2, sizeof(str2), "%sPisswasher Extra (Beer)\t$%s\n", str2, FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][2]));
		format(str2, sizeof(str2), "%sPisswasher Large (Beer)\t$%s\n", str2, FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][3]));
		Dialog_Show(playerid, DialogBarstore, DIALOG_STYLE_TABLIST_HEADERS, str, str2, "Select", "Cancel");
		Relations_Add(playerid, BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME]);
	}
	else if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_CLOTHES)
	{
		if(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH])
		{
			Dialog_Show(playerid, DialogClerk, DIALOG_STYLE_LIST, "Choose an option:", "Inventory\nPay to clerk\nTake Cash", "Select", "Close");
			return 1;
		}

		format(str, sizeof(str), "%s:", BusinessInfo[businessid][E_BUSINESS_NAME]);
		format(str2, sizeof(str2), "Product\tPrice\n");
		format(str2, sizeof(str2), "%sClassic Clothes\t$%s\n", str2, FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][1]));
		format(str2, sizeof(str2), "%sAccessories\t$%s\n", str2, FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][2]));
		Dialog_Show(playerid, DialogBuyskin, DIALOG_STYLE_TABLIST_HEADERS, str, str2, "Select", "Cancel");
		Relations_Add(playerid, BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME]);
	}
	else if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_CLUB)
	{
		if(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH])
		{
			Dialog_Show(playerid, DialogClerk, DIALOG_STYLE_LIST, "Choose an option:", "Inventory\nPay to clerk\nTake Cash", "Select", "Close");
			return 1;
		}

		format(str, sizeof(str), "%s:", BusinessInfo[businessid][E_BUSINESS_NAME]);
		format(str2, sizeof(str2), "Product\tPrice\n");
		format(str2, sizeof(str2), "%sPisswasher (Beer)\t$%s\n", str2, FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][1]));
		format(str2, sizeof(str2), "%sPisswasher Extra (Beer)\t$%s\n", str2, FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][2]));
		format(str2, sizeof(str2), "%sPisswasher Large (Beer)\t$%s\n", str2, FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][3]));
		Dialog_Show(playerid, DialogBarstore, DIALOG_STYLE_TABLIST_HEADERS, str, str2, "Select", "Cancel");
		Relations_Add(playerid, BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME]);
	}
	else if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_DINNER)
	{
		if(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH])
		{
			Dialog_Show(playerid, DialogClerk, DIALOG_STYLE_LIST, "Choose an option:", "Inventory\nPay to clerk\nTake Cash", "Select", "Close");
			return 1;
		}

		format(str, sizeof(str), "%s:", BusinessInfo[businessid][E_BUSINESS_NAME]);
		PlayerTextDrawSetString(playerid, FoodOrder[1][playerid], str);

		format(str2, sizeof(str2), "Buster~n~~r~Health +10.0~n~~b~Price $%s", FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][1]));
		PlayerTextDrawSetString(playerid, FoodOrder[5][playerid], str2);
		format(str3, sizeof(str3), "Duoble D-Luxe~n~~r~Health +15.0~n~~b~Price $%s", FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][2]));
		PlayerTextDrawSetString(playerid, FoodOrder[7][playerid], str3);
		format(str4, sizeof(str4), "Full Rack~n~~r~Health +20.0~n~~b~Price $%s", FormatMoney(BusinessInfo[businessid][E_BUSINESS_PRODUCTS][3]));
		PlayerTextDrawSetString(playerid, FoodOrder[8][playerid], str4);

		for(new i; i < 10; i++)
		{
			PlayerTextDrawShow(playerid, FoodOrder[i][playerid]);
		}
		SelectTextDraw(playerid, COLOR_YELLOW);
		Relations_Add(playerid, BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME]);
	}
	else if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_GENERAL)
	{
		if(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH])
		{
			Dialog_Show(playerid, DialogClerk, DIALOG_STYLE_LIST, "Choose an option:", "Inventory\nPay to clerk\nTake Cash", "Select", "Close");
		}
		else
		{
			if(PlayerInfo[playerid][E_CHARACTER_PURCHASE] == 0)
				return SendErrorMessage(playerid, "You don't have a bill to pay to the clerk.");

			if(PlayerInfo[playerid][E_CHARACTER_PURCHASE] > PlayerInfo[playerid][E_CHARACTER_MONEY])
			{
				return SendErrorMessage(playerid, "You can't afford a bills.");
			}

			Dialog_Show(playerid, DialogClerk, DIALOG_STYLE_LIST, "Choose an option:", "Inventory\nPay to clerk", "Select", "Close");

			Relations_Add(playerid, BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME]);
		}
	}
	else if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_HAIRCUT)
	{
		if(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH])
		{
			Dialog_Show(playerid, DialogClerk, DIALOG_STYLE_LIST, "Choose an option:", "Inventory\nPay to clerk\nTake Cash", "Select", "Close");
			return 1;
		}

		SetPlayerPos(playerid, 414.4374,-19.8381,1001.8047);
		SetPlayerFacingAngle(playerid, 88.7491);

		new str5[512];
		for(new i; i < sizeof(g_aHaircut); i++)
		{
			format(str5, sizeof(str5), "%s%d\n", str5, g_aHaircut[i]);
		}
		Dialog_Show(playerid, DialogBarberstore, DIALOG_STYLE_TABLIST, "Choose your skins:", str5, "Select", "Close");
		Relations_Add(playerid, BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME]);
	}
	else if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_BANK)
	{
		cmd_bank(playerid, "");
	}
	else if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_GYM)
	{
		if(BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_ROBBERYCASH])
		{
			Dialog_Show(playerid, DialogClerk, DIALOG_STYLE_LIST, "Choose an option:", "Inventory\nPay to clerk\nTake Cash", "Select", "Close");
			return 1;
		}

		ShowFightStyleMenu(playerid);
		Relations_Add(playerid, BusinessInfo[IsPlayerInBusiness(playerid)][E_BUSINESS_NAME]);
	}
	return 1;
}

function:OnPlayerEnterBusiness(playerid, id)
{
	PlayerEnterTimer[playerid] = false;
	return TogglePlayerControllable(playerid, true);
}

stock BusinessRefresh(businessid)
{
	if(IsValidDynamicPickup(BusinessInfo[businessid][E_BUSINESS_PICKUP]))
		DestroyDynamicPickup(BusinessInfo[businessid][E_BUSINESS_PICKUP]); 
	
	if(IsValidObject(BusinessInfo[businessid][E_BUSINESS_RDUMBELL]))
		DestroyObject(BusinessInfo[businessid][E_BUSINESS_RDUMBELL]); 

	if(IsValidObject(BusinessInfo[businessid][E_BUSINESS_LDUMBELL]))
		DestroyObject(BusinessInfo[businessid][E_BUSINESS_LDUMBELL]); 

	if(IsValidDynamic3DTextLabel(BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D]))
		DestroyDynamic3DTextLabel(BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D]);

	if(IsValidDynamic3DTextLabel(BusinessInfo[businessid][E_BUSINESS_FUEL3DTEXT]))
		DestroyDynamic3DTextLabel(BusinessInfo[businessid][E_BUSINESS_FUEL3DTEXT]);

	if(IsValidDynamic3DTextLabel(BusinessInfo[businessid][E_BUSINESS_3DTEXT]))
		DestroyDynamic3DTextLabel(BusinessInfo[businessid][E_BUSINESS_3DTEXT]);

	if(IsValidDynamicActor(BusinessInfo[businessid][E_BUSINESS_ACTOR]))
		DestroyDynamicActor(BusinessInfo[businessid][E_BUSINESS_ACTOR]);

	switch(BusinessInfo[businessid][E_BUSINESS_TYPE])
	{
		case BUSINESS_TYPE_BANK:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
		case BUSINESS_TYPE_DINNER:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
		case BUSINESS_TYPE_BAR:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
			
		case BUSINESS_TYPE_ACID:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Production]\n{ffffff}Available commands: '/production' to opens the production drugs menu.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
		    
		case BUSINESS_TYPE_GENERAL:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
		    
		case BUSINESS_TYPE_GUNSTORE:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Production]\n{ffffff}Available commands: '/creategun' to create weapons / ammo with materials..", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
		    
		case BUSINESS_TYPE_CLOTHES:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
		    
		case BUSINESS_TYPE_HAIRCUT:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
		   
		case BUSINESS_TYPE_RENT:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
		    
		case BUSINESS_TYPE_CLUB:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
			
		case BUSINESS_TYPE_AMMUNATION:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Available commands: '/buyweapon' to see weapon menu.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
			
		case BUSINESS_TYPE_DMV:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Available commands: '/drivetest' to see menu.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
			
		case BUSINESS_TYPE_GYM:
		{
			BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINTTEXT3D] = CreateDynamic3DTextLabel("[Cashiers]\n{ffffff}Press 'N' to pay items to clerk.", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR]);
		}
	}
	
	BusinessInfo[businessid][E_BUSINESS_ACTOR] = CreateDynamicActor(BusinessActor[BusinessInfo[businessid][E_BUSINESS_TYPE]][E_BACTOR_SKIN], BusinessInfo[businessid][E_BUSINESS_ACTORPOS][0], BusinessInfo[businessid][E_BUSINESS_ACTORPOS][1], BusinessInfo[businessid][E_BUSINESS_ACTORPOS][2], BusinessInfo[businessid][E_BUSINESS_ACTORPOS][3], false);
	SetDynamicActorFacingAngle(BusinessInfo[businessid][E_BUSINESS_ACTOR], BusinessInfo[businessid][E_BUSINESS_ACTORPOS][3]);
	SetDynamicActorVirtualWorld(BusinessInfo[businessid][E_BUSINESS_ACTOR], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD]);

	if(BusinessInfo[businessid][E_BUSINESS_ROBBERYTIME] > 0)
	{
		ClearDynamicActorAnimations(BusinessInfo[businessid][E_BUSINESS_ACTOR]);
		ApplyDynamicActorAnimation(BusinessInfo[businessid][E_BUSINESS_ACTOR], "PED", "DUCK_cower", 4.1, 0, 0, 0, 1, 0);
	}
	else
	{
		ClearDynamicActorAnimations(BusinessInfo[businessid][E_BUSINESS_ACTOR]);
		ApplyDynamicActorAnimation(BusinessInfo[businessid][E_BUSINESS_ACTOR], "SHOP", "SHP_Serve_Idle", 4.1, 0, 0, 0, 1, 0);
		foreach(new playerid : Player)
		{
			PlayerPlaySound(playerid, 0, 0, 0, 0);
		}
	}

	if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_RENT)
		BusinessInfo[businessid][E_BUSINESS_PICKUP] = CreateDynamicPickup(1239, 1, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][2], 0, 0, -1, 5.0);
	else
		BusinessInfo[businessid][E_BUSINESS_PICKUP] = CreateDynamicPickup(19198, 1, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][2], 0, 0, -1, 5.0);
	
	new text[128];
	format(text, sizeof(text), "%s\nFee: {ffffff}$%s", BusinessInfo[businessid][E_BUSINESS_NAME], FormatMoney(BusinessInfo[businessid][E_BUSINESS_FEE]));
	BusinessInfo[businessid][E_BUSINESS_3DTEXT] = CreateDynamic3DTextLabel(text, COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][2], 5.0);
	BusinessInfo[businessid][E_BUSINESS_FUEL3DTEXT] = CreateDynamic3DTextLabel("[Gas Station]\n{ffffff}Available Commands: '/refuel' to refill vehicles fuel", COLOR_3DTEXT, BusinessInfo[businessid][E_BUSINESS_FUELPOS][0], BusinessInfo[businessid][E_BUSINESS_FUELPOS][1], BusinessInfo[businessid][E_BUSINESS_FUELPOS][2], 5.0);
	
	if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_GYM)
	{
		BusinessInfo[businessid][E_BUSINESS_RDUMBELL] = CreateObject(3071, 772.992,5.18281,999.927,0.0,90.0,90.0);
		BusinessInfo[businessid][E_BUSINESS_LDUMBELL] = CreateObject(3072, 772.992,5.62738,999.927,0.0,90.0,90.0);
	}

	BusinessInfo[businessid][E_BUSINESS_TREADMILL] = false;
	BusinessInfo[businessid][E_BUSINESS_DUMBELL] = false;
	BusinessInfo[businessid][E_BUSINESS_BYCICLE] = false;
	BusinessInfo[businessid][E_BUSINESS_BENCH] = false;

	BusinessInfo[businessid][E_BUSINESS_EXISTS] = true;
	if(BusinessInfo[businessid][E_BUSINESS_ROBBERYCASH] == true)
	{
		BusinessInfo[businessid][E_BUSINESS_CASHOBJECT] = CreateDynamicObject(1212, BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2], 0.0, 0.0, 0.0, BusinessInfo[businessid][E_BUSINESS_INTERIORPOSWORLD], BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR], -1, 5.0);
	}
	else
	{
		DestroyDynamicObject(BusinessInfo[businessid][E_BUSINESS_CASHOBJECT]);
		BusinessInfo[businessid][E_BUSINESS_ROBBERYCASH] = false;
	}

	if(BusinessInfo[businessid][E_BUSINESS_TYPE] == BUSINESS_TYPE_BAR)
	{
		Query_LoadBusinessPool(businessid);
	}
	return 1;
}

function:OnBusinessInteriorChange(playerid, response, businessid)
{
	if(response)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		new interior = GetPlayerInterior(playerid); 
		
		BusinessInfo[businessid][E_BUSINESS_INTERIORPOS][0] = x; 
		BusinessInfo[businessid][E_BUSINESS_INTERIORPOS][1] = y; 
		BusinessInfo[businessid][E_BUSINESS_INTERIORPOS][2] = z; 
		BusinessInfo[businessid][E_BUSINESS_INTERIORPOSINTERIOR] = interior;

		BusinessRefresh(businessid);
		SendServerMessage(playerid, "You changed Business #%i's interior.", businessid);
		SaveBusiness(businessid); 
	}
	else return SendErrorMessage(playerid, "You cancelled.");
	return 1;
}

function:OnBusinessEntranceChange(playerid, response, businessid)
{
	if(response)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z); 
		
		BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][0] = x;
		BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][1] = y;
		BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOS][2] = z;

		BusinessRefresh(businessid);
		SendServerMessage(playerid, "You changed Business #%i's entrance.", businessid);
		SaveBusiness(businessid); 
	}
	else return SendErrorMessage(playerid, "You cancelled.");
	return 1;
}

function:OnBusinessGasStationChange(playerid, response, businessid)
{
	if(response)
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z); 
		
		BusinessInfo[businessid][E_BUSINESS_FUELPOS][0] = x;
		BusinessInfo[businessid][E_BUSINESS_FUELPOS][1] = y;
		BusinessInfo[businessid][E_BUSINESS_FUELPOS][2] = z;

		BusinessRefresh(businessid);
		SendServerMessage(playerid, "You changed Business #%i's gas station.", businessid);
		SaveBusiness(businessid); 
	}
	else return SendErrorMessage(playerid, "You cancelled.");
	return 1;
}

function:OnBusinessActorChange(playerid, response, businessid)
{
	if(response)
	{
		new Float:x, Float:y, Float:z, Float:a;
		GetPlayerPos(playerid, x, y, z); 
		GetPlayerFacingAngle(playerid, a);
		
		BusinessInfo[businessid][E_BUSINESS_ACTORPOS][0] = x;
		BusinessInfo[businessid][E_BUSINESS_ACTORPOS][1] = y;
		BusinessInfo[businessid][E_BUSINESS_ACTORPOS][2] = z;
		BusinessInfo[businessid][E_BUSINESS_ACTORPOS][3] = a;

		BusinessRefresh(businessid);
		SendServerMessage(playerid, "You changed Business #%i's actor.", businessid);
		SaveBusiness(businessid); 
	}
	else return SendErrorMessage(playerid, "You cancelled.");
	return 1;
}

function:OnBusinessPointChange(playerid, response, businessid, Float:x, Float:y, Float:z)
{
	if(response)
	{
		BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][0] = x;
		BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][1] = y;
		BusinessInfo[businessid][E_BUSINESS_ENTRANCEPOINT][2] = z;
		
		BusinessRefresh(businessid);
		SendServerMessage(playerid, "You changed Business #%i's point.", businessid);
		SaveBusiness(businessid); 
	}
	else return SendErrorMessage(playerid, "You cancelled.");
	return 1;
}

stock IsPlayerNearBusiness(playerid)
{
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, BusinessInfo[i][E_BUSINESS_ENTRANCEPOS][0], BusinessInfo[i][E_BUSINESS_ENTRANCEPOS][1], BusinessInfo[i][E_BUSINESS_ENTRANCEPOS][2]))
			return i;
	}
	return 0;
}

stock IsPlayerNearCashiers(playerid)
{
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, BusinessInfo[i][E_BUSINESS_ENTRANCEPOINT][0], BusinessInfo[i][E_BUSINESS_ENTRANCEPOINT][1], BusinessInfo[i][E_BUSINESS_ENTRANCEPOINT][2]))
			return i;
	}
	return 0;
}

stock IsPlayerNearGasStation(playerid)
{
	for(new i = 1; i < MAX_BUSINESS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, BusinessInfo[i][E_BUSINESS_FUELPOS][0], BusinessInfo[i][E_BUSINESS_FUELPOS][1], BusinessInfo[i][E_BUSINESS_FUELPOS][2]))
			return i;
	}
	return 0;
}

stock IsPlayerInBusiness(playerid)
{
	if(PlayerInfo[playerid][E_CHARACTER_INSIDEBIZ])
	{
		for(new i = 1; i < MAX_BUSINESS; i++)
		{
			if(!BusinessInfo[i][E_BUSINESS_DBID])
				continue;
				
			if(i == PlayerInfo[playerid][E_CHARACTER_INSIDEBIZ] && GetPlayerVirtualWorld(playerid) == BusinessInfo[i][E_BUSINESS_INTERIORPOSWORLD])
				return i;
		}
	}
	return 0;
}

stock CountPlayerBusiness(playerid)
{
    new count = 0;
    
    for(new i = 1; i < MAX_BUSINESS; i++)
    {
        if(!BusinessInfo[i][E_BUSINESS_DBID])
            continue;
            
        if(BusinessInfo[i][E_BUSINESS_OWNERDBID] == PlayerInfo[playerid][E_CHARACTER_DBID])
            count++;
    }
    return count;
}

stock SendBusinessType(playerid, id)
{
	new str[128];
	switch(BusinessInfo[id][E_BUSINESS_TYPE])
	{
		case BUSINESS_TYPE_GUNSTORE:
		{
			format(str, sizeof(str), "Welcome to %s. This is a gun store you can create gun/ammo.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Available commands: /creategun.");
		}
		case BUSINESS_TYPE_BANK:
		{
			format(str, sizeof(str), "Welcome to %s. This is a bank you can withdraw, deposit, or see balance your money in bank.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Available commands: /withdraw /deposit /balance.");
		}
		case BUSINESS_TYPE_GENERAL:
		{
			format(str, sizeof(str), "Welcome to %s. This is a general store you can buy anything.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Press N to purchase items.");
		}
		case BUSINESS_TYPE_CLUB:
		{
			format(str, sizeof(str), "Welcome to %s. This is a club you can buy anything beer.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Press N to purchase items.");
		}
		case BUSINESS_TYPE_DINNER:
		{
			format(str, sizeof(str), "Welcome to %s. This is a restaurant you can buy anything food or drink if you hungry and thirsty.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Press N to purchase items.");
		}
		case BUSINESS_TYPE_BAR:
		{
			format(str, sizeof(str), "Welcome to %s. This is a bar you can buy anything beer.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Press N to purchase items.");
		}
		case BUSINESS_TYPE_ACID:
		{
			format(str, sizeof(str), "Welcome to %s This is a acid labs you can produce drugs or something.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Available commands: /production.");
		}
		
		case BUSINESS_TYPE_CLOTHES:
		{
			format(str, sizeof(str), "Welcome to %s. This is a clothes store you can buy anything clothing or skins.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Press N to purchase items.");
		}
		case BUSINESS_TYPE_HAIRCUT:
		{
			format(str, sizeof(str), "Welcome to %s. This is a haircuts you can buy anything wigs or cuts your stylish hair.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Press N to purchase items.");
		}
		case BUSINESS_TYPE_RENT:
		{
			format(str, sizeof(str), "Welcome to %s. This is a rental you can rent anything vehicles.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
		}
		case BUSINESS_TYPE_GYM:
		{
			format(str, sizeof(str), "Welcome to %s. This is a gym you can learn fightsyle and increase your muscles.", BusinessInfo[id][E_BUSINESS_NAME]);
			SendClientMessage(playerid, COLOR_ORANGE, str);
			SendClientMessage(playerid, COLOR_ORANGE, "Available commands: /fightstyle /gym.");
		}
	}
	return 1;
}

function:OnSellBusiness(playerid, response, businessid)
{
	if(response)
	{
		new
			totalPay;
		
		totalPay = BusinessInfo[businessid][E_BUSINESS_PRICE] / 2 + BusinessInfo[businessid][E_BUSINESS_CASH]; 

    	GiveMoney(playerid, totalPay);
		
		BusinessInfo[businessid][E_BUSINESS_OWNERDBID] = 0; 
		
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SendServerMessage(playerid, "You sold your business and earned $%s.", FormatMoney(totalPay)); 
		
		SaveBusiness(businessid); SaveCharacter(playerid); 
	}
	else return SendErrorMessage(playerid, "You cancelled selling your business.");
	return 1;
}

function:OnPlayerExitDealership(playerid, response)
{
	if(response)
	{
		SendServerMessage(playerid, "You exited out the dealership.");
		
		ResetVehicleVars(DealershipPlayerCar[playerid]); 
		DestroyVehicle(DealershipPlayerCar[playerid]); 
		
		ResetDealershipVars(playerid);
		TogglePlayerControllable(playerid, true); 
	}
	else return ShowDealerAppend(playerid);
	return 1;
}

function:Query_InsertBusiness(playerid, newid, type)
{
	new 
		world = random(20000)+playerid+2;

	BusinessInfo[newid][E_BUSINESS_DBID] = cache_insert_id(); 
	BusinessInfo[newid][E_BUSINESS_TYPE] = type; 
 
 	format(BusinessInfo[newid][E_BUSINESS_NAME], 90, "Unknown");
	
	BusinessInfo[newid][E_BUSINESS_INTERIORPOS][0] = 0; 
	BusinessInfo[newid][E_BUSINESS_INTERIORPOS][1] = 0; 
	BusinessInfo[newid][E_BUSINESS_INTERIORPOS][2] = 0; 
	BusinessInfo[newid][E_BUSINESS_INTERIORPOSINTERIOR] = 0;
	BusinessInfo[newid][E_BUSINESS_INTERIORPOSWORLD] = world;  

	BusinessRefresh(newid);
	SendServerMessage(playerid, "You created business ID #%i. To configure, use \"/editbusiness\". ", newid); 
	return 1;
}

function:Query_LoadBusinesses()
{
	if(!cache_num_rows())
		return printf("[SERVER]: No businesses were loaded from \"%s\" database...", SQL_DATABASE); 
		
	new rows, fields; 
	cache_get_row_count(rows);
	cache_get_field_count(fields);
	
	for(new i = 0; i < rows && i < MAX_BUSINESS; i++)
	{
		BusinessInfo[i+1][E_BUSINESS_EXISTS] = true;

		cache_get_value_name_int(i, "BusinessDBID", BusinessInfo[i+1][E_BUSINESS_DBID]);
		cache_get_value_name_int(i, "BusinessOwnerDBID", BusinessInfo[i+1][E_BUSINESS_OWNERDBID]); 
		
		cache_get_value_name_float(i, "BusinessInteriorX", BusinessInfo[i+1][E_BUSINESS_INTERIORPOS][0]);
		cache_get_value_name_float(i, "BusinessInteriorY", BusinessInfo[i+1][E_BUSINESS_INTERIORPOS][1]);
		cache_get_value_name_float(i, "BusinessInteriorZ", BusinessInfo[i+1][E_BUSINESS_INTERIORPOS][2]);
		
		cache_get_value_name_int(i, "BusinessInteriorWorld", BusinessInfo[i+1][E_BUSINESS_INTERIORPOSWORLD]);
		cache_get_value_name_int(i, "BusinessInteriorIntID", BusinessInfo[i+1][E_BUSINESS_INTERIORPOSINTERIOR]);
		
		cache_get_value_name_float(i, "BusinessEntranceX", BusinessInfo[i+1][E_BUSINESS_ENTRANCEPOS][0]);
		cache_get_value_name_float(i, "BusinessEntranceY", BusinessInfo[i+1][E_BUSINESS_ENTRANCEPOS][1]);
		cache_get_value_name_float(i, "BusinessEntranceZ", BusinessInfo[i+1][E_BUSINESS_ENTRANCEPOS][2]);

		cache_get_value_name_float(i, "BusinessPointX", BusinessInfo[i+1][E_BUSINESS_ENTRANCEPOINT][0]);
		cache_get_value_name_float(i, "BusinessPointY", BusinessInfo[i+1][E_BUSINESS_ENTRANCEPOINT][1]);
		cache_get_value_name_float(i, "BusinessPointZ", BusinessInfo[i+1][E_BUSINESS_ENTRANCEPOINT][2]);

		cache_get_value_name_float(i, "BusinessFuelX", BusinessInfo[i+1][E_BUSINESS_FUELPOS][0]);
		cache_get_value_name_float(i, "BusinessFuelY", BusinessInfo[i+1][E_BUSINESS_FUELPOS][1]);
		cache_get_value_name_float(i, "BusinessFuelZ", BusinessInfo[i+1][E_BUSINESS_FUELPOS][2]);

		cache_get_value_name_float(i, "BusinessActorX", BusinessInfo[i+1][E_BUSINESS_ACTORPOS][0]);
		cache_get_value_name_float(i, "BusinessActorY", BusinessInfo[i+1][E_BUSINESS_ACTORPOS][1]);
		cache_get_value_name_float(i, "BusinessActorZ", BusinessInfo[i+1][E_BUSINESS_ACTORPOS][2]);
		cache_get_value_name_float(i, "BusinessActorA", BusinessInfo[i+1][E_BUSINESS_ACTORPOS][3]);
		
		cache_get_value_name(i, "BusinessName", BusinessInfo[i+1][E_BUSINESS_NAME], 90); 
		cache_get_value_name_int(i, "BusinessType", BusinessInfo[i+1][E_BUSINESS_TYPE]);
		
		cache_get_value_bool(i, "BusinessLocked", BusinessInfo[i+1][E_BUSINESS_LOCKED]); 
		cache_get_value_name_int(i, "BusinessEntranceFee", BusinessInfo[i+1][E_BUSINESS_FEE]); 
		
		cache_get_value_name_int(i, "BusinessMapIcon", BusinessInfo[i+1][E_BUSINESS_MAPICONTYPE]); 
		cache_get_value_name_int(i, "BusinessLevel", BusinessInfo[i+1][E_BUSINESS_LEVEL]); 
		cache_get_value_name_int(i, "BusinessMarketPrice", BusinessInfo[i+1][E_BUSINESS_PRICE]);
		
		cache_get_value_name_int(i, "BusinessCashbox", BusinessInfo[i+1][E_BUSINESS_CASH]);
		cache_get_value_name_int(i, "BusinessStock", BusinessInfo[i+1][E_BUSINESS_STOCK]);

		cache_get_value_name_int(i, "BusinessRobberyTime", BusinessInfo[i+1][E_BUSINESS_ROBBERYTIME]);
		cache_get_value_name_int(i, "BusinessShipments", BusinessInfo[i+1][E_BUSINESS_SHIPMENTS]);

		cache_get_value_name_int(i, "BusinessAmount", BusinessInfo[i+1][E_BUSINESS_AMOUNT]);

		for(new a = 1; a < 7; a++)
		{
			new str[32];
			format(str, sizeof(str), "BusinessProducts%d", a);
			cache_get_value_name_int(i, str, BusinessInfo[i+1][E_BUSINESS_PRODUCTS][a]);
		}
		
		BusinessRefresh(i+1);
	}	
	printf("[SERVER]: %i businesses were loaded from \"%s\" database...", rows, SQL_DATABASE);
	return 1;
}