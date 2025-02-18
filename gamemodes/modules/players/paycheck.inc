CallPaycheck(playerid)
{
	if(!AccountInfo[playerid][E_MASTERS_LOGGED])
		return 0;
		
	new
		str[128]; 

	new gTax;
	new paycheck = PlayerInfo[playerid][E_CHARACTER_PAYCHECK];
	new interest, rate;
	new tax = (paycheck / 100) * gTax; // 10% tax
	new total = paycheck - tax;

	if(PlayerInfo[playerid][E_CHARACTER_EXP] > 5)
	{
		PlayerInfo[playerid][E_CHARACTER_EXP] = 0;
		PlayerInfo[playerid][E_CHARACTER_LEVEL]++;
		format(str, sizeof(str), "Leveled up to level %i", PlayerInfo[playerid][E_CHARACTER_LEVEL]);
		ShowBoxMessage(playerid, str, 5, 2);

		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SetPlayerScore(playerid, PlayerInfo[playerid][E_CHARACTER_LEVEL]); 
		SaveCharacter(playerid); 
	}

	PlayerInfo[playerid][E_CHARACTER_TIMEPLAYED]++; 
	PlayerInfo[playerid][E_CHARACTER_EXP]++;

	interest = (PlayerInfo[playerid][E_CHARACTER_BANK] / 1000) * rate;

	total += interest;
	
	SendClientMessageEx(playerid, COLOR_WHITE, "SERVER TIME:[ %s ]", ReturnHour()); 
	
	SendClientMessage(playerid, COLOR_YELLOW, "LOS SANTOS PAYCHECK"); 
	SendClientMessageEx(playerid, COLOR_WHITE, "{cdcdcd}INTEREST RATE: $%s (RATE: {33AA33}%.1f{cdcdcd})", FormatMoney(interest), floatdiv(float(rate), 10));
	SendClientMessageEx(playerid, COLOR_WHITE, "{cdcdcd}SAVINGS INTEREST: $%s", FormatMoney(paycheck));
	SendClientMessageEx(playerid, COLOR_WHITE, "{cdcdcd}TAX PAID: {FF6347}$%s{cdcdcd} ({FF6347}%i{cdcdcd} PERCENT)", FormatMoney(tax), gTax); 
	SendClientMessageEx(playerid, COLOR_WHITE, "{cdcdcd}OLD BALANCE: {2986CC}$%s{cdcdcd} || NEW BALANCE: {2986CC}$%s{cdcdcd}", FormatMoney(PlayerInfo[playerid][E_CHARACTER_BANK]), FormatMoney(PlayerInfo[playerid][E_CHARACTER_BANK] + total));

	PlayerInfo[playerid][E_CHARACTER_PAYCHECK] = 0; 
	PlayerInfo[playerid][E_CHARACTER_BANK]+= total; 
	
	SetPlayerScore(playerid, PlayerInfo[playerid][E_CHARACTER_LEVEL]);
	SaveCharacter(playerid); 
	return 1;
}

stock GivePaycheck(playerid, amount)
{
	PlayerInfo[playerid][E_CHARACTER_PAYCHECK] += amount; 
	SaveCharacter(playerid); 
	SendInfoMessage(playerid, "[PAYCHECK] Your $%s has been added to paycheck.", FormatMoney(amount));
	PlayerPlaySound(playerid, 5205, 0, 0, 0);
	return 1;
}