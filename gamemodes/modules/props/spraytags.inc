//Spraytags
stock Spraytags_Delete(spid)
{
	if (spid != -1 && SpraytagsInfo[spid][E_SPRAYTAGS_EXISTS])
	{
        new
            string[64];

        format(string, sizeof(string), "DELETE FROM `spray_tags` WHERE `id` = '%d'", SpraytagsInfo[spid][E_SPRAYTAGS_DBID]);
        mysql_pquery(ourConnection, string);

        if (IsValidDynamicObject(SpraytagsInfo[spid][E_SPRAYTAGS_OBJECT]))
            DestroyDynamicObject(SpraytagsInfo[spid][E_SPRAYTAGS_OBJECT]);
    
        SpraytagsInfo[spid][E_SPRAYTAGS_EXISTS] = false;
        SpraytagsInfo[spid][E_SPRAYTAGS_DBID] = 0;
        SpraytagsInfo[spid][E_SPRAYTAGS_OWNER] = 0;
	}
	return 1;
}

IsPlayerNearSprayTags(playerid)
{
    for (new i = 0; i != MAX_SPRAYTAGS; i ++) if (SpraytagsInfo[i][E_SPRAYTAGS_EXISTS] && IsPlayerInRangeOfPoint(playerid, 2.5, SpraytagsInfo[i][E_SPRAYTAGS_POS][0], SpraytagsInfo[i][E_SPRAYTAGS_POS][1], SpraytagsInfo[i][E_SPRAYTAGS_POS][2]))
	{
		if (GetPlayerInterior(playerid) == SpraytagsInfo[i][E_SPRAYTAGS_INTERIOR] && GetPlayerVirtualWorld(playerid) == SpraytagsInfo[i][E_SPRAYTAGS_WORLD])
			return i;
	}
	return -1;
}

stock Spraytags_Create(playerid, modelid, owner, text[], font[], color, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	DestroyDynamicObject(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]); 
	PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 0; 
	PlayerInfo[playerid][E_CHARACTER_OBJECTID] = 0;
	PlayerInfo[playerid][E_CHARACTER_OBJECTTYPE] = 0;

	for (new i = 0; i < MAX_SPRAYTAGS; i ++) if (!SpraytagsInfo[i][E_SPRAYTAGS_EXISTS])
	{
	    SpraytagsInfo[i][E_SPRAYTAGS_EXISTS] = true;
	    SpraytagsInfo[i][E_SPRAYTAGS_OBJECTID]	= modelid;
	    SpraytagsInfo[i][E_SPRAYTAGS_TYPE]	= 1;
	    SpraytagsInfo[i][E_SPRAYTAGS_OWNER] = owner;
        format(SpraytagsInfo[i][E_SPRAYTAGS_TEXT], 128, "%s", text);
        format(SpraytagsInfo[i][E_SPRAYTAGS_FONT], 128, "%s", font);
        SpraytagsInfo[i][E_SPRAYTAGS_COLOR] = color;
        SpraytagsInfo[i][E_SPRAYTAGS_POS][0] = x;
        SpraytagsInfo[i][E_SPRAYTAGS_POS][1] = y;
        SpraytagsInfo[i][E_SPRAYTAGS_POS][2] = z;
        SpraytagsInfo[i][E_SPRAYTAGS_POS][3] = rx;
        SpraytagsInfo[i][E_SPRAYTAGS_POS][4] = ry;
        SpraytagsInfo[i][E_SPRAYTAGS_POS][5] = rz;
        SpraytagsInfo[i][E_SPRAYTAGS_TIMER] = 60;

        SpraytagsInfo[i][E_SPRAYTAGS_INTERIOR] = GetPlayerInterior(playerid);
        SpraytagsInfo[i][E_SPRAYTAGS_WORLD] = GetPlayerVirtualWorld(playerid);

		Spraytags_Refresh(i);
		mysql_pquery(ourConnection, "INSERT INTO `spray_tags` (`interior`) VALUES(0)", "OnSpraytagsCreated", "d", i);

		return i;
	}
	return -1;
}

stock Spraytags_Refresh(spid)
{
	if (spid != -1 && SpraytagsInfo[spid][E_SPRAYTAGS_EXISTS])
	{
        if (IsValidDynamicObject(SpraytagsInfo[spid][E_SPRAYTAGS_OBJECT]))
	        DestroyDynamicObject(SpraytagsInfo[spid][E_SPRAYTAGS_OBJECT]);

        if(SpraytagsInfo[spid][E_SPRAYTAGS_TYPE] == 1)
        {
            SpraytagsInfo[spid][E_SPRAYTAGS_OBJECT] = CreateDynamicObject(19482, SpraytagsInfo[spid][E_SPRAYTAGS_POS][0], SpraytagsInfo[spid][E_SPRAYTAGS_POS][1], SpraytagsInfo[spid][E_SPRAYTAGS_POS][2], SpraytagsInfo[spid][E_SPRAYTAGS_POS][3], SpraytagsInfo[spid][E_SPRAYTAGS_POS][4], SpraytagsInfo[spid][E_SPRAYTAGS_POS][5], SpraytagsInfo[spid][E_SPRAYTAGS_WORLD], SpraytagsInfo[spid][E_SPRAYTAGS_INTERIOR]);
            SetDynamicObjectMaterialText(SpraytagsInfo[spid][E_SPRAYTAGS_OBJECT], 0, SpraytagsInfo[spid][E_SPRAYTAGS_TEXT], OBJECT_MATERIAL_SIZE_512x256, SpraytagsInfo[spid][E_SPRAYTAGS_FONT], 40, 1, SpraytagsInfo[spid][E_SPRAYTAGS_COLOR], 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
        }
        return 1;
	}
	return 0;
}

function:Query_LoadSpraytags()
{
    static
	    rows,
	    fields;

	cache_get_row_count(rows);
	cache_get_field_count(fields);

	for (new i = 0; i < rows; i ++) if (i < MAX_SPRAYTAGS)
	{
	    SpraytagsInfo[i][E_SPRAYTAGS_EXISTS] = true;
	    cache_get_value_name_int(i, "id", SpraytagsInfo[i][E_SPRAYTAGS_DBID]);
	    cache_get_value_name_float(i, "posx", SpraytagsInfo[i][E_SPRAYTAGS_POS][0]);
        cache_get_value_name_float(i, "posy", SpraytagsInfo[i][E_SPRAYTAGS_POS][1]);
        cache_get_value_name_float(i, "posz", SpraytagsInfo[i][E_SPRAYTAGS_POS][2]);
        cache_get_value_name_float(i, "posrx", SpraytagsInfo[i][E_SPRAYTAGS_POS][3]);
        cache_get_value_name_float(i, "posry", SpraytagsInfo[i][E_SPRAYTAGS_POS][4]);
        cache_get_value_name_float(i, "posrz", SpraytagsInfo[i][E_SPRAYTAGS_POS][5]);
        cache_get_value_name_int(i, "interior", SpraytagsInfo[i][E_SPRAYTAGS_INTERIOR]);
		cache_get_value_name_int(i, "vw", SpraytagsInfo[i][E_SPRAYTAGS_WORLD]);
		cache_get_value_name_int(i, "models", SpraytagsInfo[i][E_SPRAYTAGS_OBJECTID]);
		cache_get_value_name_int(i, "type", SpraytagsInfo[i][E_SPRAYTAGS_TYPE]);
        cache_get_value_name(i, "text", SpraytagsInfo[i][E_SPRAYTAGS_TEXT], 128);
        cache_get_value_name(i, "font", SpraytagsInfo[i][E_SPRAYTAGS_FONT], 128);
        cache_get_value_name_int(i, "color", SpraytagsInfo[i][E_SPRAYTAGS_COLOR]);
		cache_get_value_name_int(i, "owner", SpraytagsInfo[i][E_SPRAYTAGS_OWNER]);
        cache_get_value_name_int(i, "timer", SpraytagsInfo[i][E_SPRAYTAGS_TIMER]);

		Spraytags_Refresh(i);
	}
	return 1;
}

function:OnSpraytagsCreated(spid)
{
    if (spid == -1 || !SpraytagsInfo[spid][E_SPRAYTAGS_EXISTS])
		return 0;

	SpraytagsInfo[spid][E_SPRAYTAGS_DBID] = cache_insert_id();
 	Spraytags_Save(spid);

	return 1;
}

function:SprayingTags(playerid, inputtext[], type, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    switch(type)
    {
        case 1: //CreateSpraytags
        {
            new idx = IsPlayerNearSprayTags(playerid);
			idx = Spraytags_Create(playerid, PlayerInfo[playerid][E_CHARACTER_OBJECTID], PlayerInfo[playerid][E_CHARACTER_DBID], PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], PlayerInfo[playerid][E_CHARACTER_OBJECTFONT], PlayerInfo[playerid][E_CHARACTER_OBJECTCOLOR], x, y, z, rx, ry, rz);
	    			
	    	if (idx == -1)
	    		return SendErrorMessage(playerid, "You can't make anymore spraytags.");	

            RemovePlayerAttachedObject(playerid, 8);
            RemovePlayerAttachedObject(playerid, 9);
            ClearAnimations(playerid);
			Inventory_Remove(playerid, "Spraycan", 1);

			if(PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] > INVENTORY_NONE)
			{
				ResetVarInventory(playerid);
			}
        }
    }
    return 1;
}

CMD:spray(playerid, params[])
{
	if(PlayerInfo[playerid][E_CHARACTER_EQUIPITEMS] != SPRAYCAN)
		return SendErrorMessage(playerid, "You must hold the spraycan in your hands.");

    for(new i; i < MAX_SPRAYTAGS; i++)
    {
        if(SpraytagsInfo[i][E_SPRAYTAGS_OWNER] == PlayerInfo[playerid][E_CHARACTER_DBID])
        {
            GPS_SetPlayerRaceCheckPoint(playerid, 1, SpraytagsInfo[i][E_SPRAYTAGS_POS][0], SpraytagsInfo[i][E_SPRAYTAGS_POS][1], SpraytagsInfo[i][E_SPRAYTAGS_POS][2], 0.0, 0.0, 0.0);
            SendErrorMessage(playerid, "You can't make spraytags because your spraytags already spawned."); 
            return 1;
        }
    }

    if(PlayerInfo[playerid][E_CHARACTER_LEVEL] < 3)
        return SendErrorMessage(playerid, "You can't make spraytags because your level must be higher level 3."); 

    if(!Inventory_Count(playerid, "Spraycan"))
        return SendErrorMessage(playerid, "You don't have any spraycan in your inventory."); 

    
    
    Dialog_Show(playerid, DialogSprayColor, DIALOG_STYLE_INPUT, "Spraytags:", "The font you input will only be visible to visual players that only have that font Ex: Arial\n{33AA33}Info:{ffffff} Required for spraying font your spraytags", "Input", "Cancel");
    return 1;
}

function:OnSprayTagsUpdate()
{
    for(new i; i < MAX_SPRAYTAGS; i++) if(SpraytagsInfo[i][E_SPRAYTAGS_EXISTS])
    {
        if(SpraytagsInfo[i][E_SPRAYTAGS_TIMER])
        {
            SpraytagsInfo[i][E_SPRAYTAGS_TIMER]--;
        }
        else
        {
            Spraytags_Delete(i);
        }
    }
    return 1;
}

Dialog:DialogSprayFont(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if (isnull(inputtext) || !FilterInputFont(inputtext) || strlen(inputtext) < 5)
            return Dialog_Show(playerid, DialogSprayFont, DIALOG_STYLE_INPUT, "Spraytags Fonts:", "Your spraytags will replace the spraytags with custom font.\nThe font you input will only be visible to visual players that only have that font\n{33AA33}Info:{ffffff} Required for spraying font your spraytags", "Input", "Cancel");

        format(PlayerInfo[playerid][E_CHARACTER_OBJECTFONT], 512, inputtext);
        
        new colors[3200];
        for (new colorid; colorid != sizeof g_VehicleColors; colorid++)
        {
            format(colors, sizeof colors, "%s{%06x}%03d%s", colors, g_VehicleColors[colorid] >>> 8, colorid, !((colorid + 1) % 16) ? ("\n") : (" "));
        }

        format(colors, sizeof(colors), "%s\n\n{ffffff}Enter the Color ID below: (Ex: 255)", colors);
        Dialog_Show(playerid, DialogSprayColor, DIALOG_STYLE_INPUT, "Spraytags Colors:", colors, "Enter", "Close");
    }
    return 1;
}

Dialog:DialogSprayColor(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if (isnull(inputtext) || strval(inputtext) < 0 || strlen(inputtext) > g_MaxVehicleColors)
            return SendErrorMessage(playerid, "Invalid Color ID");

        new fontcolor = g_VehicleColors[strval(inputtext)];
        new iColor = RGBAtoARGB(fontcolor);
        PlayerInfo[playerid][E_CHARACTER_OBJECTCOLOR] = iColor;
        Dialog_Show(playerid, DialogSprayText, DIALOG_STYLE_INPUT, "Spraytags Texts:", "Allowed letter is A - Z and ( ) - = / ? \nTo break the letter use \"|\"\n{33AA33}Info:{ffffff} Required for letter your spraytags", "Input", "Cancel");
    }
    return 1;
}

Dialog:DialogSprayText(playerid, response, listitem, inputtext[])
{
    if (response) 
    {
        if (isnull(inputtext) || strlen(inputtext) < 5 || strlen(inputtext) > 32)
            return Dialog_Show(playerid, DialogSprayText, DIALOG_STYLE_INPUT, "Spraytags Texts:", "Allowed letter is A - Z and * = / ? !\nTo break the letter use \"|\"\n{33AA33}Info:{ffffff} Required for letter your spraytags", "Input", "Cancel");

        new formattedText[512];
        format(formattedText, sizeof(formattedText), "%s", inputtext);

        for (new i = 0; i < strlen(formattedText); i++)
        {
            if (formattedText[i] == '|')
            {
                formattedText[i] = '\n'; 
            }
        }

        format(PlayerInfo[playerid][E_CHARACTER_OBJECTSTRING], 128, formattedText);

        new Float:x, Float:y, Float:z; 
        GetPlayerPos(playerid, x, y, z); 

        
        PlayerInfo[playerid][E_CHARACTER_ADDOBJECT] = CreateDynamicObject(19482, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)); 
        SetDynamicObjectMaterialText(PlayerInfo[playerid][E_CHARACTER_ADDOBJECT], 0, formattedText, OBJECT_MATERIAL_SIZE_512x256, PlayerInfo[playerid][E_CHARACTER_OBJECTFONT], 40, 1, PlayerInfo[playerid][E_CHARACTER_OBJECTCOLOR], 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
        
        EditDynamicObject(playerid, PlayerInfo[playerid][E_CHARACTER_ADDOBJECT]); 
        PlayerInfo[playerid][E_CHARACTER_EDITINGOBJECT] = 1;
    }
    return 1;
}