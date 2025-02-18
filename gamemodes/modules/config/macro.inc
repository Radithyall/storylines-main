//Database
#define MYSQL_HOST
//#define DEBUG_MODE

#if defined MYSQL_HOST
	#define SQL_HOSTNAME "db1.sampryzen.tech"
	#define SQL_USERNAME "u823_nrOCddC3X7"
	#define SQL_DATABASE "s823_storylines_samp"
	#define SQL_PASSWORD "z@ui05FFvkFzfy4Kf=W3Hgg+"
#else
	#define SQL_HOSTNAME "127.0.0.1"
	#define SQL_USERNAME "root"
	#define SQL_DATABASE "storylines"
	#define SQL_PASSWORD ""
#endif

#define SERVER_NAME "Storylines Roleplay | Fear N Respect"
#define SCRIPT_REV "Fear N Respect v1.0.3 Revision"
#define PLAYER_MOTD "Please read the rules first!"

#define PRESSED(%0) (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define percent(%0,%1)  floatround((float((%0)) / 100) * (%1))
#define PRESSING(%0,%1) (%0 & (%1))

#if !defined IsValidVehicle
    native IsValidVehicle(vehicleid);
#endif

#define function:%0(%1) forward %0(%1); public %0(%1)
#define	RGBAtoARGB(%0) (%0 >>> 8 | %0 << 24)

#pragma warning disable 239, 214, 213

// BODYPART:
#define BODY_PART_CHEST	(3)
#define BODY_PART_GROIN (4)
#define BODY_PART_LEFT_ARM (5)
#define BODY_PART_RIGHT_ARM (6)
#define BODY_PART_LEFT_LEG (7)
#define BODY_PART_RIGHT_LEG (8)
#define BODY_PART_HEAD (9)

// MAXIMUMS:
#define MAX_ENTRANCE 				(100)
#define MAX_PROPERTY 				(100)
#define MAX_BUSINESS 				(100)
#define MAX_BUSINESS_PRODUCTS 		(50)
#define MAX_GATES 					(100)
#define MAX_FACTIONS 				(30)
#define MAX_FACTION_RANKS 			(21)
#define MAX_PLAYER_VEHICLES 		(5)
#define MAX_ZONE_NAME 				(28)
#define MAX_SPRAYTAGS   			(500)
#define MAX_INVENTORY				(10)
#define MAX_CAR_STORAGE 			(5)
#define MAX_DROPPED_ITEMS 			(1000)
#define MAX_LISTED_ITEMS 			(10)
#define MAX_PLAYER_CLOTHING     	(5)
#define MAX_SERVERDATA				(50)
#define MAX_CONTACTS				(20)
#define MAX_COURT					(20)
#define MAX_RELATIONS 				(100)
#define MAX_TREES 					(100)
#define MAX_TRASH      				(35)
#define MAX_PROPERTY_STORAGE 		(10)
#define MAX_FURNITURE 				(300)
#define MAX_BARRICADES 				(50)
#define MAX_TICKETS					(10)
#define MAX_PRISON_CELLS 			(20)
#define MAX_CARDS       			(5)
#define MAX_FIRES                   (100)
#define MAX_FACTION_VEHICLES 		(38)
#define MAX_COMPENSATION 			(1)
#define MAX_EVENT					(1)

LoadCustomModels()
{
    //======================================Textdraws======================================
	
	//========================================Skins========================================
	AddCharModel(7, 20001, "misc/skin/citizen/bmciv1.dff", "misc/skin/citizen/bmciv1.txd");
	AddCharModel(183, 20002, "misc/skin/citizen/bmciv2.dff", "misc/skin/citizen/bmciv2.txd");
	AddCharModel(21, 20003, "misc/skin/citizen/bmgng1.dff", "misc/skin/citizen/bmgng1.txd");
	AddCharModel(67, 20004, "misc/skin/citizen/hmciv1.dff", "misc/skin/citizen/hmciv1.txd");
	AddCharModel(184, 20005, "misc/skin/citizen/hmciv2.dff", "misc/skin/citizen/hmciv2.txd");
	AddCharModel(121, 20006, "misc/skin/citizen/mabam5.dff", "misc/skin/citizen/mabam5.txd");
	AddCharModel(22, 20007, "misc/skin/citizen/mbciv11.dff", "misc/skin/citizen/mbciv11.txd");
	AddCharModel(2, 20008, "misc/skin/citizen/mwacer.dff", "misc/skin/citizen/mwacer.txd");
	AddCharModel(121, 20009, "misc/skin/citizen/bmpretty1.dff", "misc/skin/citizen/bmpretty1.txd");
	AddCharModel(184, 20010, "misc/skin/citizen/bmpretty2.dff", "misc/skin/citizen/bmpretty2.txd");
	AddCharModel(67, 20011, "misc/skin/citizen/bmpretty3.dff", "misc/skin/citizen/bmpretty3.txd");
	AddCharModel(184, 20012, "misc/skin/citizen/bmpretty4.dff", "misc/skin/citizen/bmpretty4.txd");
	AddCharModel(67, 20013, "misc/skin/citizen/hmyec3.dff", "misc/skin/citizen/hmyec3.txd");
	AddCharModel(105, 20014, "misc/skin/citizen/fam1.dff", "misc/skin/citizen/fam1.txd");
	AddCharModel(106, 20015, "misc/skin/citizen/fam2.dff", "misc/skin/citizen/fam2.txd");
	AddCharModel(107, 20016, "misc/skin/citizen/fam3.dff", "misc/skin/citizen/fam3.txd");
	AddCharModel(47, 20017, "misc/skin/citizen/hmycr.dff", "misc/skin/citizen/hmycr.txd");
	AddCharModel(30, 20018, "misc/skin/citizen/hmydrug.dff", "misc/skin/citizen/hmydrug.txd");
	AddCharModel(241, 20019, "misc/skin/citizen/smyst.dff", "misc/skin/citizen/smyst.txd");
	AddCharModel(242, 20020, "misc/skin/citizen/smyst2.dff", "misc/skin/citizen/smyst2.txd");
	AddCharModel(101, 20021, "misc/skin/citizen/wmyst.dff", "misc/skin/citizen/wmyst.txd");
	AddCharModel(189, 20022, "misc/skin/citizen/wmyva.dff", "misc/skin/citizen/wmyva.txd");
	AddCharModel(70, 20023, "misc/skin/citizen/wmosci.dff", "misc/skin/citizen/wmosci.txd");

	AddCharModel(300, 20260, "misc/skin/lspd/male/amypd2.dff", "misc/skin/lspd/male/amypd2.txd");
	AddCharModel(301, 20261, "misc/skin/lspd/male/bmopd1.dff", "misc/skin/lspd/male/bmopd1.txd");
	AddCharModel(300, 20262, "misc/skin/lspd/male/bmypd1.dff", "misc/skin/lspd/male/bmypd1.txd");
	AddCharModel(301, 20263, "misc/skin/lspd/male/bmypd2.dff", "misc/skin/lspd/male/bmypd2.txd");
	AddCharModel(300, 20264, "misc/skin/lspd/male/omypd1.dff", "misc/skin/lspd/male/omypd1.txd");
	AddCharModel(301, 20265, "misc/skin/lspd/male/fedlapd1.dff", "misc/skin/lspd/male/fedlapd1.txd");
	AddCharModel(300, 20266, "misc/skin/lspd/male/hmypd1.dff", "misc/skin/lspd/male/hmypd1.txd");
	AddCharModel(301, 20267, "misc/skin/lspd/male/hmypd2.dff", "misc/skin/lspd/male/hmypd2.txd");

	AddCharModel(306, 20268, "misc/skin/lspd/female/ofypd1.dff", "misc/skin/lspd/female/ofypd1.txd");
	AddCharModel(307, 20269, "misc/skin/lspd/female/wfysuit.dff", "misc/skin/lspd/female/wfysuit.txd");
	
	//==========================================Weapons======================================
	
	//==========================================Objects==========================================
	AddSimpleModel(-1, 1575, -2500, "misc/drugs/heroine.dff", "misc/drugs/drugs.txd"); //Heroine
	AddSimpleModel(-1, 1575, -2501, "misc/drugs/marijuana.dff", "misc/drugs/drugs.txd"); //Marijuana
	AddSimpleModel(-1, 1575, -2502, "misc/drugs/cocaine.dff", "misc/drugs/drugs.txd"); //Cocaine

	AddSimpleModel(-1, 1575, -2503, "misc/bottle/champagne_bottle.dff", "misc/bottle/champagne_bottle.txd"); //Champagne

	AddSimpleModel(-1, 1575, -2504, "misc/gym/kmb_bpress.dff", "misc/gym/gym_weights.txd"); //gym
	AddSimpleModel(-1, 1575, -2505, "misc/gym/kmb_dumbbell_l.dff", "misc/gym/gym_weights.txd"); //gym
	AddSimpleModel(-1, 1575, -2506, "misc/gym/kmb_dumbbell_r.dff", "misc/gym/gym_weights.txd"); //gym
	
	//=======================================Clothing=======================================
	

	//==========================================MAPSSSS==========================================

    return 1;
}