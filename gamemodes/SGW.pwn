/*

ESTE GAMEMODE FUE DESARROLLADO POR CRISTIAN IZAQUITA,
USANDO LA BASE DE EL GAMEMODE DE UNION LATIN PLAYERS

**STREET GANG WARS:
	 FECHA DE INICIO: LUNES 10 DE SEPTIEMBRE DE 2012, HORA 11 A.M.


AGRADECIMIENTOS A UNION LATIN PLAYERS, zo0r, Sensei, Willy, Y TODOS LOS QUE PARTICIPARON EN LA CREACIÓN DE ESE GM.

http://media.rcn.com.co/rcn/radio/p2.php?x10n=014W69c46 Música RCN

Crear sistema de niveles, con text3d en la cabeza

#error 076
#ShowPlayerDialogEx(playerid, = 16
*/

// SKINS USADOS
// SKINID= 111
// SKINID= 112
// SKINID= 113
// SKINID= 117
// SKINID= 118
// SKINID= 120
// SKINID= 121
// SKINID= 122
// SKINID= 123
// SKINID= 124
// SKINID= 125
// SKINID= 126
// SKINID= 127
// SKINID= 186
// SKINID= 187
// SKINID= 208
// SKINID= 272
// SKINID= 273
// SKINID= 290
// SKINID= 294
//////////////////////     INCLUDES   //////////////////////////////////////////////////////////////////
#include <a_samp>
#include <streamer>
#include <a_http>

//Cambiamos los players (?)
#undef MAX_PLAYERS
#define MAX_PLAYERS 100

//////////////////////     DEFINES //////////////////////////////////////////////////////////////////
#define LOGO_STREETGW 						"{FFFFFF}Bienvenido a Street Gang Wars! || Wellcome to Street Gang Wars!"
#define	GAMEMODE_VERSION					"TDM - SGW v0.1"
#define MAX_BIZZ_TYPE_COUNT                 50
#define MAX_BIZZ_COUNT                      100
#define MAX_BIZZ_SLOTS                      19
#define MAX_BIIZ_NAME   	  				35
#define MAX_HOUSE_COUNT	    	           	400
#define MAX_REFRIGERADOR_SLOTS_COUNT	    10
#define MAX_GUANTERA_GAVETA_SLOTS           8
#define MAX_HOUSE_TYPE_COUNT                40
#define MAX_VEHICLE_COUNT                   700
#define DEFAULT_AUDIO_VOLUMEN               50
#define MAX_GAS_VEHICLE						131
#define LOCK_GANG_CAR                    	true
#define MAX_PLAYER_DATA           			500
#define MAX_HOUSE_DATA           			700
#define MAX_HOUSE_SLOT                      78
#define MAX_GARAGE_FOR_HOUSE                5
#define MAX_HOUSE_FRIENDS                   5
#define MAX_BOMBAS_COUNT	                30
#define BOMBA_TYPE_NONE						0
#define BOMBA_TYPE_FOOT      				1
#define BOMBA_TYPE_CAR						2
#define MAX_VEHICLE_SLOT                    64
#define WORLD_DEFAULT_INTERIOR              4
#define MAX_RADIO_STREAM_MAP_ICON           600
#define MAX_TEXT_CHAT                       150
#define MAX_RADIO_STREAM                    300
#define MAX_GANG_RANGOS                  	10
#define MAX_GANG_NAME       				30
#define MAX_ALMACENES                       2
#define MAX_GANG_SKIN                    	15
#define WORLD_NORMAL			            0
#define TIME_CHECK_GAS_VEHICLES             15000
#define TIME_CHECK_NEW_HORA		            10
#define MAX_OBJECT_MAPPING_COUNT            50
#define MAX_GASOLINERAS_COUNT               50
#define COLOR_CHEATS_REPORTES				0xE24236FF
#define MAX_INTERIORS                       20
#define MAX_TIME_VEHICLE_HIDDEN             1200000
#define COLOR_TITULO_DE_AYUDA				0x7F91F9FF
#define TITULO_AYUDA "||-------------------------------------------------- Menú de Ayuda --------------------------------------------------||"
#define PLAYERS_COLOR   	  				0x7F91F9FF
#define MAX_ACCOUNT_BANK_SLOT               50
#define MAX_COUNT_CHEQUES                   15
#define INFINITY_HEALTH 					(Float:0x7F800000)
#define VIDA_CRACK                          5
#define MAX_DAMAGE_VEHICLE  				107 // + 512
#define COLOR_MENSAJES_DE_AVISOS 			0xEDA4A4FF
#define COLOR_TODOS_CHANNEL                 0xFFA000FF
#define COLOR_FAMILY						0xB4F8EEFF
#define MAX_TELES_COUNT						300
#define MAX_GARAGE_TYPE_COUNT               40
#define MAX_GARAGES_EX_COUNT                200
#define MAX_TEXT_DRAW_INFO_COUNT            50
#define MAX_CAMERAS_COUNT                   50
#define TYPE_MALETIN                   		1
#define MAX_OBJECTS_PLAYERS                 9
#define MAX_DOORS_COUNT                     50
#define STANDARD_SPEED_DOORS                2.5
#define STANDARD_SPEED_BARRAS               0.05
#define STANDARD_SPEED_DOORS_GRUAS          0.5
#define VELOCITY_DOORS_TIME                 30
#define VELOCITY_DOORS_PORCENT              2
#define MAX_OBJECTS_VALLAS_CONOS_PINCHOS    100
#define	COLOR_KICK_JAIL_BAN                 0xE24236FF


#define BICI         	0
#define COCHE           1
#define CAMION          2
#define MOTO            3
#define VUELO           4
#define BOTE            5
#define TREN            6
#define MAX_TRAINS                      5
#define MAX_GANG_COUNT             		5
#define MAX_GANG_SLOT                   61

#define SINGANG				  	 0
#define YAKUZA  			 1
#define RUSOS    			 2
#define ITALIANOS        	 3
#define TRIADA      	 4
#define MAX_GANG	TRIADA



//////////////////////     FORWARDS   //////////////////////////////////////////////////////////////////
//////////// LOADS //////
forward LoadDataGang(faccionid);
forward LoadLastOptionsServer(); // LOAD SPECIAL OPTION SERVER
forward LoadTextDrawInfo();
forward LoadDataBizzType();
forward DataLoadBizz(bizzid);
forward LoadHouse(houseid);
forward LoadGarages();
forward LoadBombas();
forward LoadDataVehicle(vehicleid, dir[], type);
forward LoadCarsGang();
forward LoadCarsPublic();
forward LoadPickupsMisc();
forward LoadPickupsAlmacenes();
forward DataUserLoad(playerid);
forward LoadAllAnims();
//forward LoadAccountBanking(playerid);
forward LoadCamerasLogin();
forward LoadMenuStatic();
forward LoadTelesPublics();

/////////// SAVES //////
forward DataUserSave(playerid);
forward SaveDataGang(faccionid);
forward SaveDataVehicle(vehicleid, dir[]);
forward SaveDatosPlayerDisconnect(playerid);
forward SaveIpUser(playerid, option);
forward DataSaveBizz(bizzid, bool:update);
forward SaveHouse(houseid, bool:update);
forward SaveGasolineras();
forward SaveBombas();
//forward SaveAccountBanking(playerid);

//////////////////////////////
forward DataUserClean(playerid);
forward SendChatStream(playerid, text[]);
forward SetLastSettingVehicle(vehicleid);
forward CreateVehicleEx(model, Float:Xc, Float:Yc, Float:Zc, Float:ZZc, color1, color2, vehicleid);
forward SetPlateToCarGang(vehicleid, faccionid);
forward Text:TextDrawCreateEx(Float:Xt, Float:Yt, text[]);
forward CreateDynamicMapIconSGW(Float:x, Float:y, Float:z, type);
forward ActTextDrawBizz(bizzid);
forward ActTextDrawHouse(houseid);
forward AddBomba(playerid, type, vehicleid, Float:Xbom, Float:Ybom, Float:Zbom, objectid);
forward CleanTunningSlots(vehicleid);
forward IsValidVehiclePaintJob(vehiclemodel);
forward AddVehicleComponentEx(vehicleid, componentid);
forward SetVehicleHealthEx(vehicleid, Float:health);
forward IsVehicleOff(vehicleid);
forward ExistGarageInHouse(houseid);
forward SendInfoMessage(playerid, type, optional[], message[]);
forward ShowServerStats(playerid);
forward ShowPlayerDialogEx(playerid, dialogid, style, caption[], info[], button1[], button2[]);
forward SetTimerGlobal();
forward MostrarHora(Accion ,playerid);
forward Acciones(playerid, type, text[]);
forward SetPlayerOrginalTime(playerid);
forward GetOriginalHours(hour);
forward GetOriginalMinute(minute);
forward VerificarCochesVencidos();
forward RemoveDuenoOfVehicle(vehicleid, option);
forward IsVehicleMyVehicle(playerid, vehicleid);
forward GetDataPlayersInt(playerid, data[], &savedata, &lastpos, &afterpos);
forward GetDataPlayersFloat(playerid, data[], &Float:savedata, &lastpos, &afterpos);
forward ShowLockTextDraws(vehicleid, last);
forward CheckPlayersAFK();
forward KickEx(playerid, option);
forward OnGameModeExitEx();
forward ShowPlayerLogin(playerid, option);
forward ShowPlayerRegister(playerid, option);
forward SetCameraLogin(playerid, nextcamera, avanze);
forward UpdateSpawnPlayer(playerid);
forward SpawnPlayerEx(playerid);
forward IsValidName(name[]);
forward RemoveRayaName(playerid);
forward MsgCheatsReportsToAdmins(text[]);
forward IsValidWeapon(playerid, weaponid);
forward UpdateSpectatedPlayers(playerid, death, interiorid, world);
forward SetPlayerVirtualWorldEx(playerid, wolrdid);
forward SetPlayerInteriorEx(playerid, newinterior);
forward RemoveSpectatePlayer(playerid);
forward SetSpawnInfoEx(playerid);
forward CheckSpectToPlayer(playerid);
forward CheckArmaCheat(playerid);
forward ResetPlayerWeaponsEx(playerid);
forward SetPlayerLockAllVehicles(playerid);
forward SetPlayerJail(playerid);
forward GivePlayerMoneyEx(playerid, money);
forward CleanDataDeath(playerid);
forward SetVehicleHidden(vehicleid);
forward GetMaxGangRango(faccionid);
forward MsgAdminUseCommands(level, playerid, commands[]);
forward ApplyPlayerAnimCustom(playerid, animlib[], animid[], loop);
forward GetPosSpace(text[], option);
//forward IsPlayerAccountBankConnected(accountcheck);
forward RemoveBuildingForPlayerEx(playerid);
//forward CreateAccountBank(playerid);
forward CleanPlayerAccountBank(playerid);
forward IsValidStringServerOther(playerid, string[]);
forward TogglePlayerControllableEx(playerid, toogle);
forward GetSpawnInfo(playerid);
forward GetPlayerInteriorEx(playerid);
forward CheckWeapondCheat(playerid);
forward HideTextDrawsTelesAndInfo(playerid);
forward UpdateArmourAndArmour(playerid, Float:Health, Float:Armour);
forward IsVehicleOpen(playerid, vehicleid, ispassenger);
forward ShowTextDrawFijosVelocimentros(playerid);
forward UpdateDamage(playerid, &Float:newdamage);
forward UpdateGasAndOil(vehicleid);
forward OnPlayerExitVehicleEx(playerid, vehicleid, ispassenger);
forward OnPlayerEnterVehicleEx(playerid, vehicleid, ispassenger);
forward IsFixBikeEnter(playerid, vehicleid);
forward UpdateTextDrawVehicle(playerid, vehicleid);
forward RemovePlayerFromVehicleEx(playerid, seat, time);
forward IsVehicleMyGang(playerid, vehicleid);
forward AbsVel(numberAscci);
forward UpdatePlayerVehicleStatus(vehicleid, Float:Healt);
forward IsPointFromPoint(Float:RadioE, Float:XpointOne, Float:YpointOne, Float:ZpointOne, Float:XpointTwo, Float:YpointTwo, Float:ZpointTwo);
forward HideTextDrawFijosVelocimentros(playerid);
forward SetPlayerHealthEx(playerid, Float:Health);
forward CreateTextDrawGas();
forward IsPlayerNear(myplayerid, playerid, iderror1[], iderror2[], iderror3[], stringerror1[], stringerror2[], stringerror3[]);
forward SetPlayerSelectedTypeSkin(playerid, option);
forward SetPlayerSelectedSkin(playerid);
forward SetPlayerRowSkin(playerid, response);
forward SetPlayerSkinEx(playerid, skinid);
forward SetPlayerGang(playerid, cmdfaccion[]);
forward Comandos_Admin(Comando, playerid, playeridAC, LV, Cantidad_o_Tipo, String[]);
forward ResetServer();
forward SendMessageDeathMatch(playerid);
forward IsPlayerNearBomba(playerid, Float:Range, option);
forward IntentarAccion(playerid, text[], rndNum);
forward DesactivarBomba(playerid, bombaid);
forward ActivarBomba(bombaid, count);
forward RemoveBomba(bombaid);
forward ShowBombas(playerid);
forward IsPlayerNearBombaEx(playerid, bombaid, Float:Range);
forward OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ);
forward SendMessageFamily(playerid, text[]);
forward GetVagonByVagonID(vehicleid, vagonid);
forward SetStyleTextDrawTeles(textdrawid, text[]);
forward SetStyleTextDrawTextDrawInfo(textdrawid, text[]);
forward SetPlayerArmourEx(playerid, Float:Armour);
forward GivePlayerWeaponEx(playerid, weaponid, ammo);
forward GetObjectByType(playerid, type);
forward AddObjectHoldToPlayer(playerid, objectid);
forward GetTypeObject(objectid);
forward IsPlayerNotFullObjects(playerid, msg);
forward AllowForItSkin(skinid, type);
forward ReturnObjetsToPlayer(playerid);
forward GetTypeObjectEx(objectid);
forward SetObjectHoldToPlayer(playerid, objectid, index);
forward ShowObjectos(playerid);
forward ShowObjetosOpciones(playerid);
forward ShowDarObjeto(playerid);
forward RemoveObjectHoldToPlayer(playerid, objectid, index);
forward ReverseEx(&number);
forward HaveObjectPlayer(playerid, objectid);
forward SetFunctionsForBizz(playerid, bizzid);
forward IsGarageToHouse(playerid, pickupid);
forward ShowPlayerMenuSelectWalk(playerid);
forward SetPlayerSpectateToPlayer(playerid, spectateplayerid);
forward IntermitenteEncendido(playerid);
forward NextPlayerSpect(playerid);
forward LastPlayerSpect(playerid);
forward IntermitenteIzquierdo(playerid);
forward IntermitenteDerecho(playerid);
forward IntermitenteEstacionamiento(playerid);
forward GetMyNearDoor(playerid, key, option);
forward IsPlayerNearGarage(vehicleid, playerid);
forward IsPlayerNearGarageEx(vehicleid, playerid);
forward GetMySecondNearVehicle(playerid);
forward MsgCheatsReportsToAdminsEx(text[], level);
forward encode_lights(light1, light2, light3, light4);
forward MoveDoorDynamicOne(doorid, Float:Progress);
forward MoveDoorDynamicTwo(doorid, Float:Progress);
forward LinkVehicleToInteriorEx(vehicleid, interiorid);
forward SetVehicleVirtualWorldEx(vehicleid, worldid);
forward CrearObjetoDinamicoSGW(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid, interior, playerid, Float:distance);
forward LoadStaticObjects();
forward LockVehicle(playerid);
forward IsPlayerInNearVehicle(playerid);
forward SetPlayerColorEx(playerid);
forward CheckHoraNew();
forward IsPlayerInPincho(playerid, pickupid);
forward LoadDoors();
forward LoadTelesLock();
forward SaveTelesLock();
forward strvalEx(string[]);
forward MsgKBJWReportsToAdmins(playerid, text[]);
forward UnBanUser(playerid_admin, playeridname[], option);
forward SetVehicleToRespawnEx(vehicleid);
forward SetVehicleToRespawnExTwo(vehicleid);
forward GetPlayerStats(playerid, playeridshow);
forward RespawnCoches();
forward SetPlayerTeamEx(playerid);
forward Delete3DTextLabelEx(playerid, Text3D:id);
forward DetectarSpam(playerid, text[]);
forward RespawnAutomatico();
forward MaterialTextLogin();
forward TimerMine(playerid);
forward SetMinaToPlayer(playerid);
forward CargarMapIcons();
forward RemovePlayerWeapon(playerid, weaponid);
forward AntiFakeKill(playerid);


//////////////////////     ENUMS   //////////////////////////////////////////////////////////////////
enum DataUsersOnline
{
	State,
	/*
	    0 - Conectando...
		1 - Login
		2 - Registro
		3 - Logueado
	*/
	CurrentDialog,
	IsAFK,
	Float:CoordenadasAFK[4],
	NameOnline[MAX_PLAYER_NAME],
	NameProject[MAX_PLAYER_NAME],
	IsPagaO,
	InCarId,
	Spawn,
	StateDeath,
	TimerLoginId,
	CountCheat,
	IsEspectando,
	Espectando,
	LastInterior,
	StateWeaponPass,
	Float:VidaOn,
	Float:ChalecoOn,
	StateMoneyPass,
	IsNotSilenciado,
	InAnim,
	AdminOn,
	InVehicle,
	SendCommands,
	ChangeVC,
	Float:CurrentHealth,
	Float:CurrentArmour,
	ExitedVehicle,
	InPickupTele,
	InPickupInfo,
	Float:MyPickupX_Now,
	Float:MyPickupY_Now,
	Float:MyPickupZ_Now,
	Text:MyTextDrawShow,
	InPickup,
	LastDamageInt,
	LastGas,
	CountIntentarVehicle,
	LastVel[3],
	PistaIDp,
	LastTextDrawTemperatura,
	InviteGang,
	InvitePlayer,
	TypeSkinList,
	RowSkin,
	Menu:InMenu,
	SaveAfterAgenda[60],
	Intentar,
	StateChannelFamily,
	Float:MyPickupX,
	Float:MyPickupY,
	Float:MyPickupZ,
	Float:MyPickupZZ,
	MyPickupWorld,
	MyPickupLock,
	MyPickupInterior,
	InSpecialAnim,
	AfterMenuRow,
	SubAfterMenuRow,
	MyAmmoSelect,
	InWalk,
	IsCleanAnimCar,
	LastWeapondRow,
	EspectVehOrPlayer,
	MyLastIdReport,
	MarcaZZ
};

enum NegociosTypeEnum
{
	Float:PosInX,	          	// 00 - Pos X Adentro del Negocio
	Float:PosInY,          		// 01 - Pos Y Adentro del Negocio
	Float:PosInZ,          		// 02 - Pos Z Adentro del Negocio
	Float:PosInZZ,         		// 03 - Pos ZZ Adentro del Negocio
	Float:PosInX_PC,	        // 04 - Pos X PC Adentro del Negocio
	Float:PosInY_PC,          	// 05 - Pos Y PC Adentro del Negocio
	Float:PosInZ_PC,          	// 06 - Pos Z PC Adentro del Negocio
	Float:PosInZZ_PC,         	// 07 - Pos ZZ PC Adentro del Negocio
	InteriorId,         		// 08 - ID del interior del negocio
	TypeName[MAX_PLAYER_NAME],	// 09 - Nombre del tipo de negocio
	TypePickupOrCheckponit,		// 10 - Si será un pickup o checkpoint | 0 = pickupid 1 = checkpoint
	PickupId,					// 11 - I ID del pickupp
	IdMapIcon                   // 12 - IdMapIcon
};

enum NegociosEnum
{
	Float:PosOutX,          	// 00 - Pos X Afuera del Negocio
	Float:PosOutY,          	// 01 - Pos Y Afuera del Negocio
	Float:PosOutZ,          	// 02 - Pos Z Afuera del Negocio
	Float:PosOutZZ,         	// 03 - Pos ZZ Afuera del Negocio
	PickupOutId,          	 	// 04 - ID Del Pickup de afuera del negocio
	InteriorOut,          	 	// 05 - ID del enterior de afuera del negocio
	Deposito,           		// 06 - Deposito del negocio
	Precio,           			// 07 - Precio del negocio
	Lock,           			// 08 - Cerrado o abierto
	Type,           			// 09 - Tipo de negocio
	PriceJoin,           		// 10 - Precio de entrada por defecto
	PricePiece,           		// 11 - Precio que pagaría por el producto
	NameBizz[MAX_BIIZ_NAME], 	// 12 - Nombre del negocio
	Dueno[MAX_PLAYER_NAME], 	// 13 - Nombre del dueño del negocio
	Extorsion[MAX_PLAYER_NAME], // 14 - Nombre del extorsionista
	Materiales, 				// 15 - Nombre del extorsionista
	World,                      // 16 - Mundo del negocio
	DepositoExtorsion,          // 17 - Dinero Extorsión
	Level,			            // 18 - NIvel mínimo para comprar el negocio
	Station 		            // 19 - Current Station

};

enum TypeHouseEnums
{
	TypeName[MAX_PLAYER_NAME],
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PosZZ,
	Interior,
	PickupId
}

enum RefrigeradorEnum
{
	Articulo[MAX_REFRIGERADOR_SLOTS_COUNT],
	Cantidad[MAX_REFRIGERADOR_SLOTS_COUNT]
}
enum HouseEnums
{
	Empy_Bug,
	Dueno[MAX_PLAYER_NAME],
	ArmarioWeapon[7],
	ArmarioAmmo[7],
	Float:Chaleco,
	Drogas,
	Ganzuas,
	Bombas,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PosZZ,
	Interior,
	TypeHouseId,
	PickupId,
	PriceRent,
	Level,
	World,
	Lock,
	Price,
	Deposito,
	Materiales,
	ArmarioLock,
	RefrigeradorLock,
	RingHouseTime,
	VolumenHouse,
	EcualizadorHouse[9],
	StationID,
    GavetaObjects[MAX_GUANTERA_GAVETA_SLOTS],
    GavetaLock
}
enum DataCarsEnum
{
	Float:PosX,       			// 00 - Coordenadas X
	Float:PosY,       			// 01 - Coordenadas Y
	Float:PosZ,       			// 02 - Coordenadas Z
	Float:PosZZ,      			// 03 - Coordenadas ZZ
	Float:LastX,
	Float:LastY,
	Float:LastZ,
	Float:LastZZ,
	PanelS,
	DoorS,
	LightS,
	TiresS,
	IsLastSpawn,
	Modelo,     				// 04 - Modelo
	Color1,     				// 05 - Color 1
	Color2,     				// 06 - Color 2
	Dueno[MAX_PLAYER_NAME], 	// 07 - Dueño
	Lock,						// 08 - Lock
	Time,       				// 09 - Time
	Matricula,     				// 10 - Matrícula
	MatriculaString[32],     	// 10.1 - Matrícula String
	Puente,      				// 11 - Puente
	Gas,	      				// 12 - Gas
	//ConteoOil,                  // 13 - ConteoOil
	GasNotShow,                 // 14 - GasNotShow
	//OilNotShow,
	TimeGas,                    // 15 - Time Gas
//	Text:TextDrawGas,	      	// 16 - Gas Text
//	Text:TextDrawEstado,	    // 17 - Daño Text
//	Text:TextDrawVelocidad,	    // 18 - Velocidad Text
	StateEncendido,			    // 19 - Apagado o encendido
	LockPolice,                 // 20 - Candado de la policía
	ReasonLock[50],           	// 21 - Razón del candado
	MaleteroState,              // 22 - Estado del Maletero
	SlotsTunning[14],           // 23 Slots de Tunning
	Vinillo,
	CapoState,
	LightState,
	RespawnTimerId,
	IsIntermitente,             // 0 = Descativado | 1 = Izquiredo | 2 = Derecho
	ConteoIntermitente,
	AlarmOn,
	//Oil,
	TemperaturaC,
	EngineState,
	Float:LastDamage,
//	LastVelocityInt,
	Interior,
	InteriorLast,
	World,
	WorldLast,
	AttachObjectID,
	TimeCalentamiento,
	LlenandoGas,
	StationID,
	VolumenVehicle,
    EcualizadorVehicle[9],
    GuanteraObjects[MAX_GUANTERA_GAVETA_SLOTS],
    GuanteraLock,
    TimerIdBug,
    VehicleDeath,
	VehicleAnticheat
};
enum GaragesEnum
{
    Float:Xg,
    Float:Yg,
    Float:Zg,
    Float:ZZg,
    Float:XgIn,
    Float:YgIn,
    Float:ZgIn,
    Float:ZZgIn,
    Float:XgOut,
    Float:YgOut,
    Float:ZgOut,
    Float:ZZgOut,
    LockIn,
    LockOut,
	PickupidIn,
	PickupidOut,
	TypeGarageE,
	WorldG,
	bool:DeletedG
}
enum HouseFriendsEnum
{
    Name[MAX_PLAYER_NAME],
}
enum BombasEnum
{
	TypeBomba,
	ObjectID,
	ObjectIDO,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	TimerID
}
enum GangesData
{
	NameGang[MAX_GANG_NAME],
	Lider[MAX_PLAYER_NAME],
	Precio,
	Deposito,
	Paga[MAX_GANG_RANGOS],
	Extorsion,
	Almacen[MAX_ALMACENES],
	LockA[MAX_ALMACENES],
	Float:AlmacenX[MAX_ALMACENES],
	Float:AlmacenY[MAX_ALMACENES],
	Float:AlmacenZ[MAX_ALMACENES],
	AlmacenWorld[MAX_ALMACENES],
	Float:Spawn_X[2],
	Float:Spawn_Y[2],
	Float:Spawn_Z[2],
	Float:Spawn_ZZ[2],
	Drogas[MAX_ALMACENES],
	Ganzuas[MAX_ALMACENES],
	Bombas[MAX_ALMACENES],
	InteriorSpawn,
	Float:PickupOut_X,
	Float:PickupOut_Y,
	Float:PickupOut_Z,
	Float:PickupOut_ZZ,
	Float:PickupIn_X,
	Float:PickupIn_Y,
	Float:PickupIn_Z,
	Float:PickupIn_ZZ,
	PickupidOutF,
	PickupidInF,
	PrecioGang,
	InteriorGang,
	Lock,
	World,
	Family,
	Radio
};
enum ObjectMappingEnum
{
	Objectid,
	objectmodel,
	Text3D:TextTag,
	TextTagS,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PosRotX,
	Float:PosRotY,
	Float:PosRotZ
}
enum DataUsers
{
	Zero,				//00
	Empy,				//01
	Password[25],		//02
	DeahtCount,			//03
	KilledCount,		//04
	House,				//05
	Jail,				//06
    Admin,				//07
	IsPaga,				//08
	Banco,				//09
	Gang,			//10
	HoursPlaying,		//11
	Rango,				//12
	Car,				//13
	CameraLogin,		//14
	Nacer,				//15
	Skin,				//15
	SpawnFac,			//17
    AccountBankingOpen, //18
	Objetos[MAX_OBJECTS_PLAYERS],
	WeaponS[13],		//19
	AmmoS[13],
	Float:Vida,			// 21
	Float:Chaleco,		// 22
	Float:Spawn_X,  	// 4
	Float:Spawn_Y, 		// 5
	Float:Spawn_Z, 	 	// 6
	Float:Spawn_ZZ, 	// 7
	World,				// 28
	Interior,			// 29
	IsInJail,			// 40
	Dinero,	 			// 24
	Bombas,				// 36
	AccountState,       // 3
	MyIP[16],			// 51
	Sexo,				// 37
	IsPlayerInBizz,		// 60
    IsPlayerInVehInt,
	IsPlayerInHouse,	// 46
	IsPlayerInGarage,	// 62,
   	IsPlayerInBank,
	MyStyleWalk,		// 53
	IntermitentState,	// 57
	Minas	// 57
};
enum CamerasLoginEnum
{
	Float:PlayerPosLogin[3],
	Float:CamerasPosLogin[3],
	Float:CamerasLookLogin[3]
}/*
enum AccountBankEnum
{
	Owner[MAX_PLAYER_NAME],
	Balance,
	LockIn,
	LockOut
}*/
enum GasolinerasEnum
{
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Fuel
}
enum JailType
{
	Float:PosX_Preso,
	Float:PosY_Preso,
	Float:PosZ_Preso,
	Float:PosZZ_Preso,
	Float:PosX_Liberado,
	Float:PosY_Liberado,
	Float:PosZ_Liberado,
	Float:PosZZ_Liberado,
	Interior_Preso,
	Interior_Liberado,
	WorldLiberado
}
enum ChequesEnum
{
	UniqueID,
	Type,
	NombreCh[MAX_PLAYER_NAME],
	Ammount
}
enum TelesEnum
{
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PosZZ,
	PickupID,
	PickupIDGo,
	Interior,
	World,
	Lock,
	Dueno
};
enum TypeGarageEnums
{
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PosZZ,
	Float:PosXh,
	Float:PosYh,
	Float:PosZh,
	Float:PosZZh,
	Float:PosXc,
	Float:PosYc,
	Float:PosZc,
	Float:PosZZc,
	Interior,
	PickupId,
	PickupIdh
}
enum GaragesExEnum
{
	Float:PosXOne,
	Float:PosYOne,
	Float:PosZOne,
	Float:PosZZOne,
	Float:PosXOneP,
	Float:PosYOneP,
	Float:PosZOneP,
	Float:PosZZOneP,
	Float:PosXTwo,
	Float:PosYTwo,
	Float:PosZTwo,
	Float:PosZZTwo,
	Float:PosXTwoP,
	Float:PosYTwoP,
	Float:PosZTwoP,
	Float:PosZZTwoP,
	PickupIDOneP,
	PickupIDTwoP,
	Interior,
	World,
	Lock,
	Dueno
};
enum TextDrawInfoEnum
{
	Float:PosInfoX,
	Float:PosInfoY,
	Float:PosInfoZ,
	PickupidTextInfo
}
enum CamerasEnum
{
    Interior,
    World,
	Page,
	Float:PosXLook,
	Float:PosYLook,
	Float:PosZLook,
	Float:PosXAt,
	Float:PosYAt,
	Float:PosZAt
}
enum DoorsEnums
{
	objectmodel,
	Float:PosXTrue,
	Float:PosYTrue,
	Float:PosZTrue,
	Float:PosRotXTrue,
	Float:PosRotYTrue,
	Float:PosRotZTrue,
	objectanimid,
	Float:PosXFalse,
	Float:PosYFalse,
	Float:PosZFalse,
	Float:PosRotXFalse,
	Float:PosRotYFalse,
	Float:PosRotZFalse,
	typeanim,           // 0 = Move - 1 = Static
	Float:speedmove,
	Dueno
}
enum VCPEnum
{
	objectid_vcp,
	objectmodel,
	Float:ObjX,
	Float:ObjY,
	Float:ObjZ,
	Float:ObjZRot,
	pickupidVCP
}
//////////////////////     NEWS   //////////////////////////////////////////////////////////////////
new PlayersDataOnline[MAX_PLAYERS][DataUsersOnline];
new NegociosType[MAX_BIZZ_TYPE_COUNT][NegociosTypeEnum];
new HouseData[MAX_HOUSE_COUNT][HouseEnums];
new NegociosData[MAX_BIZZ_COUNT][NegociosEnum];
new MAX_BIZZ;
new Refrigerador[MAX_HOUSE_COUNT][RefrigeradorEnum];
new TypeHouse[MAX_HOUSE_TYPE_COUNT][TypeHouseEnums];
new MAX_HOUSE;
new DataCars[MAX_VEHICLE_COUNT][DataCarsEnum];
new coches_Todos_Maleteros          [MAX_VEHICLE_COUNT][12][2]; // 7 - CHALECO | 8 - DROGAS | 9 - GANZÚAS | 10 - MATERIALES | 11 - BOMBAS
new MAX_CAR_DUENO;
new MAX_CAR;
new MAX_CAR_GANG;
new DIR_BOMBAS[9] 		= "/Bombas/";
new DIR_CONNECTIONS[14] = "/Connections/";
new DIR_GANGES[9] 		= "/Ganges/";
new DIR_HOUSES[9] 		= "/Houses/";
new DIR_MISC[7] 		= "/Misc/";
new DIR_NEGOCIOS[11] 	= "/Negocios/";
new DIR_TELES[12]		= "/TelesLock/";
new DIR_USERS[9] 		= "/Users/";
new DIR_VEHICLES[11] 	= "/Vehicles/";
new DIR_VEHICLESF[12] 	= "/VehiclesF/";
new DIR_VEHICLESP[12] 	= "/VehiclesP/";
/*
new DIR_BOMBAS[10] 		= "\\Bombas\\";
new DIR_CONNECTIONS[16] = "\\Connections\\";
new DIR_GANGES[10] 		= "\\Ganges\\";
new DIR_HOUSES[10] 		= "\\Houses\\";
new DIR_MISC[9] 		= "\\Misc\\";
new DIR_NEGOCIOS[12] 	= "\\Negocios\\";
new DIR_TELES[13]		= "\\TelesLock\\";
new DIR_USERS[10] 		= "\\Users\\";
new DIR_VEHICLES[12] 	= "\\Vehicles\\";
new DIR_VEHICLESF[13] 	= "\\VehiclesF\\";
new DIR_VEHICLESP[13] 	= "\\VehiclesP\\";*/

new MAX_CAR_PUBLIC;
new MAX_BIZZ_TYPE;
new Text:NegociosTextDraws[MAX_BIZZ_COUNT];
new Garages[MAX_HOUSE_COUNT][MAX_GARAGE_FOR_HOUSE][GaragesEnum];
new HouseFriends[MAX_HOUSE_COUNT][MAX_HOUSE_FRIENDS][HouseFriendsEnum];
new Text:CasasTextDraws[MAX_HOUSE_COUNT];
new coches_Todos_Type               [212];
new MAX_TRAIN = -1;
new TrainGroups[MAX_TRAINS][4];
new MAX_TEXT_DRAW;
new BombasO[MAX_BOMBAS_COUNT][BombasEnum];
new GangData[MAX_GANG_COUNT][GangesData];
new GangesRangos[MAX_GANG_COUNT][MAX_GANG_RANGOS][MAX_GANG_NAME];
new RangosSkins[MAX_GANG_COUNT][MAX_GANG_RANGOS][MAX_GANG_SKIN];
new	WeaponsGang[MAX_GANG_COUNT][MAX_ALMACENES][10];
new AmmoGang[MAX_GANG_COUNT][MAX_ALMACENES][10];
new Float:GangesChaleco[MAX_GANG_COUNT][MAX_ALMACENES][4];
new Text:GangTextDraws[MAX_GANG_COUNT];
new SKIN_CIVILES[2];
new ObjectMapping[MAX_OBJECT_MAPPING_COUNT][ObjectMappingEnum];
new Text:GarageTextDraw;
/*new Text:WideScreen;
new Text:WideScreen2;*/
new PlayersData[MAX_PLAYERS][DataUsers];
new Text:VelocimetroFijos[9];
new ResetGM;
new MAX_CAMERAS_LOGIN;
new CamerasLogin[10][CamerasLoginEnum];
//new Banking[MAX_PLAYERS][AccountBankEnum];
new MAX_GASOLINERAS;
new Gasolineras[MAX_GASOLINERAS_COUNT][GasolinerasEnum];
new LOGO_STAFF[50] = "Street Gang Wars:";
new WeatherCurrent;
new JailsType[3][JailType];
new Cheques[MAX_PLAYERS][MAX_COUNT_CHEQUES][ChequesEnum];
new Text:BarsDamage[MAX_DAMAGE_VEHICLE + 1];
new Text:BarsGas[MAX_GAS_VEHICLE + 1];
new Text:VelocimetroNumber1[10];
new Text:VelocimetroNumber2[10];
new Text:VelocimetroNumber3[10];
new coches_Todos_Velocidad			[212];
new TramSFID;
new Text:TemperaturaTextDraws[42];
new ReasonReset[150];
new Teles[MAX_TELES_COUNT][TelesEnum];
new MAX_TELE;
new Text:TelesTextDraws[MAX_TELES_COUNT];
new MAX_HOUSE_TYPE;
new TypeGarage[MAX_GARAGE_TYPE_COUNT][TypeGarageEnums];
new MAX_GARAGE_TYPE;
new MIN_GARAGE_PICKUP;
new MAX_GARAGE_PICKUP;
new GaragesEx[MAX_GARAGES_EX_COUNT][GaragesExEnum];
new MAX_GARAGES_EX;
new TextDrawInfo[MAX_TEXT_DRAW_INFO_COUNT][TextDrawInfoEnum];
new MAX_TEXT_DRAW_INFO;
new Text:TextDrawInfoTextDraws[MAX_TEXT_DRAW_INFO_COUNT];
new MAX_GARAGES;
new Cameras[MAX_CAMERAS_COUNT][CamerasEnum];
new Menu:CamerasM[2];
new PickUpAlambraAndJizzy[2];
new BANCO_PICKUPID_out;
new MAX_PICKUP;
new MAX_DOORS;
new Doors[MAX_DOORS_COUNT][DoorsEnums];
new MuertesCount[MAX_PLAYERS];
new FakeKill[MAX_PLAYERS];
new VCP[MAX_OBJECTS_VALLAS_CONOS_PINCHOS][VCPEnum];
new bool:ModeMina[MAX_PLAYERS];

//negocios
new Menu:CluckinBell;
new CluckinBellPrecios[7];
new Menu:BurgerShot;
new BurgerShotPrecios[8];
new Menu:PizzaStack;
new PizzaStackPrecios[7];
new Menu:JaysDiner;
new JaysDinerPrecios[8];
new Menu:RingDonuts;
new RingDonutsPrecios[8];
new Menu:Menu_Principal_Armas;
new Menu:Menues_Armas		[9];
new Armas_Clases    		[9][25];
new Armas_Nombre			[9][5][30];
new Armas_Precios			[9][5][6];
new Armas_Precios_Num		[9][5];
new Armas_Municion          [9][5];
new Armas_ID				[9][5];
new Menu:M24_7;
new Menu:TYPE_PHONES_MENU;
new M24_7_Precios[11];

new SiOrNo[2][3] =
	{
		"No",
		"Si"
	};
new COLOR_MESSAGES[4] =
	{   0xFFB300FF,      // 0 - COLOR ERROR
		0xFFFFFFFF,      // 1 - COLOR AYUDA
		0xCECECECD,      // 2 - COLOR INFORMACIÓN
		0x7FDFFFAA       // 3 - COLOR AFIRMATIVO
	};
new Sexos[2][20] =
	{
		"Hombre/Male",
		"Mujer/Female"
	};
new Meses[12][11] =
{
	{"Ene|Jan"},
	{"Feb"},
	{"Mar"},
	{"Abril"},
	{"May"},
	{"Jun"},
	{"Jul"},
	{"Agos"},
	{"Sept"},
	{"Oct"},
	{"Nov"},
	{"Dic"}
};
new AccionesColors[20] =
	{
	    0xACC97F22A,        // 0 - ME - LILA
	    0xFFFF00FF,         // 1 - AME - AMARILLO
	    0x00FF00FF,         // 2 - INTENTAR OK - VERDE
	    0xE10000FF,         // 3 - INTENTAR FAIL - ROJO
	    0xFFFFFFFF,         // 4 - GRITAR - BLANCO
	    0xE600FFFF,         // 5 - SUSURRAR - BLANCO
	    0xF0F0F0FF,         // 6 - CANAL OOC - MEDIO GRIS
	    0xFFFF00FF,         // 7 - AME FIX - AMARILLO
	    0xACC97F22A,        // 8 - ME FIX - 0xACC97F22A
	    0xFFFF00FF         // 9 - MEGAFONO
	};
new Float:AccionesRadios[20] =
	{
	    30.0,        // 0 - ME
	    30.0,        // 1 - AME
	    30.0,        // 2 - INTENTAR OK
	    30.0,        // 3 - INTENTAR FAIL
	    50.0,        // 4 - GRITAR
	    3.0,         // 5 - SUSURRAR
	    30.0,        // 6 - CANAL OOC
	    30.0,        // 7 - AME
	    30.0,         // 8 - ME
	    60.0         // 9 - MEGAFONO
	};
new SendChatStreamColors[6] =
	{
		0xF0F0F0FA,     // 1
	    0xDCDCDCFA,     // 2
	    0xC8C8C8FA,     // 3
	    0xAFAFAFC8,     // 4
	    0x9696A096,     // 5
	    0x7D7D7D64      // 6
	};
new BombasOjectsID[8] =
{
	1654, // 0
	1265, // 1
	1580, // 2
	1210, // 3
	1576, // 4
	1577, // 5
	1578, // 6
	1579  // 7
};
new SlotIDWeapon[47] =
{
	0, // 0 - Unarmed
	0, // 1 - Brass Knuckles
	1, // 2 - Golf Club
	1, // 3 - Nite Stick
	1, // 4 - Knife
	1, // 5 - Baseball Bat
	1, // 6 - Shovel
	1, // 7 - Pool Cue
	1, // 8 - Katana
	1, // 9 - Chainsaw
	10, // 10 - Purple Dildo
	10, // 11 - Small White Vibrator
	10, // 12 - Large White Vibrator
	10, // 13 - Silver Vibrator
	10, // 14 - Flowers
	10, // 15 - Cane
	8, // 16 - Grenade
	8, // 17 - Tear Gas *
	8, // 18 - Molotov Cocktail
	-1, // 19 -
	-1, // 20 -
	-1, // 21 -
	2, // 22 - 9mm
	2, // 23 - Silenced 9mm
	2, // 24 - Desert Eagle
	3, // 25 - Shotgun
	3, // 26 - Sawn-off Shotgun
	3, // 27 - Combat Shotgun
	4, // 28 - Micro SMG
	4, // 29 - MP5
	5, // 30 - AK-47
	5, // 31 - M4
	4, // 32 - Tec9
	6, // 33 - Country Rifle
	6, // 34 - Sniper Rifle
	7, // 35 - Rocket Launcher
	7, // 36 - HS Rocket Launcher **
	7, // 37 - Flamethrower
	7, // 38 - Minigun
	8, // 39 - Satchel Charge ***
	12, // 40 - Detonator
	9, // 41 - Spraycan
	9, // 42 - Fire Extinguisher
	9, // 43 - Camera
	11, // 44 - Nightvision Goggles ****
	11, // 45 - Thermal Goggles ****
	11 // 46 - Parachute
};
new ObjectsVisibleOrInvisible[2] =
{
	false,
	true
};

new NamesLook[2][13] =
	{
		"Abrió/Opened",
		"Cerró/Closed"
	};
new Float:ObjectsPlayers[1][9]     =
{
	{0.3,0.05,-0.08,-10.0,-80.0,10.0,1.0,1.0,1.0}		// 00 - Maletín // /update 1210 5 0.3 0.05 -0.08 -10 -80 10 1 1 1
};
new ObjectsNames[2][30] =
{
	"Nada",
	"Maletín"
};
new ObjectPlayersInt[0][3] =
{
	{1210,5, TYPE_MALETIN}  // 00 - Maletín
};

new ModeWalkID[15] =
{
	263,                  // 00 - WALK_player
	257,                  // 01 - WALK_drunk
	254,                  // 02 - WALK_civi
	258,                  // 03 - WALK_fat
	260,                  // 04 - WALK_gang1
	261,                 // 05 - WALK_gang2
	262,                 // 06 - WALK_old
	265,                 // 07 - WALK_shuffle
	264,                 // 08 - WALK_rocket
	270,                 // 09 - Walk_Wuzi
	275,                 // 10 - WOMAN_runfatold
	278,                  // 11 - WOMAN_walkbusy
	280,                  // 12 - WOMAN_walkpro
	283,                  // 13 - WOMAN_walksexy
	279                  // 14 - WOMAN_walkfatold
};

new ModeWalkName[15][MAX_PLAYER_NAME] =
	{
		"Normal",       // 00 -
		"Ebrio/Drunk",     // 01 -
		"Normal 2",        // 02 -
		"Patecumbia",     // 03 -
		"Gangster 1", // 04 -
		"Gangster 2", // 05 -
		"Abuelo/Oldman",      // 06 -
		"Abuelo/Oldman2",      // 07 -
		"Herido/Wounded",    // 08 -
		"Ciego/Blind",        // 09 -
		"Cansado/Tired",      // 10 -
		"Puta/Whore",      // 11 -
		"Puta/Whore2",      // 12 -
		"Sexy",   // 13 -
		"Abuela/OldWoman"         // 14 -
};
new Float:SpawnAleatorio[][] =
{
    {-1929.3855, 639.3509, 46.5625, 351.5918},
    {-2462.0627, 133.5508, 35.1719, 312.8831},
    {-1986.8948, 1118.0035, 54.0391, 271.0153},
    {-2802.7788, 1181.3500, 20.8672, 154.9826}
};
new AdminsRangos[9][30] =
{
	{"{7378FF}Mod (1)"},
	{"{474EFA}Mod (2)"},
	{"{1C25FA}Global Mod (3)"},
	{"{000AFF}Adm (4)"},
	{"{0008D8}Adm (5)"},
	{"{0007B0}Global Adm (6)"},
	{"{000580}General Adm (7)"},
	{"{000239}Principal Adm (8)"},
	{"{000000}Líder"}
};
new AdminsRangosColors[9] =
{
	0x7378FFFF,
	0x474EFAFF,
	0x1C25FAFF,
	0x000AFFFF,//4
	0x0008D8FF,//5
	0x0007B0FF,//6
	0x000580FF,//7
	0x000239FF,//8
	0x000000FF//9
};
new ATTRACTORS_ANIMATIONS   [3][30];	// ATTRACTORS - 2
new BAR_ANIMATIONS      	[12][30];	// BAR - 11
new BAT_ANIMATIONS      	[11][30];	// BAT - 10
new FIRE_ANIMATIONS      	[13][30];	// FIRE - 12
new PLAYA_ANIMATIONS      	[5][30];	// PLAYA - 4
new GYM_ANIMATIONS      	[7][30];	// GYM - 6
new BFINJECT_ANIMATIONS     [4][30];	// BFINJECT - 3
new BICID_ANIMATIONS      	[19][30];	// BICID - 18
new BICIH_ANIMATIONS      	[18][30];	// BICIH - 17
new BICIL_ANIMATIONS      	[9][30];	// BICIL - 8
new BICIS_ANIMATIONS      	[20][30];	// BICIS - 19
new BICIV_ANIMATIONS      	[18][30];	// BICIV - 17
new BICI_ANIMATIONS      	[4][30];	// BICI - 3
new GOLPE_ANIMATIONS      	[12][30];	// GOLPE - 11
new BMX_ANIMATIONS      	[18][30];	// BMX - 17
new BOMBER_ANIMATIONS      	[6][30];	// BOMBER - 5
new BOX_ANIMATIONS      	[10][30];	// BOX - 9
new BALL_ANIMATIONS      	[41][30];	// BALL - 40
new BUDDY_ANIMATIONS      	[5][30];	// BUDDY - 4
new BUS_ANIMATIONS      	[9][30];	// BUS - 8
new CAM_ANIMATIONS      	[14][30];	// CAM - 13
new CAR_ANIMATIONS      	[11][30];	// CAR - 10
new CARRY_ANIMATIONS      	[7][30];	// CARRY - 6
new CARCHAT_ANIMATIONS     	[21][30];	// CARCHAT - 20
new CASINO_ANIMATIONS      	[25][30];	// CASINO - 24
new CHAINSAW_ANIMATIONS     [11][30];	// CHAINSAW - 10
new CHOPA_ANIMATIONS      	[18][30];	// CHOPA - 17
new CLOTHES_ANIMATIONS     	[13][30];	// CLOTHES - 12
new COACH_ANIMATIONS      	[6][30];	// COACH - 5
new COLT_ANIMATIONS      	[7][30];	// COLT - 6
new COP_ANIMATIONS      	[12][30];	// COP - 11
new COPD_ANIMATIONS      	[4][30];	// COPD - 3
new CRACK_ANIMATIONS      	[10][30];	// CRACK - 9
new CRIB_ANIMATIONS      	[5][30];	// CRIB - 4
new DAM_ANIMATIONS      	[5][30];	// DAM - 4
new DANCE_ANIMATIONS      	[13][30];	// DANCE - 12
new DEALER_ANIMATIONS      	[7][30];	// DEALER - 6
new DILDO_ANIMATIONS      	[9][30];	// DILDO - 8
new DODGE_ANIMATIONS      	[4][30];	// DODGE - 3
new DOZER_ANIMATIONS      	[10][30];	// DOZER - 9
new DRIVE_ANIMATIONS      	[8][30];	// DRIVE - 7
new FAT_ANIMATIONS      	[18][30];	// FAT - 17
new FIGHTB_ANIMATIONS      	[10][30];	// FIGHTB - 9
new FIGHTC_ANIMATIONS      	[12][30];	// FIGHTC - 11
new FIGHTD_ANIMATIONS      	[10][30];	// FIGHTD - 9
new FIGHTE_ANIMATIONS      	[4][30];	// FIGHTE - 3
new FINALE_ANIMATIONS      	[16][30];	// FINALE - 15
new FINALE2_ANIMATIONS      [8][30];	// FINALE2 - 7
new FLAME_ANIMATIONS      	[1][30];	// FLAME - 0
new FLOWERS_ANIMATIONS     	[3][30];	// FLOWERS - 2
new FOOD_ANIMATIONS      	[33][30];	// FOOD - 32
new GYMA_ANIMATIONS      	[9][30];	// GYMA - 8
new GANGS_ANIMATIONS      	[33][30];	// GANGS - 32
new GHANDS_ANIMATIONS      	[20][30];	// GHANDS - 19
new GHETTO_ANIMATIONS      	[7][30];	// GHETTO - 6
new GOGGLES_ANIMATIONS     	[1][30];	// GOGGLES - 0
new GRAFFITI_ANIMATIONS     [2][30];	// GRAFFITI - 1
new GRAVE_ANIMATIONS      	[3][30];	// GRAVE - 2
new GRENADE_ANIMATIONS     	[3][30];	// GRENADE - 2
new GYMB_ANIMATIONS      	[24][30];	// GYMB - 23
new HAIR_ANIMATIONS      	[13][30];	// HAIR - 12
new HEIST_ANIMATIONS      	[10][30];	// HEIST - 9
new HOUSE_ANIMATIONS      	[10][30];	// HOUSE - 9
new OFFICE_ANIMATIONS      	[10][30];	// OFFICE - 9
new INTSHOP_ANIMATIONS     	[8][30];	// SHOP - 7
new BUISNESS_ANIMATIONS     [4][30];	// BUISNESS - 3
new KART_ANIMATIONS      	[4][30];	// KART - 3
new KISSING_ANIMATIONS     	[15][30];	// KISSING - 14
new KNIFE_ANIMATIONS      	[16][30];	// KNIFE - 15
new LAPDAN1_ANIMATIONS      [2][30];	// LAPDAN - 1
new LAPDAN2_ANIMATIONS     	[2][30];	// LAPDAN - 2
new LAPDAN3_ANIMATIONS     	[2][30];	// LAPDAN - 3
new LOWRIDER_ANIMATIONS    	[39][30];	// LOWRIDER - 38
new CHASE_ANIMATIONS      	[25][30];	// CHASE - 24
new END_ANIMATIONS      	[8][30];	// END - 7
new MEDIC_ANIMATIONS      	[1][30];	// MEDIC - 0
new MISC_ANIMATIONS      	[41][30];	// MISC - 40
new MTB_ANIMATIONS      	[18][30];	// MTB - 17
//new MUSCULAR_ANIMATIONS     [17][30];	// MUSCULAR - 16
//new NEVADA_ANIMATIONS      	[2][30];	// NEVADA - 1
new LOOKERS_ANIMATIONS     	[29][30];	// LOOKERS - 28
new OTB_ANIMATIONS      	[11][30];	// OTB - 10
new PARA_ANIMATIONS      	[22][30];	// PARA - 21
new PARK_ANIMATIONS      	[3][30];	// PARK - 2
new PAUL_ANIMATIONS      	[12][30];	// PAUL - 11
new PLAYER_ANIMATIONS      	[4][30];	// PLAYER - 3
new PLAYID_ANIMATIONS      	[5][30];	// PLAYID - 4
new POLICE_ANIMATIONS      	[10][30];	// POLICE - 9
new POOL_ANIMATIONS      	[21][30];	// POOL - 20
new POOR_ANIMATIONS      	[2][30];	// POOR - 1
new PYTHON_ANIMATIONS      	[5][30];	// PYTHON - 4
new QUAD_ANIMATIONS      	[17][30];	// QUAD - 16
new QUADD_ANIMATIONS      	[4][30];	// QUADD - 3
new RAP_ANIMATIONS      	[8][30];	// RAP - 7
new RIFLE_ANIMATIONS      	[5][30];	// RIFLE - 4
new RIOT_ANIMATIONS      	[7][30];	// RIOT - 6
new ROB_ANIMATIONS      	[5][30];	// ROB - 4
new ROCKET_ANIMATIONS      	[5][30];	// ROCKET - 4
new RUSTLER_ANIMATIONS     	[5][30];	// RUSTLER - 4
new RYDER_ANIMATIONS      	[16][30];	// RYDER - 15
new SCRAT_ANIMATIONS      	[12][30];	// SCRAT - 11
new SHAMAL_ANIMATIONS      	[4][30];	// SHAMAL - 3
new SHOP_ANIMATIONS      	[25][30];	// SHOP - 24
new SHOTGUN_ANIMATIONS     	[3][30];	// SHOTGUN - 2
new SILENCED_ANIMATIONS    	[4][30];	// SILENCED - 3
new SKATE_ANIMATIONS      	[3][30];	// SKATE - 2
new SMOK_ANIMATIONS      	[8][30];	// SMOK - 7
new SNIPER_ANIMATIONS      	[1][30];	// SNIPER - 0
new SPRAY_ANIMATIONS      	[2][30];	// SPRAY - 1
new STRIP_ANIMATIONS      	[20][30];	// STRIP - 19
new SUNBA_ANIMATIONS      	[18][30];	// SUNBA - 17
new SWAT_ANIMATIONS      	[23][30];	// SWAT - 22
new SWEET_ANIMATIONS      	[7][30];	// SWEET - 6
new SWIM_ANIMATIONS      	[7][30];	// SWIM - 6
new SWORD_ANIMATIONS      	[10][30];	// SWORD - 9
new TANK_ANIMATIONS      	[6][30];		// TANK - 5
new TATTOO_ANIMATIONS      	[57][30];	// TATTOO - 56
new TEC_ANIMATIONS      	[4][30];	// TEC - 3
new TRAIN_ANIMATIONS      	[4][30];	// TRAIN - 3
new TRUCK_ANIMATIONS      	[17][30];	// TRUCK - 16
new UZI_ANIMATIONS      	[5][30];	// UZI - 4
new VAN_ANIMATIONS      	[8][30];	// VAN - 7
new VENDING_ANIMATIONS      [6][30];	// VENDING - 5
new VORTEX_ANIMATIONS      	[4][30];	// VORTEX - 3
new WAYFA_ANIMATIONS      	[18][30];	// WAYFA - 17
new ARMA_ANIMATIONS      	[17][30];	// ARMA - 16
new WUZI_ANIMATIONS      	[12][30];	// WUZI - 11
new PED_ANIMATIONS      	[286][30]; 	// PED - 285

//////////////////////////////// SCRIPTFILE ////////////////////////////////
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("          StreetGangWars");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{

}

#endif
//////////////////////////////// END SCRIPTFILE ////////////////////////////////

//////////////////////    PUBLIC    ////////////////////////////////////////////////////////////////////

public OnGameModeInit()
{
    SetGravity(0.008);
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		PlayersDataOnline[i][MarcaZZ] = true;
	}

	print("\n\n\n\n\n\n\n___________________ INICIANDO GAMEMODE ___________________");

	SetGameModeText(GAMEMODE_VERSION);
	
	SetWeather(14);
	WeatherCurrent = 14;
	//////////////// LOADS //////////
	LoadBombas();
	LoadDoors();
	LoadAllAnims();
	LoadCamerasLogin();
	LoadStaticObjects();
	LoadTelesPublics();
	LoadTelesLock();
	LoadMenuStatic();
	LoadTextDrawInfo();
	CargarMapIcons();

	LoadDataBizzType();
	/////////// NEGOCIOS
	for (new i = 1; i < MAX_BIZZ_COUNT; i++)
	{
		if (!DataLoadBizz(i))
		{
		    MAX_BIZZ = i - 1;
		    break;
		}
	}

	/////////// CASAS
	for (new i = 1; i < MAX_HOUSE_COUNT; i++)
	{
		if (!LoadHouse(i))
		{
		    MAX_HOUSE = i - 1;
		    break;
		}
	}
	LoadGarages();
/////////// VEHICLES
	// NORMALES
	for (new i = 1; i < MAX_VEHICLE_COUNT; i++)
	{
		DataCars[i][StationID]     		= -1;
		DataCars[i][VolumenVehicle]     = DEFAULT_AUDIO_VOLUMEN;

		if (!LoadDataVehicle(i, DIR_VEHICLES, true))
		{
		    MAX_CAR_DUENO = i - 1;
		    MAX_CAR = MAX_CAR_DUENO;
		    break;
		}
		else
		{
			if ( DataCars[i][IsLastSpawn] )
			{
				SetLastSettingVehicle(i);
			}
			else
			{
				CreateVehicleEx(DataCars[i][Modelo], DataCars[i][PosX], DataCars[i][PosY], DataCars[i][PosZ], DataCars[i][PosZZ], DataCars[i][Color1], DataCars[i][Color2], i);
			}
		}
		DataCars[i][IsLastSpawn] = false;
	}
	//////////////////////////// otros ///////////
	ManualVehicleEngineAndLights();
    DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	Streamer_TickRate(10);
	ShowPlayerMarkers(1);
    UsePlayerPedAnims();
	SetWeather(14);
	WeatherCurrent = 14;
	CreateTextDrawGas();
	// GANGES
	LoadCarsGang();
	for ( new i = MAX_CAR_DUENO + 1; i <= MAX_CAR_GANG; i++)
	{
		SetPlateToCarGang(i, DataCars[i][Time]);
	    if ( LoadDataVehicle(i, DIR_VEHICLESF, false) && DataCars[i][IsLastSpawn] )
	    {
			SetLastSettingVehicle(i);
	    }
	    else
	    {
			CreateVehicleEx(DataCars[i][Modelo], DataCars[i][PosX], DataCars[i][PosY], DataCars[i][PosZ], DataCars[i][PosZZ], DataCars[i][Color1], DataCars[i][Color2], i);
			DataCars[i][Gas] = MAX_GAS_VEHICLE;
			//DataCars[i][Oil] = MAX_OIL_VEHICLE;
			DataCars[i][Lock] = LOCK_GANG_CAR;
		}
		DataCars[i][IsLastSpawn] = false;
//		printf("%i -- %i - %f - %f - %f - %f - %i - %i", DataCars[i][Time], DataCars[i][Modelo], DataCars[i][PosX], DataCars[i][PosY], DataCars[i][PosZ], DataCars[i][PosZZ], DataCars[i][Color1], DataCars[i][Color2]);
	}
	// PÚBLICOS
	LoadCarsPublic();
	for ( new i = MAX_CAR_GANG + 1; i <= MAX_CAR_PUBLIC; i++)
	{
	    if ( LoadDataVehicle(i, DIR_VEHICLESP, false) && DataCars[i][IsLastSpawn] )
	    {
			SetLastSettingVehicle(i);
	    }
	    else
	    {
			CreateVehicleEx(DataCars[i][Modelo], DataCars[i][PosX], DataCars[i][PosY], DataCars[i][PosZ], DataCars[i][PosZZ], DataCars[i][Color1], DataCars[i][Color2], i);
			DataCars[i][Gas] = MAX_GAS_VEHICLE;
			//DataCars[i][Oil] = MAX_OIL_VEHICLE;
		}
		DataCars[i][IsLastSpawn] = false;
//		printf("%i -- %i - %f - %f - %f - %f - %i - %i", DataCars[i][Time], DataCars[i][Modelo], DataCars[i][PosX], DataCars[i][PosY], DataCars[i][PosZ], DataCars[i][PosZZ], DataCars[i][Color1], DataCars[i][Color2]);
	}
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////// 						GANGES

	for (new i = 0; i < MAX_GANG_COUNT; i++)
	{
	    for (new s = 0; s < MAX_GANG_RANGOS; s++)
	    {
		    GangData[i][Paga][s] = 0;
			format(GangesRangos[i][s], MAX_GANG_NAME, "0");
			for ( new h; h < MAX_GANG_SKIN; h++)
			{
				RangosSkins[i][s][h] = 0;
			}
		}
	}
// SINGANG ID - 0
	format(GangData[SINGANG][NameGang], MAX_GANG_NAME, "No Gang");
	GangData[SINGANG][Family] 			= false;
	GangData[SINGANG][Radio] 			= false;

	GangesRangos[SINGANG][7]  = "Ninguno"; 			RangosSkins[SINGANG][7][0] 	= 119;		RangosSkins[SINGANG][7][1] 	= 233;	GangData[SINGANG][Paga][7] = 299;

// YAKUZA ID - 1
	format(GangData[YAKUZA][NameGang], MAX_GANG_NAME, "Yakuza");
	GangData[YAKUZA][Extorsion] 		= 0;
	GangData[YAKUZA][Spawn_X][0]		= -2983.1213;// -2983.1213,462.07512,7.5094
	GangData[YAKUZA][Spawn_Y][0]   		= 462.07512;
	GangData[YAKUZA][Spawn_Z][0]		= 7.5094;
	GangData[YAKUZA][Spawn_ZZ][0]   	= 0.9265;
	GangData[YAKUZA][PickupOut_X] 		= -2984.6780;
	GangData[YAKUZA][PickupOut_Y] 		= 458.0828;
	GangData[YAKUZA][PickupOut_Z] 		= 4.9141;
	GangData[YAKUZA][PickupOut_ZZ] 		= 269.1424;
	GangData[YAKUZA][PickupIn_X]		= 2317.8542;
	GangData[YAKUZA][PickupIn_Y] 		= -1026.7068;
	GangData[YAKUZA][PickupIn_Z] 		= 1050.2178;
	GangData[YAKUZA][PickupIn_ZZ] 		= 0.7340;
	GangData[YAKUZA][InteriorGang] 		= 9;
	GangData[YAKUZA][PickupidOutF]		= CreatePickup	(1254, 	1, 	GangData[YAKUZA][PickupOut_X], GangData[YAKUZA][PickupOut_Y], GangData[YAKUZA][PickupOut_Z],	 	WORLD_NORMAL);
	GangData[YAKUZA][PickupidInF] 		= CreatePickup	(1254, 	1, 	GangData[YAKUZA][PickupIn_X], GangData[YAKUZA][PickupIn_Y], GangData[YAKUZA][PickupIn_Z],	 	WORLD_DEFAULT_INTERIOR);
	GangData[YAKUZA][PrecioGang] 		= 0;
	GangData[YAKUZA][Lock] 				= 0;
	GangData[YAKUZA][World] 			= WORLD_DEFAULT_INTERIOR;
	GangData[YAKUZA][Family] 			= true;
	GangData[YAKUZA][Radio] 			= false;

	GangesRangos[YAKUZA][0]  = "Lider"; 		RangosSkins[YAKUZA][0][0] 	= 208; 	RangosSkins[YAKUZA][0][1] 	= 294;  RangosSkins[YAKUZA][0][2] 	= 123; 	GangData[YAKUZA][Paga][0] = 1000;
	GangesRangos[YAKUZA][1]  = "Sub Lider"; 	RangosSkins[YAKUZA][1][0] 	= 294;  RangosSkins[YAKUZA][1][1] 	= 122;  RangosSkins[YAKUZA][1][2] 	= 123;	GangData[YAKUZA][Paga][1] = 800;
	GangesRangos[YAKUZA][2]  = "Recluta"; 		RangosSkins[YAKUZA][2][0] 	= 121;  RangosSkins[YAKUZA][2][1] 	= 122;  RangosSkins[YAKUZA][2][2] 	= 123;	GangData[YAKUZA][Paga][2] = 500;

// RUSOSID - 2
	format(GangData[RUSOS][NameGang], MAX_GANG_NAME, "Rusos");
	GangData[RUSOS][Extorsion] 		= 0;
	GangData[RUSOS][Spawn_X][0] 		= -2148.4658;//-2148.4658, -163.1070, 35.4328
	GangData[RUSOS][Spawn_Y][0] 		= -163.1070;
	GangData[RUSOS][Spawn_Z][0] 		= 35.4328;
	GangData[RUSOS][Spawn_ZZ][0] 		= 264.5157;
	GangData[RUSOS][PickupOut_X] 		= -2106.9158;
	GangData[RUSOS][PickupOut_Y] 		= -178.6035;
	GangData[RUSOS][PickupOut_Z] 		= 35.3203;
	GangData[RUSOS][PickupOut_ZZ] 		= 359.0232;
	GangData[RUSOS][PickupIn_X] 		= 2532.2322;
	GangData[RUSOS][PickupIn_Y] 		= -1281.7468;
	GangData[RUSOS][PickupIn_Z] 		= 1048.2891;
	GangData[RUSOS][PickupIn_ZZ] 		= 271.4886;
	GangData[RUSOS][InteriorGang] 		= 2;
	GangData[RUSOS][PickupidOutF]		= CreatePickup	(1254, 	1, 	GangData[RUSOS][PickupOut_X], GangData[RUSOS][PickupOut_Y], GangData[RUSOS][PickupOut_Z],	 	WORLD_NORMAL);
	GangData[RUSOS][PickupidInF] 		= CreatePickup	(1254, 	1, 	GangData[RUSOS][PickupIn_X], GangData[RUSOS][PickupIn_Y], GangData[RUSOS][PickupIn_Z],	 	WORLD_DEFAULT_INTERIOR);
	GangData[RUSOS][PrecioGang] 		= 0;
	GangData[RUSOS][Lock] 				= 0;
	GangData[RUSOS][World] 				= WORLD_DEFAULT_INTERIOR;
	GangData[RUSOS][Family] 			= true;
	GangData[RUSOS][Radio] 				= false;

	GangesRangos[RUSOS][0]  = "Lider"; 				RangosSkins[RUSOS][0][0] 	= 290; 		RangosSkins[RUSOS][0][1] 	= 272; RangosSkins[RUSOS][0][2] 	= 113; 	GangData[RUSOS][Paga][0] = 500;
	GangesRangos[RUSOS][1]  = "Sub Lider"; 			RangosSkins[RUSOS][1][0] 	= 272;  	RangosSkins[RUSOS][1][1] 	= 112;  RangosSkins[RUSOS][1][2] 	= 113;	GangData[RUSOS][Paga][1] = 450;
	GangesRangos[RUSOS][2]  = "Recluta"; 			RangosSkins[RUSOS][2][0] 	= 111;  	RangosSkins[RUSOS][2][1] 	= 112;  RangosSkins[RUSOS][2][2] 	= 113;	GangData[RUSOS][Paga][2] = 450;

// ITALIANOS ID - 3
	format(GangData[ITALIANOS][NameGang], MAX_GANG_NAME, "Italianos");
	GangData[ITALIANOS][Extorsion] 		= 0;
	GangData[ITALIANOS][Spawn_X][0]			= -2445.4912;//-2445.4912,529.4976,29.9212,269.5339,0,0,0,0,0,0); // SpawnGang3
	GangData[ITALIANOS][Spawn_Y][0]			= 529.4976;
	GangData[ITALIANOS][Spawn_Z][0]			= 29.9212;
	GangData[ITALIANOS][Spawn_ZZ][0]		= 269.5339;
	GangData[ITALIANOS][PickupOut_X] 		= -2455.1589;//-2455.1589,503.9312,30.0774,262.8140,0,0,0,0,0,0); // PickUpOutGang3
	GangData[ITALIANOS][PickupOut_Y] 		= 503.9312;
	GangData[ITALIANOS][PickupOut_Z] 		= 30.0774;
	GangData[ITALIANOS][PickupOut_ZZ] 		= 262.8140;
	GangData[ITALIANOS][PickupIn_X] 		= 2324.3074;//2324.3074,-1148.3958,1050.7101,0.1409,0,0,0,0,0,0); // Gang3PickupIN
	GangData[ITALIANOS][PickupIn_Y] 		= -1148.3958;
	GangData[ITALIANOS][PickupIn_Z] 		= 1050.7101;
	GangData[ITALIANOS][PickupIn_ZZ] 		= 0.1409;
	GangData[ITALIANOS][InteriorGang] 		= 12;
	GangData[ITALIANOS][PickupidOutF]		= CreatePickup	(1254, 	1, 	GangData[ITALIANOS][PickupOut_X], GangData[ITALIANOS][PickupOut_Y], GangData[ITALIANOS][PickupOut_Z],	 	WORLD_NORMAL);
	GangData[ITALIANOS][PickupidInF] 		= CreatePickup	(1254, 	1, 	GangData[ITALIANOS][PickupIn_X], GangData[ITALIANOS][PickupIn_Y], GangData[ITALIANOS][PickupIn_Z],	 	WORLD_DEFAULT_INTERIOR);
	GangData[ITALIANOS][PrecioGang] 		= 0;
	GangData[ITALIANOS][Lock] 				= 0;
	GangData[ITALIANOS][World] 				= WORLD_DEFAULT_INTERIOR;
	GangData[ITALIANOS][Family] 			= true;
	GangData[ITALIANOS][Radio] 				= false;

	GangesRangos[ITALIANOS][0]  = "Lider"; 			RangosSkins[ITALIANOS][0][0] 	= 273;  	RangosSkins[ITALIANOS][0][1] 	= 127;	RangosSkins[ITALIANOS][0][2] 	= 126;	GangData[ITALIANOS][Paga][0] = 430;
	GangesRangos[ITALIANOS][1]  = "Sub Lider"; 		RangosSkins[ITALIANOS][1][0] 	= 127;  	RangosSkins[ITALIANOS][1][1] 	= 125;	RangosSkins[ITALIANOS][1][2] 	= 126;	GangData[ITALIANOS][Paga][1] = 400;
	GangesRangos[ITALIANOS][2]  = "Recluta"; 		RangosSkins[ITALIANOS][2][0] 	= 124; 		RangosSkins[ITALIANOS][2][1]	= 125; 	RangosSkins[ITALIANOS][2][2] 	= 126;	GangData[ITALIANOS][Paga][2] = 370;

// TRIADAS ID - 4
	format(GangData[TRIADA][NameGang], MAX_GANG_NAME, "Triadas");
	GangData[TRIADA][Extorsion] 			= 0;
	GangData[TRIADA][Spawn_X][0]			= -2086.9553;//-2086.9553,1424.0878,9.7109,268.1264,0,0,0,0,0,0); // SpawnGang4
	GangData[TRIADA][Spawn_Y][0]			= 1424.0878;
	GangData[TRIADA][Spawn_Z][0]			= 9.7109;
	GangData[TRIADA][Spawn_ZZ][0]		= 268.1264;
	GangData[TRIADA][PickupOut_X] 		= -2090.8271;// -2090.8271,1425.6425,7.1016,180.8222,0,0,0,0,0,0); // InteriorGang4
	GangData[TRIADA][PickupOut_Y] 		= 1425.6425;
	GangData[TRIADA][PickupOut_Z] 		= 7.1016;
	GangData[TRIADA][PickupOut_ZZ] 		= 180.8222;
	GangData[TRIADA][PickupIn_X] 		= 1261.6130;
	GangData[TRIADA][PickupIn_Y] 		= -785.2961;
	GangData[TRIADA][PickupIn_Z] 		= 1091.9063;
	GangData[TRIADA][PickupIn_ZZ] 		= 272.4865;
	GangData[TRIADA][InteriorGang] 		= 5;
	GangData[TRIADA][PickupidOutF]		= CreatePickup	(1254, 	1, 	GangData[TRIADA][PickupOut_X], GangData[TRIADA][PickupOut_Y], GangData[TRIADA][PickupOut_Z],	 	WORLD_NORMAL);
	GangData[TRIADA][PickupidInF] 		= CreatePickup	(1254, 	1, 	GangData[TRIADA][PickupIn_X], GangData[TRIADA][PickupIn_Y], GangData[TRIADA][PickupIn_Z],	 	WORLD_DEFAULT_INTERIOR);
	GangData[TRIADA][PrecioGang] 		= 0;
	GangData[TRIADA][Lock] 				= 0;
	GangData[TRIADA][World] 			= WORLD_DEFAULT_INTERIOR;
	GangData[TRIADA][Family] 			= true;
	GangData[TRIADA][Radio] 			= false;

	GangesRangos[TRIADA][0]  = "Lider"; 		RangosSkins[TRIADA][0][0] 	= 187; 	RangosSkins[TRIADA][0][1] 	= 186;	RangosSkins[TRIADA][0][2] 	= 120;	GangData[TRIADA][Paga][0] = 430;
	GangesRangos[TRIADA][1]  = "Sub Lider"; 	RangosSkins[TRIADA][1][0] 	= 186;  RangosSkins[TRIADA][1][1] 	= 118;	RangosSkins[TRIADA][1][2] 	= 120;	GangData[TRIADA][Paga][1] = 450;
	GangesRangos[TRIADA][2]  = "Recluta"; 		RangosSkins[TRIADA][2][0] 	= 117; 	RangosSkins[TRIADA][2][1]	= 118;	RangosSkins[TRIADA][2][2] 	= 120;	GangData[TRIADA][Paga][2] = 400;


//////////////////////////////// GANGES ////////////////////////////////
	for (new i = 0; i < MAX_GANG_COUNT; i++ )
	{
	    new TempDirGang[25];
	    format(TempDirGang, sizeof(TempDirGang), "%s%i.sgw", DIR_GANGES, i);

		if ( fexist(TempDirGang) )
		{
			LoadDataGang(i);
		}
		else
		{
		    break;
		}
	}
	SKIN_CIVILES[0]    = 1;
	SKIN_CIVILES[1]    = 2;

	LoadLastOptionsServer(); // LOAD SPECIAL OPTION SERVER
	ShowServerStats(-1);
	RespawnCoches();
	print("___________________ GAMEMODE CARGADO CORRECTAMENTE! ___________________");
	print("\n______________ NO SE CARGARÓN FILESCRIPTS/FILTERSCRIPTS ________________");
	return 1;
}

public OnGameModeExit()
{
	if ( !ResetGM )
	{
		OnGameModeExitEx();
  	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if ( PlayersDataOnline[playerid][State] == 0 )
	{
	    SetPlayerOrginalTime(playerid);

		PlayAudioStreamForPlayer(playerid, "http://dl.dropbox.com/u/105709431/connected.wav");
//	    PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
		for (new AE = 0; AE <= 20; AE++)
		{
		    SendClientMessage(playerid, 0xFFFFFFFF, "");
		}

		SendInfoMessage(playerid, 2, "0", LOGO_STREETGW);
		new DirBD[50];
		format(DirBD, sizeof(DirBD), "%s%s.sgw", DIR_USERS, PlayersDataOnline[playerid][NameOnline]);

		// LOGIN
		if ( fexist(DirBD) )
		{
		    PlayersDataOnline[playerid][State] = 1;
		    DataUserLoad(playerid);
 			ShowPlayerLogin(playerid, true);
		}
		// REGISTRO
		else
		{
		    PlayersDataOnline[playerid][State] = 2;
			ShowPlayerRegister(playerid, true);
		}

		PlayersData[playerid][CameraLogin]--;
		SetCameraLogin(playerid, PlayersData[playerid][CameraLogin], true);

		PlayersDataOnline[playerid][StateDeath] = 3;
	}
	else if ( !PlayersDataOnline[playerid][StateDeath] || PlayersDataOnline[playerid][State] == 3)
	{
		UpdateSpawnPlayer(playerid);
	    SpawnPlayerEx(playerid);
	}
	else if ( PlayersDataOnline[playerid][State] )
	{
		SetCameraLogin(playerid, PlayersData[playerid][CameraLogin], true);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid, 0xAAAAAA00);
	MaterialTextLogin();
	SetPlayerVirtualWorld(playerid, 1337);
	GetPlayerName(playerid, PlayersDataOnline[playerid][NameOnline], MAX_PLAYER_NAME);
	PlayersDataOnline[playerid][TimerLoginId] = SetTimerEx("IsPlayerOff", 120000, false, "d", playerid);
    SaveIpUser(playerid, true);
	SendDeathMessage(INVALID_PLAYER_ID, playerid, 200); //Icono azul al conectar
	if (IsValidName(PlayersDataOnline[playerid][NameOnline]))
	{
	}
	else
	{
		printf("Kickeado por Nick: %s", PlayersDataOnline[playerid][NameOnline]);
		SendInfoMessage(playerid, 0, "022", "El nick que usa esta deshabilitado por cuestiones de seguridad.");
		SendInfoMessage(playerid, 0, "022", "The nick using this disabled for security.");
		print("Error 119");
		KickEx(playerid, 1);
	}
	GivePlayerWeaponEx(playerid, 24, 300);
	GivePlayerWeaponEx(playerid, 26, 200);
	GivePlayerWeaponEx(playerid, 34, 100);
	GivePlayerWeaponEx(playerid, 4, 1);
	DataUserClean(playerid);
	return 1;
}

public UpdateSpectatedPlayers(playerid, death, interiorid, world)
{
	for ( new i = 0; i < MAX_PLAYERS; i++)
	{
	    if ( PlayersDataOnline[i][Espectando] == playerid )
	    {
	        if ( !death )
	        {
			    SetPlayerVirtualWorldEx(i, world);
			    SetPlayerInteriorEx(i, interiorid);
	    		PlayerSpectatePlayer(i, playerid);
			}
			else
			{
	        	RemoveSpectatePlayer(i);
			}
		}
	}
}
public OnPlayerDisconnect(playerid, reason)
{
	new string[128];
 	switch(reason)
    {
        case 0: format(string, 128, "Info: %s(%i) abandonó el servidor {F1FF00}[Razón: Crasheó]", PlayersDataOnline[playerid][NameOnline], playerid);
        case 1: format(string, 128, "Info: %s(%i) abandonó el servidor {F1FF00}[Razón: Se fué]", PlayersDataOnline[playerid][NameOnline], playerid);
        case 2: format(string, 128, "Info: %s(%i) abandonó el servidor {F1FF00}[Razón: Kickeado/Baneado]", PlayersDataOnline[playerid][NameOnline], playerid);
    }
    MsgCheatsReportsToAdmins(string);
	if ( !ResetGM )
	{
		if(PlayersDataOnline[playerid][IsEspectando])
		{
			UpdateSpectatedPlayers(playerid, true, false, false);
		}
	    SaveDatosPlayerDisconnect(playerid);
    }
	return 1;
}

public OnPlayerSpawn(playerid)
{
	MuertesCount[playerid]=0;
	if ( PlayersDataOnline[playerid][StateDeath] && PlayersDataOnline[playerid][State] == 3 )
	{
		if ( PlayersDataOnline[playerid][StateDeath] == 5 )
		{
			SendInfoMessage(playerid, 0, "001", "Jugador Fuera de Lugar, reloguee y no vuelva a intentar retornar de class.");
			SendInfoMessage(playerid, 0, "001", "Out of side, relog and don't try to change Class.");
		    KickEx(playerid, 0);
		    return 1;
		}
		//Streamer_UpdateEx(playerid, GangData[PlayersData[playerid][Gang]][Spawn_X], GangData[PlayersData[playerid][Gang]][Spawn_Y], GangData[PlayersData[playerid][Gang]][Spawn_Z]);
//		SetPlayerLockAllVehicles(playerid);
		/*if ( PlayersDataOnline[playerid][StateDeath] == 2 && PlayersData[playerid][Jail] == 0)
		{
          	SetPlayerVirtualWorldEx(playerid, 0);
	        PlayersDataOnline[playerid][VidaOn] = 100.0;
	        PlayersDataOnline[playerid][ChalecoOn] = 0.0;
			SetPlayerTeam(playerid, -1);
			ResetPlayerWeaponsEx(playerid);
		}*/
       	SetPlayerVirtualWorldEx(playerid, 0);
        PlayersDataOnline[playerid][VidaOn] = 100.0;
        PlayersDataOnline[playerid][ChalecoOn] = 0.0;
		SetPlayerTeamEx(playerid);
		ResetPlayerWeaponsEx(playerid);
		/*if ( PlayersData[playerid][Jail] > 0 )
		{
		    SetPlayerJail(playerid);
	        PlayersDataOnline[playerid][VidaOn] = 100.0;
	        PlayersDataOnline[playerid][ChalecoOn] = 0.0;
		}*/
	    SetPlayerWeather(playerid, WeatherCurrent);
		PlayersDataOnline[playerid][StateDeath] = false;
	}
	else
	{
		SendInfoMessage(playerid, 0, "001", "Jugador Fuera de Lugar, reloguee y no vuelva a intentar retornar de class.");
		SendInfoMessage(playerid, 0, "001", "Out of side, relog and don't try to change Class.");
	    KickEx(playerid, 2);
	}
	GivePlayerWeaponEx(playerid, 24, 300);
	GivePlayerWeaponEx(playerid, 26, 200);
	GivePlayerWeaponEx(playerid, 34, 100);
	GivePlayerWeaponEx(playerid, 4, 1);
	return 1;

}
public OnPlayerDeath(playerid, killerid, reason)
{
	PlayersDataOnline[playerid][StateDeath] = 2;
	if(PlayersDataOnline[playerid][IsEspectando])
	{
		UpdateSpectatedPlayers(playerid, true, false, false);
	}
	if(PlayersData[killerid][Gang] != PlayersData[playerid][Gang] ||
	   PlayersData[killerid][Gang]== SINGANG && PlayersData[playerid][Gang]== SINGANG)
	{
		if ( IsPlayerConnected(killerid) && killerid != INVALID_PLAYER_ID )
		{
			FakeKill[playerid] ++;
		    SetTimerEx("AntiFakeKill", 1000,false,"i",playerid);
		    
	        MuertesCount[killerid]++;
			GivePlayerMoneyEx(killerid, 300);
			PlayersData[killerid][KilledCount]++;

			if(MuertesCount[killerid]==1)
			{
				new MsgDobleKill[MAX_TEXT_CHAT];
				format(MsgDobleKill, sizeof(MsgDobleKill), "~>~~>~ ~r~Asesino - Slayer ~<~~<~");
				GameTextForPlayer(killerid, MsgDobleKill, 500, 5);
			}
			else if(MuertesCount[killerid]==2)
			{
				new MsgDobleKill[MAX_TEXT_CHAT];
				format(MsgDobleKill, sizeof(MsgDobleKill), "~>~~>~ ~r~Double Kill ~<~~<~");
				GameTextForPlayer(killerid, MsgDobleKill, 500, 5);
				PlayAudioStreamForPlayer(killerid, "http://dl.dropbox.com/u/105709431/Double%20Kill.mp3");
			}
			else if(MuertesCount[killerid]==3)
			{
				new MsgDobleKill[MAX_TEXT_CHAT];
				format(MsgDobleKill, sizeof(MsgDobleKill), "~>~~>~ ~r~Triple Kill ~<~~<~");
				GameTextForPlayer(killerid, MsgDobleKill, 500, 5);
				PlayAudioStreamForPlayer(killerid, "http://dl.dropbox.com/u/105709431/Triple_Kill_wma.MP3");
			}
			else if(MuertesCount[killerid]==4)
			{
				new MsgDobleKill[MAX_TEXT_CHAT];
				format(MsgDobleKill, sizeof(MsgDobleKill), "~>~~>~ ~r~Asesinato Multiple ~<~~<~");
				GameTextForPlayer(killerid, MsgDobleKill, 500, 5);
				PlayAudioStreamForPlayer(killerid, "http://dl.dropbox.com/u/105709431/Killing_Spree_wma.MP3");
			}
			else if(MuertesCount[killerid]==5)
			{
				new MsgDobleKill[MAX_TEXT_CHAT];
				format(MsgDobleKill, sizeof(MsgDobleKill), "~>~~>~ ~r~Frenesi Asesino ~<~~<~");
				GameTextForPlayer(killerid, MsgDobleKill, 500, 5);
				PlayAudioStreamForPlayer(killerid, "http://dl.dropbox.com/u/105709431/Kill_Frenzy_wma.MP3");
			}
			else if(MuertesCount[killerid]==6)
			{
				new MsgDobleKill[MAX_TEXT_CHAT];
				format(MsgDobleKill, sizeof(MsgDobleKill), "~>~~>~ ~r~Muerte Increible ~<~~<~");
				GameTextForPlayer(killerid, MsgDobleKill, 500, 5);
				PlayAudioStreamForPlayer(killerid, "http://dl.dropbox.com/u/105709431/Overkill__Un_Frikin_Believable__wma.MP3");
			}
			else if(MuertesCount[killerid]==7)
			{
				new MsgDobleKill[MAX_TEXT_CHAT];
				format(MsgDobleKill, sizeof(MsgDobleKill), "~>~~>~ ~r~Muerte Espectacular ~<~~<~");
				GameTextForPlayer(killerid, MsgDobleKill, 500, 5);
				PlayAudioStreamForPlayer(killerid, "http://dl.dropbox.com/u/105709431/Overkill__Un_Frikin_Believable__wma.MP3");
			}
		}
		UpdateSpawnPlayer(playerid);
	    SetPlayerWeather(playerid, -45);
		PlayersData[playerid][DeahtCount]++;
		PlayersDataOnline[playerid][StateMoneyPass] 	= gettime() + 5;
		CleanDataDeath(playerid);
		SetPlayerScore(killerid, PlayersData[killerid][KilledCount]);
		GivePlayerMoneyEx(playerid, -100);
	}
	else
	{
		SendInfoMessage(killerid, 0, "076", "No se permite el TeamKill lea /TK.");
	}
	SendDeathMessage(killerid, playerid, reason);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if ( coches_Todos_Type[DataCars[vehicleid][Modelo] - 400] != TREN )
	{
			DestroyVehicle(vehicleid);
			CleanTunningSlots(vehicleid);
			CreateVehicleEx(DataCars[vehicleid][Modelo],
			DataCars[vehicleid][PosX],
			DataCars[vehicleid][PosY],
			DataCars[vehicleid][PosZ],
			DataCars[vehicleid][PosZZ],
			DataCars[vehicleid][Color1],
			DataCars[vehicleid][Color2],
			vehicleid
			);
			if ( DataCars[vehicleid][VehicleDeath] )
			{
				DataCars[vehicleid][VehicleDeath] = false;
				KillTimer(DataCars[vehicleid][TimerIdBug]);
			}
			GetVehicleHealth(vehicleid, DataCars[vehicleid][LastDamage]);
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	DataCars[vehicleid][VehicleDeath] = true;
	DataCars[vehicleid][TimerIdBug] = SetTimerEx("SetVehicleBugToRespawn", 10000, false, "d", vehicleid);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if (PlayersDataOnline[playerid][State] == 3 && PlayersDataOnline[playerid][IsNotSilenciado] )
	{
		SendChatStream(playerid, text);
	}
	else
	{
		SendInfoMessage(playerid, 0, "003", "Debe ingresar a el servidor antes de utilizar cualquier comando o ha sido silenciado.");
	}
	PlayersDataOnline[playerid][IsAFK] = false;
	return 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new LenGet = strlen(cmdtext);
	for ( new i = 0; i < LenGet; i++ )
	{
	    if ( cmdtext[i] == '}' || cmdtext[i] == '{' )
	    {
	        cmdtext[i] = ' ';
	    }
	}
	if (PlayersDataOnline[playerid][State] == 3 && PlayersDataOnline[playerid][IsNotSilenciado])
	{
 		if ( strlen(cmdtext) > 1 )
		{
		   	printf("%s[%i] || %s", PlayersDataOnline[playerid][NameOnline], playerid, cmdtext);
		    PlayersDataOnline[playerid][IsAFK] = false;

			// COMANDO: /Ayuda
		  	if (strcmp("/Ayuda", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6 ||
			    strcmp("/Help", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5)
		  	{
	    	    //Dialog de Ayuda
	    	    new MsgDialogAyuda[500];
	    	    format(MsgDialogAyuda, sizeof(MsgDialogAyuda),
				"{AFEBFF}/Créditos - /Gang - /Aceptar || /Accept - (/Reglas - /Rules)");
	    	    strcat(MsgDialogAyuda, "\n/Admins - /Chat - /Armas");
	    	    strcat(MsgDialogAyuda, "\n/Rangos /Skin");
	    	    strcat(MsgDialogAyuda, "\n/Caminar || /Walk - /Anims");
	    	    strcat(MsgDialogAyuda, "\n/Parar música || /Stop Music /Stats - /Explosivo - /Comprar || /Buy");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Centro de Ayuda || Help center", MsgDialogAyuda, "Ok", "");
		   	}
		    // COMANDO: /Gang
			else if (strcmp("/Gang", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5 )
			{
   				if ( PlayersData[playerid][Gang] != SINGANG )
   				{
		    	    if ( PlayersData[playerid][Rango] == 0 )
		    	    {
					    SendClientMessage(playerid, COLOR_TITULO_DE_AYUDA, TITULO_AYUDA);
					   	SendInfoMessage(playerid, 1, "/Expulsar [ID] || /Expel [ID]", "Gangs: ");
        				}
		    	    if ( PlayersData[playerid][Rango] <= 1 )
		    	    {
					   	SendInfoMessage(playerid, 1, "/Invit [ID] - /Rango [ID] [ID_RANGO]", "Gangs: ");
		    	    }
		    	    //////////////// YAKUZA
		    	    if(PlayersData[playerid][Gang] == YAKUZA)
		    	    {
					   	SendInfoMessage(playerid, 1, "/Salvar [ID] || /Heal [ID] - /Puerta (Abrir o cerrar) || /Door (Open or Close)", "Gangs: ");
		    	    }
		    	    //////////////// RUSOS
		    	    else if(PlayersData[playerid][Gang] == RUSOS)
		    	    {
					   	SendInfoMessage(playerid, 1, "/Salvar [ID] || /Heal [ID] - /Puerta (Abrir o cerrar) || /Door (Open or Close)", "Gangs: ");
		    	    }
		    	    //////////////// ITALIANOS
		    	    else if(PlayersData[playerid][Gang] == ITALIANOS)
		    	    {
					   	SendInfoMessage(playerid, 1, "/Salvar [ID] || /Heal [ID] - /Puerta (Abrir o cerrar) || /Door (Open or Close)", "Gangs: ");
		    	    }
		    	    //////////////// TRIADA
		    	    else if(PlayersData[playerid][Gang] == TRIADA)
		    	    {
					   	SendInfoMessage(playerid, 1, "/Salvar [ID] || /Heal [ID] - /Puerta (Abrir o cerrar) || /Door (Open or Close)", "Gangs: ");
		    	    }
				}
 				else
 				{
					SendInfoMessage(playerid, 0, "004", "Tu Gang no tiene comandos || Your gang dont have commands.");
			 	}
			}/*
		    	// COMANDO: /Ayuda Llaves
				else if (strcmp("/Ayuda Llaves", cmdtext, true, 13) == 0 && strlen(cmdtext) == 13)
			    {

		    	    new MsgDialogAyuda[500];
		    	    format(MsgDialogAyuda, sizeof(MsgDialogAyuda),
					"{AFEBFF}/Reglas - /Skin");
		    	    strcat(MsgDialogAyuda, "\n/Admins - /Ayuda Chat");
					ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Centro de Ayuda ", MsgDialogAyuda, "Ok", "");
		    	}*/
	  			// COMANDO: /Ayuda Aceptar
			else if (strcmp("/Aceptar", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8 ||
					 strcmp("/Accept", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7 )
			{
	    	    new MsgDialogAyuda[500];
	    	    format(MsgDialogAyuda, sizeof(MsgDialogAyuda),
				"{AFEBFF}/Aceptar Invite - /Accept Invite");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Aceptar || Accept ", MsgDialogAyuda, "Ok", "");
			}
  			// COMANDO: /Ayuda Chat
			else if (strcmp("/Chat", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5)
			{
	    	    new MsgDialogAyuda[500];
	    	    format(MsgDialogAyuda, sizeof(MsgDialogAyuda),
				"{AFEBFF}/T [General Chat] - /G [Gang]");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Chat || Chat help", MsgDialogAyuda, "Ok", "");
			}
  			// COMANDO: /Ayuda BOMBAS
			/*else if (strcmp("/Ayuda bombas", cmdtext, true, 13) == 0 && strlen(cmdtext) == 13)
			{
			    SendClientMessage(playerid, COLOR_TITULO_DE_AYUDA, TITULO_AYUDA);
			    SendInfoMessage(playerid, 1, "/Bombas - /Desactivar Bomba - /Ver Bomba - /Poner Bomba [Tipo] - /Detonar Todas", "Bombas: ");
			}*/
  			// COMANDO: /Ayuda PONER
			else if (strcmp("/Ayuda Poner", cmdtext, true, 12) == 0 && strlen(cmdtext) == 12)
			{
			    SendClientMessage(playerid, COLOR_TITULO_DE_AYUDA, TITULO_AYUDA);
			    SendInfoMessage(playerid, 1, "/Poner Bomba", "Poner: ");
			}
		    // COMANDO: /Ayuda Rangos
			else if (strcmp("/Rangos", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7)
		    {
		        if ( PlayersData[playerid][Gang] != SINGANG )
		        {
		    	    new MsgDialogRangos[500];
					for (new i = 0; i <= GetMaxGangRango(PlayersData[playerid][Gang]); i++)
					{
			    	    format(MsgDialogRangos, sizeof(MsgDialogRangos),
						"{AFEBFF}%i - %s", i + 1, GangesRangos[PlayersData[playerid][Gang]][i]);
					}
					ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Rangos", MsgDialogRangos, "Ok", "");
				}
				else
				{
					SendInfoMessage(playerid, 0, "005", "Tu Gang no tiene rangos || Your gang dont have Rangos.");
				}
		    }
		    // COMANDO: /Ayuda Animaciones
			else if (strcmp("/Anims", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
		    {
	    	    //Dialog de Ayuda
	    	    new MsgDialogAyuda[500];
	    	    format(MsgDialogAyuda, sizeof(MsgDialogAyuda),
				"{AFEBFF}/Miedo || /Afraid - /Borracho || /Drunk - /Mear || /Piss");
	    	    strcat(MsgDialogAyuda, "\n/Acostarse || /Sleep - /Sentarse || /Seat - /Bailar || /Dance");
	    	    strcat(MsgDialogAyuda, "\n/Fuck - /Fuck2 - /Gangster - /Apuntar - /Apuntar2");
	    	    strcat(MsgDialogAyuda, "\n/Rendirse - /Serio || /Serius - /Picazón - /Crack");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Anims ", MsgDialogAyuda, "Ok", "");
		    }
			// COMANDO: /Ayuda Admin
			else if (strcmp("/Ayuda Admin", cmdtext, true, 12) == 0 && strlen(cmdtext) == 12)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
	    	    new MsgDialogAdminAyuda[500];
				if (PlayersData[playerid][Admin] >= 1)
				{
		    	    format(MsgDialogAdminAyuda, sizeof(MsgDialogAdminAyuda),
					"{AFEBFF}Ayuda Admin 1: /Ir [ID] - /Traer [ID] - /Kick - /AdminOn - /Espectar - /Pos [ID]");
					if (PlayersData[playerid][Admin] >= 2)
					{
			    	    strcat(MsgDialogAdminAyuda, "{AFEBFF}\nAyuda Admin 2: /Spawn [ID] - /DesbugArma [ID]");
				   		if (PlayersData[playerid][Admin] >= 3)
						{
				    	    strcat(MsgDialogAdminAyuda, "{AFEBFF}\nAyuda Admin 3: /Matar [ID] - /Ban ");
					   	 	if (PlayersData[playerid][Admin] >= 4)
							{
					    	    strcat(MsgDialogAdminAyuda, "{AFEBFF}\nAyuda Admin 4: /IrC [ID Coche] ");
						   	   	if (PlayersData[playerid][Admin] >= 5)
								{
						    	    strcat(MsgDialogAdminAyuda, "{AFEBFF}\nAyuda Admin 5: /TraerC [ID Coche] - /Dinero");
							   		if (PlayersData[playerid][Admin] >= 6)
									{
							    	    strcat(MsgDialogAdminAyuda, "{AFEBFF}\nAyuda Admin 6: /Tele - /ActColor [ID] - /Decir [Texto] - /Say [Texto]");
								   	   	if (PlayersData[playerid][Admin] >= 7)
										{
								    	    strcat(MsgDialogAdminAyuda, "{AFEBFF}\nAyuda Admin 7: /Desactivar Bomba Todos - /GMX - /Desbanear - /Respawn - /BanEx");
									   	  	if (PlayersData[playerid][Admin] >= 8)
											{
									    	    strcat(MsgDialogAdminAyuda, "{AFEBFF}\nAyuda Admin 8: /Desactivar Bomba - /Bombas - /Ver Bomba - /Poner Bomba - /Gang [ID] [ID_Gang] [Rango]");
										   	  	if (PlayersData[playerid][Admin] >= 9)
												{
										    	    strcat(MsgDialogAdminAyuda, "{AFEBFF}\nAyuda Admin 9: /Staff [ID] [Nivel]");
												}
							      			}
						      			}
					      			}
				      			}
					   	   	}
				   	   	}
				   	}
					ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Admin ", MsgDialogAdminAyuda, "Ok", "");
 				}
				else
				{
					SendInfoMessage(playerid, 0, "006", "Tú no tienes acceso a el comando /Ayuda Admin.");
				}
			}
		    // COMANDO: /Creditos
			else if (strcmp("/Créditos", cmdtext, true, 9) == 0 && strlen(cmdtext) == 9||
		 			 strcmp("/Creditos", cmdtext, true, 9) == 0 && strlen(cmdtext) == 9)
		    {
	    	    //Dialog de Ayuda
	    	    new MsgDialogAyuda[500];
	    	    format(MsgDialogAyuda, sizeof(MsgDialogAyuda),
				"{4AFF00}Créditos %s:", GAMEMODE_VERSION);
	    	    strcat(MsgDialogAyuda, "\n{FF0000}Programador: {FFFFFF}Izaquita1");
	    	    strcat(MsgDialogAyuda, "\n{FF0000}Mappers: {FFFFFF}Lwis Tejada, Izaquita1");
	    	    strcat(MsgDialogAyuda, "\n{FF0000}Beta Tester: {FFFFFF}Camilo Daza");
	    	    strcat(MsgDialogAyuda, "\n{FF0000}Gamemode Base: {FFFFFF}ULP");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Créditos ", MsgDialogAyuda, "Ok", "");
		    }
		    // COMANDO: /Creditos
			else if (strcmp("/Armas", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
		    {
				ShowMenuForPlayer(Menu_Principal_Armas, playerid);
				PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
				TogglePlayerControllableEx(playerid, 0);
		    }
			// COMANDO: /Reglas
			else if(strcmp("/Reglas", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7)
		    {
	    	    //Dialog de Reglas
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}Reglas:  - {FF0000}NO {AFEBFF}se permite nada de lo siguiente:");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Reglas: /TK (TeamKill) - /CK (CarKill) - /DB (DriverBy)");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Reglas: /HK (HeliKill) - /AAA - (AutoAimAbuse) - /Flood (Flood)");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Reglas: /CJ (CarJacked) - /SK (SpawnKill)");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Otras: Hacks - Cheats - cBug ");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Otras: Aprovechamiento de cualquier otro bug.");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF} - Quebrantar alguna de éstas reglas tiene concecuencias Graves.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			// COMANDO: /Rules
			else if (strcmp("/Rules", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
		    {
	    	    //Dialog de Reglas
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}Rules:  - {FF0000}DO NOT {AFEBFF}do anything of this:");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Rules: /TK (TeamKill) - /CK (CarKill) - /DB (DriverBy)");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Rules: /HK (HeliKill) - /AAA - (AutoAimAbuse) - /Flood (Flood)");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Rules: /CJ (CarJacked) - /SK (SpawnKill)");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Rules: Hacks - Cheats - cBug ");
	    	    strcat(MsgDialogReglas, "\n{AFEBFF}Rules: If you abuse of a bug, you will be banned.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Rules ", MsgDialogReglas, "Ok", "");
		    }
			else if (strcmp("/TK", cmdtext, true, 3) == 0 && strlen(cmdtext) == 3)
		    {
	    	    //Dialog de Reglas
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}TeamKill: Matar a miembros del mismo equipo para beneficio de otros equipos o del mismo jugador.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			else if (strcmp("/CK", cmdtext, true, 3) == 0 && strlen(cmdtext) == 3)
		    {
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}CarKill: Matar a un usuario atropellandolo o dejando el auto encima de él.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			else if (strcmp("/DB", cmdtext, true, 3) == 0 && strlen(cmdtext) == 3)
		    {
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}DriveBy: Disparar estando dentro de un auto en el asiento del jugador.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			else if (strcmp("/HK", cmdtext, true, 3) == 0 && strlen(cmdtext) == 3)
		    {

	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}HeliKill: Matar a uno o más usuarios con el helicóptero o sus helices.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			else if (strcmp("/AAA", cmdtext, true, 4) == 0 && strlen(cmdtext) == 4)
		    {
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}AutoAimAbuse: Abusar de la mira automática del GTA SA.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			else if (strcmp("/Flood", cmdtext, true, 6) == 0 && strlen(cmdtext) == 4)
		    {
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}Flood: Repetir una o varias palabras más de tres veces.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			else if (strcmp("/CJ", cmdtext, true, 3) == 0 && strlen(cmdtext) == 3)
		    {
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}CarJacked: Robar un auto mientras otro user lo maneja o está en el asiento del conductor.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			else if (strcmp("/SK", cmdtext, true, 3) == 0 && strlen(cmdtext) == 3)
		    {
	    	    new MsgDialogReglas[500];
	    	    format(MsgDialogReglas, sizeof(MsgDialogReglas),
				"{AFEBFF}SpawnKill: Matar en la zona de Spawn de una Gang.");
				ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Ayuda Reglas ", MsgDialogReglas, "Ok", "");
		    }
			// COMANDO: /Rendirse
			else if (strcmp("/Rendirse", cmdtext, true, 9) == 0 && strlen(cmdtext) == 9)
   			{
				ApplyPlayerAnimCustom(playerid,
				"ROB_BANK",
				ROB_ANIMATIONS[4], false);
			}
			// COMANDO: /Apuntar
			else if (strcmp("/Apuntar", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8)
			{
				ApplyPlayerAnimCustom(playerid,
				"PED",
				PED_ANIMATIONS[150], false);
			}
			// COMANDO: /Apuntar2
			else if (strcmp("/Apuntar2", cmdtext, true, 9) == 0 && strlen(cmdtext) == 9)
			{
				ApplyPlayerAnimCustom(playerid,
				"TEC",
				TEC_ANIMATIONS[3], false);
			}
			// COMANDO: /Miedo
			else if (strcmp("/Miedo", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6 ||
		  			 strcmp("/Afraid", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7)
			{
				ApplyPlayerAnimCustom(playerid,
				"PED",
				PED_ANIMATIONS[71], false);
			 }
			// COMANDO: /Borracho
			else if (strcmp("/Borracho", cmdtext, true, 9) == 0 && strlen(cmdtext) == 9 ||
					 strcmp("/Drunk", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
			{
				ApplyPlayerAnimCustom(playerid,
				"PED",
				PED_ANIMATIONS[257], true);
			 }
			// COMANDO: /Sentarse
			else if (strcmp("/Sentarse", cmdtext, true, 9) == 0 && strlen(cmdtext) == 9 ||
					 strcmp("/Seat", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5)
			{
				ApplyPlayerAnimCustom(playerid,
				"BEACH",
				PLAYA_ANIMATIONS[2], false);
			}
			// COMANDO: /Acostarse
			else if (strcmp("/Acostarse", cmdtext, true, 10) == 0 && strlen(cmdtext) == 10 ||
					 strcmp("/Sleep", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
			{
				ApplyPlayerAnimCustom(playerid,
				"BEACH",
				PLAYA_ANIMATIONS[0], false);
			}
			// COMANDO: /Crack
			else if (strcmp("/Crack", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
			{
				ApplyPlayerAnimCustom(playerid,
				"CRACK",
				CRACK_ANIMATIONS[3], false);
			}
			// COMANDO: /Fuck
			else if (strcmp("/Fuck", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5)
			{
				ApplyPlayerAnimCustom(playerid,
				"PED",
				PED_ANIMATIONS[149], false);
			}
			// COMANDO: /Fuck
			else if (strcmp("/Fuck2", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
			{
				ApplyPlayerAnimCustom(playerid,
				"RIOT",
				RIOT_ANIMATIONS[4], false);
			}
			// COMANDO: /Picazón
			else if (strcmp("/Picazon", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8 ||
		 			 strcmp("/Picazón", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8)
			{
				ApplyPlayerAnimCustom(playerid,
				"MISC",
				MISC_ANIMATIONS[34], false);
			}
			// COMANDO: /sERIO
			else if (strcmp("/Serio", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6 ||
					 strcmp("/Serius", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7)
			{
				ApplyPlayerAnimCustom(playerid,
				"OTB",
				OTB_ANIMATIONS[6], false);
			}
			// COMANDO: /Picazón
			else if (strcmp("/Gangster", cmdtext, true, 9) == 0 && strlen(cmdtext) == 9)
			{
				ApplyPlayerAnimCustom(playerid,
				"RIOT",
				RIOT_ANIMATIONS[0], false);
			}
			// /Bailar [ID]
	  		else if (strfind(cmdtext, "/Bailar ", true) == 0||
  					 strfind(cmdtext, "/Dance ", true) == 0)
			{
			    new IDDance[3];
				strmid(IDDance, cmdtext, 8, strlen(cmdtext), sizeof(IDDance));
				if ( strval(IDDance) >= 1 && strval(IDDance) <=4 )
				{
					SetPlayerSpecialAction(playerid, strval(IDDance) + 4);
					PlayersDataOnline[playerid][InAnim] = true;
				}
				else
				{
					SendInfoMessage(playerid, 0, "008", "El ID a bailar tiene que estar comprendida entre 1 y 4.");
				}
			}
			else if (strcmp("/Explosivo", cmdtext, true, 10) == 0 && strlen(cmdtext) == 10)
			{
			    if(PlayersData[playerid][Minas] <= 0)
				{
					SendInfoMessage(playerid, 0, "008", "No tienes explosivos usa /Comprar");
				}
				else
				if(ModeMina[playerid] == false)
			    {
					ModeMina[playerid] = true;
					SendInfoMessage(playerid, 2, "0", "Modo Explosivos Activado.");
					PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
				}
				else
				{
				    ModeMina[playerid] = false;
					SendInfoMessage(playerid, 2, "0", "Modo Explosivos desactivado.");
					PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
				}
				return 1;
			}
			else if (strcmp("/Comprar", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8)
			{
			    ShowPlayerDialogEx(playerid, 17, DIALOG_STYLE_LIST, "{FF0000}[SGW] Comprar Explosivos", "Explosivos-Sniper", "Comprar", "Salir");
			    PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
				return 1;
			}
			// COMANDO: /Salvar
			else if (strfind(cmdtext, "/Salvar ", true) == 0)
			{
				new Float:Vida1;
				GetPlayerHealth(strval(cmdtext[7]), Vida1);
				if ( PlayersData[playerid][Gang] == YAKUZA && PlayersData[strval(cmdtext[7])][Gang] == YAKUZA ||
					 PlayersData[playerid][Gang] == RUSOS && PlayersData[strval(cmdtext[7])][Gang] == RUSOS ||
					 PlayersData[playerid][Gang] == ITALIANOS && PlayersData[strval(cmdtext[7])][Gang] == ITALIANOS ||
					 PlayersData[playerid][Gang] == TRIADA && PlayersData[strval(cmdtext[7])][Gang] == TRIADA)
			    {
				    if ( IsPlayerNear(playerid, strval(cmdtext[7]),
						 "414",
						 "415",
						 "416",
						 "El jugador que le deseas curar no se encuentra conectado",
						 "El jugador que le deseas curar no se ha logueado",
						 "El jugador que le deseas curar no se encuentra cerca de tí") )
				    {
						if ( Vida1 <= VIDA_CRACK )
						{
							ApplyPlayerAnimCustom(playerid,
							"MEDIC",
							MEDIC_ANIMATIONS[0], false);
							ApplyPlayerAnimCustom(playerid,
							"MEDIC",
							MEDIC_ANIMATIONS[0], false);
					        new MsgCurarIntentar[MAX_TEXT_CHAT];
					        format(MsgCurarIntentar, sizeof(MsgCurarIntentar), "salvar a %s", PlayersDataOnline[strval(cmdtext[7])][NameOnline]);
    						if (IntentarAccion(playerid, MsgCurarIntentar, random(3)))
    						{
								SetPlayerHealthEx(strval(cmdtext[7]), 50);
								ApplyAnimation(strval(cmdtext[7]),"PED",PED_ANIMATIONS[ModeWalkID[PlayersData[playerid][MyStyleWalk]]], 4.0, 0, 1, 1, 0, 1, 1);
 							}
						}
						else
						{
							SendInfoMessage(playerid, 0, "417", "Este jugador no necesitan que lo curen");
						}
				    }
		        }
		        else
		        {
					SendInfoMessage(playerid, 0, "418", "El jugador no pertenece a su Gang ó no tienes Gang.");
				}
			}
			// COMANDO: /Mear
			else if (strcmp("/Mear", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5)
	  		{
				SetPlayerSpecialAction(playerid, 68);
				PlayersDataOnline[playerid][InAnim] = true;
			}
			// COMANDO: /Sonido1 test
		    // Testing Commands
			// /play [soundid]
			else if (strfind(cmdtext, "/play ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if ( PlayersData[playerid][Admin] >= 7 )
				{
				    new soundidPlay = strval(cmdtext[GetPosSpace(cmdtext, 1)]);
                    PlayerPlaySound(playerid, soundidPlay,0.0,0.0,0.0);
			    }
		        else
		        {
					SendInfoMessage(playerid, 0, "418", "No tienes acceso al comando /Play");
				}
			}
			else if (strfind(cmdtext, "/Decir ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if ( PlayersData[playerid][Admin] >= 6 )
				{
					for( new todos; todos < MAX_PLAYERS; todos++ )
					{
	                    new Texto[MAX_TEXT_CHAT];
	                    format(Texto, sizeof(Texto), "http://translate.google.com/translate_tts?tl=es&q=%s", cmdtext[7]);
						PlayAudioStreamForPlayer( todos, Texto);
					}
			    }
		        else
		        {
					SendInfoMessage(playerid, 0, "418", "No tienes acceso al comando /Decir");
				}
			}
			else if (strfind(cmdtext, "/Say ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if ( PlayersData[playerid][Admin] >= 6 )
				{
					for( new todos; todos < MAX_PLAYERS; todos++ )
					{
	                    new Texto[MAX_TEXT_CHAT];
	                    format(Texto, sizeof(Texto), "http://translate.google.com/translate_tts?tl=en&q=%s", cmdtext[5]);
						PlayAudioStreamForPlayer( todos, Texto);
					}
			    }
		        else
		        {
					SendInfoMessage(playerid, 0, "418", "No tienes acceso al comando /Say");
				}
			}
			else if (strfind(cmdtext, "/Pos ", true) == 0)
            {
                MsgAdminUseCommands(9, playerid, cmdtext);
                if ( PlayersData[playerid][Admin] >= 1 )
                {
                    new Float:x, Float:y, Float:z;
                    GetPlayerPos(strval(cmdtext[4]), x, y, z);
                    new MsgAvisoCheat[MAX_TEXT_CHAT];
                    format(MsgAvisoCheat, sizeof(MsgAvisoCheat), "%s (%s)[%i], Posición actual jugador: {99A4AA}Coord( x: %f | y: %f | z: %f)", LOGO_STAFF, PlayersDataOnline[strval(cmdtext[4])][NameOnline], strval(cmdtext[4]), x, y, z);
                    MsgCheatsReportsToAdmins(MsgAvisoCheat);
                }
		        else
		        {
					SendInfoMessage(playerid, 0, "418", "No tienes acceso al comando /Pos");
				}
            }
			// COMANDO: /Stats
  			else if (strcmp("/Stats", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
	    	{
	    	    GetPlayerStats(playerid, playerid);
			}
			// COMANDO: /Sonido4 test
			else if (strcmp("/RadioT", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7)
	  		{
				for( new todos; todos < MAX_PLAYERS; todos++ )
				{
				    PlayAudioStreamForPlayer( todos, "http://sc9.mystreamserver.com:8030/listen.pls" );
				}
			}            // COMANDO: /Sonido4 test
            else if (strcmp("/Tuto1", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
              {
                for( new todos; todos < MAX_PLAYERS; todos++ )
                {
                    PlayAudioStreamForPlayer( todos, "http://goo.gl/lZ4QE" );
                }
            }
            // COMANDO: /Sonido4 test
            else if (strcmp("/Tuto2", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
              {
                for( new todos; todos < MAX_PLAYERS; todos++ )
                {
                    PlayAudioStreamForPlayer( todos, "http://goo.gl/lZPJg" );
                }
            }
            // COMANDO: /Sonido4 test
            else if (strcmp("/Tuto3", cmdtext, true, 6) == 0 && strlen(cmdtext) == 6)
              {
                for( new todos; todos < MAX_PLAYERS; todos++ )
                {
                    PlayAudioStreamForPlayer( todos, "http://goo.gl/DbMZy" );
                }
            }
			else if (strcmp("/Gangnam", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8)
	  		{
				for( new todos; todos < MAX_PLAYERS; todos++ )
				{
				    PlayAudioStreamForPlayer( todos, "http://dl.dropbox.com/u/105709431/GangStylexD.mp3" );
				}
			}
			// COMANDO: /Sonido4 test
			else if (strcmp("/Stop", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5)
	  		{
				for( new todos; todos < MAX_PLAYERS; todos++ )
				{
				    StopAudioStreamForPlayer(todos);
				}
			}
			// COMANDO: /HTTP
			else if (strcmp("/HTTP", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5)
	  		{
		        HTTP(playerid, HTTP_GET, "streetgangwars.co.cc/Test/Test.html", "", "MyHttpResponse");
		        return 1;
			}
			// Parar música User
			else if (strcmp("/Parar musica", cmdtext, true, 13) == 0 && strlen(cmdtext) == 13 ||
					 strcmp("/Parar música", cmdtext, true, 13) == 0 && strlen(cmdtext) == 13)
	  		{
	    		StopAudioStreamForPlayer(playerid);
			}
		//			/IrC [ID]					- Ir a un Coche
			else if (strfind(cmdtext, "/IrC ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 4)
				{
				    if (strval(cmdtext[5]) >= 1 && strval(cmdtext[5]) <= MAX_CAR )
				    {
					    new Float:VehiclePoss[3];GetVehiclePos(strval(cmdtext[5]), VehiclePoss[0], VehiclePoss[1], VehiclePoss[2]);
					    SetPlayerPos(playerid,  VehiclePoss[0], VehiclePoss[1], VehiclePoss[2] + 2);
					    SetPlayerInteriorEx(playerid, DataCars[strval(cmdtext[5])][InteriorLast]);
					    SetPlayerVirtualWorldEx(playerid, DataCars[strval(cmdtext[5])][WorldLast]);
						return 1;
					}
					else
					{
						SendInfoMessage(playerid, 0, "553", "El ID el vehículo introducído no existe.");
				        return 1;
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "891", "Tú no tienes acceso a el comando /IrC.");
			        return 1;
				}
			}
		//			/TraerC [ID]					- Traer un coche
			else if (strfind(cmdtext, "/TraerC ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 5)
				{
					if (strval(cmdtext[8]) > 0 && strval(cmdtext[8]) <= MAX_CAR_PUBLIC)
					{
						new Float:MyPoss[3];GetPlayerPos(playerid, MyPoss[0], MyPoss[1], MyPoss[2]);
						SetVehiclePos(strval(cmdtext[8]),  MyPoss[0] + 3, MyPoss[1], MyPoss[2]);
						LinkVehicleToInteriorEx(strval(cmdtext[8]), GetPlayerInteriorEx(playerid));
						SetVehicleVirtualWorldEx(strval(cmdtext[8]), GetPlayerVirtualWorld(playerid));
					}
					else
					{
						SendInfoMessage(playerid, 0, "1447", "El vehículo que desea traer no existe.");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "189", "Tú no tienes acceso a el comando /TraerC.");
			        return 1;
				}
			}
		// //Reiniciar
			else if (strcmp("/GMX", cmdtext, true, 4) == 0 && strlen(cmdtext) == 4)
	  		{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 7)
				{
	    			ShowPlayerDialogEx(playerid, 6, DIALOG_STYLE_INPUT, "{FF0000}[SGW] Reiniciar servidor", "Diga la razón del reinicio.", "Reiniciar", "Cancelar");
				}
				else
				{
				SendInfoMessage(playerid, 0, "077", "No tienes acceso a éste comando.");
				}
	  		}
		//		19-	*		/Respawn Todos					- Respawear todos los coches
			else if (strcmp("/Respawn", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 7)
				{
					Comandos_Admin(7, playerid, 0, PlayersData[playerid][Admin], 0, "0");
					return 1;
				}
				else
				{
					SendInfoMessage(playerid, 0, "188", "Tú no tienes acceso a el comando /Respawn Todos.");
			        return 1;
				}
			}
			// COMANDO: /Llaves
			else if (strfind(cmdtext, "/Llaves ", true) == 0)
			{
				// COMANDO: /Llaves Coche
			  	if (strcmp("/Llaves Coche", cmdtext, true, 13) == 0 && strlen(cmdtext) == 13)
			   	{
					LockVehicle(playerid);
			   	}
			   	else
			   	{
					SendInfoMessage(playerid, 0, "288", "Quizás quiso decir: /Llaves Coche");
				}
			}
		//		3- *       /Matar [ID]         - Matar a un jugador
			else if (strfind(cmdtext, "/Matar ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 3)
				{
					new ID_JugadorAMatar[11];
					strmid(ID_JugadorAMatar, cmdtext, 7, strlen(cmdtext), sizeof(ID_JugadorAMatar));
					if (IsPlayerConnected(strval(ID_JugadorAMatar)))
					{
					    Comandos_Admin(3, playerid, strval(ID_JugadorAMatar), PlayersData[playerid][Admin], 0, "0");
						return 1;
					}
					else
					{
						SendInfoMessage(playerid, 0, "183", "El jugador que desea matarlo no se encuentra conectado.");
						return 1;
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "184", "Tú no tienes acceso a el comando /Matar.");
			        return 1;
				}
			}
		//	       /Spawn [ID]         - Spawnear a un Jugador
			else if (strfind(cmdtext, "/Spawn ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 2)
				{
				    new PlayreSpawn = strval(cmdtext[7]);
					if (IsPlayerConnected(PlayreSpawn))
					{
						if ( IsPlayerInAnyVehicle(PlayreSpawn) )
						{
							PlayersDataOnline[PlayreSpawn][StateMoneyPass] 	= gettime() + 5;
							PlayersDataOnline[PlayreSpawn][VidaOn] = 100.0;
							new Float:PlayerPos[3]; GetPlayerPos(PlayreSpawn, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
							SetPlayerPos(PlayreSpawn, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
						}
						PlayersDataOnline[PlayreSpawn][StateDeath] = 3;
					    SpawnPlayerEx(PlayreSpawn);
					    SetPlayerInteriorEx(PlayreSpawn, 0);
					    SetPlayerVirtualWorldEx(PlayreSpawn, 0);
						CleanDataDeath(PlayreSpawn);
						new StringFormat[MAX_TEXT_CHAT];
						new StringFormatEX[MAX_TEXT_CHAT];
						if ( PlayreSpawn != playerid)
						{
							format(StringFormat, sizeof(StringFormat), "%s Te ha spawneado %s con el comando /Spawn [ID].",LOGO_STAFF, PlayersDataOnline[playerid][NameOnline]);
							format(StringFormatEX, sizeof(StringFormatEX), "%s Has spawneado a %s [%i] con el comando /Spawn [ID].",LOGO_STAFF, PlayersDataOnline[PlayreSpawn][NameOnline], PlayreSpawn);
				            SendClientMessage(PlayreSpawn, COLOR_MENSAJES_DE_AVISOS, StringFormat);
						}
						else
						{
							format(StringFormatEX, sizeof(StringFormatEX), "%s Te has spawneado tú mismo con el comando /Spawn [ID].",LOGO_STAFF);
						}
			            SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormatEX);
						return 1;
					}
					else
					{
						SendInfoMessage(playerid, 0, "1317", "El jugador que desea spawnearlo no se encuentra conectado.");
						return 1;
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "1431", "Tú no tienes acceso a el comando /Spawn.");
			        return 1;
				}
			}
		//	2- *		/Ir [ID]						- Ir a la poición de un jugador
			else if (strfind(cmdtext, "/Ir ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 1)
				{
				    new SendString[4];
					strmid(SendString, cmdtext, 4, strlen(cmdtext), sizeof(SendString));
					
					if (IsPlayerConnected(strval(SendString)))
					{
						if (strval(SendString) != playerid)
						{
							Comandos_Admin(2, playerid, strval(SendString), PlayersData[playerid][Admin], 0, "0");
						}
						else
						{
							SendInfoMessage(playerid, 0, "073", "La ID que has introducído es la suya.");
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "074", "El jugador al que desea ir no se encuentra conectado.");
					}
					return 1;
				}
				else
				{
					SendInfoMessage(playerid, 0, "075", "Tú no tienes acceso a el comando /Ir.");
			    	return 1;
				}
			}
			//		4-	*		/Traer [ID]						- Traer un jugador a tu posición
			else if (strfind(cmdtext, "/Traer ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 1)
				{
				    new SendString[4];
					strmid(SendString, cmdtext, 7, strlen(cmdtext), sizeof(SendString));
					if (IsPlayerConnected(strval(SendString)))
					{
						if (strval(SendString) != playerid)
						{
							Comandos_Admin(4, playerid, strval(SendString), PlayersData[playerid][Admin], 0, "0");
						}
						else
						{
							SendInfoMessage(playerid, 0, "172", "La ID que has introducído es la suya.");
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "173", "El jugador que desea traer no se encuentra conectado.");
					}
					return 1;
				}
				else
				{
					SendInfoMessage(playerid, 0, "174", "Tú no tienes acceso a el comando /Traer");
			        return 1;
				}
			}
			//////////--- /Desbanear [Nombre_Del_Jugador]              - Desbanear a un jugador
			else if (strfind(cmdtext, "/Desbanear ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if ( PlayersData[playerid][Admin] >= 7 )
				{
				    if ( strlen(cmdtext[11]) >= 3 && strlen(cmdtext[11]) <= 24)
				    {
						UnBanUser(playerid, cmdtext[11], false);
					}
			        else
			        {
						SendInfoMessage(playerid, 0, "675", "El nombre tiene que contener entre 3 y 24 caracteres");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "674", "No tienes acceso al comando /Desbanear");
				}
			}
			//////////--- /BanEx [Nombre_Del_Jugador]              - Banear a un jugador offline
			else if (strfind(cmdtext, "/BanEx ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if ( PlayersData[playerid][Admin] >= 7 )
				{
				    if ( strlen(cmdtext[7]) >= 3 && strlen(cmdtext[7]) <= 24)
				    {
						UnBanUser(playerid, cmdtext[7], true);
					}
			        else
			        {
						SendInfoMessage(playerid, 0, "973", "El nombre tiene que contener entre 3 y 24 caracteres");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "974", "No tienes acceso al comando /BanEx");
				}
			}
			//		05-	*		/Ban [ID] [Razón]				- Banear a un jugador
			else if (strfind(cmdtext, "/Ban ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 3)
				{
			        new PlayerIDBan = strvalEx(cmdtext[GetPosSpace(cmdtext, 1)]);
					if (strlen(cmdtext) >= 9)
					{
						if (PlayerIDBan != playerid)
						{
							if (IsPlayerConnected(PlayerIDBan) && PlayersData[PlayerIDBan][Admin] != 9)
							{
							    Comandos_Admin(5, playerid, PlayerIDBan, PlayersData[playerid][Admin], 0, cmdtext[GetPosSpace(cmdtext, 2)]);
	       						return 1;
							}
							else
							{
								SendInfoMessage(playerid, 0, "166", "El jugador que desea banear no se encuentra conectado.");
								return 1;
							}
						}
						else
						{
							SendInfoMessage(playerid, 0, "167", "La ID que has introducído es la suya.");
		                    return 1;
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "168", "Ha introducído mal el sintaxis del comando /Ban. Ejemplo correcto: /Ban 22 No respetar las normas el servidor.");
						return 1;
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "169", "Tú no tienes acceso a el comando /Ban.");
			        return 1;
				}
			}
			//		06-	*		/Kick [ID] [Razón]				- Kikear a un jugador
			else if (strfind(cmdtext, "/Kick ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 1)
				{
					new PlayerKickID = strvalEx(cmdtext[GetPosSpace(cmdtext, 1)]);
					if (strlen(cmdtext) >= 8 )
					{
						if (PlayerKickID != playerid)
						{
							if (IsPlayerConnected(PlayerKickID))
							{
							    Comandos_Admin(6, playerid, PlayerKickID, PlayersData[playerid][Admin], 0, cmdtext[GetPosSpace(cmdtext, 2)]);
								return 1;
							}
							else
							{
								SendInfoMessage(playerid, 0, "162", "El jugador que desea kikear no se encuentra conectado.");
								return 1;
							}
						}
						else
						{
							SendInfoMessage(playerid, 0, "163", "La ID que has introducído es la suya.");
		                    return 1;
						}
						}
					else
					{
						SendInfoMessage(playerid, 0, "164", "Ha introducído mal el sintaxis del comando /Kick. Ejemplo correcto: /Kick 22 No respetar las normas el servidor.");
						return 1;
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "165", "Tú no tienes acceso a el comando /Kick.");
			        return 1;
				}
			}
		//		08-	*		/Espectar [ID]					- Espectar a un jugador
			else if (strfind(cmdtext, "/Espectar", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 1)
				{
					if (strlen(cmdtext) == 9)
					{
					    Comandos_Admin(8, playerid, false, PlayersData[playerid][Admin], 2, "0");
					}
					else if (IsPlayerConnected(strval(cmdtext[10])))
					{
					    if ( strval(cmdtext[10]) != playerid )
					    {
					        if ( PlayersDataOnline[strval(cmdtext[10])][StateDeath] != 2 )
					        {
								Comandos_Admin(8, playerid, strval(cmdtext[10]), PlayersData[playerid][Admin], 1, "0");
 							}
							else
							{
								SendInfoMessage(playerid, 0, "1151", "El jugador que desea espectar se encuentra muerto en estos momentos, intentelo de nuevo en unos segundos.");
							}
						}
						else
						{
							SendInfoMessage(playerid, 0, "1150", "Has introducido tu misma ID a espectar.");
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "155", "El jugador que desea espectar no se encuentra conectado.");
					}
					return 1;
				}
				else
				{
					SendInfoMessage(playerid, 0, "156", "Tú no tienes acceso a el comando /Espectar.");
			        return 1;
				}
			}
			// COMANDO: /PAGAR Y /PAY
			else if (strfind(cmdtext, "/Dinero", true) == 0 || strfind(cmdtext, "/Money", true) == 0)
			{
				if (strfind(cmdtext, "/Dinero ", true) == 0 || strfind(cmdtext, "/Money ", true) == 0)
				{
				    new playeridpagar = strval(cmdtext[GetPosSpace(cmdtext, 1)]);
				    new Dineropagar = strval(cmdtext[GetPosSpace(cmdtext, 2)]);
					if (IsPlayerConnected(playeridpagar))
					{
					    if (PlayersData[playerid][Admin] >= 5)
					    {
							new Mensaje_Pagar[81];
							new Mensaje_PagarME[70];

							// FORMATEO DEL MENSAJE MENSAJES
							format(Mensaje_Pagar, sizeof(Mensaje_Pagar),
							"Has recibido $%i de el jugador %s."
							, Dineropagar, PlayersDataOnline[playerid][NameOnline]);
							format(Mensaje_PagarME, sizeof(Mensaje_PagarME),
							"Le has dado $%i a el jugador %s."
							,Dineropagar, PlayersDataOnline[playeridpagar][NameOnline]);

							// ENVIO DEL MENSAJE
							SendInfoMessage(playeridpagar, 3, "0", Mensaje_Pagar);
							SendInfoMessage(playerid, 3, "0", Mensaje_PagarME);
							// PAGO
		            		GivePlayerMoneyEx(playeridpagar, Dineropagar);
		            		return 1;
						}
						else
						{
							SendInfoMessage(playerid, 0, "245", "No tienes acceso a este comando o no eres Admin.");
							return 1;
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "247", "El jugador que desea pagarle no se encuentra conectado.");
				       	return 1;
				    }
			    }
			    else
			    {
					SendInfoMessage(playerid, 0, "249", "Uso correcto es /Dinero [ID] [CANTIDAD]");
					return 1;
			    }
			}
			// COMANDO: /Llaves Puerta
		  	else if (strcmp("/Puerta", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7)
	    	{
		    	GetMyNearDoor(playerid, false, false);
			}
			// COMANDO: /Caminar
			else if (strcmp("/Caminar", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8||
					 strcmp("/Walk", cmdtext, true, 5) == 0 && strlen(cmdtext) == 5)
	  		{
				ShowPlayerMenuSelectWalk(playerid);
	  		}
			// COMANDO: /Aceptar
			else if (strfind(cmdtext, "/Aceptar", true) == 0)
			{
				// COMANDO: /Aceptar Invite
			  	if (strcmp("/Aceptar Invite", cmdtext, true, 15) == 0 && strlen(cmdtext) == 15)
			   	{
			   	    if ( PlayersDataOnline[playerid][InviteGang] != 0 )
			   	    {
					    if ( IsPlayerNear(playerid, PlayersDataOnline[playerid][InvitePlayer],
							 "027",
							 "028",
							 "029",
							 "El líder que te invito se ha desconectado",
							 "El líder que te invito no se encuentra logueado",
							 "Te separaste mucho del líder que te invito, intentele de nuevo") )
					    {
	                        PlayersData[playerid][Gang] = PlayersDataOnline[playerid][InviteGang];
	                        PlayersData[playerid][Rango]   = GetMaxGangRango(PlayersDataOnline[playerid][InviteGang]);
							new MsgAcceptUser[MAX_TEXT_CHAT]; format(MsgAcceptUser, sizeof(MsgAcceptUser), "Metíste a tu Gang a %s.", PlayersDataOnline[playerid][NameOnline]);
							new MsgAcceptMe[MAX_TEXT_CHAT]; format(MsgAcceptMe, sizeof(MsgAcceptMe), "Bienvenido a la Gang \"%s\"!", GangData[PlayersDataOnline[playerid][InviteGang]][NameGang]);
	                        SendInfoMessage(PlayersDataOnline[playerid][InvitePlayer], 3, "0", MsgAcceptUser);
                            SendInfoMessage(playerid, 3, "0", MsgAcceptMe);
                            UpdateSpawnPlayer(playerid);
  						   	PlayersDataOnline[playerid][InvitePlayer]  = 0;
							PlayersDataOnline[playerid][InviteGang] = 0;
							SetPlayerSelectedTypeSkin(playerid, true);
//							SetPlayerLockAllVehicles(playerid);
							SetPlayerColorEx(playerid);
							SetPlayerTeamEx(playerid);
						}
						else
						{
						   	PlayersDataOnline[playerid][InvitePlayer]  = 0;
							PlayersDataOnline[playerid][InviteGang] = 0;
							SetPlayerColorEx(playerid);
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "023", "No has recibido ningún invite");
					}
		    	}
		    	else
				{
					SendInfoMessage(playerid, 0, "024", "Quizás quiso decir: /Aceptar Invite");
				}
			}
		//			/ActColor [ID]                  - Actualizar color de un user
			else if (strfind(cmdtext, "/ActColor ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 6)
				{
				    new playerColor[5];
				    strmid(playerColor, cmdtext, 6, strlen(cmdtext), sizeof(playerColor));
					if ( IsPlayerConnected(strval(playerColor)) )
					{
                        SetPlayerColorEx(strval(playerColor));
					}
					else
					{
						SendInfoMessage(playerid, 0, "202", "El jugador no se encuentra conectado.");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "203", "Tú no tienes acceso a el comando /ActColor.");
			        return 1;
				}
			}
			    // /Tele
			else if (strfind(cmdtext, "/Tele ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if ( PlayersData[playerid][Admin] >= 6 )
				{
				    new InteriorID = strval(cmdtext[GetPosSpace(cmdtext, 1)]);
				    if ( InteriorID >= 0 && InteriorID <= 19 )
				    {
					    new Float:X = floatstr(cmdtext[GetPosSpace(cmdtext, 2)]);
					    new Float:Y = floatstr(cmdtext[GetPosSpace(cmdtext, 3)]);
					    new Float:Z = floatstr(cmdtext[GetPosSpace(cmdtext, 4)]);
					    SetPlayerInteriorEx(playerid, InteriorID);
					    SetPlayerPos(playerid, X, Y, Z);
					    new MsgPos[MAX_TEXT_CHAT];
					    format(MsgPos, sizeof(MsgPos), "%s Has ido a la posición %f - %f - %f con interior [%i]", LOGO_STAFF, X, Y, Z, InteriorID);
						SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, MsgPos);
					}
					else
					{
						SendInfoMessage(playerid, 0, "1119", "El número del interior tiene que ser mayor de 0 y menor de 19");
					}
		    	}
				else
				{
					SendInfoMessage(playerid, 0, "1118", "No tienes acceso al comando /Tele");
				}
			}
			
			// COMANDO: /Gang [ID] [ID_GANG] [Rango]
	  		else if (strfind(cmdtext, "/Gang ", true) == 0 )
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				SetPlayerGang(playerid, cmdtext);
			}
			// COMANDO: /Rango [ID] [ID_Rango]
			else if (strfind(cmdtext, "/Rango ", true) == 0)
			{
			    if ( PlayersData[playerid][Gang] != SINGANG && PlayersData[playerid][Rango] <= 1 )
			    {
					new idTochange = strval(cmdtext[GetPosSpace(cmdtext, 1)]);
					new RangoID 	=  strval(cmdtext[GetPosSpace(cmdtext, 2)]);
					if ( strlen(cmdtext) > 3 )
					{
					    if ( IsPlayerNear(playerid, idTochange,
							 "033",
							 "034",
							 "035",
							 "El jugador que desea dar rango no se encuentra conectado",
							 "El jugador que desea dar rango no se encuentra logueado",
							 "El jugador que desea dar rango no se encuentra cerca de tí") )
					    {
							if ( PlayersData[idTochange][Gang] == PlayersData[playerid][Gang] )
							{
							    if ( RangoID >= 1 && RangoID <= GetMaxGangRango(PlayersData[playerid][Gang]) )
							    {
							        if ( RangoID != PlayersData[idTochange][Rango] )
							        {
			                            PlayersData[idTochange][Rango]   = RangoID;
										new MsgRangoUser[MAX_TEXT_CHAT]; format(MsgRangoUser, sizeof(MsgRangoUser), "Has asignado el rango \"%s\" a %s", GangesRangos[PlayersData[playerid][Gang]][RangoID],PlayersDataOnline[idTochange][NameOnline]);
										new MsgRangoMe[MAX_TEXT_CHAT]; format(MsgRangoMe, sizeof(MsgRangoMe), "%s te ha asignado el rango \"%s\"", PlayersDataOnline[playerid][NameOnline], GangesRangos[PlayersData[playerid][Gang]][RangoID]);
			                            SendInfoMessage(idTochange, 3, "0", MsgRangoMe);
			                            SendInfoMessage(playerid, 3, "0", MsgRangoUser);
	  		                            SetPlayerSelectedTypeSkin(idTochange, true);
			                        }
			                        else
			                        {
										SendInfoMessage(playerid, 0, "045", "Ese jugador ya tiene ese rango asignado.");
									}
		                       	}
								else
								{
									SendInfoMessage(playerid, 0, "044", "El rango introducído no existe para tu Gang");
								}
							}
							else
							{
								SendInfoMessage(playerid, 0, "043", "El jugador que desea dar rango no pertenece a su Gang");
							}
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "042", "Ha introducído mal el sintaxis del comando /Rango. Ejemplo correcto: /Rango 2 7");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "041", "Tú no eres líder.");
				}
			}
			// COMANDO: /Expulsar [ID]
			else if (strfind(cmdtext, "/Expulsar ", true) == 0)
			{
			    if ( PlayersData[playerid][Gang] != SINGANG && PlayersData[playerid][Rango] == 0 )
			    {
				    new IdSend[4]; strmid(IdSend, cmdtext, 10, strlen(cmdtext), sizeof(IdSend));
				    if ( IsPlayerNear(playerid, strval(IdSend),
						 "036",
						 "037",
						 "038",
						 "El jugador que desea expulsar no se encuentra conectado",
						 "El jugador que desea expulsar no se encuentra logueado",
						 "El jugador que desea expulsar no se encuentra cerca de tí") )
				    {
						if ( PlayersData[strval(IdSend)][Gang] == PlayersData[playerid][Gang] )
						{
                            PlayersData[strval(IdSend)][Gang] = 0;
                            PlayersData[strval(IdSend)][Rango]   = 7;
							PlayersData[strval(IdSend)][SpawnFac] = 0;
							new MsgExpulsarUser[MAX_TEXT_CHAT]; format(MsgExpulsarUser, sizeof(MsgExpulsarUser), "%s te ha expulsado de la Gang!", PlayersDataOnline[playerid][NameOnline]);
							new MsgExpulsarMe[MAX_TEXT_CHAT]; format(MsgExpulsarMe, sizeof(MsgExpulsarMe), "Expulsaste a %s de tú Gang.", PlayersDataOnline[strval(IdSend)][NameOnline]);
                            SendInfoMessage(strval(IdSend), 3, "0", MsgExpulsarUser);
                            SendInfoMessage(playerid, 3, "0", MsgExpulsarMe);
				   		    if ( PlayersData[playerid][Sexo] )
						    {
								PlayersData[strval(IdSend)][Skin] = 233;// 56 hembra 
							}
							else
							{
								PlayersData[strval(IdSend)][Skin] = 299;// y 26 macho
							}
							SetPlayerSkinEx(strval(IdSend), PlayersData[strval(IdSend)][Skin]);
//							SetPlayerLockAllVehicles(strval(IdSend));
						    UpdateSpawnPlayer(strval(IdSend));
							SetPlayerTeamEx(strval(IdSend));
							SetPlayerColorEx(strval(IdSend));
						}
						else
						{
							SendInfoMessage(playerid, 0, "039", "El jugador que desea expulsar no pertenece a su Gang");
						}
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "040", "Tú no eres líder de la Gang.");
				}
			}
			// COMANDO: /Invitar [ID]
			else if (strfind(cmdtext, "/Invitar ", true) == 0)
			{
			    if ( PlayersData[playerid][Gang] != SINGANG && PlayersData[playerid][Rango] <= 1 )
			    {
				    new IdSend[4]; strmid(IdSend, cmdtext, 9, strlen(cmdtext), sizeof(IdSend));
				    if ( IsPlayerNear(playerid, strval(IdSend),
						 "030",
						 "031",
						 "032",
						 "El jugador que desea invitar no se encuentra conectado",
						 "El jugador que desea invitar no se encuentra logueado",
						 "El jugador que desea invitar no se encuentra cerca de tí") )
				    {
						if ( PlayersData[strval(IdSend)][Gang] == 0 )
						{
		                   	PlayersDataOnline[strval(IdSend)][InvitePlayer]  = playerid;
							PlayersDataOnline[strval(IdSend)][InviteGang] = PlayersData[playerid][Gang];

							new MsgInviteUser[MAX_TEXT_CHAT]; format(MsgInviteUser, sizeof(MsgInviteUser), "Invitaste a %s a la Gang.", PlayersDataOnline[strval(IdSend)][NameOnline]);
							new MsgInviteMe[MAX_TEXT_CHAT]; format(MsgInviteMe, sizeof(MsgInviteMe), "Has sido invitado a la pandilla \"%s\", Usa (/Aceptar Invite)",PlayersDataOnline[playerid][NameOnline], GangData[PlayersData[playerid][Gang]][NameGang]);
	                        SendInfoMessage(strval(IdSend), 3, "0", MsgInviteMe);
	                        SendInfoMessage(playerid, 3, "0", MsgInviteUser);
						}
						else
						{
							SendInfoMessage(playerid, 0, "025", "El jugador que desea invitar ya pertenece a una Gang");
						}
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "026", "Tú no eres líder.");
				}
			}
		   // /Adminon
		  	else if (strcmp("/AdminOn", cmdtext, true, 8) == 0 && strlen(cmdtext) == 8)
  			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if ( PlayersData[playerid][Admin] >= 1 )
				{
					new MsgAdminOn[MAX_TEXT_CHAT];
					if ( PlayersDataOnline[playerid][AdminOn] )
					{
						format(MsgAdminOn, sizeof(MsgAdminOn), "%s Has desactivado el AdminOn", LOGO_STAFF);
						PlayersDataOnline[playerid][AdminOn] = false;
						SetPlayerColorEx(playerid);
					}
					else
					{
						format(MsgAdminOn, sizeof(MsgAdminOn), "%s Has activado el AdminOn", LOGO_STAFF);
						SetPlayerColor(playerid, AdminsRangosColors[PlayersData[playerid][Admin] -1]);
						PlayersDataOnline[playerid][AdminOn] = true;
					}
					SendClientMessage(playerid, COLOR_MESSAGES[1], MsgAdminOn);
				}
				else
				{
					SendInfoMessage(playerid, 0, "144", "No tienes acceso al comando /AdminOn");
				}
  			}
			// /Staff
			else if (strcmp("/Admins", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7)
			{
			    new FoundAdmin;
				for (new i = 0; i < MAX_PLAYERS; i++)
				{
					if ( IsPlayerConnected(i) && PlayersDataOnline[i][State] == 3 && PlayersData[i][Admin] && PlayersData[i][Admin] != 9)
					{
	    				new MsgAdminsOnline[500];
					    if ( !FoundAdmin )
					    {
							FoundAdmin++;
						}
			    	    format(MsgAdminsOnline, sizeof(MsgAdminsOnline),
						"{505050}»»»»»»»»»»»»»»»»»» {008228}A{00B428}dmins {008228}O{00B428}nline {505050}««««««««««««««««««\n{0037FF}* %s %s[%i]", AdminsRangos[PlayersData[i][Admin] - 1], PlayersDataOnline[i][NameOnline], i);
						ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Admins ", MsgAdminsOnline, "Ok", "");
					}
				}
				if ( !FoundAdmin )
				{
		    	    new MsgAdminsOnline[500];
		    	    format(MsgAdminsOnline, sizeof(MsgAdminsOnline),
					"{910000}»»»»»»»»»»»»» {E10000}No hay admins online {910000}«««««««««««««");
					ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Admins ", MsgAdminsOnline, "Ok", "");
				}
			}
			//		22- *		/Staff [ID] [Nivel]				- Dar un nivel a un miembro de el Staff
			else if (strfind(cmdtext, "/Staff ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 9)
				{
					new Datos_Picados[4];
					new DatosOriginales[120];
					strmid(DatosOriginales, cmdtext, 7, strlen(cmdtext), sizeof(DatosOriginales));
					new wPos;
					wPos = strfind(DatosOriginales, " ", false); // HOLA³QUE³PASA³
					if (wPos != -1 || wPos > 4)
					{
						strmid(Datos_Picados[0], DatosOriginales, 0, wPos, sizeof(DatosOriginales));
						strdel(DatosOriginales, 0, wPos + 1);
						if ( strval(DatosOriginales) <= 9 && strval(DatosOriginales) >= 0 )
						{
							if (IsPlayerConnected(strval(Datos_Picados[0])))
							{
							    Comandos_Admin(1, playerid, strval(Datos_Picados[0]), PlayersData[playerid][Admin], strval(DatosOriginales), "0");
							    return 1;
							}
							else
							{
								SendInfoMessage(playerid, 0, "066", "El jugador del Staff al que se refiere no esta conectado.");
								return 1;
							}
					    }
					    else
						{
							SendInfoMessage(playerid, 0, "065", "El número de level de Staff debe estar comprendido entre 0 y 8, donde 0 sera igual a expulsión.");
							return 1;
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "064", "Ha introducído mal el sintaxis del comando /Staff. Ejemplo correcto: /Staff 22 1.");
						return 1;
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "063", "Tú no tienes acceso a el comando /Staff.");
			        return 1;
				}
			}// COMANDOS BOMBAS
			// COMANDO: /Bomba
	  		else if (strfind(cmdtext, "/Boom", true) == 0 )
			{
			    PlayersData[playerid][Bombas]++;
				SendInfoMessage(playerid, 2, "0", "Se ha dado una bomba (Comando Test).");
			}
			// COMANDO: /Desactivar
			else if (strfind(cmdtext, "/Desactivar ", true) == 0)
			{
				// COMANDO: /Desactivar Bomba
			  	if (strcmp("/Desactivar Bomba", cmdtext, true, 17) == 0 && strlen(cmdtext) == 17)
			  	{
			    	MsgAdminUseCommands(9, playerid, cmdtext);
					if ( PlayersData[playerid][Gang] == YAKUZA &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == RUSOS &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == ITALIANOS &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == TRIADA &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Admin] >= 8 && PlayersDataOnline[playerid][AdminOn] )
				    {
				        new IsBombNear = IsPlayerNearBomba(playerid, 1.5, -1);
				        if ( IsBombNear != -1 )
				        {
							if ( PlayersData[playerid][Gang] == YAKUZA &&
								 PlayersData[playerid][Rango] <= 1 ||
								 PlayersData[playerid][Gang] == RUSOS &&
								 PlayersData[playerid][Rango] <= 1 ||
								 PlayersData[playerid][Gang] == ITALIANOS &&
								 PlayersData[playerid][Rango] <= 1 ||
								 PlayersData[playerid][Gang] == TRIADA &&
								 PlayersData[playerid][Rango] <= 1)
					        {
								if (IntentarAccion(playerid, "desactivar la bomba", random(3)))
								{
								    DesactivarBomba(playerid, IsBombNear);
								    Acciones(playerid, 7, "Bomba: Desactivada...");
								}
								else
								{
									ActivarBomba(IsBombNear, 20);
								    Acciones(playerid, 7, "Bomba: Activada...");
								}
							}
							else
							{
				            	if ( DesactivarBomba(playerid, IsBombNear) )
				            	{
									SendInfoMessage(playerid, 2, "0", "Desactivaste está bomba!");
				            	}
				            	else
				            	{
									SendInfoMessage(playerid, 0, "052", "Ocurrió un error al desactivar la bomba!");
								}
							}
			           	}
			           	else
			           	{
							SendInfoMessage(playerid, 0, "053", "No te encuentras cerca de una bomba!");
						}
				    }
				    else
				    {
						SendInfoMessage(playerid, 0, "054", "Usted no es no puede desactivar bombas!");
					}
				}
				// COMANDO: /Desactivar Bomba
				else if (strcmp("/Desactivar Bomba Todos", cmdtext, true, 23) == 0 && strlen(cmdtext) == 23)
				{
				    MsgAdminUseCommands(9, playerid, cmdtext);
					if ( PlayersData[playerid][Admin] >= 7 )
				    {
						for (new i = 0; i < MAX_BOMBAS_COUNT; i++ )
						{
							RemoveBomba(i);
						}
						new StringFormat[MAX_TEXT_CHAT];
						format(StringFormat, sizeof(StringFormat), "%s Has desactivado todas las bombas",LOGO_STAFF);
		           		SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormat);
				    }
				    else
				    {
						SendInfoMessage(playerid, 0, "055", "Tú no tienes acceso a el comando /Desactivar Bomba Todos.");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "056", "Quizás quiso decir: /Desactivar Bomba");
				}
      		}
			// COMANDO: /Bombas
			else if (strcmp("/Bombas", cmdtext, true, 7) == 0 && strlen(cmdtext) == 7)
			{
			    MsgAdminUseCommands(9, playerid, cmdtext);
				if ( PlayersData[playerid][Gang] == YAKUZA &&
					 PlayersData[playerid][Rango] <= 1 ||
					 PlayersData[playerid][Gang] == RUSOS &&
					 PlayersData[playerid][Rango] <= 1 ||
					 PlayersData[playerid][Gang] == ITALIANOS &&
					 PlayersData[playerid][Rango] <= 1 ||
					 PlayersData[playerid][Gang] == TRIADA &&
					 PlayersData[playerid][Rango] <= 1 ||
					 PlayersData[playerid][Admin] >= 8 && PlayersDataOnline[playerid][AdminOn] )
			    {
				    ShowBombas(playerid);
			    }
			    else
			    {
					SendInfoMessage(playerid, 0, "051", "Usted no puede usar el control de bombas!");
				}
			}
			// COMANDO: /Ver
			else if (strfind(cmdtext, "/Ver", true) == 0)
			{
				// COMANDO: /Ver Bomba
			  	if (strcmp("/Ver Bomba", cmdtext, true, 10) == 0 && strlen(cmdtext) == 10)
			  	{
				    MsgAdminUseCommands(9, playerid, cmdtext);
					if ( PlayersData[playerid][Gang] == YAKUZA &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == RUSOS &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == ITALIANOS &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == TRIADA &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Admin] >= 8 && PlayersDataOnline[playerid][AdminOn] )
				    {
				        new IsBombNear = IsPlayerNearBomba(playerid, 1.5, -1);
				        if ( IsBombNear != -1 )
				        {
						    new MsgVerBomba[MAX_TEXT_CHAT];
						    format(MsgVerBomba, sizeof(MsgVerBomba), "Esta bomba tiene el número de control #%i", IsBombNear);
							SendInfoMessage(playerid, 2, "0", MsgVerBomba);
		            	}
		            	else
		            	{
							SendInfoMessage(playerid, 0, "062", "No te encuentras cerca de una bomba");
						}
				    }
				    else
				    {
						SendInfoMessage(playerid, 0, "061", "Usted no puede ver el número de control en una bomba!");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "060", "Quizás quiso decir: /Ver Bomba");
				}
			}
			// COMANDO: /G [Gang]
			else if (strfind(cmdtext, "/G ", true) == 0)
			{
			    if ( GangData[PlayersData[playerid][Gang]][Family] )
			    {
			    	SendMessageFamily(playerid, cmdtext[3]);
				}
				else
				{
					SendInfoMessage(playerid, 0, "068", "Su Gang no tiene canal /G [Gang Chat]");
				}
			}
			// COMANDO: /O [Texto]
	  		else if (strfind(cmdtext, "/T ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if ( strlen(cmdtext) > 3 )
				{
				    new MsgTodos[MAX_TEXT_CHAT];
					strmid(MsgTodos, cmdtext, 3, strlen(cmdtext), sizeof(MsgTodos));
				    if ( !DetectarSpam(playerid, MsgTodos) )
				    {
					    format(MsgTodos, sizeof(MsgTodos), "{FF0000}[SGW] {EDEF00}[Chat General] [%i] %s: %s",playerid, PlayersDataOnline[playerid][NameOnline], MsgTodos);
					}
					else
					{
					    switch ( random(4) )
					    {
					        case 0:
					        {
							    format(MsgTodos, sizeof(MsgTodos), "{FF0000}[SGW] {EDEF00}[Chat General] [%i] %s: Soy lammer y n00b, me gusta el sexo anal.",playerid, PlayersDataOnline[playerid][NameOnline]);
							}
					        case 1:
					        {
							    format(MsgTodos, sizeof(MsgTodos), "{FF0000}[SGW] {EDEF00}[Chat General] [%i] %s: I'm lammer and n00b and i like anal sex.",playerid, PlayersDataOnline[playerid][NameOnline]);
							}
					        case 2:
					        {
							    format(MsgTodos, sizeof(MsgTodos), "{FF0000}[SGW] {EDEF00}[Chat General] [%i] %s: Soy maricón y me gusta que me den por la colita.",playerid, PlayersDataOnline[playerid][NameOnline]);
							}
					        case 3:
					        {
							    format(MsgTodos, sizeof(MsgTodos), "{FF0000}[SGW] {EDEF00}[Chat General] [%i] %s: I'm a fag and i like the dildos.",playerid, PlayersDataOnline[playerid][NameOnline]);
							}
						}
					}
				    for(new i=0;i<MAX_PLAYERS;i++)
				    {
					    SendClientMessage(i, COLOR_TODOS_CHANNEL, MsgTodos);
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "070", "Debe escribir más de 3 carácteres!");
				}
			}
			//			/Skin [ID]                  - Forzar a cambiar un Skin a un jugador
			else if (strfind(cmdtext, "/Skin", true) == 0)
			{
			    if(PlayersDataOnline[playerid][VidaOn] >=95)
			    {
					SetPlayerSelectedTypeSkin(playerid, true);
				}
				else
				{
					SendInfoMessage(playerid, 0, "070", "No puede cambiar su skin, debe llenar su vida primero!");
				}
			}

		//			/DesbugArma [ID]                  - Desbuguear armas a un user
			else if (strfind(cmdtext, "/DesbugArma ", true) == 0)
			{
				MsgAdminUseCommands(9, playerid, cmdtext);
				if (PlayersData[playerid][Admin] >= 2)
				{
				    new playeridSkin[5];	strmid(playeridSkin, cmdtext, 6, strlen(cmdtext), sizeof(playeridSkin));
					if ( IsPlayerConnected(strval(playeridSkin)) )
					{
						ResetPlayerWeaponsEx(strval(playeridSkin));
						GivePlayerWeaponEx(strval(playeridSkin), 24, 300);
						GivePlayerWeaponEx(strval(playeridSkin), 26, 200);
						GivePlayerWeaponEx(strval(playeridSkin), 34, 100);
						GivePlayerWeaponEx(strval(playeridSkin), 4, 1);
					}
					else
					{
						SendInfoMessage(playerid, 0, "202", "El jugador no se encuentra conectado.");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "203", "Tú no tienes acceso a el comando /DesbugArma.");
			        return 1;
				}
			}
			//	Test /Arma44 Visores Nocturnos
			else if (strfind(cmdtext, "/arma44", true) == 0)
			{
				GivePlayerWeaponEx(playerid, 44, 1);
				SendInfoMessage(playerid, 2, "0", "Arma 44(Visores nocturnos)agregada a su inventario de armas.(Comando Test).");
			}
			//	Test /Arma45 Visores térmicos
			else if (strfind(cmdtext, "/arma45", true) == 0)
			{
				GivePlayerWeaponEx(playerid, 45, 1);
				SendInfoMessage(playerid, 2, "0", "Arma 45(Visores térmicos)agregada a su inventario de armas.(Comando Test).");
			}
			// COMANDO /Poner
			else if (strfind(cmdtext, "/Poner ", true) == 0)
			{
				// COMANDO: /Poner Bomba
				if (strcmp("/Poner Bomba", cmdtext, true, 12) == 0 && strlen(cmdtext) == 12)
			  	{
				    MsgAdminUseCommands(9, playerid, cmdtext);
					if ( PlayersData[playerid][Gang] == YAKUZA &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == RUSOS &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == ITALIANOS &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Gang] == TRIADA &&
						 PlayersData[playerid][Rango] <= 1 ||
						 PlayersData[playerid][Admin] >= 8 && PlayersDataOnline[playerid][AdminOn] )
					{
					    if ( PlayersData[playerid][Bombas] > 0 || PlayersData[playerid][Admin] >= 8 && PlayersDataOnline[playerid][AdminOn] )
					    {
       					    new ObjectIDBomb = strval(cmdtext[GetPosSpace(cmdtext, 2)]);
					        new ResultadoPlanted;
							new Float:PosPlayer[3]; GetPlayerPos(playerid, PosPlayer[0], PosPlayer[1], PosPlayer[2]);
							if ( PlayersDataOnline[playerid][InCarId] && IsPlayerInAnyVehicle(playerid) ||
								 PlayersDataOnline[playerid][InVehicle] && IsPlayerInAnyVehicle(playerid) )
							{
						        ResultadoPlanted = AddBomba(playerid, BOMBA_TYPE_CAR, GetPlayerVehicleID(playerid), PosPlayer[0], PosPlayer[1], PosPlayer[2], 0);
								ApplyPlayerAnimCustom(playerid,
								"CAR_CHAT",
								CARCHAT_ANIMATIONS[15], false);
							}
							else
							{
							    if ( ObjectIDBomb >= 0 && ObjectIDBomb < 8 )
							    {
							        ResultadoPlanted = AddBomba(playerid, BOMBA_TYPE_FOOT, false, PosPlayer[0], PosPlayer[1], PosPlayer[2], BombasOjectsID[ObjectIDBomb]);
									ApplyPlayerAnimCustom(playerid,
									"BOMBER",
									BOMBER_ANIMATIONS[0], false);
								}
								else
								{
									SendInfoMessage(playerid, 0, "009", "El tipo de bomba debe estár comprendido entre 0 y 7!");
								}
							}
							if ( ResultadoPlanted )
							{
							    if ( PlayersData[playerid][Admin] >= 8 && PlayersDataOnline[playerid][AdminOn] )
							    {

								}
								else
								{
									PlayersData[playerid][Bombas]--;
								}
							}
						}
						else
						{
							SendInfoMessage(playerid, 0, "010", "No tienes bombas!");
						}
					}
					else
					{
						SendInfoMessage(playerid, 0, "011", "Usted no es no puede poner bombas!");
     				}
			  	}
				else
				{
					SendInfoMessage(playerid, 0, "012", "Quizás quiso decir: /Poner Bomba}");
				}
			}
			    // NO COMMANDS SEND
			else
			{
				SendInfoMessage(playerid, 0, "013", "El comando introducído no es válido, para más información consulte /Ayuda");
				SendInfoMessage(playerid, 0, "013", "Type /Help for information.");
			}
  		}
		else
		{
			SendInfoMessage(playerid, 0, "014", "El comando introducído no existe, para más información consulte /Ayuda");
			SendInfoMessage(playerid, 0, "014", "The command not exist, for more information type /Help");
		}
	}
	return 1;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if ( PlayersData[playerid][IsPlayerInBizz] )
	{
		new TypeBizz = NegociosData[PlayersData[playerid][IsPlayerInBizz]][Type];
		// Tiendas de ropa
		if (PlayersData[playerid][IsPlayerInBizz] && strfind(NegociosType[TypeBizz][TypeName], "Ropa", false) == 0)
		{
			SendInfoMessage(playerid, 2, "0", "Use (/Comprar {Ropa, Lentes, Gorra, Reloj, Casco}) para ingresar en el vestidor!");
		}
		// Barberías
		else if ( TypeBizz >= 27 && TypeBizz <= 29 )
		{
			SendInfoMessage(playerid, 2, "0", "Use (/Comprar Peluca) para comprar pelucas o (/Comprar Boina) para boinas.");
		}
		// CluckinBell;
		else if ( TypeBizz == 22 )
		{
			ShowMenuForPlayer(CluckinBell, playerid);
		    TogglePlayerControllableEx(playerid, 0);
			PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
		}
		// BurgerShot;
		else if ( TypeBizz == 23 )
		{
			ShowMenuForPlayer(BurgerShot, playerid);
		    TogglePlayerControllableEx(playerid, 0);
			PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
		}
		// PizzaStack;
		else if ( TypeBizz == 24 )
		{
			ShowMenuForPlayer(PizzaStack, playerid);
		    TogglePlayerControllableEx(playerid, 0);
			PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
		}
		// JaysDiner;
		else if ( TypeBizz == 7 )
		{
			ShowMenuForPlayer(JaysDiner, playerid);
		    TogglePlayerControllableEx(playerid, 0);
			PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
		}
		// RingDonuts;
		else if (TypeBizz == 6 )
		{
			ShowMenuForPlayer(RingDonuts, playerid);
		    TogglePlayerControllableEx(playerid, 0);
			PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
		}
		// Armerias;
		else if ( TypeBizz >= 8 &&
				TypeBizz <= 12 )
		{
			ShowMenuForPlayer(Menu_Principal_Armas, playerid);
			PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
			TogglePlayerControllableEx(playerid, 0);
		}
		// 24/7;
		else if ( TypeBizz >= 16 &&
				TypeBizz <= 17 )
		{
			ShowMenuForPlayer(M24_7, playerid);
			PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
			TogglePlayerControllableEx(playerid, 0);
		}
	}
	else
	{
		DisablePlayerCheckpoint(playerid);
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if (PlayersDataOnline[playerid][State] == 1)
	{
		SendInfoMessage(playerid, 0, "071", "Debe loguearse antes de entrar al servidor.");
	}
	else if (PlayersDataOnline[playerid][State] == 2)
	{
		SendInfoMessage(playerid, 0, "072", "Debe regístrarse antes de entrar al servidor.");
	}
	return 0;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if ( PlayersDataOnline[playerid][InPickup] != pickupid )
	{
		HideTextDrawsTelesAndInfo(playerid);
	    PlayersDataOnline[playerid][InPickup] = pickupid;
		// FACCIONES
        if ( pickupid >= GangData[YAKUZA][PickupidOutF] &&
             pickupid <= GangData[MAX_GANG][PickupidInF] )
        {
            for(new i=YAKUZA;i<=MAX_GANG;i++)
            {
                if ( GangData[i][PickupidOutF] == pickupid || GangData[i][PickupidInF] == pickupid )
                {
                    if ( GangData[i][PickupidOutF] == pickupid )
                    {
	                    PlayersDataOnline[playerid][MyPickupX]  = GangData[i][PickupIn_X];
	                    PlayersDataOnline[playerid][MyPickupY]  = GangData[i][PickupIn_Y];
	                    PlayersDataOnline[playerid][MyPickupZ]  = GangData[i][PickupIn_Z];
	                    PlayersDataOnline[playerid][MyPickupZZ] = GangData[i][PickupIn_ZZ];
	                    PlayersDataOnline[playerid][MyPickupInterior] = GangData[i][InteriorGang];

						PlayersDataOnline[playerid][MyPickupX_Now] = GangData[i][PickupOut_X];
						PlayersDataOnline[playerid][MyPickupY_Now] = GangData[i][PickupOut_Y];
						PlayersDataOnline[playerid][MyPickupZ_Now] = GangData[i][PickupOut_Z];
						PlayersDataOnline[playerid][MyPickupWorld] = GangData[i][World];
	                }
	                else
	                {
	                    PlayersDataOnline[playerid][MyPickupX]  = GangData[i][PickupOut_X];
	                    PlayersDataOnline[playerid][MyPickupY]  = GangData[i][PickupOut_Y];
	                    PlayersDataOnline[playerid][MyPickupZ]  = GangData[i][PickupOut_Z];
	                    PlayersDataOnline[playerid][MyPickupZZ] = GangData[i][PickupOut_ZZ];
						PlayersDataOnline[playerid][MyPickupWorld] = 0;
	                    PlayersDataOnline[playerid][MyPickupInterior] = 0;

						PlayersDataOnline[playerid][MyPickupX_Now] = GangData[i][PickupIn_X];
						PlayersDataOnline[playerid][MyPickupY_Now] = GangData[i][PickupIn_Y];
						PlayersDataOnline[playerid][MyPickupZ_Now] = GangData[i][PickupIn_Z];
					}
					PlayersDataOnline[playerid][MyPickupLock]  = GangData[i][Lock];
                    TextDrawShowForPlayer(playerid, GangTextDraws[i]);
                    PlayersDataOnline[playerid][MyTextDrawShow] = GangTextDraws[i];

		            PlayersDataOnline[playerid][InSpecialAnim] = GetPlayerSpecialAction(playerid);
                    PlayersDataOnline[playerid][InPickupTele] = true;
                    break;
				}
            }
        }
		// TELES
        else if ( pickupid >= Teles[0][PickupID] &&
             	  pickupid <= Teles[MAX_TELE][PickupID] )
        {
            for(new i=0;i<=MAX_TELE;i++)
            {
                if ( Teles[i][PickupID] == pickupid )
                {
	                PlayersDataOnline[playerid][MyPickupX]  	= Teles[Teles[i][PickupIDGo]][PosX];
	                PlayersDataOnline[playerid][MyPickupY]  	= Teles[Teles[i][PickupIDGo]][PosY];
	                PlayersDataOnline[playerid][MyPickupZ]  	= Teles[Teles[i][PickupIDGo]][PosZ];
	                PlayersDataOnline[playerid][MyPickupZZ] 	= Teles[Teles[i][PickupIDGo]][PosZZ];
	                PlayersDataOnline[playerid][MyPickupInterior] = Teles[Teles[i][PickupIDGo]][Interior];
	                if ( !PlayersData[playerid][IsPlayerInVehInt] )
	                {
						PlayersDataOnline[playerid][MyPickupWorld] 	= Teles[Teles[i][PickupIDGo]][World];
					}
					else
					{
						PlayersDataOnline[playerid][MyPickupWorld] = GetVagonByVagonID(PlayersData[playerid][IsPlayerInVehInt], Teles[Teles[i][PickupIDGo]][World]);
					}
					PlayersDataOnline[playerid][MyPickupLock]  	= Teles[i][Lock];

	                PlayersDataOnline[playerid][MyPickupX_Now]  = Teles[i][PosX];
	                PlayersDataOnline[playerid][MyPickupY_Now]  = Teles[i][PosY];
	                PlayersDataOnline[playerid][MyPickupZ_Now]  = Teles[i][PosZ];

                    TextDrawShowForPlayer(playerid, TelesTextDraws[i]);
                    PlayersDataOnline[playerid][MyTextDrawShow] = TelesTextDraws[i];

		            PlayersDataOnline[playerid][InSpecialAnim] = GetPlayerSpecialAction(playerid);
                    PlayersDataOnline[playerid][InPickupTele] 	= true;
                    break;
                }
            }
        }
        // NEGOCIOS
        else if ( pickupid >= NegociosData[1][PickupOutId] &&
             	  pickupid <= NegociosData[MAX_BIZZ][PickupOutId] )
        {
            for(new i=1;i<=MAX_BIZZ;i++)
            {
                if ( NegociosData[i][PickupOutId] == pickupid )
                {
		            PlayersDataOnline[playerid][MyPickupX]  	= NegociosType[NegociosData[i][Type]][PosInX];
		            PlayersDataOnline[playerid][MyPickupY]  	= NegociosType[NegociosData[i][Type]][PosInY];
		            PlayersDataOnline[playerid][MyPickupZ]  	= NegociosType[NegociosData[i][Type]][PosInZ];
		            PlayersDataOnline[playerid][MyPickupZZ] 	= NegociosType[NegociosData[i][Type]][PosInZZ];
		            PlayersDataOnline[playerid][MyPickupInterior] = NegociosType[NegociosData[i][Type]][InteriorId];
					PlayersDataOnline[playerid][MyPickupWorld] 	= NegociosData[i][World];
					PlayersDataOnline[playerid][MyPickupLock]  	= NegociosData[i][Lock];

		            PlayersDataOnline[playerid][MyPickupX_Now]  = NegociosData[i][PosOutX];
		            PlayersDataOnline[playerid][MyPickupY_Now]  = NegociosData[i][PosOutY];
		            PlayersDataOnline[playerid][MyPickupZ_Now]  = NegociosData[i][PosOutZ];

		            TextDrawShowForPlayer(playerid, NegociosTextDraws[i]);
		            PlayersDataOnline[playerid][MyTextDrawShow] = NegociosTextDraws[i];

		            PlayersDataOnline[playerid][InSpecialAnim]  = GetPlayerSpecialAction(playerid);
		            PlayersDataOnline[playerid][InPickupTele] 	= true;
		            break;
	            }
            }
        }
        // NEGOCIOS TYPE
        else if ( PlayersData[playerid][IsPlayerInBizz] && pickupid >= NegociosType[0][PickupId] &&
             	  pickupid <= NegociosType[MAX_BIZZ_TYPE][PickupId] )
        {
            for(new i=0;i<=MAX_BIZZ_TYPE;i++)
            {
                if ( NegociosType[i][PickupId] == pickupid )
                {
		            PlayersDataOnline[playerid][MyPickupX]  	= NegociosData[PlayersData[playerid][IsPlayerInBizz]][PosOutX];
		            PlayersDataOnline[playerid][MyPickupY]  	= NegociosData[PlayersData[playerid][IsPlayerInBizz]][PosOutY];
		            PlayersDataOnline[playerid][MyPickupZ]  	= NegociosData[PlayersData[playerid][IsPlayerInBizz]][PosOutZ];
		            PlayersDataOnline[playerid][MyPickupZZ] 	= NegociosData[PlayersData[playerid][IsPlayerInBizz]][PosOutZZ];
		            PlayersDataOnline[playerid][MyPickupInterior] = NegociosData[PlayersData[playerid][IsPlayerInBizz]][InteriorOut];
					PlayersDataOnline[playerid][MyPickupWorld] 	= 0;
					PlayersDataOnline[playerid][MyPickupLock]  	= NegociosData[PlayersData[playerid][IsPlayerInBizz]][Lock]; // NegociosData[MyWorld][Lock];

		            PlayersDataOnline[playerid][MyPickupX_Now]  = NegociosType[i][PosInX];
		            PlayersDataOnline[playerid][MyPickupY_Now]  = NegociosType[i][PosInY];
		            PlayersDataOnline[playerid][MyPickupZ_Now]  = NegociosType[i][PosInZ];

		            TextDrawShowForPlayer(playerid, NegociosTextDraws[PlayersData[playerid][IsPlayerInBizz]]);
		            PlayersDataOnline[playerid][MyTextDrawShow] = NegociosTextDraws[PlayersData[playerid][IsPlayerInBizz]];

		            PlayersDataOnline[playerid][InSpecialAnim]  = GetPlayerSpecialAction(playerid);
		            PlayersDataOnline[playerid][InPickupTele] 	= true;
		            break;
	            }
            }
        }
        // CASAS
		else if ( pickupid >= HouseData[1][PickupId] &&
             	  pickupid <= HouseData[MAX_HOUSE][PickupId] )
        {
            for(new i=1;i<=MAX_HOUSE;i++)
            {
                if ( HouseData[i][PickupId] == pickupid )
                {
		            PlayersDataOnline[playerid][MyPickupX]  	= TypeHouse[HouseData[i][TypeHouseId]][PosX];
		            PlayersDataOnline[playerid][MyPickupY]  	= TypeHouse[HouseData[i][TypeHouseId]][PosY];
		            PlayersDataOnline[playerid][MyPickupZ]  	= TypeHouse[HouseData[i][TypeHouseId]][PosZ];
		            PlayersDataOnline[playerid][MyPickupZZ] 	= TypeHouse[HouseData[i][TypeHouseId]][PosZZ];
		            PlayersDataOnline[playerid][MyPickupInterior] = TypeHouse[HouseData[i][TypeHouseId]][Interior];
					PlayersDataOnline[playerid][MyPickupWorld] 	= HouseData[i][World];
					PlayersDataOnline[playerid][MyPickupLock]  	= HouseData[i][Lock];

		            PlayersDataOnline[playerid][MyPickupX_Now]  = HouseData[i][PosX];
		            PlayersDataOnline[playerid][MyPickupY_Now]  = HouseData[i][PosY];
		            PlayersDataOnline[playerid][MyPickupZ_Now]  = HouseData[i][PosZ];

		            TextDrawShowForPlayer(playerid, CasasTextDraws[i]);
		            PlayersDataOnline[playerid][MyTextDrawShow] = CasasTextDraws[i];

		            PlayersDataOnline[playerid][InSpecialAnim] = GetPlayerSpecialAction(playerid);
		            PlayersDataOnline[playerid][InPickupTele] 	= true;
		            break;
	            }
            }
		}
        // CASAS TYPE
        else if ( PlayersData[playerid][IsPlayerInHouse] && pickupid >= TypeHouse[0][PickupId] &&
             	  pickupid <= TypeHouse[MAX_HOUSE_TYPE][PickupId] )
        {
            for(new i=0;i<=MAX_HOUSE_TYPE;i++)
            {
                if ( TypeHouse[i][PickupId] == pickupid )
                {
		            PlayersDataOnline[playerid][MyPickupX]  	= HouseData[PlayersData[playerid][IsPlayerInHouse]][PosX];
		            PlayersDataOnline[playerid][MyPickupY]  	= HouseData[PlayersData[playerid][IsPlayerInHouse]][PosY];
		            PlayersDataOnline[playerid][MyPickupZ]  	= HouseData[PlayersData[playerid][IsPlayerInHouse]][PosZ];
		            PlayersDataOnline[playerid][MyPickupZZ] 	= HouseData[PlayersData[playerid][IsPlayerInHouse]][PosZZ];
		            PlayersDataOnline[playerid][MyPickupInterior] = 0; // HouseData[MyWorld][Interior];
					PlayersDataOnline[playerid][MyPickupWorld] 	= 0;
					PlayersDataOnline[playerid][MyPickupLock]  	= HouseData[PlayersData[playerid][IsPlayerInHouse]][Lock]; // HouseData[MyWorld][Lock];

		            PlayersDataOnline[playerid][MyPickupX_Now]  = TypeHouse[i][PosX];
		            PlayersDataOnline[playerid][MyPickupY_Now]  = TypeHouse[i][PosY];
		            PlayersDataOnline[playerid][MyPickupZ_Now]  = TypeHouse[i][PosZ];

		            TextDrawShowForPlayer(playerid, CasasTextDraws[PlayersData[playerid][IsPlayerInHouse]]);
		            PlayersDataOnline[playerid][MyTextDrawShow] = CasasTextDraws[PlayersData[playerid][IsPlayerInHouse]];

		            PlayersDataOnline[playerid][InSpecialAnim] = GetPlayerSpecialAction(playerid);
		            PlayersDataOnline[playerid][InPickupTele] 	= true;
		            break;
	            }
            }
        }
        // GARAGES TYPE
        else if ( PlayersData[playerid][IsPlayerInGarage] >= 0 && PlayersData[playerid][IsPlayerInHouse] && pickupid >= TypeGarage[0][PickupId] &&
             	  pickupid <= TypeGarage[MAX_GARAGE_TYPE][PickupIdh] )
        {
            for(new i=0;i<=MAX_GARAGE_TYPE;i++)
            {
                if ( TypeGarage[i][PickupId] == pickupid || TypeGarage[i][PickupIdh] == pickupid )
                {
                    if ( TypeGarage[i][PickupIdh] == pickupid )
                    {
			            PlayersDataOnline[playerid][MyPickupX]  	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][XgIn];
			            PlayersDataOnline[playerid][MyPickupY]  	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][YgIn];
			            PlayersDataOnline[playerid][MyPickupZ]  	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][ZgIn];
			            PlayersDataOnline[playerid][MyPickupZZ] 	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][ZZgIn];
 			            PlayersDataOnline[playerid][MyPickupInterior] = TypeHouse[HouseData[PlayersData[playerid][IsPlayerInHouse]][TypeHouseId]][Interior];
						PlayersDataOnline[playerid][MyPickupWorld] 	= PlayersData[playerid][IsPlayerInHouse];
						PlayersDataOnline[playerid][MyPickupLock]  	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][LockIn];

			            PlayersDataOnline[playerid][MyPickupX_Now]  = TypeGarage[i][PosXh];
			            PlayersDataOnline[playerid][MyPickupY_Now]  = TypeGarage[i][PosYh];
			            PlayersDataOnline[playerid][MyPickupZ_Now]  = TypeGarage[i][PosZh];
					}
					else
					{
			            PlayersDataOnline[playerid][MyPickupX]  	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][Xg];
			            PlayersDataOnline[playerid][MyPickupY]  	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][Yg];
			            PlayersDataOnline[playerid][MyPickupZ]  	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][Zg];
			            PlayersDataOnline[playerid][MyPickupZZ] 	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][ZZg];
 			            PlayersDataOnline[playerid][MyPickupInterior] = 0;
						PlayersDataOnline[playerid][MyPickupWorld] 	= 0;
						PlayersDataOnline[playerid][MyPickupLock]  	= Garages[PlayersData[playerid][IsPlayerInHouse]][PlayersData[playerid][IsPlayerInGarage]][LockOut];

			            PlayersDataOnline[playerid][MyPickupX_Now]  = TypeGarage[i][PosX];
			            PlayersDataOnline[playerid][MyPickupY_Now]  = TypeGarage[i][PosY];
			            PlayersDataOnline[playerid][MyPickupZ_Now]  = TypeGarage[i][PosZ];
		            }

		            TextDrawShowForPlayer(playerid, GarageTextDraw);
		            PlayersDataOnline[playerid][MyTextDrawShow] = GarageTextDraw;

		            PlayersDataOnline[playerid][InSpecialAnim] = GetPlayerSpecialAction(playerid);
		            PlayersDataOnline[playerid][InPickupTele] 	= true;
		            break;
					//GarageTextDraw
                }
            }
        }
        // GARAGES
        else if ( pickupid >= MIN_GARAGE_PICKUP &&
             	  pickupid <= MAX_GARAGE_PICKUP )
        {
			for (new h = 1; h <= MAX_HOUSE; h++)
			{
				for ( new i = 0; i < MAX_GARAGE_FOR_HOUSE; i++ )
				{
			        if ( Garages[h][i][PickupidIn] == pickupid || Garages[h][i][PickupidOut] == pickupid )
			        {
						if ( Garages[h][i][PickupidOut] == pickupid )
						{
				            PlayersDataOnline[playerid][MyPickupX]  	= TypeGarage[Garages[h][i][TypeGarageE]][PosX];
				            PlayersDataOnline[playerid][MyPickupY]  	= TypeGarage[Garages[h][i][TypeGarageE]][PosY];
			    	        PlayersDataOnline[playerid][MyPickupZ]  	= TypeGarage[Garages[h][i][TypeGarageE]][PosZ];
      						PlayersDataOnline[playerid][MyPickupZZ] 	= TypeGarage[Garages[h][i][TypeGarageE]][PosZZ];
 			        	    PlayersDataOnline[playerid][MyPickupInterior] = TypeGarage[Garages[h][i][TypeGarageE]][Interior];
							PlayersDataOnline[playerid][MyPickupWorld] 	= Garages[h][i][WorldG];
							PlayersDataOnline[playerid][MyPickupLock]  	= Garages[h][i][LockOut]; // HouseData[MyWorld][Lock];

				            PlayersDataOnline[playerid][MyPickupX_Now]  = Garages[h][i][Xg];
				            PlayersDataOnline[playerid][MyPickupY_Now]  = Garages[h][i][Yg];
				            PlayersDataOnline[playerid][MyPickupZ_Now]  = Garages[h][i][Zg];
						}
						else if ( PlayersData[playerid][IsPlayerInHouse] )
						{
				            PlayersDataOnline[playerid][MyPickupX]  	= TypeGarage[Garages[h][i][TypeGarageE]][PosXh];
				            PlayersDataOnline[playerid][MyPickupY]  	= TypeGarage[Garages[h][i][TypeGarageE]][PosYh];
			    	        PlayersDataOnline[playerid][MyPickupZ]  	= TypeGarage[Garages[h][i][TypeGarageE]][PosZh];
      						PlayersDataOnline[playerid][MyPickupZZ] 	= TypeGarage[Garages[h][i][TypeGarageE]][PosZZh];
 			        	    PlayersDataOnline[playerid][MyPickupInterior] = TypeGarage[Garages[h][i][TypeGarageE]][Interior];
							PlayersDataOnline[playerid][MyPickupWorld] 	= Garages[h][i][WorldG];
							PlayersDataOnline[playerid][MyPickupLock]  	= Garages[h][i][LockIn]; // HouseData[MyWorld][Lock];

				            PlayersDataOnline[playerid][MyPickupX_Now]  = Garages[h][i][XgIn];
				            PlayersDataOnline[playerid][MyPickupY_Now]  = Garages[h][i][YgIn];
				            PlayersDataOnline[playerid][MyPickupZ_Now]  = Garages[h][i][ZgIn];
						}
			            PlayersDataOnline[playerid][InSpecialAnim]  = GetPlayerSpecialAction(playerid);
			            PlayersData[playerid][IsPlayerInGarage]     = i - 50;
			            PlayersDataOnline[playerid][InPickupTele] 	= h;

			            TextDrawShowForPlayer(playerid, GarageTextDraw);
			            PlayersDataOnline[playerid][MyTextDrawShow] = GarageTextDraw;
					    return true;
			        }
		        }
	        }
		}
        // GARAGES EX
        else if ( pickupid >= GaragesEx[0][PickupIDOneP] &&
             	  pickupid <= GaragesEx[MAX_GARAGES_EX][PickupIDTwoP] )
        {
			for ( new i = 0; i <= MAX_GARAGES_EX; i++ )
			{
			    if ( GaragesEx[i][PickupIDOneP] == pickupid || GaragesEx[i][PickupIDTwoP] == pickupid )
			    {
			        if ( GaragesEx[i][PickupIDOneP] == pickupid )
			        {
			            PlayersDataOnline[playerid][MyPickupX]  	= GaragesEx[i][PosXTwoP];
			            PlayersDataOnline[playerid][MyPickupY]  	= GaragesEx[i][PosYTwoP];
		    	        PlayersDataOnline[playerid][MyPickupZ]  	= GaragesEx[i][PosZTwoP];
  						PlayersDataOnline[playerid][MyPickupZZ] 	= GaragesEx[i][PosZZTwoP];
		        	    PlayersDataOnline[playerid][MyPickupInterior] = 0;
						PlayersDataOnline[playerid][MyPickupWorld] 	= 0;
						PlayersDataOnline[playerid][MyPickupLock]  	= GaragesEx[i][Lock];

			            PlayersDataOnline[playerid][MyPickupX_Now]  = GaragesEx[i][PosXOneP];
			            PlayersDataOnline[playerid][MyPickupY_Now]  = GaragesEx[i][PosYOneP];
			            PlayersDataOnline[playerid][MyPickupZ_Now]  = GaragesEx[i][PosZOneP];
					}
					else
					{
			            PlayersDataOnline[playerid][MyPickupX]  	= GaragesEx[i][PosXOneP];
			            PlayersDataOnline[playerid][MyPickupY]  	= GaragesEx[i][PosYOneP];
		    	        PlayersDataOnline[playerid][MyPickupZ]  	= GaragesEx[i][PosZOneP];
  						PlayersDataOnline[playerid][MyPickupZZ] 	= GaragesEx[i][PosZZOneP];
		        	    PlayersDataOnline[playerid][MyPickupInterior] = GaragesEx[i][Interior];
						PlayersDataOnline[playerid][MyPickupWorld] 	= GaragesEx[i][World];
						PlayersDataOnline[playerid][MyPickupLock]  	= GaragesEx[i][Lock];

			            PlayersDataOnline[playerid][MyPickupX_Now]  = GaragesEx[i][PosXTwoP];
			            PlayersDataOnline[playerid][MyPickupY_Now]  = GaragesEx[i][PosYTwoP];
			            PlayersDataOnline[playerid][MyPickupZ_Now]  = GaragesEx[i][PosZTwoP];
					}

		            TextDrawShowForPlayer(playerid, GarageTextDraw);
		            PlayersDataOnline[playerid][MyTextDrawShow] = GarageTextDraw;
		            PlayersDataOnline[playerid][InSpecialAnim] = GetPlayerSpecialAction(playerid);
		            PlayersDataOnline[playerid][InPickupTele] 	= true;
		            break;
				}
			}
		}
		/* ----- */
        // INFO TEXT´s
        else if ( pickupid >= TextDrawInfo[0][PickupidTextInfo] &&
             	  pickupid <= TextDrawInfo[MAX_TEXT_DRAW_INFO][PickupidTextInfo] )
        {
            for(new i=0;i<=MAX_TEXT_DRAW_INFO;i++)
            {
                if ( TextDrawInfo[i][PickupidTextInfo] == pickupid )
                {
		            PlayersDataOnline[playerid][MyPickupX_Now]  = TextDrawInfo[i][PosInfoX];
		            PlayersDataOnline[playerid][MyPickupY_Now]  = TextDrawInfo[i][PosInfoY];
		            PlayersDataOnline[playerid][MyPickupZ_Now]  = TextDrawInfo[i][PosInfoZ];

		            TextDrawShowForPlayer(playerid, TextDrawInfoTextDraws[i]);
		            PlayersDataOnline[playerid][MyTextDrawShow] = TextDrawInfoTextDraws[i];
		            PlayersDataOnline[playerid][InPickupInfo] 	= true;
		            break;
	            }
            }
        }
		else if (IsPlayerInPincho(playerid, pickupid))
		{

		}
	}
	else if (IsPlayerInPincho(playerid, pickupid))
	{

	}
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	new MsgAvisoBug[MAX_TEXT_CHAT];
    format(MsgAvisoBug, sizeof(MsgAvisoBug), "%s Tunning´s Owned - El jugador %s[%i] le puso un componente con ID[%i] al vehículo ID[%i].", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, componentid, vehicleid);
	MsgCheatsReportsToAdmins(MsgAvisoBug);
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	if ( PlayersDataOnline[playerid][InMenu] == Menu_Principal_Armas )
	{
	     ShowMenuForPlayer(Menues_Armas[row], playerid);
	     PlayersDataOnline[playerid][AfterMenuRow] = row;
	}
	else if ( PlayersDataOnline[playerid][InMenu] == CamerasM[0])
	{
     	if ( Cameras[row][Page] )
     	{
			SetPlayerCameraPos(playerid, Cameras[row][PosXLook], Cameras[row][PosYLook], Cameras[row][PosZLook]);
			SetPlayerCameraLookAt(playerid, Cameras[row][PosXAt], Cameras[row][PosYAt], Cameras[row][PosZAt]);
		    SetPlayerInteriorEx(playerid, Cameras[row][Interior]);
	     	SetPlayerVirtualWorldEx(playerid, Cameras[row][World]);
			ShowMenuForPlayer(CamerasM[0], playerid);
		}
	}
	else if ( PlayersDataOnline[playerid][InMenu] == Menues_Armas[PlayersDataOnline[playerid][AfterMenuRow]] )
	{
		PlayersDataOnline[playerid][SubAfterMenuRow] = row;
		if ( Armas_Municion[PlayersDataOnline[playerid][AfterMenuRow]][row] == 1 )
		{
			if ( CheckWeapondCheat(playerid) && PlayersData[playerid][Dinero] >= Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][row] )
			{
		        new MsgCompra[MAX_TEXT_CHAT];
			    if ( PlayersDataOnline[playerid][AfterMenuRow] == 8 && row == 1 )
			    {
                    format(MsgCompra, sizeof(MsgCompra), "Has comprado un chaleco por $%i", Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][row]);
					SetPlayerArmourEx(playerid, 80);
				}
				else
				{
                    format(MsgCompra, sizeof(MsgCompra), "Has comprado %s por $%i", Armas_Nombre[PlayersDataOnline[playerid][AfterMenuRow]][row][4], Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][row]);
                    GivePlayerWeaponEx(playerid, Armas_ID[PlayersDataOnline[playerid][AfterMenuRow]][row], 1);
				}
                SendInfoMessage(playerid, 2, "0", MsgCompra);
				GivePlayerMoneyEx(playerid, -Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][row]);
			}
			else
			{
				SendInfoMessage(playerid, 0, "356", "No tienes suficiente dinero para comprar este accesorio de la armeria");
			}
			ShowMenuForPlayer(Menues_Armas[PlayersDataOnline[playerid][AfterMenuRow]], playerid);
		}
		else
		{
		    new MsgComprarArmaDialogPresupuesto[MAX_TEXT_CHAT];
		    format(MsgComprarArmaDialogPresupuesto, sizeof(MsgComprarArmaDialogPresupuesto), "{F0F0F0}¿Desea comprar %s con %i de munición\n{F0F0F0}por el precio de $%i?",
			Armas_Nombre[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]][4],
			Armas_Municion[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]], Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]] * Armas_Municion[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]]);

			ShowPlayerDialogEx(playerid, 10, DIALOG_STYLE_MSGBOX, "{00A5FF}Finalize su compra!", MsgComprarArmaDialogPresupuesto, "Comprar!", "Modificar");
			PlayersDataOnline[playerid][MyAmmoSelect] = Armas_Municion[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]];
		}
	}
	else if ( PlayersDataOnline[playerid][InMenu] == M24_7 )
	{
		if (PlayersData[playerid][Dinero] >= M24_7_Precios[row] )
		{
		    if ( CheckWeapondCheat(playerid))
		    {
		        new PassSwitch = false;
				if ( row != 0 )
				{
				    switch(row)
				    {
	                    // Patines
				        case 1:
				        {
							new MsgCompra[MAX_TEXT_CHAT];
							format(MsgCompra, sizeof(MsgCompra), "Has comprado unos Patines por $%i.", M24_7_Precios[row]);
							SendInfoMessage(playerid, 3, "0", MsgCompra);
							print(MsgCompra);
							PassSwitch = true;
						}
	                    // Dados
				        case 2:
				        {
							new MsgCompra[MAX_TEXT_CHAT];
							format(MsgCompra, sizeof(MsgCompra), "Has comprado unos Dados por $%i.", M24_7_Precios[row]);
							SendInfoMessage(playerid, 3, "0", MsgCompra);
							print(MsgCompra);
							PassSwitch = true;
						}
						// Flores
				        case 3:
				        {
						    GivePlayerWeaponEx(playerid, 14, 1);
							new MsgCompra[MAX_TEXT_CHAT];
							format(MsgCompra, sizeof(MsgCompra), "Has comprado unas flores por $%i.", M24_7_Precios[row]);
							SendInfoMessage(playerid, 3, "0", MsgCompra);
							print(MsgCompra);
				        }
						//Condones
				        case 4:
				        {
							new MsgCompra[MAX_TEXT_CHAT];
							format(MsgCompra, sizeof(MsgCompra), "Has comprado unos Condones por $%i.", M24_7_Precios[row]);
							SendInfoMessage(playerid, 3, "0", MsgCompra);
							print(MsgCompra);
							PassSwitch = true;
				        }
						// Maleta
				        case 5:
				        {
				            if ( GetObjectByType(playerid, TYPE_MALETIN) == -1 )
				            {
								new MsgCompra[MAX_TEXT_CHAT];
								format(MsgCompra, sizeof(MsgCompra), "Has comprado un maletín por $%i.", M24_7_Precios[row]);
								SendInfoMessage(playerid, 3, "0", MsgCompra);
								print(MsgCompra);
								AddObjectHoldToPlayer(playerid, 1210);
							}
							else
							{
								SendInfoMessage(playerid, 0, "1548", "Tienes las manos ocupadas, no puedes llevar más nada en ellas!");
								PassSwitch = true;
							}
				        }
						default:
						{
							PassSwitch = true;
						}

					}
				}
				else
				{
				    GivePlayerWeaponEx(playerid, 43, 200);
					new MsgCompra[MAX_TEXT_CHAT];
					format(MsgCompra, sizeof(MsgCompra), "Has comprado una Cámara por $%i.", M24_7_Precios[row]);
					SendInfoMessage(playerid, 3, "0", MsgCompra);
					print(MsgCompra);
				}
				if ( row != 6 && row != 6 )
				{
					ShowMenuForPlayer(M24_7, playerid);
					PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
				}

				if ( PassSwitch )
				{
				    return 1;
				}
				else
				{
				    GivePlayerMoneyEx(playerid, -M24_7_Precios[row]);
				}
			}
			else
			{
				if ( row == 6 || row == 10 )
				{
					TogglePlayerControllableEx(playerid, true);
					PlayersDataOnline[playerid][SubAfterMenuRow] = 0;
					PlayersDataOnline[playerid][AfterMenuRow] 	 = 0;
				}
			}
		}
		else
		{
			SendInfoMessage(playerid, 0, "360", "No tienes suficiente dinero para comprar éste artículo del 24/7");
		}
		if ( row != 6 && row != 10)
		{
			ShowMenuForPlayer(M24_7, playerid);
			PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
		}
	}
	else if ( PlayersDataOnline[playerid][InMenu] == CluckinBell )
	{
		if (PlayersData[playerid][Dinero] >= CluckinBellPrecios[row] )
		{
		    GivePlayerMoneyEx(playerid, -CluckinBellPrecios[row]);
			SetPlayerHealthEx(playerid, CluckinBellPrecios[row]);
		}
		else
		{
			SendInfoMessage(playerid, 0, "329", "No tienes suficiente dinero para comprar esta comida del Cluckin' Bell");
		}
		ShowMenuForPlayer(CluckinBell, playerid);
	}
	else if ( PlayersDataOnline[playerid][InMenu] == BurgerShot)
	{
		if (PlayersData[playerid][Dinero] >= BurgerShotPrecios[row] )
		{
		    GivePlayerMoneyEx(playerid, -BurgerShotPrecios[row]);

			SetPlayerHealthEx(playerid, BurgerShotPrecios[row]);
			ShowMenuForPlayer(BurgerShot, playerid);
		}
		else
		{
			SendInfoMessage(playerid, 0, "327", "No tienes suficiente dinero para comprar esta comida del Burger Shot");
		}
		ShowMenuForPlayer(BurgerShot, playerid);
	}
	else if ( PlayersDataOnline[playerid][InMenu] == PizzaStack)
	{
		if (PlayersData[playerid][Dinero] >= PizzaStackPrecios[row] )
		{
		    GivePlayerMoneyEx(playerid, -PizzaStackPrecios[row]);

			SetPlayerHealthEx(playerid, PizzaStackPrecios[row]);
			ShowMenuForPlayer(PizzaStack, playerid);
		}
		else
		{
			SendInfoMessage(playerid, 0, "325", "No tienes suficiente dinero para comprar esta comida del Pizza Stack");
		}
		ShowMenuForPlayer(PizzaStack, playerid);
	}
	else if ( PlayersDataOnline[playerid][InMenu] == JaysDiner)
	{
		if (PlayersData[playerid][Dinero] >= JaysDinerPrecios[row] )
		{
			GivePlayerMoneyEx(playerid, -JaysDinerPrecios[row]);


			SetPlayerHealthEx(playerid, JaysDinerPrecios[row]);
			ShowMenuForPlayer(JaysDiner, playerid);
		}
		else
		{
			SendInfoMessage(playerid, 0, "323", "No tienes suficiente dinero para comprar esta comida del Restaurante");
		}
		ShowMenuForPlayer(JaysDiner, playerid);
	}
	else if ( PlayersDataOnline[playerid][InMenu] == RingDonuts)
	{
		if (PlayersData[playerid][Dinero] >= RingDonutsPrecios[row] )
		{
			    GivePlayerMoneyEx(playerid, -RingDonutsPrecios[row]);

				SetPlayerHealthEx(playerid, RingDonutsPrecios[row]);
				ShowMenuForPlayer(RingDonuts, playerid);
		}
		else
		{
			SendInfoMessage(playerid, 0, "321", "No tienes suficiente dinero para comprar esta comida del Restaurante");
		}
		ShowMenuForPlayer(RingDonuts, playerid);
	}
    PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	if ( PlayersDataOnline[playerid][InMenu] == CamerasM[0] )
	{
    	TogglePlayerSpectating(playerid, 0);
        PlayersDataOnline[playerid][Spawn]      = true;
    	SetSpawnInfoEx(playerid);
		TogglePlayerControllableEx(playerid, true);

		PlayersDataOnline[playerid][SubAfterMenuRow] = 0;
		PlayersDataOnline[playerid][AfterMenuRow] 	 = 0;
	}
	else if ( PlayersDataOnline[playerid][InMenu] != Menu_Principal_Armas &&
			  PlayersData[playerid][IsPlayerInBizz] &&
		 	  NegociosData[PlayersData[playerid][IsPlayerInBizz]][Type] >= 8 &&
   	     	  NegociosData[PlayersData[playerid][IsPlayerInBizz]][Type] <= 12 )
	{
	     ShowMenuForPlayer(Menu_Principal_Armas, playerid);
	     PlayersDataOnline[playerid][InMenu] = GetPlayerMenu(playerid);
	}
	else if ( PlayersDataOnline[playerid][InMenu] == Menu_Principal_Armas)
	{
		TogglePlayerControllableEx(playerid, true);
		PlayersDataOnline[playerid][SubAfterMenuRow] = 0;
		PlayersDataOnline[playerid][AfterMenuRow] 	 = 0;
	}
	else
	{
		TogglePlayerControllableEx(playerid, true);
		PlayersDataOnline[playerid][SubAfterMenuRow] = 0;
		PlayersDataOnline[playerid][AfterMenuRow] 	 = 0;
	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	/*
	 16 - 1	= Enter 			- Entrar a un coche
	  2 	= C       			- Agacharse
	 32 	= CONTROL 			- Saltar
	  8 	= SHIFT Y ESPACIO	- Correr
	  4     = Click izquierdo (MAYUS)  - Golpear, acciones
	128     = Click derecho		- Apuntar (Sin coche)
	128     = ESPACIO			- Frenar (En coche)
	8     	= ESPACIO			- Frenar (En coche)
	512     = Rueda del ratón   - Rueda del ratón
	  1     = TAB               - Musestra los jugadores online
  1024      = DEL               - Andar (Caminar suave)
  2048      = J                 - Nada
  4096      = K                 - Nada
	*/
	/*new Keys[MAX_TEXT_CHAT]; format(Keys, sizeof(Keys), "Key: %i", newkeys);
    SendClientMessage(playerid, COLOR_MESSAGES[0], Keys);*/

	if (newkeys == 16 || newkeys == 8192)
	{
		if(PlayersDataOnline[playerid][InPickup] != -1)
		{
		    if (PlayersDataOnline[playerid][InPickupTele])
		    {
		        if ( !IsPlayerInAnyVehicle(playerid) && IsPlayerInRangeOfPoint(playerid, 2.0, PlayersDataOnline[playerid][MyPickupX_Now], PlayersDataOnline[playerid][MyPickupY_Now], PlayersDataOnline[playerid][MyPickupZ_Now]))
		        {
		            if ( !PlayersDataOnline[playerid][MyPickupLock] || PlayersDataOnline[playerid][AdminOn] &&  PlayersData[playerid][Admin] >= 4 )
		            {
					    TextDrawHideForPlayer(playerid, PlayersDataOnline[playerid][MyTextDrawShow]);
				        if ( PlayersDataOnline[playerid][InPickup] >= NegociosData[1][PickupOutId] &&
				             PlayersDataOnline[playerid][InPickup] <= NegociosData[MAX_BIZZ][PickupOutId] ||
							 Teles[PickUpAlambraAndJizzy[0]][PickupIDGo] == PlayersDataOnline[playerid][InPickup] ||
							 Teles[PickUpAlambraAndJizzy[1]][PickupIDGo] == PlayersDataOnline[playerid][InPickup] )
				        {
							if (PlayersData[playerid][Dinero] >= NegociosData[PlayersDataOnline[playerid][MyPickupWorld]][PriceJoin] )
							{
							    NegociosData[PlayersDataOnline[playerid][MyPickupWorld]][Deposito] = NegociosData[PlayersDataOnline[playerid][MyPickupWorld]][Deposito] + NegociosData[PlayersDataOnline[playerid][MyPickupWorld]][PriceJoin];
							    GivePlayerMoneyEx(playerid, -NegociosData[PlayersDataOnline[playerid][MyPickupWorld]][PriceJoin]);
						        SetFunctionsForBizz(playerid, NegociosData[PlayersDataOnline[playerid][MyPickupWorld]][Type]);
						        PlayersData[playerid][IsPlayerInBizz] = PlayersDataOnline[playerid][MyPickupWorld];
							}
							else
							{
								SendInfoMessage(playerid, 0, "295", "No tienes suficiente dinero para entrar a este negocio");
								return 1;
							}
				        }
						else if ( PlayersDataOnline[playerid][InPickup] >= HouseData[1][PickupId] &&
				  				  PlayersDataOnline[playerid][InPickup] <= HouseData[MAX_HOUSE][PickupId] )
				        {
							PlayersData[playerid][IsPlayerInHouse] = PlayersDataOnline[playerid][MyPickupWorld];
				        }
					    // GARAGES TYPE
					    else if ( PlayersDataOnline[playerid][InPickup] >= TypeGarage[0][PickupId] &&
					          	  PlayersDataOnline[playerid][InPickup] <= TypeGarage[MAX_GARAGE_TYPE][PickupIdh] &&
								  PlayersDataOnline[playerid][MyPickupWorld] )
					    {
   					    	PlayersData[playerid][IsPlayerInHouse] = PlayersDataOnline[playerid][MyPickupWorld];
					        if ( IsGarageToHouse(playerid, PlayersDataOnline[playerid][InPickup]) )
					        {
                              	PlayersData[playerid][IsPlayerInGarage] =  -1;
                            }
                            else
                            {
                            PlayersData[playerid][IsPlayerInGarage] =  PlayersData[playerid][IsPlayerInGarage] + 50;
							}
				        }
					    else if ( PlayersDataOnline[playerid][InPickup] >= MIN_GARAGE_PICKUP &&
					          	  PlayersDataOnline[playerid][InPickup] <= MAX_GARAGE_PICKUP )
					    {
					    	PlayersData[playerid][IsPlayerInHouse] 	= PlayersDataOnline[playerid][InPickupTele];
                            PlayersData[playerid][IsPlayerInGarage] =  PlayersData[playerid][IsPlayerInGarage] + 50;
					    }
					    else if ( PlayersDataOnline[playerid][InPickup] == BANCO_PICKUPID_out )
					    {
							PlayersData[playerid][IsPlayerInBank] = true;
						}
					  	DisablePlayerCheckpoint(playerid);
					   	PlayersData[playerid][IsPlayerInHouse] 		= false;
					   	PlayersData[playerid][IsPlayerInBizz] 		= false;
						PlayersData[playerid][IsPlayerInBank] = false;
						PlayersData[playerid][IsPlayerInGarage] 	= -1;

						new InterioridTele = PlayersDataOnline[playerid][MyPickupInterior];
						new WorldTele = PlayersDataOnline[playerid][MyPickupWorld];
						SetPlayerInteriorEx(playerid, InterioridTele);
						SetPlayerVirtualWorldEx(playerid, WorldTele);
					    SetPlayerPos(playerid, PlayersDataOnline[playerid][MyPickupX], PlayersDataOnline[playerid][MyPickupY], PlayersDataOnline[playerid][MyPickupZ]);
						SetPlayerFacingAngle(playerid, PlayersDataOnline[playerid][MyPickupZZ]);
						SetCameraBehindPlayer(playerid);
			            if ( PlayersData[playerid][IsPlayerInVehInt] )
			            {
			                 PlayersData[playerid][IsPlayerInVehInt] = WorldTele;
			            }

						if(PlayersDataOnline[playerid][IsEspectando])
						{
							UpdateSpectatedPlayers(playerid, false, InterioridTele, WorldTele);
						}
						if ( newkeys == 8192 )
						{
							SetPlayerSpecialAction(playerid, 0);
					    	ClearAnimations(playerid, true);
							SetPlayerSpecialAction(playerid, PlayersDataOnline[playerid][InSpecialAnim]);
						}
					}
					else
					{
						GameTextForPlayer(playerid, "~W~Puerta ~R~Cerrada!", 1000, 6);
					}
				}
		    }
		}
		else if ( PlayersDataOnline[playerid][InAnim] )
		{
		    ApplyAnimation(playerid,"PED",PED_ANIMATIONS[ModeWalkID[4]], 4.0, 0, 1, 1, 0, 1, 1);
			PlayersDataOnline[playerid][InAnim] = false;
		}
	}
	else if ( newkeys == 16384 )
	{
		RemoveSpectatePlayer(playerid);
	}
	else if ( newkeys == 0 )
	{
	    if ( PlayersDataOnline[playerid][InWalk])
	    {
		    ApplyAnimation(playerid,"PED",PED_ANIMATIONS[ModeWalkID[PlayersData[playerid][MyStyleWalk]]], 4.0, 0, 1, 1, 0, 1, 1);
		    PlayersDataOnline[playerid][InWalk] = false;
		}
	}
	else if ( newkeys == 1024)
	{
		ApplyPlayerAnimCustom(playerid,
		"PED",
		PED_ANIMATIONS[ModeWalkID[PlayersData[playerid][MyStyleWalk]]], true);
		PlayersDataOnline[playerid][InWalk] = true;
	}
	else if ( newkeys == 8)
	{
	    if ( PlayersDataOnline[playerid][Espectando] != -1 )
	    {
			SetPlayerSpectateToPlayer(playerid, PlayersDataOnline[playerid][Espectando]);
		}
		/*if (!IsPlayerInAnyVehicle(playerid))
		{
			ApplyPlayerAnimCustom(playerid,
			ModeSprintLibraryAnim[PlayersData[playerid][MyStyleSprint]],
			ModeSprintNameAnim[PlayersData[playerid][MyStyleSprint]], true);
			PlayersDataOnline[playerid][InWalk] = true;
		}*/
	}
	else if ( newkeys == 4 )
	{
	    if ( GetPlayerSpecialAction(playerid) == 22 || GetPlayerSpecialAction(playerid) == 21 )
	    {
	        SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid) + 200);
		    if ( GetPlayerDrunkLevel(playerid) >= 20000 )
		    {
			    GameTextForPlayer(playerid, "~W~Vaya ~B~nota llevas!", 5000, 1);
				SetPlayerSpecialAction(playerid, 0);
			}
		    if ( GetPlayerDrunkLevel(playerid) >= 5000 )
		    {
				ApplyPlayerAnimCustom(playerid,
				"PED",
				PED_ANIMATIONS[257], true);
		    }
		}
		/*if ( !PlayersDataOnline[playerid][ModeDM] )
		{
			CheckWeapondCheat(playerid);
		}*/
		if ( !PlayersData[playerid][IntermitentState] )
		{
			IntermitenteEncendido(playerid);
		}
		LastPlayerSpect(playerid);
	}
	else if ( newkeys == 128 || newkeys == 512 )
	{
	    if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && coches_Todos_Type[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400] == COCHE )
	    {
 			ApplyPlayerAnimCustom(playerid,
			"CAR",
			CAR_ANIMATIONS[4], false);
	    }
		/*if ( !PlayersDataOnline[playerid][ModeDM] )
		{
			CheckWeapondCheat(playerid);
		}*/
		NextPlayerSpect(playerid);
	}
	else if ( newkeys == 2048 )
	{
		if ( !PlayersData[playerid][IntermitentState] )
		{
			IntermitenteIzquierdo(playerid);
		}
	}
	else if ( newkeys == 4096 )
	{
		if ( !PlayersData[playerid][IntermitentState] )
		{
			IntermitenteDerecho(playerid);
		}
	}
	else if ( newkeys == 132 )
	{
		if ( !PlayersData[playerid][IntermitentState] )
		{
			IntermitenteEstacionamiento(playerid);
		}
	}
	else if ( newkeys == 2 )
	{
	    if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) != 0 && PlayersDataOnline[playerid][IsCleanAnimCar] == 2 && GetPlayerWeapon(playerid))
	    {
			PlayersDataOnline[playerid][LastWeapondRow] = GetPlayerWeapon(playerid);
			PlayersDataOnline[playerid][IsCleanAnimCar] = 0;
            SetPlayerArmedWeapon(playerid, 0);
	        if ( coches_Todos_Type[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400] == MOTO )
	        {
	 			ApplyPlayerAnimCustom(playerid,
				"MD_CHASE",
				CHASE_ANIMATIONS[3], false);
			}
			else
			{
	 			ApplyPlayerAnimCustom(playerid,
				"PED",
				PED_ANIMATIONS[59], false);
			}
		}
		else if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) != 0 && PlayersDataOnline[playerid][IsCleanAnimCar] <= 1)
		{
			SetPlayerArmedWeapon(playerid, PlayersDataOnline[playerid][LastWeapondRow]);
			PlayersDataOnline[playerid][IsCleanAnimCar]++;
		}
		else if ( PlayersDataOnline[playerid][InCarId] && IsPlayerInVehicle(playerid, PlayersDataOnline[playerid][InCarId])  && GetPlayerVehicleSeat(playerid) == 0  )
		{
			GetMyNearDoor(playerid, true, false);
			if ( !IsPlayerNearGarage(GetPlayerVehicleID(playerid), playerid) )
			{
				IsPlayerNearGarageEx(GetPlayerVehicleID(playerid), playerid);
			}
		}
	}
	else if ( newkeys == 1 )
	{
	    if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 525 ||
			 IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 515 ||
 			 IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 514 ||
 			 IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 )
		{
			new MySecondNearVehicle = GetMySecondNearVehicle(playerid);
			if ( GetVehicleModel(GetPlayerVehicleID(playerid)) == 515 && GetVehicleModel(MySecondNearVehicle) != 591 &&
				 GetVehicleModel(GetPlayerVehicleID(playerid)) == 515 && GetVehicleModel(MySecondNearVehicle) != 435 &&
				 GetVehicleModel(GetPlayerVehicleID(playerid)) == 515 && GetVehicleModel(MySecondNearVehicle) != 584 ||
				 GetVehicleModel(GetPlayerVehicleID(playerid)) == 514 && GetVehicleModel(MySecondNearVehicle) != 591 &&
				 GetVehicleModel(GetPlayerVehicleID(playerid)) == 514 && GetVehicleModel(MySecondNearVehicle) != 435 &&
				 GetVehicleModel(GetPlayerVehicleID(playerid)) == 514 && GetVehicleModel(MySecondNearVehicle) != 584 ||
				 GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 && GetVehicleModel(MySecondNearVehicle) != 591 &&
				 GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 && GetVehicleModel(MySecondNearVehicle) != 435 &&
				 GetVehicleModel(GetPlayerVehicleID(playerid)) == 403 && GetVehicleModel(MySecondNearVehicle) != 584  )
			{
				return 1;
			}
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	if ( !success )
	{
	    new MenjaseFailLogin[120];

		new IpBan[120];
		for (new i = 0; i < MAX_PLAYERS; i++)
		{
		    if ( IsPlayerConnected(i) )
			{
				GetPlayerIp(i, IpBan, sizeof(IpBan));
			}
			else
			{
			    continue;
			}

		    if ( strcmp(ip, IpBan, true) == 0 )
		    {
		        new Nombre[35];
				GetPlayerName(i, Nombre, sizeof(Nombre));
				format(MenjaseFailLogin, sizeof(MenjaseFailLogin), "%s Posible ataque DDoS por RconLogin password \"%s\" Usuario: \"%s\" desde la IP: %s",LOGO_STAFF, password, Nombre, ip);
				SendInfoMessage(i, 2, "0", "Good Bye!");
		        Ban(i);
				break;
			}
		}
		MsgCheatsReportsToAdmins(MenjaseFailLogin);
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
    /*if(GetPlayerAnimationIndex(playerid))
    {
        new animlib[32];
        new animname[32];
        new msg[128];
        GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,32,animname,32);
        format(msg, 128, "Running anim: %s %s", animlib, animname);
        SendClientMessage(playerid, 0xFFFFFFFF, msg);
    }*/
    //////////////// The begin.
	if ( PlayersDataOnline[playerid][State] == 3 )
	{
	    switch(GetPlayerWeapon(playerid))
	    {
	      case 44, 45:
	      {
	        new keys, ud, lr;
	        GetPlayerKeys(playerid, keys, ud, lr);
	        if((keys & KEY_FIRE) && (!IsPlayerInAnyVehicle(playerid)))
	            {
	              return 0;
	            }
	        }
	    }
  		//////////////// Mode Death Match
	    /*if (!PlayersDataOnline[playerid][ModeDM])
	    {*/
	    /*static Keys,UD,LR;
	    GetPlayerKeys(playerid,Keys,UD,LR);
	    if(LR > 0 || LR < 0 || UD > 0 || UD < 0)
	    {
			if ( PlayersData[playerid][Cansansio] <= 1 )
			{
				ApplyAnimation(playerid,"PED",PED_ANIMATIONS[258], 4.0, 0, 1, 1, 0, 1, 1);
			}
		else
		{
			if ( PlayersData[playerid][Cansansio] <= 1 )
			{
				ApplyAnimation(playerid,"FAT",FAT_ANIMATIONS[17], 4.0, 1, 1, 1, 1, 1, 1);
			}
		}
		}*/
		//}
        //////////////// The Time....
//	    static MyTime; MyTime = gettime();

        //////////////// The Check Fire....
	    /*if ( (MyTime - PlayersDataOnline[playerid][IsCheckAudio]) >= 1)
	    {
	        PlayersDataOnline[playerid][IsCheckAudio]= MyTime;
			PlayAllEcualizerForVehicle(playerid);
			PlayAllEcualizerForHouse(playerid);
	    }
		if ( HaveObjectByTypeAndShow(playerid, TYPE_TASER) )
		{
			SetPlayerArmedWeapon(playerid, 0);
		}*/
        //////////////// Check TextDraws Teles
		HideTextDrawsTelesAndInfo(playerid);

        //////////////// Jail
		/*if ( PlayersData[playerid][IsInJail] != -1 && PlayersData[playerid][Jail] <= MyTime )
		{
			PlayersData[playerid][Jail] = 0;
			PlayersDataOnline[playerid][StateDeath] = 4;
			SetPlayerVirtualWorldEx(playerid, JailsType[PlayersData[playerid][IsInJail]][WorldLiberado]);
			SetPlayerInteriorEx(playerid, JailsType[PlayersData[playerid][IsInJail]][Interior_Liberado]);
		    PlayersData[playerid][IsInJail] = -1;
			SendInfoMessage(playerid, 2, "0", "Has cumplido tu condena de jail.");
		    SpawnPlayerEx(playerid);
		}*/

        //////////////// AdminOn
		if ( PlayersDataOnline[playerid][AdminOn] )
		{
			SetPlayerHealth(playerid, INFINITY_HEALTH);
			PlayersDataOnline[playerid][ChangeVC] = 10;
		}
        //////////////// Check Health...
		else
		{
			GetPlayerHealth(playerid, PlayersDataOnline[playerid][CurrentHealth]);
			GetPlayerArmour(playerid, PlayersDataOnline[playerid][CurrentArmour]);
			if ( PlayersDataOnline[playerid][ChangeVC] <= 0 )
			{
			    UpdateArmourAndArmour(playerid, PlayersDataOnline[playerid][CurrentHealth], PlayersDataOnline[playerid][CurrentArmour]);
				if ( PlayersDataOnline[playerid][CurrentHealth] <= VIDA_CRACK)
				{
					ApplyAnimation(playerid,"CRACK",CRACK_ANIMATIONS[4], 4.0, 1, 1, 1, 1, 1, 1);
				}
			}
			else if( PlayersDataOnline[playerid][ChangeVC] )
			{
		        SetPlayerHealth(playerid, PlayersDataOnline[playerid][VidaOn]);
		        SetPlayerArmour(playerid, PlayersDataOnline[playerid][ChalecoOn]);
			    PlayersDataOnline[playerid][ChangeVC]--;
			}
		}
        //////////////// Vehicles...
	    if ( IsPlayerInAnyVehicle(playerid) )
	    {
	        if ( !PlayersDataOnline[playerid][InCarId] && !PlayersDataOnline[playerid][InVehicle] )
	        {
		        if ( IsVehicleOpen(playerid, GetPlayerVehicleID(playerid), GetPlayerVehicleSeat(playerid)))
		        {
		        	if ( coches_Todos_Type[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400] != BICI )
		        	{
						if ( GetPlayerVehicleSeat(playerid) == 0 )
						{
					    	PlayersDataOnline[playerid][InCarId] = GetPlayerVehicleID(playerid);
							ShowTextDrawFijosVelocimentros(playerid);
							
							DataCars[PlayersDataOnline[playerid][InCarId]][GasNotShow] = true;

							IsVehicleOff(PlayersDataOnline[playerid][InCarId]);
							
							
						    if ( PlayersDataOnline[playerid][InCarId] <= MAX_CAR_DUENO && DataCars[PlayersDataOnline[playerid][InCarId]][Puente] && strlen(DataCars[PlayersDataOnline[playerid][InCarId]][Dueno]) == 1)
						    {
							}
							else if ( !DataCars[PlayersDataOnline[playerid][InCarId]][StateEncendido] )
							{
							    SendInfoMessage(playerid, 2, "0", "Éste vehículo se encuentra apagado. Usa (Click Izquierdo) o (Enter)");
							}

							static Float:Estado; GetVehicleHealth(PlayersDataOnline[playerid][InCarId], Estado);
							DataCars[PlayersDataOnline[playerid][InCarId]][LastDamage]     = Estado;
	                        UpdateDamage(playerid, Estado);
							UpdateGasAndOil(PlayersDataOnline[playerid][InCarId]);
//							DataCars[PlayersDataOnline[playerid][InCarId]][LastVelocityInt] 	= GetVehicleVelocityEx(PlayersDataOnline[playerid][InCarId]);
							//OnPlayerEnterVehicleEx(playerid, PlayersDataOnline[playerid][InCarId], 0);
						}
						else
						{
							PlayersDataOnline[playerid][InVehicle] = GetPlayerVehicleID(playerid);
//							OnPlayerEnterVehicleEx(playerid, PlayersDataOnline[playerid][InVehicle], GetPlayerVehicleSeat(playerid));
						}
					}
				}
				else
				{
//					RemovePlayerFromVehicle(playerid);
					IsFixBikeEnter(playerid, GetPlayerVehicleID(playerid));
				}
			}
			else if ( PlayersDataOnline[playerid][InCarId] )
			{
	            if ( GetPlayerVehicleID(playerid) == PlayersDataOnline[playerid][InCarId] )
				{
					UpdateTextDrawVehicle(playerid, PlayersDataOnline[playerid][InCarId]);
					if ( DataCars[PlayersDataOnline[playerid][InCarId]][StateEncendido] )
					{
						if ( DataCars[PlayersDataOnline[playerid][InCarId]][Gas] < 1 && DataCars[PlayersDataOnline[playerid][InCarId]][GasNotShow] )
					    {
						    DataCars[PlayersDataOnline[playerid][InCarId]][GasNotShow] = false;
							SendClientMessage(playerid, COLOR_MESSAGES[0], " Vehículo sin gas! Use (Enter) para salir del mismo");
						}
						if ( DataCars[PlayersDataOnline[playerid][InCarId]][TemperaturaC] )
						{
							Acciones(playerid, 7, "Vehículo: Sobrecalentado.");
						}
	 					if ( DataCars[PlayersDataOnline[playerid][InCarId]][Gas] < 1)
						{
							DataCars[PlayersDataOnline[playerid][InCarId]][StateEncendido] = false;
							DataCars[PlayersDataOnline[playerid][InCarId]][TemperaturaC] = false;
							IsVehicleOff(PlayersDataOnline[playerid][InCarId]);
						}
					}
					if ( DataCars[PlayersDataOnline[playerid][InCarId]][LockPolice] )
					{
						SetVehicleVelocity(PlayersDataOnline[playerid][InCarId], 0.0, 0.0, 0.0);
					}
				}
				else
				{
//				    RemovePlayerFromVehicleEx(playerid, false, MyTime);
				}
			}
			else if ( PlayersDataOnline[playerid][InVehicle] )
			{
				if ( GetPlayerVehicleID(playerid) != PlayersDataOnline[playerid][InVehicle] )
				{
//    				RemovePlayerFromVehicleEx(playerid, true, MyTime);
				}
			}
    	}
    	else
    	{
	        if ( PlayersDataOnline[playerid][InCarId])
	        {
//			    RemovePlayerFromVehicleEx(playerid, false, MyTime);
	        }
	        else if ( PlayersDataOnline[playerid][InVehicle] )
	        {
//			    RemovePlayerFromVehicleEx(playerid, true, MyTime);
			}
    	}

	    //////////////// Anticheat Money...
		if ( PlayersData[playerid][Dinero] != GetPlayerMoney(playerid) )
		{
/*		    if ( PlayersDataOnline[playerid][StateMoneyPass] <= MyTime )
			{
				IsCheatMoney(playerid, GetPlayerMoney(playerid));
			}*/
			ResetPlayerMoney(playerid);
			GivePlayerMoney(playerid, PlayersData[playerid][Dinero]);
		}

		return CheckWeapondCheat(playerid);
	}
	else
	{
	    return 0;
	}
}
// aca voy
public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if ( PlayersDataOnline[playerid][CurrentDialog] != dialogid )
	{
		SendInfoMessage(playerid, 0, "016", "Hacking attempt? || Why? Because this's Another Reality!");
		return true;
	}
	switch ( dialogid )
	{
	    // LOGIN
	    case 1:
	    {
	        if ( response == 1 )
	        {
	            if ( PlayersData[playerid][AccountState] != 3 )
	            {
			        if ( strcmp(PlayersData[playerid][Password], inputtext, false) == 0 && strlen(inputtext) ==  strlen(PlayersData[playerid][Password]))
			        {
						KillTimer(PlayersDataOnline[playerid][TimerLoginId]);

						new HoraPaga, MinutosPaga, SegundosPaga;
						gettime(HoraPaga, MinutosPaga, SegundosPaga);
						
						if ( PlayersData[playerid][Interior] == 0 && PlayersData[playerid][World] == 0)
						{
							PlayersData[playerid][Spawn_Z] = PlayersData[playerid][Spawn_Z] + 2;
						}

						GetPlayerIp(playerid, PlayersData[playerid][MyIP],16);
						SetPlayerColorEx(playerid);

						SetPlayerScore(playerid, PlayersData[playerid][KilledCount]);
//   						SetSpawnInfo(playerid, -1, PlayersData[playerid][Skin],	PlayersData[playerid][Spawn_Y], PlayersData[playerid][Spawn_Y], PlayersData[playerid][Spawn_Z], PlayersData[playerid][Spawn_ZZ], 0, 0, 0, 0, 0, 0);
						UpdateSpawnPlayer(playerid);

					    SpawnPlayer(playerid);
						PlayersDataOnline[playerid][ChalecoOn] = PlayersData[playerid][Chaleco];
						PlayersDataOnline[playerid][VidaOn] = PlayersData[playerid][Vida];
						SetPlayerVirtualWorld(playerid, 0);
					  	SetPlayerInteriorEx(playerid, 0);
					  	SetPlayerFightingStyle(playerid, 26);
					  	SetPlayerTeamEx(playerid);
					  	GivePlayerMoney(playerid, PlayersData[playerid][Dinero]);
//						Streamer_UpdateEx(playerid, PlayersData[playerid][Spawn_X], PlayersData[playerid][Spawn_Y], PlayersData[playerid][Spawn_Z]);


						PlayersDataOnline[playerid][StateMoneyPass] 	= gettime() + 5;
					    PlayersDataOnline[playerid][StateWeaponPass] 	= gettime() + 5;
//						LoadAccountBanking(playerid);
						RemoveBuildingForPlayerEx(playerid);

        			    PlayersDataOnline[playerid][State] = 3;

						//PlayerPlaySound(playerid, 1186, -1999.2559, 743.3678, 58.7168);
						//StopAudioStreamForPlayer(playerid);
						new HiMsg[45];
						format(HiMsg, sizeof(HiMsg), "~W~Buenas!~N~~B~%s", PlayersDataOnline[playerid][NameOnline]);
						GameTextForPlayer(playerid, HiMsg, 1000, 1);
						
						printf("%s[%i] Logueado!", PlayersDataOnline[playerid][NameOnline], playerid);
					}
					else
					{
						ShowPlayerLogin(playerid, false);
						SendInfoMessage(playerid, 0, "017", "Contraseña incorrecta, vuelva a intentarlo");
					}
			    }
			    else
			    {
					SendInfoMessage(playerid, 0, "018", "Esta cuenta se encuentra baneada.");
					SendInfoMessage(playerid, 1, "Ayuda: ", "Apelaciones en la web, gracias.");
				    KickEx(playerid, 3);
				}
			}
			else
			{
				ShowPlayerLogin(playerid, true);
			}
		}
		// REGISTRO
		case 2:
		{
	        if ( response == 1 )
	        {
				if ( strlen(inputtext) >= 4 && strlen(inputtext) <= 25)
				{
				    if ( IsValidStringServerOther(playerid, inputtext) )
				    {
						format(PlayersData[playerid][Password], 25, "%s", inputtext);
						ShowPlayerDialogEx(playerid, 3, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Sexo", "{F0F0F0}¿Cuál es el sexo de su skin?", Sexos[1], Sexos[0]);

						//StopAudioStreamForPlayer(playerid);
						//PlayerPlaySound(playerid, 1186, -1999.2559, 743.3678, 58.7168);
					}
					else
					{
						ShowPlayerRegister(playerid, false);
					}
				}
				else
				{
					ShowPlayerRegister(playerid, false);
					SendInfoMessage(playerid, 0, "019", "Contraseña muy corta, debe contener más de 4 caracteres y menos de 25");
				}
			}
			else
			{
				SendInfoMessage(playerid, 2, "0", "Recuerde que para ingresar el servidor debe regístrarse. Vuelva pronto!");
				KickEx(playerid, 5);
			}
		}
		// SEXO
		case 3:
		{
			KillTimer(PlayersDataOnline[playerid][TimerLoginId]);
			GetPlayerIp(playerid, PlayersData[playerid][MyIP],16);
		    UpdateSpawnPlayer(playerid);
  			SetPlayerFightingStyle(playerid, 26);
			PlayersDataOnline[playerid][State] = 3;
			GivePlayerMoneyEx(playerid, 0);
		    SpawnPlayerEx(playerid);
		    SetPlayerVirtualWorldEx(playerid, 0);

		    DataUserSave(playerid);
//			LoadAccountBanking(playerid);
			SetPlayerColorEx(playerid);
		  	SetPlayerTeamEx(playerid);
			
			RemoveBuildingForPlayerEx(playerid);
			new HoraPaga, MinutosPaga, SegundosPaga;
			gettime(HoraPaga, MinutosPaga, SegundosPaga);

			
		    TogglePlayerControllableEx(playerid, true);
			PlayersDataOnline[playerid][IsNotSilenciado] = true;
			PlayersData[playerid][Sexo] = response;
   		    if ( response == 1 )
		    {
				PlayersData[playerid][Skin] = 233;
			}
        }
		//      TIPO DE SKIN A ESCOGER
		case 4:
		{
			PlayersDataOnline[playerid][TypeSkinList] = response;
			SetPlayerSelectedSkin(playerid);
	    }
		//  SKIN
		case 5:
		{
			SetPlayerRowSkin(playerid, response);
		}
		// RESET SERVER
		case 6:
		{
   		    if ( response == 1 )
		    {
		        if ( strlen(inputtext) > 0 )
				{
					format(ReasonReset, sizeof(ReasonReset), "{47EA1A}Razón de reinicio: {C546AE}%s.", inputtext);
				}
				else
				{
					format(ReasonReset, sizeof(ReasonReset), "{47EA1A}Razón de reinicio: {C546AE}No anunciada.");
				}
				ResetServer();
			}
		}
		case 7:
		{
   		    if ( response == 1 )
		    {
		        new IsBombNear = IsPlayerNearBomba(playerid, 250.0, PlayersDataOnline[playerid][SaveAfterAgenda][listitem]);
		        if ( IsBombNear != -1 )
		        {
	                if ( ActivarBomba(IsBombNear, 20) )
	                {
						ShowPlayerDialogEx(playerid,11,DIALOG_STYLE_MSGBOX,"{FF0000}[SGW] Bombas - Control Detonación", "{00F50A}Bomba detonada exitosamente!", "Ok", "Volver");
					}
					else
					{
						ShowPlayerDialogEx(playerid,11,DIALOG_STYLE_MSGBOX,"{FF0000}[SGW] Bombas - Control Error", "{F50000}Error al detonar la bomba!\n Al parecer ya fue detonada por otro miembro!", "Ok", "Volver");
					}
            	}
				else
				{
					ShowPlayerDialogEx(playerid,11,DIALOG_STYLE_MSGBOX,"{FF0000}[SGW] Bombas - Control Error", "{00F50A}Error de conexión con la bomba\n intente acercarse más a la misma para detonarla!", "Ok", "Volver");
				}
		    }
	    }
		case 8:
		{
   		    if ( response == 0 )
		    {
				ShowBombas(playerid);
		    }
	    }
		//      MENU ARMAS - CALCULAR
		case 9:
		{
   		    if ( response == 1 )
		    {
				if ( strval(inputtext) >= 10 && strval(inputtext) <= 1000)
				{
				    PlayersDataOnline[playerid][MyAmmoSelect] = strval(inputtext);
				    new MsgComprarArmaDialogPresupuesto[MAX_TEXT_CHAT];
				    format(MsgComprarArmaDialogPresupuesto, sizeof(MsgComprarArmaDialogPresupuesto), "{F0F0F0}¿Desea comprar %s con %i de munición\n{F0F0F0}por el precio de $%i?", Armas_Nombre[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]][4], PlayersDataOnline[playerid][MyAmmoSelect], Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]] * strval(inputtext));
					ShowPlayerDialogEx(playerid, 10, DIALOG_STYLE_MSGBOX, "{00A5FF}Finalize su compra!", MsgComprarArmaDialogPresupuesto, "Comprar!", "Modificar");
				}
				else
				{
				    new MsgComprarArmaDialog[MAX_TEXT_CHAT];
				    format(MsgComprarArmaDialog, sizeof(MsgComprarArmaDialog), "{F0F0F0}Ingrese el número de munición \n{F0F0F0}que desea para %s", Armas_Nombre[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]][4]);
					ShowPlayerDialogEx(playerid, 9, DIALOG_STYLE_INPUT, "{00A5FF}Seleccione Cantidad de munición", MsgComprarArmaDialog, "Calcular", "Volver");
					SendInfoMessage(playerid, 0, "357", "El mínimo de munición para comprar un arma es 10 y máximo 1000");
				}
			}
			else
			{
				ShowMenuForPlayer(Menues_Armas[PlayersDataOnline[playerid][AfterMenuRow]], playerid);
			}
		}
		//      MENU ARMAS - COMPRAR
		case 10:
		{
   		    if ( response == 1 )
		    {
				if ( CheckWeapondCheat(playerid) && PlayersData[playerid][Dinero] >= Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]] * PlayersDataOnline[playerid][MyAmmoSelect] )
				{
			        new MsgCompra[MAX_TEXT_CHAT];
                    format(MsgCompra, sizeof(MsgCompra), "Has comprado %s por $%i", Armas_Nombre[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]][4], Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]] * PlayersDataOnline[playerid][MyAmmoSelect]);
                    GivePlayerWeaponEx(playerid, Armas_ID[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]], PlayersDataOnline[playerid][MyAmmoSelect]);

	                SendInfoMessage(playerid, 2, "0", MsgCompra);
					GivePlayerMoneyEx(playerid, -(Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]] * PlayersDataOnline[playerid][MyAmmoSelect]) );
					
					ShowMenuForPlayer(Menues_Armas[PlayersDataOnline[playerid][AfterMenuRow]], playerid);
				}
				else
				{
					SendInfoMessage(playerid, 0, "358", "No tienes suficiente dinero para comprar esta arma con esa munición");
				    new MsgComprarArmaDialogPresupuesto[MAX_TEXT_CHAT];
				    format(MsgComprarArmaDialogPresupuesto, sizeof(MsgComprarArmaDialogPresupuesto), "{F0F0F0}¿Desea comprar %s con %i de munición\n{F0F0F0}por el precio de $%i?", Armas_Nombre[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]][4], PlayersDataOnline[playerid][MyAmmoSelect], Armas_Precios_Num[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]] * PlayersDataOnline[playerid][MyAmmoSelect]);
					ShowPlayerDialogEx(playerid, 10, DIALOG_STYLE_MSGBOX, "{00A5FF}Finalize su compra!", MsgComprarArmaDialogPresupuesto, "Comprar!", "Modificar");
				}
		    }
		    else
		    {
			    new MsgComprarArmaDialog[MAX_TEXT_CHAT];
			    format(MsgComprarArmaDialog, sizeof(MsgComprarArmaDialog), "{F0F0F0}Ingrese el número de munición \n{F0F0F0}que desea para %s", Armas_Nombre[PlayersDataOnline[playerid][AfterMenuRow]][PlayersDataOnline[playerid][SubAfterMenuRow]][4]);
				ShowPlayerDialogEx(playerid, 9, DIALOG_STYLE_INPUT, "{00A5FF}Seleccione Cantidad de munición", MsgComprarArmaDialog, "Calcular", "Volver");
			}
		}
		case 11:
		{
   		    if ( response == 0 )
		    {
				ShowBombas(playerid);
		    }
	    }
		// ShowObjectos
		case 12:
		{
		    if ( response == 1 )
		    {
		        PlayersDataOnline[playerid][SaveAfterAgenda][10] = PlayersDataOnline[playerid][SaveAfterAgenda][listitem];
				ShowObjetosOpciones(playerid);
			}
		}
		// ShowObjetosOpciones
		case 13:
		{
			if ( response == 1 )
			{
				switch ( listitem )
				{
				    // Dar
				    case 0:
				    {
				        ShowDarObjeto(playerid);
				    }
				    // Tirar
				    case 1:
				    {
                        new MsgTirarObjetos[MAX_TEXT_CHAT];
						format(MsgTirarObjetos, sizeof(MsgTirarObjetos), "tira %s al suelo", ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])]);
				        Acciones(playerid, 8, MsgTirarObjetos);
						RemoveObjectHoldToPlayer(playerid, -1, PlayersDataOnline[playerid][SaveAfterAgenda][10]);
						ShowObjectos(playerid);
				    }
				    // Sacar y Mostrar
				    case 2:
				    {
				        if ( !ObjectsVisibleOrInvisible[GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])] )
				        {
				            if ( AllowForItSkin(PlayersData[playerid][Skin], GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])) )
				            {
								ReverseEx(PlayersDataOnline[playerid][SaveAfterAgenda][10]);
								if ( !PlayersDataOnline[playerid][SaveAfterAgenda][10] )
								{
									SetObjectHoldToPlayer(playerid, PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]], PlayersDataOnline[playerid][SaveAfterAgenda][10]);
								}
								else
								{
									RemovePlayerAttachedObject(playerid, PlayersDataOnline[playerid][SaveAfterAgenda][10]);
								}
							}
							else
							{
								SendInfoMessage(playerid, 0, "1563", "No puedes mostrar éste objeto con éste skin!");
							}
						}
						else
						{
							SendInfoMessage(playerid, 0, "1549", "No puedes guardar ni sacar éste objeto!");
						}
						ShowObjetosOpciones(playerid);
				    }
				}
			}
			else
			{
			    ShowObjectos(playerid);
			}
		}
		// ShowDarObjeto
		case 14:
		{
			if ( response == 1 )
			{
			    new SaveIDGive = strval(inputtext);
			    if ( IsPlayerNear(playerid, SaveIDGive,
					 "1552",
					 "1553",
					 "1554",
					 "El jugador que le deseas dar éste objeto no se encuentra conectado",
					 "El jugador que le deseas dar éste objeto no se ha logueado",
					 "El jugador que le deseas dar éste objeto no se encuentra cerca de tí") )
			    {
				    new saveType = GetObjectByType(SaveIDGive, GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]]));
				    if ( saveType == -1 )
				    {
						if ( AddObjectHoldToPlayer(SaveIDGive, PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]]) )
						{
							new MsgDarObjetoMe[MAX_TEXT_CHAT];
							new MsgDarObjetoYou[MAX_TEXT_CHAT];

					        format(MsgDarObjetoMe, sizeof(MsgDarObjetoMe), "Le has dado %s a %s",
					        ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])],
							PlayersDataOnline[SaveIDGive][NameOnline]);

					        format(MsgDarObjetoYou, sizeof(MsgDarObjetoYou), "%s te ha dado %s",
							PlayersDataOnline[playerid][NameOnline],
					        ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])]);

					        SendInfoMessage(playerid, 2, "0", MsgDarObjetoMe);
					        SendInfoMessage(SaveIDGive, 2, "0", MsgDarObjetoYou);

							RemoveObjectHoldToPlayer(playerid, -1, PlayersDataOnline[playerid][SaveAfterAgenda][10]);
							ShowObjectos(playerid);
							return 1;
						}
						else
						{
							SendInfoMessage(playerid, 0, "1550", "El jugador que deseas dar éste objeto ya no puede llevar más encima!");
						}
				    }
				    else
				    {
						SendInfoMessage(playerid, 0, "1551", "Al jugador al que deseas dar el objeto no puede llevar más de éste tipo!");
				    }
			    }
				ShowObjetosOpciones(playerid);
			}
			else
			{
				ShowObjetosOpciones(playerid);
			}
		}
		//      FORMAS DE CAMINAR
		case 15:
		{
   		    if ( response == 1 )
		    {
                PlayersData[playerid][MyStyleWalk] = listitem;
		    }
	    }
		//      REPORTE VIA TAB
		case 16:
		{
   		    if ( response == 1 )
		    {
				if (IsPlayerConnected(PlayersDataOnline[playerid][MyLastIdReport]))
				{
				    if ( strlen(inputtext) >= 1)
				    {
						new StringFormat[MAX_TEXT_CHAT];
						new StringFormat2[MAX_TEXT_CHAT];
					    format(StringFormat2, sizeof(StringFormat2), "Reporte: Has reportado a %s[%i]. {F1FF00}Razón: %s", PlayersDataOnline[PlayersDataOnline[playerid][MyLastIdReport]][NameOnline], PlayersDataOnline[playerid][MyLastIdReport], inputtext);
						format(StringFormat, sizeof(StringFormat), "%s %s[%i] reporta a %s[%i]. {F1FF00}Razón: %s",LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, PlayersDataOnline[PlayersDataOnline[playerid][MyLastIdReport]][NameOnline], PlayersDataOnline[playerid][MyLastIdReport], inputtext);

					    MsgCheatsReportsToAdmins(StringFormat);
					    SendClientMessage(playerid, COLOR_CHEATS_REPORTES, StringFormat2);
					}
					else
					{
						SendInfoMessage(playerid, 0, "962", "Debe introducir una razón a reportar.");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "422", "El jugador que desea reportar no se encuentra connectado");
				}
		    }
	    }
	    case 17:
	    {
	        if(listitem == 0)
	        {
	            ShowPlayerDialogEx(playerid, 18, DIALOG_STYLE_INPUT, "{FF0000}[SGW] Comprar Explosivos.", "Introduzca una cantidad.", "Comprar", "Volver");
			}
        	return 1;
		}
		case 18:
		{
			if(!response)
			{
			    ShowPlayerDialogEx(playerid, 17, DIALOG_STYLE_LIST, "{FF0000}[SGW] Comprar Explosivos", "Explosivos-Sniper", "Comprar", "Salir");
			}
			else
			{
			    if(strval(inputtext) <= 0)
			    {
			        ShowPlayerDialogEx(playerid, 18, DIALOG_STYLE_INPUT, "{FF0000}[SGW] Comprar Explosivos.", "Introduzca una cantidad mayor que 0.", "Comprar", "Volver");
				}
				else
				{
	   				if(GetPlayerMoney(strval(inputtext) >= GetPlayerMoney(playerid)))
				   	{
				    	PlayersData[playerid][Minas] += strval(inputtext);
						GivePlayerMoneyEx(playerid, -strval(inputtext)*500);
						new ComprarExplosivos[MAX_TEXT_CHAT]; format(ComprarExplosivos, sizeof(ComprarExplosivos), "Has comprado %i explosivos, usa /Explosivo para activarlos con la sniper.", strval(inputtext));
						SendInfoMessage(playerid, 3, "0", ComprarExplosivos);
					}
					else
					{
						SendInfoMessage(playerid, 0, "422", "No tienes suficiente deinero para comprar esa cantidad de explosivos.");
					}
				}
			}
  			return 1;
		}
	}
	//// END DIALOGS
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if ( PlayersDataOnline[playerid][State] == 3 )
	{
		if (playerid != clickedplayerid)
		{
			new MsgReportarInputText[MAX_TEXT_CHAT];
			PlayersDataOnline[playerid][MyLastIdReport] = clickedplayerid;
			format(MsgReportarInputText, sizeof(MsgReportarInputText), "{00A5FF}Reportar a %s", PlayersDataOnline[clickedplayerid][NameOnline]);
		    ShowPlayerDialogEx(playerid, 16, DIALOG_STYLE_INPUT, MsgReportarInputText, "{F0F0F0}Descríba brevemente la razón de su reporte", "Reportar", "Cancelar");
		}
		else
		{
			SendInfoMessage(playerid, 0, "423", "El jugador que ha seleccionado para reportar es usted mismo.");
		}
	}
	else
	{
		SendInfoMessage(playerid, 0, "825", "Debe loguearse antes de reportar a un usuario");
	}
	return 1;
}

////////////////////////////////////// publicforwards ////////////////////////

public LoadDataBizzType()
{
	new PickupModelBizz = 1272;
// 00 ///////////////////////////////////////////////////////////////////////// Lugar: Prolaps
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 207.1340;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -139.3590;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1003.2390;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 359.0096;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 199.0661;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -127.7109;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1003.5152;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 180.3268;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 3;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Ropa");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 45;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 01 ///////////////////////////////////////////////////////////////////////// Lugar: Victim
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 226.6100;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -8.2260;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1002.2109;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 87.4987;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 206.1365;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -12.1991;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1001.2178;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 0.1185;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 5;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Ropa");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 45;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 02 ///////////////////////////////////////////////////////////////////////// Lugar: SubUrban
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 203.9409;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -49.8919;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.8047;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 3.0708;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 213.3677;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -41.5770;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1002.0234;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 88.5883;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 1;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Ropa");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 45;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 03 ///////////////////////////////////////////////////////////////////////// Lugar: Zip
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 161.4387;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -96.1310;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.8047;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 354.3740;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 161.3552;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -72.0944;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1001.8047;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 177.2982;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 18;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Ropa");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 45;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 04 ///////////////////////////////////////////////////////////////////////// Lugar: Didier Sachs
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 204.3610;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -168.0961;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1000.5234;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 3.0833;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 215.4577;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -156.2483;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1000.5234;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 88.3108;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 14;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Ropa");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 45;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 05 ///////////////////////////////////////////////////////////////////////// Lugar: Binco
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 207.7097;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -110.5522;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1005.1328;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 357.8142;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 217.2972;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -98.4899;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1005.2578;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 92.2329;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 15;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Ropa");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 45;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 06 ///////////////////////////////////////////////////////////////////////// Lugar: Ring Donuts
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 377.1915;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -192.9054;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1000.6401;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 358.7130;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 379.0891;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -187.8959;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1000.6328;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 270.1432;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 17;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Restaurante");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 50;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 07 ///////////////////////////////////////////////////////////////////////// Lugar: Jay's Diner
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 459.9540;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -88.6612;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 999.5547;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 90.9800;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 450.3769;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -84.0060;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 999.5547;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 359.9035;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 4;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Restaurante");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 50;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 08 ///////////////////////////////////////////////////////////////////////// Lugar: Armeria 1
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 315.8257;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -143.0595;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 999.6016;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 356.5333;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 313.9653;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -133.1587;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 999.6016;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 271.3058;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 7;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Armeria");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 18;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 09 ///////////////////////////////////////////////////////////////////////// Lugar: Armeria 2
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 285.4598;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -40.8969;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.5156;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 357.8593;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 296.4650;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -38.1313;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1001.5156;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 177.8897;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 1;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Armeria");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 18;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 10 ///////////////////////////////////////////////////////////////////////// Lugar: Armeria 3
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 285.7038;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -85.9912;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.5229;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 5.4625;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 297.8895;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -80.4345;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1001.5156;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 178.2963;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 4;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Armeria");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 18;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 11 ///////////////////////////////////////////////////////////////////////// Lugar: Armeria 4
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 296.8842;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -111.5674;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.5156;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 356.7233;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 287.7097;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -106.8642;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1001.5156;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 355.1800;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 6;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Armeria");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 18;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 12 ///////////////////////////////////////////////////////////////////////// Lugar: Armeria 5
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 287.7097;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -106.8642;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.5156;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 355.1800;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 316.3125;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -169.6709;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 999.6010;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 354.2805;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 6;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Armeria");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 18;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 13 ///////////////////////////////////////////////////////////////////////// Lugar: Club
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 493.3510;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -24.1066;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1000.6797;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 1.8939;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 499.5866;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -20.4216;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1000.6797;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 273.3881;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 17;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Club");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 48;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 14 ///////////////////////////////////////////////////////////////////////// Lugar: The Pig Pen
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 1204.9838;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -13.4134;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1000.9219;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 355.6215;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 1215.9023;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -13.0323;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1000.9219;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 178.4822;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 2;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Strip Club");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 48;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 15 ///////////////////////////////////////////////////////////////////////// Lugar: Jizzy
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= -2636.7153;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= 1403.0614;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 906.4609;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 357.6521;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= -2653.1179;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= 1410.1919;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 906.2734;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 82.8796;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 3;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Jizzy");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 48;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 16 ///////////////////////////////////////////////////////////////////////// Lugar: 24/7 1
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= -30.9650;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -91.3013;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1003.5469;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 3.2113;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= -28.3832;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -89.6670;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1003.5469;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 180.6406;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 18;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "24/7");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 17;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 17 ///////////////////////////////////////////////////////////////////////// Lugar: 24/7 2
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= -25.8594;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -140.8397;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1003.5469;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 358.6795;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= -22.5046,
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -138.4611;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1003.5469;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 181.1223;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 16;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "24/7");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 17;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 18 ///////////////////////////////////////////////////////////////////////// Lugar: Bar 1
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= -228.8344;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= 1401.1725;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 27.7656;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 273.3879;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= -225.2749;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= 1404.3914;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 27.7734;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 273.8058;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 18;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Lil' Probe Inn");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 49;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 19 ///////////////////////////////////////////////////////////////////////// Lugar: Bar 2
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 501.9434;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -68.3368;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 998.7578;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 183.0326;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 497.5212;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -75.6564;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 998.7578;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 182.9688;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 11;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Bar");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 49;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 20 ///////////////////////////////////////////////////////////////////////// Lugar: SexShop 1
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= -100.4072;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -24.2039;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1000.7188;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 356.6941;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= -107.0554;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -11.0345;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1000.7188;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 2.6070;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 3;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "SexShop");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 38;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 21 ///////////////////////////////////////////////////////////////////////// Lugar: SexShop 2
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 744.4740;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= 1436.9453;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1102.7031;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 357.3116;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 745.1048;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= 1440.2638;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1102.7031;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 90.8947;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 6;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "SexShop");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 38;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 22 ///////////////////////////////////////////////////////////////////////// Lugar: Cluckin' Bell
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 364.9758;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -11.0294;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.8516;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 2.6789;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 369.6758;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -6.3894;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1001.8589;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 1.9072;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 9;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Cluckin' Bell");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 14;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 23 ///////////////////////////////////////////////////////////////////////// Lugar:Burger Shot
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 363.3516;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -74.7660;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.5078;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 305.2676;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 378.2618;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -67.8177;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1001.5151;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 3.3392;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 10;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Burger Shot");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 10;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 24 ///////////////////////////////////////////////////////////////////////// Lugar: Pizza Stack
	NegociosType[MAX_BIZZ_TYPE][PosInX] 				= 372.3392;
	NegociosType[MAX_BIZZ_TYPE][PosInY] 				= -132.8387;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] 				= 1001.4922;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] 				= 0.3519;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] 				= 375.5667;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] 				= -119.4645;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] 				= 1001.4995;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]				= 354.5028;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] 			= 5;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Pizza Stack");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] 				= CreatePickup	(PickupModelBizz, 	1, 	NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],	 	-1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 29;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 25 ///////////////////////////////////////////////////////////////////////// Lugar: Bar
	NegociosType[MAX_BIZZ_TYPE][PosInX] = 677.30352783203;
	NegociosType[MAX_BIZZ_TYPE][PosInY] = -463.25582885742;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] = -25.6171875;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] = 265.4503;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] = 681.57141113281;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] = -456.29409790039;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] = -25.609874725342;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]= 25.4987;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] = 1;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Bar");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] = CreatePickup(PickupModelBizz, 1, NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ], -1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 49;
///////////////////////////////////////////////////////////////////////////
	MAX_BIZZ_TYPE++;
// 26 ///////////////////////////////////////////////////////////////////////// Lugar: Restaurtante
	NegociosType[MAX_BIZZ_TYPE][PosInX] = 1367.0800;
	NegociosType[MAX_BIZZ_TYPE][PosInY] = 1274.5714;
	NegociosType[MAX_BIZZ_TYPE][PosInZ] = 10.8203;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ] = 184.6329;
	NegociosType[MAX_BIZZ_TYPE][PosInX_PC] = 1374.5895996094;
	NegociosType[MAX_BIZZ_TYPE][PosInY_PC] = 1262.2515869141;
	NegociosType[MAX_BIZZ_TYPE][PosInZ_PC] = 10.8203125;
	NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]= 15.983;
	NegociosType[MAX_BIZZ_TYPE][InteriorId] = 8;
	format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Burger Restaurant");
	NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
	NegociosType[MAX_BIZZ_TYPE][PickupId] = CreatePickup(PickupModelBizz, 1, NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ], -1);
	NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 50;
///////////////////////////////////////////////////////////////////////////
    MAX_BIZZ_TYPE++;
/// 27 ////////////////////////////////////////////////////////////////////// Lugar: Barbería 1
    NegociosType[MAX_BIZZ_TYPE][PosInX]                 = 411.57223510742;
    NegociosType[MAX_BIZZ_TYPE][PosInY]                 = -23.165138244629;
    NegociosType[MAX_BIZZ_TYPE][PosInZ]                 = 1001.8046875;
    NegociosType[MAX_BIZZ_TYPE][PosInZZ]                 = 0;
    NegociosType[MAX_BIZZ_TYPE][PosInX_PC]                 = 414.43997192383;
    NegociosType[MAX_BIZZ_TYPE][PosInY_PC]                 = -18.894048690796;
    NegociosType[MAX_BIZZ_TYPE][PosInZ_PC]                 = 1001.8046875;
    NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]                = 90;
    NegociosType[MAX_BIZZ_TYPE][InteriorId]             = 2;
    format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Barbero");
    NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
    NegociosType[MAX_BIZZ_TYPE][PickupId]                 = CreatePickup    (PickupModelBizz,     1,     NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],         -1);
    NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 7;
///////////////////////////////////////////////////////////////////////////
    MAX_BIZZ_TYPE++;
// 28 /////////////////////////////////////////////////////////////////////// Lugar: Barbería 2
    NegociosType[MAX_BIZZ_TYPE][PosInX]                 = 411.92514038086;
    NegociosType[MAX_BIZZ_TYPE][PosInY]                 = -54.446674346924;
    NegociosType[MAX_BIZZ_TYPE][PosInZ]                 = 1001.8984375;
    NegociosType[MAX_BIZZ_TYPE][PosInZZ]                 = 0;
    NegociosType[MAX_BIZZ_TYPE][PosInX_PC]                 = 415.04098510742;
    NegociosType[MAX_BIZZ_TYPE][PosInY_PC]                 = -52.34215927124;
    NegociosType[MAX_BIZZ_TYPE][PosInZ_PC]                 = 1001.8984375;
    NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]                = 90;
    NegociosType[MAX_BIZZ_TYPE][InteriorId]             = 12;
    format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Barbero");
    NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
    NegociosType[MAX_BIZZ_TYPE][PickupId]                 = CreatePickup    (PickupModelBizz,     1,     NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],         -1);
    NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 7;
///////////////////////////////////////////////////////////////////////////
    MAX_BIZZ_TYPE++;
// 29 /////////////////////////////////////////////////////////////////////// Lugar: Barbería 3
    NegociosType[MAX_BIZZ_TYPE][PosInX]                 = 418.59677124023;
    NegociosType[MAX_BIZZ_TYPE][PosInY]                 = -84.363059997559;
    NegociosType[MAX_BIZZ_TYPE][PosInZ]                 = 1001.8046875;
    NegociosType[MAX_BIZZ_TYPE][PosInZZ]                 = 0;
    NegociosType[MAX_BIZZ_TYPE][PosInX_PC]                 = 421.55499267578;
    NegociosType[MAX_BIZZ_TYPE][PosInY_PC]                 = -77.96834564209;
    NegociosType[MAX_BIZZ_TYPE][PosInZ_PC]                 = 1001.8046875;
    NegociosType[MAX_BIZZ_TYPE][PosInZZ_PC]                = 90;
    NegociosType[MAX_BIZZ_TYPE][InteriorId]             = 3;
    format(NegociosType[MAX_BIZZ_TYPE][TypeName], MAX_PLAYER_NAME, "Barbero");
    NegociosType[MAX_BIZZ_TYPE][TypePickupOrCheckponit] = true;
    NegociosType[MAX_BIZZ_TYPE][PickupId]                 = CreatePickup    (PickupModelBizz,     1,     NegociosType[MAX_BIZZ_TYPE][PosInX],NegociosType[MAX_BIZZ_TYPE][PosInY],NegociosType[MAX_BIZZ_TYPE][PosInZ],         -1);
    NegociosType[MAX_BIZZ_TYPE][IdMapIcon]              = 7;
///////////////////////////////////////////////////////////////////////////
}
public DataSaveBizz(bizzid, bool:update)
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%sN%i.sgw", DIR_NEGOCIOS, bizzid);

    new BizzData[MAX_PLAYER_DATA];
    format(BizzData, sizeof(BizzData),
    	"0³%f³%f³%f³%f³%i³%i³%i³%i³%i³%i³%i³%s³%s³%s³%i³%i³%i³",
	    NegociosData[bizzid][PosOutX],  	//		00
	    NegociosData[bizzid][PosOutY],		//      01
	    NegociosData[bizzid][PosOutZ],		//      03
	    NegociosData[bizzid][PosOutZZ],     //      04
	    NegociosData[bizzid][InteriorOut],  //      05
	    NegociosData[bizzid][Deposito],     //      06
	    NegociosData[bizzid][Precio],       //      07
	    NegociosData[bizzid][Lock],         //      08
	    NegociosData[bizzid][Type],         //      09
	    NegociosData[bizzid][PriceJoin],    //      10
	    NegociosData[bizzid][PricePiece],   //      11
		NegociosData[bizzid][NameBizz],     //      12
		NegociosData[bizzid][Dueno],        //      13
		NegociosData[bizzid][Extorsion],    //      14
		NegociosData[bizzid][Materiales],   //      15
		NegociosData[bizzid][DepositoExtorsion],  //      16
		NegociosData[bizzid][Level],  		//      17
		NegociosData[bizzid][Station]  		//      18
    );

	if ( update )
	{
		ActTextDrawBizz(bizzid);
	}

	// 0³2244.6292³-1664.8536³15.4766³340.1742³0³0³1000³1³9999³20³5³Ninguno³0³No³100³

	new File:SaveBizz = fopen(DirBD, io_write);
	fwrite(SaveBizz, BizzData);
	fclose(SaveBizz);
}
public DataLoadBizz(bizzid)
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%sN%i.sgw", DIR_NEGOCIOS, bizzid);
	if ( fexist(DirBD) )
	{
	    new BizzData[MAX_PLAYER_DATA];
	    new BizzDataSlots[MAX_BIZZ_SLOTS][35];
		new File:LoadBizzF = fopen(DirBD, io_read);
		fread(LoadBizzF, BizzData);
		fclose(LoadBizzF);
		new PosSplitAfter = 0;
		for ( new i = 0; i < MAX_BIZZ_SLOTS; i++ )
		{
			PosSplitAfter = strfind(BizzData, "³", false);
			strmid(BizzDataSlots[i], BizzData, 0, PosSplitAfter, sizeof(BizzData));
			strdel(BizzData, 0, PosSplitAfter + 1);
		}
		// DATA BIZZ
	    NegociosData[bizzid][PosOutX] 		= floatstr(BizzDataSlots[1]);
	    NegociosData[bizzid][PosOutY] 		= floatstr(BizzDataSlots[2]);
	    NegociosData[bizzid][PosOutZ] 		= floatstr(BizzDataSlots[3]);
	    NegociosData[bizzid][PosOutZZ] 		= floatstr(BizzDataSlots[4]);
	    NegociosData[bizzid][PickupOutId]	= CreatePickup	(1239, 	1, 	NegociosData[bizzid][PosOutX], NegociosData[bizzid][PosOutY], NegociosData[bizzid][PosOutZ], -1);
	    NegociosData[bizzid][InteriorOut]	= strval(BizzDataSlots[5]);
	    NegociosData[bizzid][Deposito]		= strval(BizzDataSlots[6]);
	    NegociosData[bizzid][Precio]		= strval(BizzDataSlots[7]);
	    NegociosData[bizzid][Lock]			= strval(BizzDataSlots[8]);
	    NegociosData[bizzid][Type]			= strval(BizzDataSlots[9]);
	    NegociosData[bizzid][PriceJoin]		= strval(BizzDataSlots[10]);
	    NegociosData[bizzid][PricePiece] 	= strval(BizzDataSlots[11]);
		format(NegociosData[bizzid][NameBizz], 	MAX_BIIZ_NAME, "%s", BizzDataSlots[12]);
		format(NegociosData[bizzid][Dueno],		MAX_PLAYER_NAME, "%s", BizzDataSlots[13]);
		format(NegociosData[bizzid][Extorsion], MAX_PLAYER_NAME, "%s", BizzDataSlots[14]);
		NegociosData[bizzid][Materiales]    = strval(BizzDataSlots[15]);
		NegociosData[bizzid][DepositoExtorsion]  = strval(BizzDataSlots[16]);
		NegociosData[bizzid][Level]  		= strval(BizzDataSlots[17]);
		NegociosData[bizzid][Station]  		= strval(BizzDataSlots[18]);

		NegociosData[bizzid][World]     	= bizzid;
		NegociosTextDraws[bizzid] = TextDrawCreateEx(180.0, 300.0, "Empty");
		TextDrawUseBox(NegociosTextDraws[bizzid], 1);
		TextDrawBackgroundColor(NegociosTextDraws[bizzid], 0x000000FF);
		TextDrawBoxColor(NegociosTextDraws[bizzid], 0x00000066);
		TextDrawTextSize(NegociosTextDraws[bizzid], 405.0, 380.0);
		TextDrawSetShadow(NegociosTextDraws[bizzid], 1);
		TextDrawLetterSize(NegociosTextDraws[bizzid], 0.4 , 1.1);

		CreateDynamicMapIconSGW(NegociosData[bizzid][PosOutX], NegociosData[bizzid][PosOutY], NegociosData[bizzid][PosOutZ], NegociosType[NegociosData[bizzid][Type]][IdMapIcon]);

        ActTextDrawBizz(bizzid);
		/*printf(    	"%i - %s³%f³%f³%f³%f³%i³%i³%i³%i³%i³%i³%i³%s³%s³%s³%i³%i",
		bizzid,
		BizzDataSlots[0],
	    NegociosData[bizzid][PosOutX],
	    NegociosData[bizzid][PosOutY],
	    NegociosData[bizzid][PosOutZ],
	    NegociosData[bizzid][PosOutZZ],
	    NegociosData[bizzid][InteriorOut],
	    NegociosData[bizzid][Deposito],
	    NegociosData[bizzid][Precio],
	    NegociosData[bizzid][Lock],
	    NegociosData[bizzid][Type],
	    NegociosData[bizzid][PriceJoin],
	    NegociosData[bizzid][PricePiece],
		NegociosData[bizzid][NameBizz],
		NegociosData[bizzid][Dueno],
		NegociosData[bizzid][Extorsion],
		NegociosData[bizzid][Materiales],
		NegociosData[bizzid][DepositoExtorsion]
		);*/
	    return true;
	}
	else
	{
	    return false;
	}
}
public LoadHouse(houseid)
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%sH%i.sgw", DIR_HOUSES, houseid);
	if ( fexist(DirBD) )
	{
		HouseData[houseid][StationID]        = -1;
		HouseData[houseid][VolumenHouse]     = DEFAULT_AUDIO_VOLUMEN;

	    new HouseDataRead[MAX_HOUSE_DATA];
	    new HouseSlots[MAX_HOUSE_SLOT][30];
		new File:LoadHouseF = fopen(DirBD, io_read);
		fread(LoadHouseF, HouseDataRead);

		new PosSplitAfter = 0;
		for ( new i = 0; i < MAX_HOUSE_SLOT; i++ )
		{
			PosSplitAfter = strfind(HouseDataRead, ",", false);
			strmid(HouseSlots[i], HouseDataRead, 0, PosSplitAfter, sizeof(HouseDataRead));
			strdel(HouseDataRead, 0, PosSplitAfter + 1);
		}
		HouseData[houseid][Empy_Bug] = strval(HouseSlots[0]);
		format(HouseData[houseid][Dueno], MAX_PLAYER_NAME, "%s", HouseSlots[1]);
		HouseData[houseid][ArmarioWeapon][0] = strval(HouseSlots[2]);
		HouseData[houseid][ArmarioWeapon][1] = strval(HouseSlots[3]);
		HouseData[houseid][ArmarioWeapon][2] = strval(HouseSlots[4]);
		HouseData[houseid][ArmarioWeapon][3] = strval(HouseSlots[5]);
		HouseData[houseid][ArmarioWeapon][4] = strval(HouseSlots[6]);
		HouseData[houseid][ArmarioWeapon][5] = strval(HouseSlots[7]);
		HouseData[houseid][ArmarioWeapon][6] = strval(HouseSlots[8]);
		HouseData[houseid][ArmarioAmmo][0]	 = strval(HouseSlots[9]);
		HouseData[houseid][ArmarioAmmo][1]	 = strval(HouseSlots[10]);
		HouseData[houseid][ArmarioAmmo][2]   = strval(HouseSlots[11]);
		HouseData[houseid][ArmarioAmmo][3] 	= strval(HouseSlots[12]);
		HouseData[houseid][ArmarioAmmo][4] 	= strval(HouseSlots[13]);
		HouseData[houseid][ArmarioAmmo][5] 	= strval(HouseSlots[14]);
		HouseData[houseid][ArmarioAmmo][6] 	= strval(HouseSlots[15]);
		HouseData[houseid][Chaleco] 		= floatstr(HouseSlots[16]);
		HouseData[houseid][Drogas] 			= strval(HouseSlots[17]);
		HouseData[houseid][Ganzuas] 		= strval(HouseSlots[18]);
		HouseData[houseid][PosX] 			= floatstr(HouseSlots[19]);
		HouseData[houseid][PosY] 			= floatstr(HouseSlots[20]);
		HouseData[houseid][PosZ] 			= floatstr(HouseSlots[21]);
		HouseData[houseid][PosZZ] 			= floatstr(HouseSlots[22]);
		HouseData[houseid][Interior] 		= strval(HouseSlots[23]);
		HouseData[houseid][TypeHouseId]		= strval(HouseSlots[24]);
		HouseData[houseid][PickupId] 		= CreatePickup	(1273, 	1, 	HouseData[houseid][PosX], HouseData[houseid][PosY], HouseData[houseid][PosZ],	 	-1);
		HouseData[houseid][PriceRent] 		= strval(HouseSlots[25]);
		HouseData[houseid][Level] 			= strval(HouseSlots[26]);
		HouseData[houseid][World] 			= houseid;
		HouseData[houseid][Lock]            = strval(HouseSlots[27]);
		HouseData[houseid][Price]           = strval(HouseSlots[28]);
		HouseData[houseid][Bombas]			= strval(HouseSlots[29]);
		HouseData[houseid][Deposito]		= strval(HouseSlots[30]);
		HouseData[houseid][Materiales]		= strval(HouseSlots[31]);
		HouseData[houseid][ArmarioLock]		= strval(HouseSlots[32]);

		Garages[houseid][0][Xg]				= floatstr(HouseSlots[33]);
		Garages[houseid][0][Yg]				= floatstr(HouseSlots[34]);
		Garages[houseid][0][Zg]				= floatstr(HouseSlots[35]);
		Garages[houseid][0][ZZg]			= floatstr(HouseSlots[36]);
		Garages[houseid][0][XgIn]			= floatstr(HouseSlots[37]);
		Garages[houseid][0][YgIn]			= floatstr(HouseSlots[38]);
		Garages[houseid][0][ZgIn]			= floatstr(HouseSlots[39]);
		Garages[houseid][0][ZZgIn]			= floatstr(HouseSlots[40]);
		Garages[houseid][0][XgOut]			= floatstr(HouseSlots[41]);
		Garages[houseid][0][YgOut]			= floatstr(HouseSlots[42]);
		Garages[houseid][0][ZgOut]			= floatstr(HouseSlots[43]);
		Garages[houseid][0][ZZgOut]			= floatstr(HouseSlots[44]);
		Garages[houseid][0][LockIn]			= strval(HouseSlots[45]);
		Garages[houseid][0][LockOut]		= strval(HouseSlots[46]);
		Garages[houseid][0][TypeGarageE]	= strval(HouseSlots[47]);

		Garages[houseid][1][Xg]				= floatstr(HouseSlots[48]);
		Garages[houseid][1][Yg]				= floatstr(HouseSlots[49]);
		Garages[houseid][1][Zg]				= floatstr(HouseSlots[50]);
		Garages[houseid][1][ZZg]			= floatstr(HouseSlots[51]);
		Garages[houseid][1][XgIn]			= floatstr(HouseSlots[52]);
		Garages[houseid][1][YgIn]			= floatstr(HouseSlots[53]);
		Garages[houseid][1][ZgIn]			= floatstr(HouseSlots[54]);
		Garages[houseid][1][ZZgIn]			= floatstr(HouseSlots[55]);
		Garages[houseid][1][XgOut]			= floatstr(HouseSlots[56]);
		Garages[houseid][1][YgOut]			= floatstr(HouseSlots[57]);
		Garages[houseid][1][ZgOut]			= floatstr(HouseSlots[58]);
		Garages[houseid][1][ZZgOut]			= floatstr(HouseSlots[59]);
		Garages[houseid][1][LockIn]			= strval(HouseSlots[60]);
		Garages[houseid][1][LockOut]		= strval(HouseSlots[61]);
		Garages[houseid][1][TypeGarageE]	= strval(HouseSlots[62]);

		Garages[houseid][2][Xg]				= floatstr(HouseSlots[63]);
		Garages[houseid][2][Yg]				= floatstr(HouseSlots[64]);
		Garages[houseid][2][Zg]				= floatstr(HouseSlots[65]);
		Garages[houseid][2][ZZg]			= floatstr(HouseSlots[66]);
		Garages[houseid][2][XgIn]			= floatstr(HouseSlots[67]);
		Garages[houseid][2][YgIn]			= floatstr(HouseSlots[68]);
		Garages[houseid][2][ZgIn]			= floatstr(HouseSlots[69]);
		Garages[houseid][2][ZZgIn]			= floatstr(HouseSlots[70]);
		Garages[houseid][2][XgOut]			= floatstr(HouseSlots[71]);
		Garages[houseid][2][YgOut]			= floatstr(HouseSlots[72]);
		Garages[houseid][2][ZgOut]			= floatstr(HouseSlots[73]);
		Garages[houseid][2][ZZgOut]			= floatstr(HouseSlots[74]);
		Garages[houseid][2][LockIn]			= strval(HouseSlots[75]);
		Garages[houseid][2][LockOut]		= strval(HouseSlots[76]);
		Garages[houseid][2][TypeGarageE]	= strval(HouseSlots[77]);

		fread(LoadHouseF, HouseDataRead);

		PosSplitAfter = 0;
		for ( new i = 0; i < MAX_HOUSE_SLOT; i++ )
		{
			PosSplitAfter = strfind(HouseDataRead, ",", false);
			strmid(HouseSlots[i], HouseDataRead, 0, PosSplitAfter, sizeof(HouseDataRead));
			strdel(HouseDataRead, 0, PosSplitAfter + 1);
		}

		Garages[houseid][3][Xg]				= floatstr(HouseSlots[0]);
		Garages[houseid][3][Yg]				= floatstr(HouseSlots[1]);
		Garages[houseid][3][Zg]				= floatstr(HouseSlots[2]);
		Garages[houseid][3][ZZg]			= floatstr(HouseSlots[3]);
		Garages[houseid][3][XgIn]			= floatstr(HouseSlots[4]);
		Garages[houseid][3][YgIn]			= floatstr(HouseSlots[5]);
		Garages[houseid][3][ZgIn]			= floatstr(HouseSlots[6]);
		Garages[houseid][3][ZZgIn]			= floatstr(HouseSlots[7]);
		Garages[houseid][3][XgOut]			= floatstr(HouseSlots[8]);
		Garages[houseid][3][YgOut]			= floatstr(HouseSlots[9]);
		Garages[houseid][3][ZgOut]			= floatstr(HouseSlots[10]);
		Garages[houseid][3][ZZgOut]			= floatstr(HouseSlots[11]);
		Garages[houseid][3][LockIn]			= strval(HouseSlots[12]);
		Garages[houseid][3][LockOut]		= strval(HouseSlots[13]);
		Garages[houseid][3][TypeGarageE]	= strval(HouseSlots[14]);

		Garages[houseid][4][Xg]				= floatstr(HouseSlots[15]);
		Garages[houseid][4][Yg]				= floatstr(HouseSlots[16]);
		Garages[houseid][4][Zg]				= floatstr(HouseSlots[17]);
		Garages[houseid][4][ZZg]			= floatstr(HouseSlots[18]);
		Garages[houseid][4][XgIn]			= floatstr(HouseSlots[19]);
		Garages[houseid][4][YgIn]			= floatstr(HouseSlots[20]);
		Garages[houseid][4][ZgIn]			= floatstr(HouseSlots[21]);
		Garages[houseid][4][ZZgIn]			= floatstr(HouseSlots[22]);
		Garages[houseid][4][XgOut]			= floatstr(HouseSlots[23]);
		Garages[houseid][4][YgOut]			= floatstr(HouseSlots[24]);
		Garages[houseid][4][ZgOut]			= floatstr(HouseSlots[25]);
		Garages[houseid][4][ZZgOut]			= floatstr(HouseSlots[26]);
		Garages[houseid][4][LockIn]			= strval(HouseSlots[27]);
		Garages[houseid][4][LockOut]		= strval(HouseSlots[28]);
		Garages[houseid][4][TypeGarageE]	= strval(HouseSlots[29]);

		Garages[houseid][0][WorldG]			= strval(HouseSlots[30]);
		Garages[houseid][1][WorldG]			= strval(HouseSlots[31]);
		Garages[houseid][2][WorldG]			= strval(HouseSlots[32]);
		Garages[houseid][3][WorldG]			= strval(HouseSlots[33]);
		Garages[houseid][4][WorldG]			= strval(HouseSlots[34]);

		format(HouseFriends[houseid][0][Name], MAX_PLAYER_NAME, "%s", HouseSlots[35]);
		format(HouseFriends[houseid][1][Name], MAX_PLAYER_NAME, "%s", HouseSlots[36]);
		format(HouseFriends[houseid][2][Name], MAX_PLAYER_NAME, "%s", HouseSlots[37]);
		format(HouseFriends[houseid][3][Name], MAX_PLAYER_NAME, "%s", HouseSlots[38]);
		format(HouseFriends[houseid][4][Name], MAX_PLAYER_NAME, "%s", HouseSlots[39]);

		Refrigerador[houseid][Articulo][0] 	= strval(HouseSlots[40]);
		Refrigerador[houseid][Articulo][1] 	= strval(HouseSlots[41]);
		Refrigerador[houseid][Articulo][2] 	= strval(HouseSlots[42]);
		Refrigerador[houseid][Articulo][3] 	= strval(HouseSlots[43]);
		Refrigerador[houseid][Articulo][4] 	= strval(HouseSlots[44]);
		Refrigerador[houseid][Articulo][5] 	= strval(HouseSlots[45]);
		Refrigerador[houseid][Articulo][6] 	= strval(HouseSlots[46]);
		Refrigerador[houseid][Articulo][7] 	= strval(HouseSlots[47]);
		Refrigerador[houseid][Articulo][8] 	= strval(HouseSlots[48]);
		Refrigerador[houseid][Articulo][9] 	= strval(HouseSlots[49]);
		Refrigerador[houseid][Cantidad][0] 	= strval(HouseSlots[50]);
		Refrigerador[houseid][Cantidad][1] 	= strval(HouseSlots[51]);
		Refrigerador[houseid][Cantidad][2] 	= strval(HouseSlots[52]);
		Refrigerador[houseid][Cantidad][3] 	= strval(HouseSlots[53]);
		Refrigerador[houseid][Cantidad][4] 	= strval(HouseSlots[54]);
		Refrigerador[houseid][Cantidad][5] 	= strval(HouseSlots[55]);
		Refrigerador[houseid][Cantidad][6] 	= strval(HouseSlots[56]);
		Refrigerador[houseid][Cantidad][7] 	= strval(HouseSlots[57]);
		Refrigerador[houseid][Cantidad][8] 	= strval(HouseSlots[58]);
		Refrigerador[houseid][Cantidad][9] 	= strval(HouseSlots[59]);


		HouseData[houseid][RefrigeradorLock] = strval(HouseSlots[60]);
		HouseData[houseid][StationID] 		 = strval(HouseSlots[61]);
		HouseData[houseid][VolumenHouse] 	 = strval(HouseSlots[62]);
		HouseData[houseid][EcualizadorHouse][0] = strval(HouseSlots[63]);
		HouseData[houseid][EcualizadorHouse][1] = strval(HouseSlots[64]);
		HouseData[houseid][EcualizadorHouse][2] = strval(HouseSlots[65]);
		HouseData[houseid][EcualizadorHouse][3] = strval(HouseSlots[66]);
		HouseData[houseid][EcualizadorHouse][4] = strval(HouseSlots[67]);
		HouseData[houseid][EcualizadorHouse][5] = strval(HouseSlots[68]);
		HouseData[houseid][EcualizadorHouse][6] = strval(HouseSlots[69]);
		HouseData[houseid][EcualizadorHouse][7] = strval(HouseSlots[70]);
		HouseData[houseid][EcualizadorHouse][8] = strval(HouseSlots[71]);

		HouseData[houseid][GavetaLock]		  = strval(HouseSlots[72]);
		HouseData[houseid][GavetaObjects][0]  = strval(HouseSlots[73]);
		HouseData[houseid][GavetaObjects][1]  = strval(HouseSlots[74]);
		HouseData[houseid][GavetaObjects][2]  = strval(HouseSlots[75]);
		HouseData[houseid][GavetaObjects][3]  = strval(HouseSlots[76]);
		HouseData[houseid][GavetaObjects][4]  = strval(HouseSlots[77]);

		fread(LoadHouseF, HouseDataRead);
		fclose(LoadHouseF);

		PosSplitAfter = 0;
		for ( new i = 0; i < MAX_HOUSE_SLOT; i++ )
		{
			PosSplitAfter = strfind(HouseDataRead, ",", false);
			strmid(HouseSlots[i], HouseDataRead, 0, PosSplitAfter, sizeof(HouseDataRead));
			strdel(HouseDataRead, 0, PosSplitAfter + 1);
		}

		HouseData[houseid][GavetaObjects][5]  = strval(HouseSlots[0]);
		HouseData[houseid][GavetaObjects][6]  = strval(HouseSlots[1]);
		HouseData[houseid][GavetaObjects][7]  = strval(HouseSlots[2]);

		CasasTextDraws[houseid] = TextDrawCreateEx(180.0, 300.0, "Empty");
		TextDrawUseBox(CasasTextDraws[houseid], 1);
		TextDrawBackgroundColor(CasasTextDraws[houseid], 0x000000FF);
		TextDrawBoxColor(CasasTextDraws[houseid], 0x00000066);
		TextDrawTextSize(CasasTextDraws[houseid], 360.0, 380.0);
		TextDrawSetShadow(CasasTextDraws[houseid], 1);
		TextDrawLetterSize(CasasTextDraws[houseid], 0.4 , 1.1);

		ActTextDrawHouse(houseid);
		return true;
	}
	return false;
}
public LoadBombas()
{
	new TempDirBombas[25];
    new BombasDataALL[MAX_PLAYER_DATA];
    new BombasDataSlots[6][MAX_PLAYER_NAME];
    new BombaType;
	for (new i = 0; i < MAX_BOMBAS_COUNT; i++ )
	{
	    format(TempDirBombas, sizeof(TempDirBombas), "%s%i.sgw", DIR_BOMBAS, i);
		if ( fexist(TempDirBombas) )
		{
			new File:LoadBombasF = fopen(TempDirBombas, io_read);
			fread(LoadBombasF, BombasDataALL);
			fclose(LoadBombasF);

			new PosSplitAfter = 0;
			for ( new s = 0; s < 6; s++ )
			{
				PosSplitAfter = strfind(BombasDataALL, "|", false);
				strmid(BombasDataSlots[s], BombasDataALL, 0, PosSplitAfter, sizeof(BombasDataALL));
				strdel(BombasDataALL, 0, PosSplitAfter + 1);
			}
			BombaType 		= strval(BombasDataSlots[0]);
			if ( BombaType != BOMBA_TYPE_NONE )
			{
				AddBomba(-1, BombaType, strval(BombasDataSlots[1]), floatstr(BombasDataSlots[2]), floatstr(BombasDataSlots[3]), floatstr(BombasDataSlots[4]), strval(BombasDataSlots[5]));
			}
		}
	}
}
public LoadDataVehicle(vehicleid, dir[], type)
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%sC%i.dat", dir, vehicleid);
	if ( fexist(DirBD) )
	{
	    new VehicleData[MAX_PLAYER_DATA];
	    new VehicleSlots[MAX_VEHICLE_SLOT][50];
		new File:LoadVehicle = fopen(DirBD, io_read);
		fread(LoadVehicle, VehicleData);

		new PosSplitAfter = 0;
		for ( new i = 0; i < MAX_VEHICLE_SLOT; i++ )
		{
			PosSplitAfter = strfind(VehicleData, ",", false);
			strmid(VehicleSlots[i], VehicleData, 0, PosSplitAfter, sizeof(VehicleData));
			strdel(VehicleData, 0, PosSplitAfter + 1);
		}
		new ModelTemp 						= strval(VehicleSlots[4]);
		if ( type )
		{
			DataCars[vehicleid][PosX]		= floatstr(VehicleSlots[0]);
			DataCars[vehicleid][PosY] 		= floatstr(VehicleSlots[1]);
			DataCars[vehicleid][PosZ] 		= floatstr(VehicleSlots[2]);
			DataCars[vehicleid][PosZZ]		= floatstr(VehicleSlots[3]);

			DataCars[vehicleid][Modelo]		= strval(VehicleSlots[4]);

			DataCars[vehicleid][Color1] 	= strval(VehicleSlots[5]);
			DataCars[vehicleid][Color2] 	= strval(VehicleSlots[6]);
			format(DataCars[vehicleid][Dueno], MAX_PLAYER_NAME, "%s", VehicleSlots[7]);
		}
		DataCars[vehicleid][Lock] 			= strval(VehicleSlots[8]);
		if ( type )
		{
			DataCars[vehicleid][Time] 		= strval(VehicleSlots[9]);
			DataCars[vehicleid][Matricula]	= strval(VehicleSlots[10]);
			format(DataCars[vehicleid][MatriculaString], 32, "%s", VehicleSlots[10]);
		}
		DataCars[vehicleid][LockPolice]	= strval(VehicleSlots[11]);
		format(DataCars[vehicleid][ReasonLock], 50, "%s", VehicleSlots[12]);
		coches_Todos_Maleteros[vehicleid][0][0]	= strval(VehicleSlots[13]);
		coches_Todos_Maleteros[vehicleid][0][1]	= strval(VehicleSlots[14]);
		coches_Todos_Maleteros[vehicleid][1][0]	= strval(VehicleSlots[15]);
		coches_Todos_Maleteros[vehicleid][1][1]	= strval(VehicleSlots[16]);
		coches_Todos_Maleteros[vehicleid][2][0]	= strval(VehicleSlots[17]);
		coches_Todos_Maleteros[vehicleid][2][1]	= strval(VehicleSlots[18]);
		coches_Todos_Maleteros[vehicleid][3][0]	= strval(VehicleSlots[19]);
		coches_Todos_Maleteros[vehicleid][3][1]	= strval(VehicleSlots[20]);
		coches_Todos_Maleteros[vehicleid][4][0]	= strval(VehicleSlots[21]);
		coches_Todos_Maleteros[vehicleid][4][1]	= strval(VehicleSlots[22]);
		coches_Todos_Maleteros[vehicleid][5][0]	= strval(VehicleSlots[23]);
		coches_Todos_Maleteros[vehicleid][5][1]	= strval(VehicleSlots[24]);
		coches_Todos_Maleteros[vehicleid][6][0]	= strval(VehicleSlots[25]);
		coches_Todos_Maleteros[vehicleid][6][1]	= strval(VehicleSlots[26]);
		coches_Todos_Maleteros[vehicleid][7][0]	= strval(VehicleSlots[27]);
		coches_Todos_Maleteros[vehicleid][8][0]	= strval(VehicleSlots[28]);
		coches_Todos_Maleteros[vehicleid][9][0]	= strval(VehicleSlots[29]);
		coches_Todos_Maleteros[vehicleid][10][0]= strval(VehicleSlots[30]);
		coches_Todos_Maleteros[vehicleid][11][0]= strval(VehicleSlots[31]);
		DataCars[vehicleid][MaleteroState]		= strval(VehicleSlots[32]);
//		DataCars[vehicleid][Oil]				= strval(VehicleSlots[33]);
		DataCars[vehicleid][Gas]				= strval(VehicleSlots[33]);
		DataCars[vehicleid][LastX]				= floatstr(VehicleSlots[34]);
		DataCars[vehicleid][LastY]				= floatstr(VehicleSlots[35]);
		DataCars[vehicleid][LastZ]				= floatstr(VehicleSlots[36]);
		DataCars[vehicleid][LastZZ]				= floatstr(VehicleSlots[37]);
		DataCars[vehicleid][IsLastSpawn]		= strval(VehicleSlots[38]);
		DataCars[vehicleid][LastDamage]			= floatstr(VehicleSlots[39]);
		DataCars[vehicleid][PanelS]				= strval(VehicleSlots[40]);
		DataCars[vehicleid][DoorS]				= strval(VehicleSlots[41]);
		DataCars[vehicleid][LightS]				= strval(VehicleSlots[42]);
		DataCars[vehicleid][TiresS]				= strval(VehicleSlots[43]);
		DataCars[vehicleid][SlotsTunning][0]	= strval(VehicleSlots[44]);
		DataCars[vehicleid][SlotsTunning][1]	= strval(VehicleSlots[45]);
		DataCars[vehicleid][SlotsTunning][2]	= strval(VehicleSlots[46]);
		DataCars[vehicleid][SlotsTunning][3]	= strval(VehicleSlots[47]);
		DataCars[vehicleid][SlotsTunning][4]	= strval(VehicleSlots[48]);
		DataCars[vehicleid][SlotsTunning][5]	= strval(VehicleSlots[49]);
		DataCars[vehicleid][SlotsTunning][6]	= strval(VehicleSlots[50]);
		DataCars[vehicleid][SlotsTunning][7]	= strval(VehicleSlots[51]);
		DataCars[vehicleid][SlotsTunning][8]	= strval(VehicleSlots[52]);
		DataCars[vehicleid][SlotsTunning][9]	= strval(VehicleSlots[53]);
		DataCars[vehicleid][SlotsTunning][10]	= strval(VehicleSlots[54]);
		DataCars[vehicleid][SlotsTunning][11]	= strval(VehicleSlots[55]);
		DataCars[vehicleid][SlotsTunning][12]	= strval(VehicleSlots[56]);
		DataCars[vehicleid][SlotsTunning][13]	= strval(VehicleSlots[57]);
		DataCars[vehicleid][Vinillo]			= strval(VehicleSlots[58]);
		if ( type )
		{
			DataCars[vehicleid][Interior]			= strval(VehicleSlots[59]);
		}
		DataCars[vehicleid][InteriorLast]		= strval(VehicleSlots[60]);
		if ( type )
		{
			DataCars[vehicleid][World]				= strval(VehicleSlots[61]);
		}
		DataCars[vehicleid][WorldLast]			= strval(VehicleSlots[62]);

		fread(LoadVehicle, VehicleData);
		fclose(LoadVehicle);

		PosSplitAfter = 0;
		for ( new i = 0; i < MAX_VEHICLE_SLOT; i++ )
		{
			PosSplitAfter = strfind(VehicleData, ",", false);
			strmid(VehicleSlots[i], VehicleData, 0, PosSplitAfter, sizeof(VehicleData));
			strdel(VehicleData, 0, PosSplitAfter + 1);
		}

		DataCars[vehicleid][StationID]				= strval(VehicleSlots[0]);
		DataCars[vehicleid][VolumenVehicle]			= strval(VehicleSlots[1]);
		DataCars[vehicleid][EcualizadorVehicle][0]	= strval(VehicleSlots[2]);
		DataCars[vehicleid][EcualizadorVehicle][1]	= strval(VehicleSlots[3]);
		DataCars[vehicleid][EcualizadorVehicle][2]	= strval(VehicleSlots[4]);
		DataCars[vehicleid][EcualizadorVehicle][3]	= strval(VehicleSlots[5]);
		DataCars[vehicleid][EcualizadorVehicle][4]	= strval(VehicleSlots[6]);
		DataCars[vehicleid][EcualizadorVehicle][5]	= strval(VehicleSlots[7]);
		DataCars[vehicleid][EcualizadorVehicle][6]	= strval(VehicleSlots[8]);
		DataCars[vehicleid][EcualizadorVehicle][7]	= strval(VehicleSlots[9]);
		DataCars[vehicleid][EcualizadorVehicle][8]	= strval(VehicleSlots[10]);

		DataCars[vehicleid][GuanteraLock]			= strval(VehicleSlots[11]);
		DataCars[vehicleid][GuanteraObjects][0]		= strval(VehicleSlots[12]);
		DataCars[vehicleid][GuanteraObjects][1]		= strval(VehicleSlots[13]);
		DataCars[vehicleid][GuanteraObjects][2]		= strval(VehicleSlots[14]);
		DataCars[vehicleid][GuanteraObjects][3]		= strval(VehicleSlots[15]);
		DataCars[vehicleid][GuanteraObjects][4]		= strval(VehicleSlots[16]);
		DataCars[vehicleid][GuanteraObjects][5]		= strval(VehicleSlots[17]);
		DataCars[vehicleid][GuanteraObjects][6]		= strval(VehicleSlots[18]);
		DataCars[vehicleid][GuanteraObjects][7]		= strval(VehicleSlots[19]);


		DataCars[vehicleid][VehicleDeath]		= false;
		DataCars[vehicleid][Puente]				= true;
		DataCars[vehicleid][StateEncendido] 	= false;

		if ( !type )
		{
		    if ( ModelTemp != DataCars[vehicleid][Modelo] )
		    {
		        DataCars[vehicleid][IsLastSpawn]  = false;
		        DataCars[vehicleid][WorldLast]    = DataCars[vehicleid][World];
		        DataCars[vehicleid][InteriorLast] = DataCars[vehicleid][Interior];
				CleanTunningSlots(vehicleid);
		    }
		}
		return true;
	}
	return false;
}
public SetLastSettingVehicle(vehicleid)
{
	CreateVehicleEx(DataCars[vehicleid][Modelo], DataCars[vehicleid][LastX], DataCars[vehicleid][LastY], DataCars[vehicleid][LastZ], DataCars[vehicleid][LastZZ], DataCars[vehicleid][Color1], DataCars[vehicleid][Color2], vehicleid);
	UpdateVehicleDamageStatus(vehicleid, DataCars[vehicleid][PanelS], DataCars[vehicleid][DoorS], DataCars[vehicleid][LightS], DataCars[vehicleid][TiresS]);
	if ( DataCars[vehicleid][Vinillo] != -1 && IsValidVehiclePaintJob(DataCars[vehicleid][Modelo]) )
	{
		ChangeVehiclePaintjob(vehicleid, DataCars[vehicleid][Vinillo]);
	}
	else
	{
		DataCars[vehicleid][Vinillo] = -1;
	}
	for (new t = 0; t < 14; t++ )
	{
	    if ( DataCars[vehicleid][SlotsTunning][t] )
	    {
			AddVehicleComponentEx(vehicleid, DataCars[vehicleid][SlotsTunning][t]);
		}
	}
	if ( DataCars[vehicleid][LastDamage] >= 250.0 )
	{
		SetVehicleHealthEx(vehicleid, DataCars[vehicleid][LastDamage]);
		GetVehicleHealth(vehicleid, DataCars[vehicleid][LastDamage]);
	}
	SetVehicleVirtualWorld(vehicleid, DataCars[vehicleid][WorldLast]);
	LinkVehicleToInterior(vehicleid, DataCars[vehicleid][InteriorLast]);
}
public CreateVehicleEx(model, Float:Xc, Float:Yc, Float:Zc, Float:ZZc, color1, color2, vehicleid)
{
	if ( coches_Todos_Type[model - 400] != TREN )
	{
   		CreateVehicle(model, Xc, Yc, Zc, ZZc, color1, color2, -1);
   	}
   	else
   	{
   		if ( model == 538 || model == 449 )
   		{
	   		AddStaticVehicle(model, Xc, Yc, Zc, ZZc, color1, color2);

			DataCars[vehicleid][Gas] = MAX_GAS_VEHICLE;
			//DataCars[vehicleid][Oil] = MAX_OIL_VEHICLE;

	   		if ( model == 538 )
	   		{
	   			MAX_TRAIN++;
		   		TrainGroups[MAX_TRAIN][0] = vehicleid;
		   		TrainGroups[MAX_TRAIN][1] = vehicleid + 1;
		   		TrainGroups[MAX_TRAIN][2] = vehicleid + 2;
		   		TrainGroups[MAX_TRAIN][3] = vehicleid + 3;
	   		}
   		}
	}

	SetVehicleNumberPlate(vehicleid, DataCars[vehicleid][MatriculaString]);

	if ( vehicleid <= MAX_CAR_DUENO && strlen(DataCars[vehicleid][Dueno]) == 1 )
	{
		DataCars[vehicleid][AlarmOn] = true;
	}
	else
	{
		DataCars[vehicleid][AlarmOn] = false;
	}
	if ( coches_Todos_Type[GetVehicleModel(vehicleid) - 400] != BICI )
	{
		DataCars[vehicleid][StateEncendido] = false;
	}
	else
	{
		DataCars[vehicleid][StateEncendido] = true;
		IsVehicleOff(vehicleid);
	}
	if ( vehicleid > MAX_CAR_DUENO && vehicleid <= MAX_CAR_GANG && DataCars[vehicleid][Time] == TRIADA && GetVehicleModel(vehicleid) == 483 )
	{
		ChangeVehiclePaintjob(vehicleid, 0);
	}

	SetVehicleParamsEx(vehicleid, DataCars[vehicleid][StateEncendido], DataCars[vehicleid][LightState], false, false, DataCars[vehicleid][CapoState], DataCars[vehicleid][MaleteroState], false);

	SetVehicleVirtualWorld(vehicleid, DataCars[vehicleid][World]);
	LinkVehicleToInterior(vehicleid, DataCars[vehicleid][Interior]);
}

public LoadCarsGang()
{
/////////////////////////////////////		/// YAKUZA
	MAX_CAR++;// 487,-2987.5625,477.9844,5.1315,90.1193,0,0); // HeliGang1
	DataCars[MAX_CAR][PosX]   = -2987.5625;
	DataCars[MAX_CAR][PosY]   = 477.9844;
	DataCars[MAX_CAR][PosZ]   = 5.1315;
	DataCars[MAX_CAR][PosZZ]  = 180;
	DataCars[MAX_CAR][Modelo] = 487;
	DataCars[MAX_CAR][Color1] = 6;
	DataCars[MAX_CAR][Color2] = 6;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]   = YAKUZA;

	MAX_CAR++; // 411,-2971.5820,458.8619,4.6411,359.3310,1,1); // CarroGang1
	DataCars[MAX_CAR][PosX]   = -2971.5820;
	DataCars[MAX_CAR][PosY]     = 458.8619;
	DataCars[MAX_CAR][PosZ]     = 4.6411;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 560;
	DataCars[MAX_CAR][Color1] = 6;
	DataCars[MAX_CAR][Color2] = 6;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = YAKUZA;

	MAX_CAR++; // 411,-2966.4954,458.7052,4.6411,0.2663,1,1); // Carro2Gang1
	DataCars[MAX_CAR][PosX]   = -2966.4954;
	DataCars[MAX_CAR][PosY]     = 458.8619;
	DataCars[MAX_CAR][PosZ]     = 4.6411;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 560;
	DataCars[MAX_CAR][Color1] = 6;
	DataCars[MAX_CAR][Color2] = 6;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = YAKUZA;

	MAX_CAR++; // 411,-2966.4954,458.7052,4.6411,0.2663,1,1); // Carro3Gang1
	DataCars[MAX_CAR][PosX]   = -2961.4088;
	DataCars[MAX_CAR][PosY]     = 458.8619;
	DataCars[MAX_CAR][PosZ]     = 4.6411;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 6;
	DataCars[MAX_CAR][Color2] = 6;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = YAKUZA;

	MAX_CAR++; // 411,-2966.4954,458.7052,4.6411,0.2663,1,1); // Carro4Gang1
	DataCars[MAX_CAR][PosX]   = -2956.3222;
	DataCars[MAX_CAR][PosY]     = 458.8619;
	DataCars[MAX_CAR][PosZ]     = 4.6411;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 6;
	DataCars[MAX_CAR][Color2] = 6;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = YAKUZA;
//5.0866
	MAX_CAR++; // 411,-2966.4954,458.7052,4.6411,0.2663,1,1); // Moto1Gang1
	DataCars[MAX_CAR][PosX]   = -2951.2356;
	DataCars[MAX_CAR][PosY]     = 458.8619;
	DataCars[MAX_CAR][PosZ]     = 4.6411;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 522;
	DataCars[MAX_CAR][Color1] = 6;
	DataCars[MAX_CAR][Color2] = 6;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = YAKUZA;

////////////////////////////////////////// RUSOS
	MAX_CAR++;// 487,-2124.4072,-123.5105,36.7112,270.5307,6,6); // HeliGang2
	DataCars[MAX_CAR][PosX]   = -2124.4072;
	DataCars[MAX_CAR][PosY]   = -123.5105;
	DataCars[MAX_CAR][PosZ]   = 36.7112;
	DataCars[MAX_CAR][PosZZ]  = 270;
	DataCars[MAX_CAR][Modelo] = 487;
	DataCars[MAX_CAR][Color1] = 3;
	DataCars[MAX_CAR][Color2] = 3;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]   = RUSOS;

	MAX_CAR++; // 411,-2137.4072,-175.6781,35.0496,0.3695,6,6); // Car1Gang2
	DataCars[MAX_CAR][PosX]   = -2137.4072;
	DataCars[MAX_CAR][PosY]     = -175.6781;
	DataCars[MAX_CAR][PosZ]     = 35.0496;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 560;
	DataCars[MAX_CAR][Color1] = 3;
	DataCars[MAX_CAR][Color2] = 3;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = RUSOS;

	MAX_CAR++; // 411,-2131.7261,-175.6978,35.0474,358.9370,6,6); // Car2Gang2
	DataCars[MAX_CAR][PosX]   = -2131.7261;
	DataCars[MAX_CAR][PosY]     = -175.6781;
	DataCars[MAX_CAR][PosZ]     = 35.0496;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 560;
	DataCars[MAX_CAR][Color1] = 3;
	DataCars[MAX_CAR][Color2] = 3;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = RUSOS;
//5,6811
	MAX_CAR++; // 411,-2131.7261,-175.6978,35.0474,358.9370,6,6); // Car3Gang2
	DataCars[MAX_CAR][PosX]   = -2126.0450;
	DataCars[MAX_CAR][PosY]     = -175.6781;
	DataCars[MAX_CAR][PosZ]     = 35.0496;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 3;
	DataCars[MAX_CAR][Color2] = 3;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = RUSOS;
//5,6811
	MAX_CAR++; // 411,-2131.7261,-175.6978,35.0474,358.9370,6,6); // Car4Gang2
	DataCars[MAX_CAR][PosX]   = -2120.3639;
	DataCars[MAX_CAR][PosY]     = -175.6781;
	DataCars[MAX_CAR][PosZ]     = 35.0496;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 3;
	DataCars[MAX_CAR][Color2] = 3;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = RUSOS;
//5,6811
	MAX_CAR++; // 411,-2131.7261,-175.6978,35.0474,358.9370,6,6); // MotoGang2
	DataCars[MAX_CAR][PosX]   = -2114.6828;
	DataCars[MAX_CAR][PosY]     = -175.6781;
	DataCars[MAX_CAR][PosZ]     = 35.0496;
	DataCars[MAX_CAR][PosZZ]  = 0;
	DataCars[MAX_CAR][Modelo] = 522;
	DataCars[MAX_CAR][Color1] = 3;
	DataCars[MAX_CAR][Color2] = 3;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = RUSOS;

///////////////////////////////////////////////// ITALIANOSSS
	MAX_CAR++; // 411,-2414.1594,535.9025,29.6551,258.1873,6,6); // Car1Gang3
	DataCars[MAX_CAR][PosX]   = -2414.1594;
	DataCars[MAX_CAR][PosY]     = 535.9025;
	DataCars[MAX_CAR][PosZ]     = 29.6551;
	DataCars[MAX_CAR][PosZZ]  = 258.1873;
	DataCars[MAX_CAR][Modelo] = 560;
	DataCars[MAX_CAR][Color1] = 44;
	DataCars[MAX_CAR][Color2] = 44;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = ITALIANOS;

	MAX_CAR++; // 411,-2415.2856,532.1779,29.6568,248.0297,6,6); // Car2Gang3
	DataCars[MAX_CAR][PosX]   = -2415.2856;
	DataCars[MAX_CAR][PosY]     = 532.1779;
	DataCars[MAX_CAR][PosZ]     = 29.6568;
	DataCars[MAX_CAR][PosZZ]  = 248.0297;
	DataCars[MAX_CAR][Modelo] = 560;
	DataCars[MAX_CAR][Color1] = 44;
	DataCars[MAX_CAR][Color2] = 44;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = ITALIANOS;

	MAX_CAR++; // -2417.1035,528.6509,29.6568,237.8349,6,6); // Car3Gang3
	DataCars[MAX_CAR][PosX]   = -2417.1035;
	DataCars[MAX_CAR][PosY]     = 528.6509;
	DataCars[MAX_CAR][PosZ]     = 29.6568;
	DataCars[MAX_CAR][PosZZ]  = 237.8349;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 44;
	DataCars[MAX_CAR][Color2] = 44;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = ITALIANOS;

	MAX_CAR++; // 411,-2419.5374,525.1858,29.6568,231.2986,6,6); // Car4Gang3
	DataCars[MAX_CAR][PosX]   = -2419.5374;
	DataCars[MAX_CAR][PosY]     = 525.1858;
	DataCars[MAX_CAR][PosZ]     = 29.6568;
	DataCars[MAX_CAR][PosZZ]  = 231.2986;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 44;
	DataCars[MAX_CAR][Color2] = 44;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = ITALIANOS;

	MAX_CAR++; // 522,-2422.3230,521.7115,29.6568,226.5609,6,6); // Car5Gang3 Moto
	DataCars[MAX_CAR][PosX]   = -2422.3230;
	DataCars[MAX_CAR][PosY]     = 521.7115;
	DataCars[MAX_CAR][PosZ]     = 29.6568;
	DataCars[MAX_CAR][PosZZ]  = 226.5609;
	DataCars[MAX_CAR][Modelo] = 522;
	DataCars[MAX_CAR][Color1] = 44;
	DataCars[MAX_CAR][Color2] = 44;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = ITALIANOS;

	MAX_CAR++; // 487,-2441.5906,523.5626,34.3147,179.9894,6,6); // Car6Gang3 Heli
	DataCars[MAX_CAR][PosX]   = -2441.5906;
	DataCars[MAX_CAR][PosY]     = 523.5626;
	DataCars[MAX_CAR][PosZ]     = 34.3147;
	DataCars[MAX_CAR][PosZZ]  = 180;
	DataCars[MAX_CAR][Modelo] = 487;
	DataCars[MAX_CAR][Color1] = 44;
	DataCars[MAX_CAR][Color2] = 44;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = ITALIANOS;
//////////////////////////////////////////////////// AUTOS TRIADAS

	MAX_CAR++; // 487,-2071.5427,1426.2271,7.2489,180.0605,6,6); // HeliGang4
	DataCars[MAX_CAR][PosX]   = -2071.5427;
	DataCars[MAX_CAR][PosY]     = 1426.2271;
	DataCars[MAX_CAR][PosZ]     = 7.2489;
	DataCars[MAX_CAR][PosZZ]  = 180;
	DataCars[MAX_CAR][Modelo] = 487;
	DataCars[MAX_CAR][Color1] = 118;
	DataCars[MAX_CAR][Color2] = 118;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = TRIADA;

	MAX_CAR++; // 411,-2091.7502,1411.8964,6.8286,269.1866,6,6); // Carro1Gang4
	DataCars[MAX_CAR][PosX]   = -2091.7502;
	DataCars[MAX_CAR][PosY]     = 1411.8964;
	DataCars[MAX_CAR][PosZ]     = 6.8286;
	DataCars[MAX_CAR][PosZZ]  = 270;
	DataCars[MAX_CAR][Modelo] = 560;
	DataCars[MAX_CAR][Color1] = 118;
	DataCars[MAX_CAR][Color2] = 118;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = TRIADA;

	MAX_CAR++; // 411,-2091.6270,1407.0438,6.8286,271.0850,6,6); // Carro2Gang4
	DataCars[MAX_CAR][PosX]   = -2091.6270;
	DataCars[MAX_CAR][PosY]     = 1407.0438;
	DataCars[MAX_CAR][PosZ]     = 6.8286;
	DataCars[MAX_CAR][PosZZ]  = 270;
	DataCars[MAX_CAR][Modelo] = 560;
	DataCars[MAX_CAR][Color1] = 118;
	DataCars[MAX_CAR][Color2] = 118;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = TRIADA;

	MAX_CAR++; // 411,-2091.5073,1402.6138,6.8284,272.8087,6,6); // Carro3Gang4
	DataCars[MAX_CAR][PosX]   = -2091.5073;
	DataCars[MAX_CAR][PosY]     = 1402.6138;
	DataCars[MAX_CAR][PosZ]     = 6.8286;
	DataCars[MAX_CAR][PosZZ]  = 270;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 118;
	DataCars[MAX_CAR][Color2] = 118;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = TRIADA;

	MAX_CAR++; // 411,-2091.6365,1397.5176,6.8277,269.7722,6,6); // Carro4Gang4
	DataCars[MAX_CAR][PosX]   = -2091.6365;
	DataCars[MAX_CAR][PosY]     = 1397.5176;
	DataCars[MAX_CAR][PosZ]     = 6.8286;
	DataCars[MAX_CAR][PosZZ]  = 270;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 118;
	DataCars[MAX_CAR][Color2] = 118;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = TRIADA;

	MAX_CAR++; // 522,-2091.8357,1390.9486,6.6714,273.3169,6,6); // Moto1Gang4
	DataCars[MAX_CAR][PosX]   = -2091.8357;
	DataCars[MAX_CAR][PosY]     = 1390.9486;
	DataCars[MAX_CAR][PosZ]     = 6.8286;
	DataCars[MAX_CAR][PosZZ]  = 270;
	DataCars[MAX_CAR][Modelo] = 522;
	DataCars[MAX_CAR][Color1] = 118;
	DataCars[MAX_CAR][Color2] = 118;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = TRIADA;

	
	// END VEHICLES
	MAX_CAR_GANG = MAX_CAR;
}
public LoadCarsPublic()
{
//AUTOS PUBLICOS

	MAX_CAR++; // 411,-2840.5300,1257.4949,5.2520,141.8740,6,6); // Carro1Gang0- SpawnParke Jizzys
	DataCars[MAX_CAR][PosX]   = -2840.5300;
	DataCars[MAX_CAR][PosY]     = 1257.4949;
	DataCars[MAX_CAR][PosZ]     = 5.2520;
	DataCars[MAX_CAR][PosZZ]  = 141.8740;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;

	MAX_CAR++; //411,-2846.4028,1249.9537,5.2521,142.2395,6,6); // Carro2Gang0- SpawnParke Jizzys
	DataCars[MAX_CAR][PosX]   = -2846.4028;//
	DataCars[MAX_CAR][PosY]     = 1249.9537;//
	DataCars[MAX_CAR][PosZ]     = 5.2521;
	DataCars[MAX_CAR][PosZZ]  = 142.2395;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;

	MAX_CAR++; //411,-2851.9612,1242.6803,5.2538,142.5598,6,6); // Carro3Gang0- SpawnParke Jizzys
	DataCars[MAX_CAR][PosX]   = -2851.9612;//
	DataCars[MAX_CAR][PosY]     = 1242.6803;//
	DataCars[MAX_CAR][PosZ]     = 5.2538;
	DataCars[MAX_CAR][PosZZ]  = 142.5598;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;

	MAX_CAR++; //411,-2857.7947,1234.9545,5.2520,142.6751,6,6); // Carro4Gang0- SpawnParke Jizzys
	DataCars[MAX_CAR][PosX]   = -2857.7947;//
	DataCars[MAX_CAR][PosY]     = 1234.9545;//
	DataCars[MAX_CAR][PosZ]     = 5.2520;
	DataCars[MAX_CAR][PosZZ]  = 142.6751;
	DataCars[MAX_CAR][Modelo] = 522;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;

	MAX_CAR++; //411,-2462.2710,167.8905,34.7625,180.8224,6,6); // Carro1Gang0 - SpawnHotel
	DataCars[MAX_CAR][PosX]   = -2462.2710;//
	DataCars[MAX_CAR][PosY]     = 167.8905;//
	DataCars[MAX_CAR][PosZ]     = 34.7625;
	DataCars[MAX_CAR][PosZZ]  = 180.8224;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //411,-2462.0793,155.3077,34.7924,179.5923,6,6); // Car2Gang0-Spawnhotel
	DataCars[MAX_CAR][PosX]   = -2462.0793;//
	DataCars[MAX_CAR][PosY]     = 155.3077;//
	DataCars[MAX_CAR][PosZ]     = 34.7924;
	DataCars[MAX_CAR][PosZZ]  = 179.5923;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //411,-2455.6143,181.8394,34.7599,134.2879,6,6); // Car3Gang0-Spawnhotel
	DataCars[MAX_CAR][PosX]   = -2455.6143;//
	DataCars[MAX_CAR][PosY]     = 181.8394;//
	DataCars[MAX_CAR][PosZ]     = 34.7599;
	DataCars[MAX_CAR][PosZZ]  = 134.2879;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //522,-2460.8037,175.6152,34.5314,158.1226,6,6); // Car4Gang0-Spawnhotel Moto
	DataCars[MAX_CAR][PosX]   = -2460.8037;//
	DataCars[MAX_CAR][PosY]     = 175.6152;//
	DataCars[MAX_CAR][PosZ]     = 34.5314;
	DataCars[MAX_CAR][PosZZ]  = 158.1226;
	DataCars[MAX_CAR][Modelo] = 522;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //411,-1961.5807,1140.6160,48.9304,180.7005,6,6); // Car1Gang0-SpawnIglesia
	DataCars[MAX_CAR][PosX]   = -1961.5807;//
	DataCars[MAX_CAR][PosY]     = 1140.6160;//
	DataCars[MAX_CAR][PosZ]     = 48.9304;
	DataCars[MAX_CAR][PosZZ]  = 180.7005;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //411,-1961.6688,1131.2214,50.6274,179.9019,6,6); // Car2Gang0-SpawnIglesia
	DataCars[MAX_CAR][PosX]   = -1961.6688;//
	DataCars[MAX_CAR][PosY]     = 1131.2214;//
	DataCars[MAX_CAR][PosZ]     = 50.6274;
	DataCars[MAX_CAR][PosZZ]  = 179.9019;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //411,-1961.5728,1121.3226,52.4164,179.9008,6,6); // Car3Gang0-SpawnIglesia
	DataCars[MAX_CAR][PosX]   = -1961.5728;//
	DataCars[MAX_CAR][PosY]     = 1121.3226;//
	DataCars[MAX_CAR][PosZ]     = 52.4164;
	DataCars[MAX_CAR][PosZZ]  = 179.9008;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //522,-1961.8265,1112.0741,53.8456,178.9151,6,6); // Car4Gang0-SpawnIglesia Moto
	DataCars[MAX_CAR][PosX]   = -1961.8265;//
	DataCars[MAX_CAR][PosY]     = 1112.0741;//
	DataCars[MAX_CAR][PosZ]     = 53.8456;
	DataCars[MAX_CAR][PosZZ]  = 178.9151;
	DataCars[MAX_CAR][Modelo] = 522;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //411,-1924.8342,723.8277,45.0958,90.5065,1,1); // Carro1Gang0 SpwnCentro
	DataCars[MAX_CAR][PosX]   = -1924.8342;//
	DataCars[MAX_CAR][PosY]     = 723.8277;//
	DataCars[MAX_CAR][PosZ]     = 45.0958;
	DataCars[MAX_CAR][PosZZ]  = 90;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //411,-1933.7247,723.9589,45.0959,88.8244,1,1); // Carro2Gang0 SpwnCentro
	DataCars[MAX_CAR][PosX]   = -1933.7247;//
	DataCars[MAX_CAR][PosY]     = 723.8277;//
	DataCars[MAX_CAR][PosZ]     = 45.0958;
	DataCars[MAX_CAR][PosZZ]  = 90;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //411,-1942.9653,724.0085,45.0958,89.8353,1,1); // Carro3Gang0 SpwnCentro
	DataCars[MAX_CAR][PosX]   = -1942.9653;//
	DataCars[MAX_CAR][PosY]     = 724.0085;//
	DataCars[MAX_CAR][PosZ]     = 45.0958;
	DataCars[MAX_CAR][PosZZ]  = 90;
	DataCars[MAX_CAR][Modelo] = 411;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	MAX_CAR++; //522,-1952.6813,724.3341,44.8738,87.3538,1,1); // Carro4Gang0 SpwnCentro Moto
	DataCars[MAX_CAR][PosX]   = -1952.6813;//
	DataCars[MAX_CAR][PosY]     = 724.3341;//
	DataCars[MAX_CAR][PosZ]     = 44.8738;
	DataCars[MAX_CAR][PosZZ]  = 90;
	DataCars[MAX_CAR][Modelo] = 522;
	DataCars[MAX_CAR][Color1] = 1;
	DataCars[MAX_CAR][Color2] = 1;
	format(DataCars[MAX_CAR][Dueno], MAX_PLAYER_NAME, "0");
	DataCars[MAX_CAR][Lock]   = false;
	DataCars[MAX_CAR][Time]     = SINGANG;
	MAX_CAR_PUBLIC = MAX_CAR;

	// END VEHICLES PUBLICS
}
public SetPlateToCarGang(vehicleid, faccionid)
{
	format(DataCars[vehicleid][MatriculaString], 32, "G%i-V%i", faccionid, vehicleid);
	DataCars[vehicleid][Matricula]	= strval(DataCars[vehicleid][MatriculaString]);
}
public Text:TextDrawCreateEx(Float:Xt, Float:Yt, text[])
{
    MAX_TEXT_DRAW++;
    return TextDrawCreate(Xt, Yt, text);
}
public CreateDynamicMapIconSGW(Float:x, Float:y, Float:z, type)
{
	CreateDynamicMapIcon(x, y, z, type, 0, 0, 0, -1, MAX_RADIO_STREAM_MAP_ICON);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public LoadDataGang(faccionid)
{
	new TempDirGang[25];
    format(TempDirGang, sizeof(TempDirGang), "%s%i.sgw", DIR_GANGES, faccionid);
    new GangDataALL[MAX_PLAYER_DATA];
    new GangDataSlots[MAX_GANG_SLOT][MAX_PLAYER_NAME];
	new File:LoadGang = fopen(TempDirGang, io_read);
	fread(LoadGang, GangDataALL);
	fclose(LoadGang);

	new PosSplitAfter = 0;
	for ( new i = 0; i < MAX_GANG_SLOT; i++ )
	{
		PosSplitAfter = strfind(GangDataALL, "|", false);
		strmid(GangDataSlots[i], GangDataALL, 0, PosSplitAfter, sizeof(GangDataALL));
		strdel(GangDataALL, 0, PosSplitAfter + 1);
	}

	format(GangData[faccionid][Lider], MAX_PLAYER_NAME, "%s", GangDataSlots[0]);
	GangData[faccionid][Deposito] 		= strval(GangDataSlots[1]);
	GangData[faccionid][Almacen][0] 		= strval(GangDataSlots[2]);
	GangData[faccionid][Almacen][1] 		= strval(GangDataSlots[3]);
	GangData[faccionid][LockA][0]		= strval(GangDataSlots[4]);
	GangData[faccionid][LockA][1] 		= strval(GangDataSlots[5]);
	GangData[faccionid][Lock]            = strval(GangDataSlots[6]);

	WeaponsGang[faccionid][0][0]    = strval(GangDataSlots[7]);
	WeaponsGang[faccionid][0][1]    = strval(GangDataSlots[8]);
	WeaponsGang[faccionid][0][2]    = strval(GangDataSlots[9]);
	WeaponsGang[faccionid][0][3]    = strval(GangDataSlots[10]);
	WeaponsGang[faccionid][0][4]    = strval(GangDataSlots[11]);
	WeaponsGang[faccionid][0][5]    = strval(GangDataSlots[12]);
	WeaponsGang[faccionid][0][6]    = strval(GangDataSlots[13]);
	WeaponsGang[faccionid][0][7]    = strval(GangDataSlots[14]);
	WeaponsGang[faccionid][0][8]    = strval(GangDataSlots[15]);
	WeaponsGang[faccionid][0][9]    = strval(GangDataSlots[16]);

	WeaponsGang[faccionid][1][0]    = strval(GangDataSlots[17]);
	WeaponsGang[faccionid][1][1]    = strval(GangDataSlots[18]);
	WeaponsGang[faccionid][1][2]    = strval(GangDataSlots[19]);
	WeaponsGang[faccionid][1][3]    = strval(GangDataSlots[20]);
	WeaponsGang[faccionid][1][4]    = strval(GangDataSlots[21]);
	WeaponsGang[faccionid][1][5]    = strval(GangDataSlots[22]);
	WeaponsGang[faccionid][1][6]    = strval(GangDataSlots[23]);
	WeaponsGang[faccionid][1][7]    = strval(GangDataSlots[24]);
	WeaponsGang[faccionid][1][8]    = strval(GangDataSlots[25]);
	WeaponsGang[faccionid][1][9]    = strval(GangDataSlots[26]);

	AmmoGang[faccionid][0][0]    = strval(GangDataSlots[27]);
	AmmoGang[faccionid][0][1]    = strval(GangDataSlots[28]);
	AmmoGang[faccionid][0][2]    = strval(GangDataSlots[29]);
	AmmoGang[faccionid][0][3]    = strval(GangDataSlots[30]);
	AmmoGang[faccionid][0][4]    = strval(GangDataSlots[31]);
	AmmoGang[faccionid][0][5]    = strval(GangDataSlots[32]);
	AmmoGang[faccionid][0][6]    = strval(GangDataSlots[33]);
	AmmoGang[faccionid][0][7]    = strval(GangDataSlots[34]);
	AmmoGang[faccionid][0][8]    = strval(GangDataSlots[35]);
	AmmoGang[faccionid][0][9]    = strval(GangDataSlots[36]);

	AmmoGang[faccionid][1][0]    = strval(GangDataSlots[37]);
	AmmoGang[faccionid][1][1]    = strval(GangDataSlots[38]);
	AmmoGang[faccionid][1][2]    = strval(GangDataSlots[39]);
	AmmoGang[faccionid][1][3]    = strval(GangDataSlots[40]);
	AmmoGang[faccionid][1][4]    = strval(GangDataSlots[41]);
	AmmoGang[faccionid][1][5]    = strval(GangDataSlots[42]);
	AmmoGang[faccionid][1][6]    = strval(GangDataSlots[43]);
	AmmoGang[faccionid][1][7]    = strval(GangDataSlots[44]);
	AmmoGang[faccionid][1][8]    = strval(GangDataSlots[45]);
	AmmoGang[faccionid][1][9]    = strval(GangDataSlots[46]);

	GangesChaleco[faccionid][0][0]    = floatstr(GangDataSlots[47]);
	GangesChaleco[faccionid][0][1]    = floatstr(GangDataSlots[48]);
	GangesChaleco[faccionid][0][2]    = floatstr(GangDataSlots[49]);
	GangesChaleco[faccionid][0][3]    = floatstr(GangDataSlots[50]);

	GangesChaleco[faccionid][1][0]    = floatstr(GangDataSlots[51]);
	GangesChaleco[faccionid][1][1]    = floatstr(GangDataSlots[52]);
	GangesChaleco[faccionid][1][2]    = floatstr(GangDataSlots[53]);
	GangesChaleco[faccionid][1][3]    = floatstr(GangDataSlots[54]);

	GangData[faccionid][Drogas][0]    = strval(GangDataSlots[55]);
	GangData[faccionid][Drogas][1]    = strval(GangDataSlots[56]);

	GangData[faccionid][Ganzuas][0]   = strval(GangDataSlots[57]);
	GangData[faccionid][Ganzuas][1]   = strval(GangDataSlots[58]);

	GangData[faccionid][Bombas][0]    = strval(GangDataSlots[59]);
	GangData[faccionid][Bombas][1]    = strval(GangDataSlots[60]);

	new ActTextDraw[150];
	format(ActTextDraw, sizeof(ActTextDraw), "~B~Gang: ~W~%s ~N~~G~ ~W~%s", GangData[faccionid][NameGang], GangData[faccionid][Lider]);

	LoadPickupsMisc();
	LoadPickupsAlmacenes();

	GangTextDraws[faccionid] = TextDrawCreateEx(200.0, 380.0, ActTextDraw);
	TextDrawUseBox(GangTextDraws[faccionid], 1);
	TextDrawBackgroundColor(GangTextDraws[faccionid] ,0x000000FF);
	TextDrawBoxColor(GangTextDraws[faccionid], 0x00000066);
	TextDrawTextSize(GangTextDraws[faccionid], 350.0, 380.0);
	TextDrawSetShadow(GangTextDraws[faccionid], 1);
	TextDrawLetterSize(GangTextDraws[faccionid], 0.5 , 1.2);
}
public SetStyleTextDrawTeles(textdrawid, text[])
{
	new TextDrawTeleText[MAX_TEXT_CHAT];
	format(TextDrawTeleText, sizeof(TextDrawTeleText), "~B~Lugar: ~W~%s", text);
	TelesTextDraws[textdrawid] = TextDrawCreateEx(200.0, 380.0, TextDrawTeleText);
	TextDrawUseBox(TelesTextDraws[textdrawid], 1);
	TextDrawBackgroundColor(TelesTextDraws[textdrawid] ,0x000000FF);
	TextDrawBoxColor(TelesTextDraws[textdrawid], 0x00000066);
	TextDrawTextSize(TelesTextDraws[textdrawid], 350.0, 380.0);
	TextDrawSetShadow(TelesTextDraws[textdrawid], 1);
	TextDrawLetterSize(TelesTextDraws[textdrawid], 0.5 , 1.2);
	return textdrawid;
}
public ActTextDrawBizz(bizzid)
{
	new TextDrawNegociosText[300];
	if ( strlen(NegociosData[bizzid][Dueno]) != 1 )
	{
		format(TextDrawNegociosText, sizeof(TextDrawNegociosText),
		"%s~N~~N~~B~Lugar: ~W~Negocio~N~~G~Tipo: ~W~%s~N~~G~Propietario: ~W~%s~N~~G~Extorsionista: ~W~%s~N~~G~Entrada: ~W~$%i~N~~G~Nivel: ~W~%i",
			NegociosData[bizzid][NameBizz],
	        NegociosType[NegociosData[bizzid][Type]][TypeName],
	        NegociosData[bizzid][Dueno],
	        NegociosData[bizzid][Extorsion],
	        NegociosData[bizzid][PriceJoin],
	        NegociosData[bizzid][Level]
		);
	}
	else
	{
		format(TextDrawNegociosText, sizeof(TextDrawNegociosText),
		"~B~Lugar: ~W~Negocio~N~~G~Tipo: ~W~%s~N~~G~Estado: ~W~¡En Venta!~N~~G~Precio: ~W~$%i~N~~G~Nivel: ~W~%i~N~~G~Use ~R~/Comprar Negocio",
	        NegociosType[NegociosData[bizzid][Type]][TypeName],
			NegociosData[bizzid][Precio],
	        NegociosData[bizzid][Level]
		);
	}
	TextDrawSetString(NegociosTextDraws[bizzid], TextDrawNegociosText);
}
public ActTextDrawHouse(houseid)
{
	new TextDrawHouseText[300];
	if ( strlen(HouseData[houseid][Dueno]) != 2 )
	{
		new PriceRentText[50];
		if ( HouseData[houseid][PriceRent] != 0 )
		{
		    format(PriceRentText, sizeof(PriceRentText), "$%i", HouseData[houseid][PriceRent]);
		}
		else
		{
			PriceRentText = "No se renta";
		}
		format(TextDrawHouseText, sizeof(TextDrawHouseText),
		"~B~Lugar: ~W~Casa~N~~G~Tipo: ~W~%s~N~~G~Garage: ~W~%s~N~~G~Propietario: ~W~%s~N~~G~Renta: ~W~%s~N~~G~Nivel: ~W~%i",
	        TypeHouse[HouseData[houseid][TypeHouseId]][TypeName],
	        SiOrNo[ExistGarageInHouse(houseid)],
			HouseData[houseid][Dueno],
			PriceRentText,
			HouseData[houseid][Level] );
	}
	else
	{
		format(TextDrawHouseText, sizeof(TextDrawHouseText),
		"~B~Lugar: ~W~Casa~N~~G~Tipo: ~W~%s~N~~G~Garage: ~W~%s~N~~G~Estado: ~W~¡En Venta!~N~~G~Precio: ~W~$%i~N~~G~Nivel: ~W~%i~N~~G~Use: ~R~/Comprar Casa",
	        TypeHouse[HouseData[houseid][TypeHouseId]][TypeName],
	        SiOrNo[ExistGarageInHouse(houseid)],
			HouseData[houseid][Price],
			HouseData[houseid][Level] );
	}
	TextDrawSetString(CasasTextDraws[houseid], TextDrawHouseText);
}
public AddBomba(playerid, type, vehicleid, Float:Xbom, Float:Ybom, Float:Zbom, objectid)
{
	for (new i = 0; i < MAX_BOMBAS_COUNT; i++ )
	{
	    if ( BombasO[i][TypeBomba] == BOMBA_TYPE_NONE )
	    {
   		    new MsgPonerBomba[MAX_TEXT_CHAT];
			if ( type == BOMBA_TYPE_FOOT )
			{
			    format(MsgPonerBomba, sizeof(MsgPonerBomba), "Has puesto una bomba en el piso! El número de contro de la bomba es #%i.", i);
			    new Float:ZZ[3];
				if ( playerid != -1 )
				{
				    switch ( objectid )
				    {
				        case 1654: // Dinámita
				        {
	                        Zbom 	= Zbom - 0.9;
	                        ZZ[0] 	= -90.0;
						}
				        case 1265: // Bolsa
				        {
	                        Zbom 	= Zbom - 0.6;
						}
				        case 1580:
				        {
	                        Zbom 	= Zbom - 1.0;
						}
				        case 1210: // Maletín
				        {
	                        Zbom 	= Zbom - 0.9;
	                        ZZ[0] 	= -90.0;
						}
				        case 1576:
				        {
	                        Zbom 	= Zbom - 1.0;
						}
				        case 1577:
				        {
	                        Zbom 	= Zbom - 1.0;
						}
				        case 1578:
				        {
	                        Zbom 	= Zbom - 1.0;
						}
				        case 1579:
				        {
	                        Zbom 	= Zbom - 1.0;
						}
					}
				}
				else
				{
				    if ( objectid == 1654 || objectid == 1210 )
				    {
				        ZZ[0] = -90.0;
					}
				}
				BombasO[i][ObjectIDO] = objectid;
				BombasO[i][ObjectID]  = CreateDynamicObject(objectid, Xbom, Ybom, Zbom, ZZ[0], ZZ[1], ZZ[2], -1, -1, -1, MAX_RADIO_STREAM); //
				BombasO[i][PosX]      = Xbom;
				BombasO[i][PosY] 	  = Ybom;
				BombasO[i][PosZ]  	  = Zbom;
				BombasO[i][TypeBomba] = BOMBA_TYPE_FOOT;
			}
			else
			{
			    format(MsgPonerBomba, sizeof(MsgPonerBomba), "Has puesto una bomba en éste vehículo! El número de contro de la bomba es #%i.", i);
				BombasO[i][ObjectID]  = vehicleid;
				BombasO[i][TypeBomba] = BOMBA_TYPE_CAR;
			}
			if ( playerid != -1 )
			{
				SendInfoMessage(playerid, 2, "0", MsgPonerBomba);
			}
//			BombasO[i][TimerID] = SetTimerEx("ActivarBomba", MAX_BOMBA_TIME_INACTIVE, false, "d", i);
			return true;
		}
	}
	if ( playerid != -1 )
	{
		SendInfoMessage(playerid, 0, "020", "Han alcanzado el número de bombas plantadas!");
	}
	return false;
}
public CleanTunningSlots(vehicleid)
{
	for (new t = 0; t < 14; t++ )
	{
		DataCars[vehicleid][SlotsTunning][t] = 0;
    }
    DataCars[vehicleid][Vinillo] = -1;
}
public IsValidVehiclePaintJob(vehiclemodel)
{
	if ( vehiclemodel == 560 ||
		 vehiclemodel == 561 ||
		 vehiclemodel == 567 ||
		 vehiclemodel == 562 ||
		 vehiclemodel == 565 ||
		 vehiclemodel == 569 ||
		 vehiclemodel == 568 ||
		 vehiclemodel == 434 ||
		 vehiclemodel == 535 ||
		 vehiclemodel == 536 ||
 		 vehiclemodel == 558 ||
 		 vehiclemodel == 545 ||
 		 vehiclemodel == 559
	   )
	{
	    return true;
	}
	else
	{
	    return false;
	}
}
public AddVehicleComponentEx(vehicleid, componentid)
{
	AddVehicleComponent(vehicleid, componentid);
	DataCars[vehicleid][SlotsTunning][GetVehicleComponentType(componentid)] = componentid;
}
public SetVehicleHealthEx(vehicleid, Float:health)
{
    DataCars[vehicleid][VehicleAnticheat] = gettime() + 5;
    SetVehicleHealth(vehicleid, health);
}
public IsVehicleOff(vehicleid)
{
	new EngineC, LightsC, AlarmC, DoorsC, BonnetC, BootC, ObjectiveC;
	GetVehicleParamsEx(vehicleid, EngineC, LightsC, AlarmC, DoorsC, BonnetC, BootC, ObjectiveC);
	SetVehicleParamsEx(vehicleid, DataCars[vehicleid][StateEncendido], DataCars[vehicleid][LightState], DataCars[vehicleid][AlarmOn], DoorsC, DataCars[vehicleid][CapoState], DataCars[vehicleid][MaleteroState], ObjectiveC);
}
public ExistGarageInHouse(houseid)
{
	for ( new i = 0; i < MAX_GARAGE_FOR_HOUSE; i++ )
	{
	    if ( Garages[houseid][i][Xg] != 0)
	    {
	        return true;
		}
	}
	return false;
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////// MESSAGES INFO
public SendInfoMessage(playerid, type, optional[], message[])
{
	new MsgInfo[MAX_TEXT_CHAT];
	switch ( type )
	{
	    // Error
	    case 0:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "[SGW] Error Nº %s: %s", optional, message);
		}
		// Ayuda
	    case 1:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "%s {AFEBFF}%s", message, optional);
		}
		// Información
	    case 2:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "[SGW] Info: %s", message);
		}
		// Afirmativo
	    case 3:
	    {
	        format(MsgInfo, sizeof(MsgInfo), "[SGW] Importante: %s", message);
		}
	}
	SendClientMessage(playerid, COLOR_MESSAGES[type], MsgInfo);
}
public LoadPickupsMisc()
{

}
public LoadPickupsAlmacenes()
{

	for ( new i = YAKUZA; i <= MAX_GANG; i++ )
	{
	    for ( new a = 0; a < MAX_ALMACENES; a++)
	    {
			if ( GangData[i][AlmacenX][a] != 0 )
			{
				MAX_PICKUP = CreatePickup	(1575, 	1, 	GangData[i][AlmacenX][a], GangData[i][AlmacenY][a], GangData[i][AlmacenZ][a],	 	GangData[i][AlmacenWorld][a]);
			}
		}
	}
}
public GetDataPlayersFloat(playerid, data[], &Float:savedata, &lastpos, &afterpos)
{
	afterpos = strfind(data, "³", false, lastpos);
	strmid(PlayersDataOnline[playerid][NameProject], data, lastpos, afterpos, MAX_PLAYER_NAME);
	savedata = floatstr(PlayersDataOnline[playerid][NameProject]);
	lastpos = afterpos + 1;
}
public GetDataPlayersInt(playerid, data[], &savedata, &lastpos, &afterpos)
{
	afterpos = strfind(data, "³", false, lastpos);
	strmid(PlayersDataOnline[playerid][NameProject], data, lastpos, afterpos, MAX_PLAYER_NAME);
	savedata = strval(PlayersDataOnline[playerid][NameProject]);
	lastpos = afterpos + 1;
}
public MsgCheatsReportsToAdmins(text[])
{
	for (new e = 0; e < MAX_PLAYERS; e++)
	{
	    if ( IsPlayerConnected(e) && PlayersData[e][Admin] >= 1 && PlayersDataOnline[e][State] == 3)
	    {
	        SendClientMessage(e, COLOR_CHEATS_REPORTES, text);
	    }
    }
	printf("%s", text);
}
//////////////////// CLEAN
public DataUserClean(playerid)
{
	if ( !PlayersDataOnline[playerid][MarcaZZ] )
	{
		new MsgAviso[MAX_TEXT_CHAT];
	    format(MsgAviso, sizeof(MsgAviso), "%s Debug Data Error - Jugador: %s[%i] - ID %i.", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, gettime());
	    MsgCheatsReportsToAdmins(MsgAviso);
	}
	else
	{
		PlayersDataOnline[playerid][MarcaZZ] = false;
	}
	// DATA USERS
    PlayersData[playerid][Zero] 		= 0;            //00
    PlayersData[playerid][Empy] 		= 0;            //01
    format(PlayersData[playerid][Password], 25, "0");   //02
    PlayersData[playerid][DeahtCount] 	= 0;
    PlayersData[playerid][KilledCount]  = 0;
    PlayersData[playerid][House] 		= -1;
    PlayersData[playerid][Jail] 		= 0;
    PlayersData[playerid][Admin]        = 0;
    PlayersData[playerid][IsPaga]		= 0;
    PlayersData[playerid][Banco] 		= 1000;
    PlayersData[playerid][Gang] 		= 0;
    PlayersData[playerid][HoursPlaying] = 0;
    PlayersData[playerid][Rango] 		= 7;
    PlayersData[playerid][Car] 			= -1;
	PlayersData[playerid][CameraLogin]	= 0;
    PlayersData[playerid][Nacer]		= false;
    PlayersData[playerid][Skin]			= 299;
	PlayersData[playerid][SpawnFac]		= 0;
    PlayersData[playerid][AccountBankingOpen] = 0;
	PlayersData[playerid][Objetos][0]	= 0;
	PlayersData[playerid][Objetos][1]	= 0;
	PlayersData[playerid][Objetos][2]	= 0;
	PlayersData[playerid][Objetos][3]	= 0;
	PlayersData[playerid][Objetos][4]	= 0;
	PlayersData[playerid][Objetos][5]	= 0;
	PlayersData[playerid][Objetos][6]	= 0;
	PlayersData[playerid][Objetos][7]	= 0;
	PlayersData[playerid][Objetos][8]	= 0;

    PlayersData[playerid][WeaponS][0] 	= 0;
    PlayersData[playerid][WeaponS][1] 	= 0;
    PlayersData[playerid][WeaponS][2]   = 24;
    PlayersData[playerid][WeaponS][3]   = 26;
    PlayersData[playerid][WeaponS][4]	= 1;
    PlayersData[playerid][WeaponS][5]	= 0;
    PlayersData[playerid][WeaponS][6]	= 34;
    PlayersData[playerid][WeaponS][7]	= 0;
    PlayersData[playerid][WeaponS][8]   = 0;
    PlayersData[playerid][WeaponS][9]  	= 0;
    PlayersData[playerid][WeaponS][10]   = 0;
    PlayersData[playerid][WeaponS][11] 	= 0;
    PlayersData[playerid][WeaponS][12] 	= 0;
    
    PlayersData[playerid][AmmoS][0] 	 = 0;
    PlayersData[playerid][AmmoS][1] 	 = 0;
    PlayersData[playerid][AmmoS][2] 	 = 200;
    PlayersData[playerid][AmmoS][3]	 	= 200;
    PlayersData[playerid][AmmoS][4]		 = 1;
    PlayersData[playerid][AmmoS][5]	 	= 0;
    PlayersData[playerid][AmmoS][6]		 = 100;
    PlayersData[playerid][AmmoS][7]		 = 0;
	PlayersData[playerid][AmmoS][8]		 = 0;
    PlayersData[playerid][AmmoS][9] 	 = 0;
    PlayersData[playerid][AmmoS][10]	 = 0;
    PlayersData[playerid][AmmoS][11]	 = 0;
    PlayersData[playerid][AmmoS][12]	 = 0;
    PlayersData[playerid][Vida] 		= 100;
    PlayersData[playerid][Chaleco] 		= 0;
    PlayersData[playerid][Spawn_X] 		= 0;
    PlayersData[playerid][Spawn_Y] 		= 0;
    PlayersData[playerid][Spawn_Z] 		= 0;
    PlayersData[playerid][Spawn_ZZ]		= 0;
    PlayersData[playerid][World]		= 0;
    PlayersData[playerid][Interior]		= 0;
    PlayersData[playerid][Dinero]		= 0;
    PlayersData[playerid][Bombas]		= 0;
    PlayersData[playerid][AccountState] = 0;
	format(PlayersData[playerid][MyIP], 16, "0");
    PlayersData[playerid][Sexo]			= 0;
	PlayersData[playerid][IsPlayerInBizz]	= false;
    PlayersData[playerid][IsPlayerInVehInt]	= false;
    PlayersData[playerid][IsPlayerInHouse]	= false;
	PlayersData[playerid][IsPlayerInGarage]	= 0;
	PlayersData[playerid][IsPlayerInBank]= false;
	PlayersData[playerid][MyStyleWalk]		= 0;
	PlayersData[playerid][IntermitentState]= false;
	PlayersData[playerid][Minas]		= 0;


    // DATA USERS ONLINE
	PlayersDataOnline[playerid][State]  			= 0;
	PlayersDataOnline[playerid][CurrentDialog]		= 999;
	PlayersDataOnline[playerid][IsAFK]    			= false;
	PlayersDataOnline[playerid][IsPagaO]			= gettime();
	PlayersDataOnline[playerid][InCarId]            = false;
	PlayersDataOnline[playerid][Spawn]  			= true;
	PlayersDataOnline[playerid][StateDeath]     	= false;
	PlayersDataOnline[playerid][CountCheat]			= 0;
	PlayersDataOnline[playerid][IsEspectando]  		= false;
	PlayersDataOnline[playerid][Espectando]			= -1;
	PlayersDataOnline[playerid][LastInterior]     	= false;
	PlayersDataOnline[playerid][VidaOn]	          	= 100.0;
	PlayersDataOnline[playerid][ChalecoOn]          = 0;
	PlayersDataOnline[playerid][StateMoneyPass]  	= true;
	PlayersDataOnline[playerid][IsNotSilenciado]    = true;
	PlayersDataOnline[playerid][AdminOn]       		= false;
	PlayersDataOnline[playerid][InVehicle]			= false;
	PlayersDataOnline[playerid][SendCommands]		= false;
	PlayersDataOnline[playerid][ChangeVC]           = false;
	PlayersDataOnline[playerid][ExitedVehicle] 		= false;
	PlayersDataOnline[playerid][InPickupTele]		= false;
	PlayersDataOnline[playerid][MyPickupX_Now] 		= 0;
	PlayersDataOnline[playerid][MyPickupY_Now] 		= 0;
	PlayersDataOnline[playerid][MyPickupZ_Now] 		= 0;
	PlayersDataOnline[playerid][InPickup] 			= -1;
	PlayersDataOnline[playerid][InPickupTele]		= false;
	PlayersDataOnline[playerid][InPickupInfo]		= false;
	PlayersDataOnline[playerid][LastDamageInt]     	= 0;
	PlayersDataOnline[playerid][LastGas]     		= 0;
	PlayersDataOnline[playerid][InviteGang] 		= 0;
	PlayersDataOnline[playerid][InvitePlayer]  		= 0;
	PlayersDataOnline[playerid][RowSkin]       		= 0;
	PlayersDataOnline[playerid][Intentar]  			= 0;
	PlayersDataOnline[playerid][StateChannelFamily] = true;
	PlayersDataOnline[playerid][MyPickupX] 			= 0;
	PlayersDataOnline[playerid][MyPickupY] 			= 0;
	PlayersDataOnline[playerid][MyPickupZ] 			= 0;
	PlayersDataOnline[playerid][MyPickupZZ]			= 0;
	PlayersDataOnline[playerid][MyPickupWorld]		= 0;
	PlayersDataOnline[playerid][MyPickupLock]	   	= true;
	PlayersDataOnline[playerid][MyPickupInterior]	= 0;
	PlayersDataOnline[playerid][SubAfterMenuRow] 	= 0;
	PlayersDataOnline[playerid][AfterMenuRow] 	 	= 0;
	PlayersDataOnline[playerid][InWalk]             = false;
	PlayersDataOnline[playerid][EspectVehOrPlayer]	= false;
	PlayersDataOnline[playerid][MyLastIdReport]		= 0;
}
//////////////////// LOAD
public DataUserLoad(playerid)
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%s%s.sgw", DIR_USERS, PlayersDataOnline[playerid][NameOnline]);

	if ( fexist(DirBD) )
	{
	    new MyData[MAX_PLAYER_DATA];
		new PosSplitLast, PosSplitAfter;
		new File:LoadUser = fopen(DirBD, io_read);

		fread(LoadUser, MyData);
		PosSplitLast 	= 0;
		PosSplitAfter 	= 0;

		// DATA USERS
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Zero], 			PosSplitLast, PosSplitAfter); // 00
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Empy], 			PosSplitLast, PosSplitAfter); // 01
	    // Name
		PosSplitAfter = strfind(MyData, "³", false, PosSplitLast);
		strmid(PlayersData[playerid][Password], MyData, PosSplitLast, PosSplitAfter, 25);  	  						  // 02
		PosSplitLast = PosSplitAfter + 1;
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][DeahtCount], 			PosSplitLast, PosSplitAfter); // 03
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][KilledCount],			PosSplitLast, PosSplitAfter); // 04
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][House], 				PosSplitLast, PosSplitAfter); // 05
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Jail], 				PosSplitLast, PosSplitAfter); // 06
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Admin], 				PosSplitLast, PosSplitAfter); // 07
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][IsPaga], 				PosSplitLast, PosSplitAfter); // 08
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Banco], 				PosSplitLast, PosSplitAfter); // 09
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Gang], 				PosSplitLast, PosSplitAfter); // 10
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][HoursPlaying], 		PosSplitLast, PosSplitAfter); // 11
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Rango], 				PosSplitLast, PosSplitAfter); // 12
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Car], 					PosSplitLast, PosSplitAfter); // 13
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][CameraLogin], 			PosSplitLast, PosSplitAfter); // 14
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Nacer], 				PosSplitLast, PosSplitAfter); // 15
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Skin], 				PosSplitLast, PosSplitAfter); // 16
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][SpawnFac], 			PosSplitLast, PosSplitAfter); // 17
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AccountBankingOpen], 	PosSplitLast, PosSplitAfter); // 18
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][0],	PosSplitLast, PosSplitAfter); 	  // 01
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][1],	PosSplitLast, PosSplitAfter); 	  // 02
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][2],	PosSplitLast, PosSplitAfter); 	  // 03
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][3],	PosSplitLast, PosSplitAfter); 	  // 04
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][4],	PosSplitLast, PosSplitAfter); 	  // 05
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][5],	PosSplitLast, PosSplitAfter); 	  // 01
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][6],	PosSplitLast, PosSplitAfter); 	  // 02
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][7],	PosSplitLast, PosSplitAfter); 	  // 03
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Objetos][8],	PosSplitLast, PosSplitAfter); 	  // 04

		fread(LoadUser, MyData);
		PosSplitLast 	= 0;
		PosSplitAfter 	= 0;
		
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][0], 		PosSplitLast, PosSplitAfter); // 00
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][1], 		PosSplitLast, PosSplitAfter); // 01
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][2], 		PosSplitLast, PosSplitAfter); // 02
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][3], 		PosSplitLast, PosSplitAfter); // 03
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][4], 		PosSplitLast, PosSplitAfter); // 04
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][5], 		PosSplitLast, PosSplitAfter); // 05
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][6], 		PosSplitLast, PosSplitAfter); // 06
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][7], 		PosSplitLast, PosSplitAfter); // 07
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][8], 		PosSplitLast, PosSplitAfter); // 08
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][9], 		PosSplitLast, PosSplitAfter); // 09
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][10],		PosSplitLast, PosSplitAfter); // 10
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][11],		PosSplitLast, PosSplitAfter); // 11
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][WeaponS][12],		PosSplitLast, PosSplitAfter); // 12
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][0], 		PosSplitLast, PosSplitAfter); // 13
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][1], 		PosSplitLast, PosSplitAfter); // 14
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][2], 		PosSplitLast, PosSplitAfter); // 15
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][3], 		PosSplitLast, PosSplitAfter); // 16
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][4], 		PosSplitLast, PosSplitAfter); // 17
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][5], 		PosSplitLast, PosSplitAfter); // 18
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][6], 		PosSplitLast, PosSplitAfter); // 19
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][7], 		PosSplitLast, PosSplitAfter); // 20
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][8], 		PosSplitLast, PosSplitAfter); // 21
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][9], 		PosSplitLast, PosSplitAfter); // 22
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][10], 		PosSplitLast, PosSplitAfter); // 23
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][11], 		PosSplitLast, PosSplitAfter); // 24
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AmmoS][12], 		PosSplitLast, PosSplitAfter); // 25
	    GetDataPlayersFloat	(playerid, MyData, PlayersData[playerid][Vida], 			PosSplitLast, PosSplitAfter); // 26
	    GetDataPlayersFloat	(playerid, MyData, PlayersData[playerid][Chaleco], 			PosSplitLast, PosSplitAfter); // 27
	    GetDataPlayersFloat	(playerid, MyData, PlayersData[playerid][Spawn_X], 			PosSplitLast, PosSplitAfter); // 04
	    GetDataPlayersFloat	(playerid, MyData, PlayersData[playerid][Spawn_Y], 			PosSplitLast, PosSplitAfter); // 05
	    GetDataPlayersFloat	(playerid, MyData, PlayersData[playerid][Spawn_Z], 			PosSplitLast, PosSplitAfter); // 06
	    GetDataPlayersFloat	(playerid, MyData, PlayersData[playerid][Spawn_ZZ], 		PosSplitLast, PosSplitAfter); // 07
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][World], 			PosSplitLast, PosSplitAfter); // 32
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Interior], 		PosSplitLast, PosSplitAfter); // 33
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][IsInJail], 		PosSplitLast, PosSplitAfter); // 33
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Dinero], 			PosSplitLast, PosSplitAfter); // 33
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Bombas], 			PosSplitLast, PosSplitAfter); // 33
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][AccountState], 	PosSplitLast, PosSplitAfter); // 03
	    // MyIP
		PosSplitAfter = strfind(MyData, "³", false, PosSplitLast);
		strmid(PlayersData[playerid][MyIP], MyData, PosSplitLast, PosSplitAfter, 16);  	  							  // 66
		PosSplitLast = PosSplitAfter + 1;
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Sexo], 			PosSplitLast, PosSplitAfter); // 41
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][IsPlayerInBizz], 	PosSplitLast, PosSplitAfter); // 75
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][IsPlayerInHouse], 	PosSplitLast, PosSplitAfter); // 61
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][IsPlayerInVehInt], PosSplitLast, PosSplitAfter); // 39
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][IsPlayerInGarage], PosSplitLast, PosSplitAfter); // 77
	    GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][IsPlayerInBank], 	PosSplitLast, PosSplitAfter); // 65
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][MyStyleWalk], 		PosSplitLast, PosSplitAfter); // 68
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][IntermitentState], PosSplitLast, PosSplitAfter); // 72
		GetDataPlayersInt	(playerid, MyData, PlayersData[playerid][Minas],			PosSplitLast, PosSplitAfter); // 72
	    return true;
	}
	else
	{
		return false;
	}
}
//////////////////// SAVE
public DataUserSave(playerid)
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%s%s.sgw", DIR_USERS, PlayersDataOnline[playerid][NameOnline]);
	
	if ( PlayersDataOnline[playerid][Spawn] )
	{
        GetSpawnInfo(playerid);
    }
    
	new MyData[MAX_PLAYER_DATA];
    format(MyData, sizeof(MyData),
    "%i³%i³%s³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³",
	PlayersData[playerid][Zero],//00
	PlayersData[playerid][Empy],//01
	PlayersData[playerid][Password],//02
    PlayersData[playerid][DeahtCount],//03
    PlayersData[playerid][KilledCount],//04
    PlayersData[playerid][House],//05
    PlayersData[playerid][Jail],//06
    PlayersData[playerid][Admin],//07
    PlayersData[playerid][IsPaga],//08
    PlayersData[playerid][Banco],//09
    PlayersData[playerid][Gang],//10
    PlayersData[playerid][HoursPlaying],//11
    PlayersData[playerid][Rango],//12
    PlayersData[playerid][Car],//13
    PlayersData[playerid][CameraLogin],//14
    PlayersData[playerid][Nacer],//15
    PlayersData[playerid][Skin],//16
    PlayersData[playerid][SpawnFac],//17
    PlayersData[playerid][AccountBankingOpen],//18
	PlayersData[playerid][Objetos][0],
	PlayersData[playerid][Objetos][1],
	PlayersData[playerid][Objetos][2],
	PlayersData[playerid][Objetos][3],
	PlayersData[playerid][Objetos][4],
	PlayersData[playerid][Objetos][5],
	PlayersData[playerid][Objetos][6],
	PlayersData[playerid][Objetos][7],
	PlayersData[playerid][Objetos][8]//27
    );
	new File:SaveUser = fopen(DirBD, io_write);
	fwrite(SaveUser, MyData);
    format(MyData, sizeof(MyData),
    "\r\n%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%f³%f³%f³%f³%f³%f³%i³%i³%i³%i³%i³%s³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³%i³",
	    PlayersData[playerid][WeaponS][0],
	    PlayersData[playerid][WeaponS][1],
	    PlayersData[playerid][WeaponS][2],
	    PlayersData[playerid][WeaponS][3],
	    PlayersData[playerid][WeaponS][4],
	    PlayersData[playerid][WeaponS][5],
	    PlayersData[playerid][WeaponS][6],
	    PlayersData[playerid][WeaponS][7],
	    PlayersData[playerid][WeaponS][8],
	    PlayersData[playerid][WeaponS][9],
	    PlayersData[playerid][WeaponS][10],
	    PlayersData[playerid][WeaponS][11],
	    PlayersData[playerid][WeaponS][12],
	    PlayersData[playerid][AmmoS][0],
	    PlayersData[playerid][AmmoS][1],
	    PlayersData[playerid][AmmoS][2],
	    PlayersData[playerid][AmmoS][3],
	    PlayersData[playerid][AmmoS][4],
	    PlayersData[playerid][AmmoS][5],
	    PlayersData[playerid][AmmoS][6],
	    PlayersData[playerid][AmmoS][7],
		PlayersData[playerid][AmmoS][8],
	    PlayersData[playerid][AmmoS][9],
	    PlayersData[playerid][AmmoS][10],
	    PlayersData[playerid][AmmoS][11],
	    PlayersData[playerid][AmmoS][12],
	    PlayersData[playerid][Vida],
	    PlayersData[playerid][Chaleco],
		PlayersData[playerid][Spawn_X],
		PlayersData[playerid][Spawn_Y],
	    PlayersData[playerid][Spawn_Z],
	    PlayersData[playerid][Spawn_ZZ],
	    PlayersData[playerid][World],
	    PlayersData[playerid][Interior],
	    PlayersData[playerid][IsInJail],
	    PlayersData[playerid][Dinero],
	    PlayersData[playerid][Bombas],
		PlayersData[playerid][AccountState],
    	PlayersData[playerid][MyIP],
    	PlayersData[playerid][Sexo],
		PlayersData[playerid][IsPlayerInBizz],
	    PlayersData[playerid][IsPlayerInVehInt],
	    PlayersData[playerid][IsPlayerInHouse],
		PlayersData[playerid][IsPlayerInGarage],
	    PlayersData[playerid][IsPlayerInBank],
		PlayersData[playerid][MyStyleWalk],
		PlayersData[playerid][IntermitentState],
		PlayersData[playerid][Minas]
		);
	fwrite(SaveUser, MyData);

	fclose(SaveUser);
}
public ShowPlayerDialogEx(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
    PlayersDataOnline[playerid][CurrentDialog] = dialogid;
	ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
}
public ShowServerStats(playerid)
{
	new ListDialog[1000];
	new TempConvert[150];

	if ( playerid != -1 )
	{
		format(TempConvert, sizeof(TempConvert),
		"{E6E6E6}01- MAX_PLAYERS {00F50A}(%i)", MAX_PLAYERS);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}02- MAX_OBJECTS {00F50A}(%i)", CountDynamicObjects());
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}06- MAX_BIZZ_TYPE {00F50A}(%i)", MAX_BIZZ_TYPE);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}09- MAX_BIZZ {00F50A}(%i)", MAX_BIZZ);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}10- MAX_HOUSE {00F50A}(%i)", MAX_HOUSE);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}14- MAX_CAR {00F50A}(%i)", MAX_CAR);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}15- MAX_CAR_DUENO {00F50A}(%i)", MAX_CAR_DUENO);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}16- MAX_CAR_GANG {00F50A}(%i)", MAX_CAR_GANG - MAX_CAR_DUENO);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}17- MAX_CAR_PUBLIC {00F50A}(%i)", MAX_CAR_PUBLIC - MAX_CAR_GANG);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}20- MAX_PICKUP {00F50A}(%i)", MAX_PICKUP);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n{E6E6E6}21- MAX_TEXT_DRAW {00F50A}(%i)", MAX_TEXT_DRAW);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		ShowPlayerDialogEx(playerid,999,DIALOG_STYLE_LIST,"{FF0000}[SGW] Estadísticas de StreetGangWars", ListDialog, "Ok", "");
	}
	else
	{
		format(TempConvert, sizeof(TempConvert),
		"01- MAX_PLAYERS\t\t\t%i", MAX_PLAYERS);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n02- MAX_OBJECTS\t\t\t%i", CountDynamicObjects());
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n06- MAX_BIZZ_TYPE\t\t%i", MAX_BIZZ_TYPE);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n09- MAX_BIZZ\t\t\t%i", MAX_BIZZ);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n10- MAX_HOUSE\t\t\t%i", MAX_HOUSE);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n14- MAX_CAR\t\t\t%i", MAX_CAR);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n15- MAX_CAR_DUENO\t\t%i", MAX_CAR_DUENO);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n16- MAX_CAR_GANG\t\t%i", MAX_CAR_GANG - MAX_CAR_DUENO);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n17- MAX_CAR_PUBLIC\t\t%i", MAX_CAR_PUBLIC - MAX_CAR_GANG);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n20- MAX_PICKUP\t\t\t%i", MAX_PICKUP);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		format(TempConvert, sizeof(TempConvert),
		"\r\n21- MAX_TEXT_DRAW\t\t%i", MAX_TEXT_DRAW);
		strcat(ListDialog, TempConvert, sizeof(ListDialog));

		printf("%s", ListDialog);
	}
}
public Acciones(playerid, type, text[])
{
	new MsgAcciones[150];
	switch (type)
	{
	    case 0: // 0 - ME - LILA
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]: * %s %s", PlayersDataOnline[playerid][NameOnline], text);
		}
	    case 1: // 1 - AME - AMARILLO
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]: %s [ID:%i]", text, playerid);
		}
	    case 2: // 2 - INTENTAR OK - VERDE
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]: * %s intentó %s, y consiguió hacerlo!", PlayersDataOnline[playerid][NameOnline], text);
		}
	    case 3: // 3 - INTENTAR FAIL - ROJO
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]: * %s intentó %s, y no consiguió hacerlo.", PlayersDataOnline[playerid][NameOnline], text);
		}
	    case 4: // 4 - GRITAR - BLANCO
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]: * %s Grita: %s!!", PlayersDataOnline[playerid][NameOnline], text);
		}
	    case 5: // 5 - SUSURRAR - BLANCO
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]: * %s Susurra: %s", PlayersDataOnline[playerid][NameOnline], text);
		}
	    case 6: // 6 - CANAL OOC - MEDIO GRIS
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]:  %s: (( %s ))", PlayersDataOnline[playerid][NameOnline], text);
		}
	    case 7: // 7 - AME FIX - AMARILLO
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]: %s [ID:%i]*", text, playerid);
		}
	    case 8: // 8 - ME FIX - LILA
	    {
			format(MsgAcciones, sizeof(MsgAcciones), "[SGW]: ** %s %s", PlayersDataOnline[playerid][NameOnline], text);
		}
	}

    new Float:PosMensajeX, Float:PosMensajeY, Float:PosMensajeZ;
    GetPlayerPos(playerid, Float:PosMensajeX, Float:PosMensajeY, Float:PosMensajeZ);
    new MyWorrld = GetPlayerVirtualWorld(playerid);
	for ( new i = 0; i < MAX_PLAYERS; i++ )
	{
		if ( IsPlayerConnected(i) && IsPlayerInRangeOfPoint(
			i,
			AccionesRadios[type],
			Float:PosMensajeX,
			Float:PosMensajeY,
			Float:PosMensajeZ) && GetPlayerVirtualWorld(i) == MyWorrld &&
			PlayersDataOnline[i][State] == 3)
		{
			SendClientMessage(i, AccionesColors[type], MsgAcciones);
		}
	}
	print(MsgAcciones);
}
public GetOriginalMinute(minute)
{
	if ( minute == 60 )
	{
	    return 0;
	}
	else if ( !minute )
	{
	    return 1;
	}
	else
	{
	    return minute;
	}
}
public GetOriginalHours(hour)
{
	if ( hour == 24 )
	{
	    return 0;
	}
	else if ( !hour )
	{
	    return 1;
	}
	else
	{
	    return hour;
	}
}
public SetPlayerOrginalTime(playerid)
{
	new HourA, MinutesA;
	gettime(HourA, MinutesA);
	SetPlayerTime(playerid, GetOriginalHours(HourA), GetOriginalMinute(MinutesA));
}
public IsVehicleMyVehicle(playerid, vehicleid)
{
	if ( PlayersData[playerid][Car] == vehicleid )
	{
		return true;
	}
	else
	{
		return false;
	}
}
public ShowLockTextDraws(vehicleid, last)
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if ( IsPlayerConnected(i) && PlayersDataOnline[i][State] == 3 && PlayersDataOnline[i][InCarId] == vehicleid)
		{
		    if ( last != -1 )
		    {
		        if ( !last )
		        {
					TextDrawHideForPlayer(i, VelocimetroFijos[7]);
				}
				else
				{
					TextDrawHideForPlayer(i, VelocimetroFijos[8]);
				}
		    }
		    if ( !DataCars[vehicleid][Lock] )
		    {
			    TextDrawShowForPlayer(i, VelocimetroFijos[7]);
		    }
		    else
		    {
			    TextDrawShowForPlayer(i, VelocimetroFijos[8]);
		    }
		    return true;
		}
	}
	return false;
}
public SaveDataVehicle(vehicleid, dir[])
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%sC%i.dat", dir, vehicleid);

    new DataVehicle[MAX_PLAYER_DATA];
    format(DataVehicle, sizeof(DataVehicle),
    "%f,%f,%f,%f,%i,%i,%i,%s,%i,%i,%i,%i,%s,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%f,%f,%f,%i,%f,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,",
		DataCars[vehicleid][PosX],
		DataCars[vehicleid][PosY],
		DataCars[vehicleid][PosZ],
		DataCars[vehicleid][PosZZ],
		DataCars[vehicleid][Modelo],
		DataCars[vehicleid][Color1],
		DataCars[vehicleid][Color2],
		DataCars[vehicleid][Dueno],
		DataCars[vehicleid][Lock],
		DataCars[vehicleid][Time],
		DataCars[vehicleid][Matricula],
		DataCars[vehicleid][LockPolice],
		DataCars[vehicleid][ReasonLock],
		coches_Todos_Maleteros[vehicleid][0][0],
		coches_Todos_Maleteros[vehicleid][0][1],
		coches_Todos_Maleteros[vehicleid][1][0],
		coches_Todos_Maleteros[vehicleid][1][1],
		coches_Todos_Maleteros[vehicleid][2][0],
		coches_Todos_Maleteros[vehicleid][2][1],
		coches_Todos_Maleteros[vehicleid][3][0],
		coches_Todos_Maleteros[vehicleid][3][1],
		coches_Todos_Maleteros[vehicleid][4][0],
		coches_Todos_Maleteros[vehicleid][4][1],
		coches_Todos_Maleteros[vehicleid][5][0],
		coches_Todos_Maleteros[vehicleid][5][1],
		coches_Todos_Maleteros[vehicleid][6][0],
		coches_Todos_Maleteros[vehicleid][6][1],
		coches_Todos_Maleteros[vehicleid][7][0],
		coches_Todos_Maleteros[vehicleid][8][0],
		coches_Todos_Maleteros[vehicleid][9][0],
		coches_Todos_Maleteros[vehicleid][10][0],
		coches_Todos_Maleteros[vehicleid][11][0],
		DataCars[vehicleid][MaleteroState],
		DataCars[vehicleid][Gas],
		DataCars[vehicleid][LastX],
		DataCars[vehicleid][LastY],
		DataCars[vehicleid][LastZ],
		DataCars[vehicleid][LastZZ],
		DataCars[vehicleid][IsLastSpawn],
		DataCars[vehicleid][LastDamage],
		DataCars[vehicleid][PanelS],
		DataCars[vehicleid][DoorS],
		DataCars[vehicleid][LightS],
		DataCars[vehicleid][TiresS],
		DataCars[vehicleid][SlotsTunning][0],
		DataCars[vehicleid][SlotsTunning][1],
		DataCars[vehicleid][SlotsTunning][2],
		DataCars[vehicleid][SlotsTunning][3],
		DataCars[vehicleid][SlotsTunning][4],
		DataCars[vehicleid][SlotsTunning][5],
		DataCars[vehicleid][SlotsTunning][6],
		DataCars[vehicleid][SlotsTunning][7],
		DataCars[vehicleid][SlotsTunning][8],
		DataCars[vehicleid][SlotsTunning][9],
		DataCars[vehicleid][SlotsTunning][10],
		DataCars[vehicleid][SlotsTunning][11],
		DataCars[vehicleid][SlotsTunning][12],
		DataCars[vehicleid][SlotsTunning][13],
		DataCars[vehicleid][Vinillo],
		DataCars[vehicleid][Interior],
		DataCars[vehicleid][InteriorLast],
		DataCars[vehicleid][World],
		DataCars[vehicleid][WorldLast]
    );
	new File:SaveVehicle = fopen(DirBD, io_write);
	fwrite(SaveVehicle, DataVehicle);
    format(DataVehicle, sizeof(DataVehicle),
    "\r\n%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,",
		DataCars[vehicleid][StationID],
		DataCars[vehicleid][VolumenVehicle],
		DataCars[vehicleid][EcualizadorVehicle][0],
		DataCars[vehicleid][EcualizadorVehicle][1],
		DataCars[vehicleid][EcualizadorVehicle][2],
		DataCars[vehicleid][EcualizadorVehicle][3],
		DataCars[vehicleid][EcualizadorVehicle][4],
		DataCars[vehicleid][EcualizadorVehicle][5],
		DataCars[vehicleid][EcualizadorVehicle][6],
		DataCars[vehicleid][EcualizadorVehicle][7],
		DataCars[vehicleid][EcualizadorVehicle][8],
		DataCars[vehicleid][GuanteraLock],
		DataCars[vehicleid][GuanteraObjects][0],
		DataCars[vehicleid][GuanteraObjects][1],
		DataCars[vehicleid][GuanteraObjects][2],
		DataCars[vehicleid][GuanteraObjects][3],
		DataCars[vehicleid][GuanteraObjects][4],
		DataCars[vehicleid][GuanteraObjects][5],
		DataCars[vehicleid][GuanteraObjects][6],
		DataCars[vehicleid][GuanteraObjects][7]
    );
	fwrite(SaveVehicle, DataVehicle);
	fclose(SaveVehicle);
}
public RemoveDuenoOfVehicle(vehicleid, option)
{
	new playerid = 499;
	format(PlayersDataOnline[playerid][NameOnline], MAX_PLAYER_NAME, "%s", DataCars[vehicleid][Dueno]);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if ( IsPlayerConnected(i) && PlayersDataOnline[i][State] == 3 && IsVehicleMyVehicle(i, vehicleid) )
		{
			playerid = i;
			break;
		}
	}
	if ( playerid == 499 )
	{
		PlayersDataOnline[playerid][Spawn] = false;
		DataUserLoad(playerid);
	}
	new lastLock = DataCars[vehicleid][Lock];
	DataCars[vehicleid][Lock] = false;
	if ( lastLock )
	{
		ShowLockTextDraws(vehicleid, lastLock);
	}
	format(DataCars[vehicleid][Dueno], MAX_PLAYER_NAME, "0");
	PlayersData[playerid][Car] = -1;
	DataUserSave(playerid);
	SaveDataVehicle(vehicleid, DIR_VEHICLES);
	printf("Vehículo con ID[%i] vencido. Opción: %i", vehicleid, option);
	return playerid;
}
public VerificarCochesVencidos()
{
	for (new i = 1; i <= MAX_CAR_DUENO; i++ )
	{
		if ( strlen(DataCars[i][Dueno]) != 1 )
		{
		    if ( DataCars[i][Time] <= 1 )
		    {
				RemoveDuenoOfVehicle(i, 3);
			}
			else
			{
				DataCars[i][Time]--;
			}
		}
	}
}
public MostrarHora(Accion ,playerid)
{
	new Hora, Minutos, Segundos;
	new Ano, Mes, Dia;
	new FechaHoraFormateada[90];

	gettime( Hora, Minutos, Segundos );
	getdate(Ano, Mes, Dia);
	Mes--;

	if ( Accion == 0 )
	{
	    if ( PlayersData[playerid][Jail] == 0 )
	    {
			format(FechaHoraFormateada, sizeof(FechaHoraFormateada), "~W~%i ~B~%s ~W~%i ~N~Son las %i~R~:~W~%i~R~:~W~%i", Dia, Meses[Mes], Ano, Hora, Minutos, Segundos);
		}
		else
		{
			format(FechaHoraFormateada, sizeof(FechaHoraFormateada), "~W~%i ~B~%s ~W~%i ~N~Son las %i~R~:~W~%i~R~:~W~%i~N~~R~Jail: ~W~%i sec", Dia, Meses[Mes], Ano, Hora, Minutos, Segundos, PlayersData[playerid][Jail] - gettime());
		}
		GameTextForPlayer(playerid, FechaHoraFormateada, 5000, 1 );
	}
	else if ( Accion == 1 )
	{
		format(FechaHoraFormateada, sizeof(FechaHoraFormateada), "~W~%i ~B~%s ~W~%i ~N~Son las %i~R~:~W~%i~R~:~W~%i", Dia, Meses[Mes], Ano, Hora, Minutos, Segundos);
		//new MensajeBanco[3][70];
		//new Intereses;
		new TimeNow = gettime();
		new Float:Xpaga, Float:Ypaga, Float:Zpaga;
	    for (new i = 0; i < MAX_PLAYERS; i++)
	    {
			if ( IsPlayerConnected(i) && PlayersDataOnline[i][State] == 3 && ((TimeNow - PlayersDataOnline[i][IsPagaO]) + PlayersData[i][IsPaga]) > 1200)
			{
			    //Intereses = PlayersData[i][Banco] / 2000;

		   		/*PlayersData[i][Banco] = PlayersData[i][Banco] + GangData[PlayersData[i][Gang]][Paga][PlayersData[i][Rango]] + Intereses;

   				format(MensajeBanco[0], 70, "Nuevo Balance: $%i Paga: $%i", PlayersData[i][Banco], GangData[PlayersData[i][Gang]][Paga][PlayersData[i][Rango]]);
		   		format(MensajeBanco[1], 70, "Intereses: $%i", Intereses);
		   		format(MensajeBanco[2], 70, "Antiguo Balance: $%i", PlayersData[i][Banco] - GangData[PlayersData[i][Gang]][Paga][PlayersData[i][Rango]] - Intereses);

				GameTextForPlayer(i, FechaHoraFormateada, 5000, 1 );

    			SendInfoMessage(i, 1, " ", "|___________________  Banco ___________________|");
    			SendInfoMessage(i, 1, MensajeBanco[0], "Banco: ");
    			SendInfoMessage(i, 1, MensajeBanco[1], "Banco: ");
    			SendInfoMessage(i, 1, MensajeBanco[2], "Banco: ");
    			SendInfoMessage(i, 1, " ", "|_____________________ Fin ____________________|");*/
    			
				PlayersData[i][HoursPlaying]++;
				PlayersData[i][IsPaga] = 0;
				PlayersDataOnline[i][IsPagaO]			= TimeNow;
				GameTextForPlayer(i, FechaHoraFormateada, 6000, 1 );
				GetPlayerPos(i, Xpaga, Ypaga, Zpaga);
//			    PlayerPlaySound(i, 1133, Xpaga, Ypaga, Zpaga);
			    SetPlayerOrginalTime(i);
			}
		}
		VerificarCochesVencidos();
	}
	return 1;
}
public SetTimerGlobal()
{
	// Hora Global
	new HoraGLOBAL, MinutosGLOBAL, SegundosGLOBAL;
	gettime(HoraGLOBAL, MinutosGLOBAL, SegundosGLOBAL);

	if ( HoraGLOBAL == 0 )
	{
		HoraGLOBAL = 23;
	}
	else
	{
	    HoraGLOBAL--;		      /*- Restamos 1, porque la hora de GETTIME la da en formato 24 horas, pero en
			                        -  SetWordTime es de rango 0 - 23.  */
	}

	SetWorldTime(HoraGLOBAL);	 // Establecemos la hora global

	new NuevaHora = ( (60 - ((MinutosGLOBAL) + 1)) * 60000 ) + ( (60 - (SegundosGLOBAL + 1) ) * 1000);
	SetTimer("SetTimerGlobal", NuevaHora, false); // Echamos andar el timer
	printf("Nueva Hora: %i Minutos: %i Milisegundos: %i", HoraGLOBAL, (NuevaHora / 1000) / 60,NuevaHora );
	MostrarHora(1, 0);
	return 1;
}
public KickEx(playerid, option)
{
	printf("Playerid [%i] kiked OPTION: %i", playerid, option);
	Kick(playerid);
}
public CheckPlayersAFK()
{
	new Float:PosAFK[4];
	for ( new i = 0; i < MAX_PLAYERS; i++ )
	{
		if ( IsPlayerConnected(i) && PlayersDataOnline[i][State] == 3)
		{
		    GetPlayerPos(i, PosAFK[0], PosAFK[1], PosAFK[2]);
			GetPlayerFacingAngle(i, PosAFK[3]);
	        //new Text3D:label = Create3DTextLabel("AFK, No gastes balas!", 0x008080FF, 30.0, 40.0, 50.0, 40.0, 0);
		    if ( PlayersDataOnline[i][IsAFK] && PlayersDataOnline[i][CoordenadasAFK][0] == PosAFK[0] && PlayersDataOnline[i][CoordenadasAFK][1] == PosAFK[1] && PlayersDataOnline[i][CoordenadasAFK][2] == PosAFK[2] && PlayersDataOnline[i][CoordenadasAFK][3] == PosAFK[3] )
		    {
			    //Attach3DTextLabelToPlayer(label, i, 0.0, 0.0, 0.7);
			}
			else
			{
			    GetPlayerPos(i, PlayersDataOnline[i][CoordenadasAFK][0], PlayersDataOnline[i][CoordenadasAFK][1], PlayersDataOnline[i][CoordenadasAFK][2]);
			    GetPlayerFacingAngle(i, PlayersDataOnline[i][CoordenadasAFK][3]);
			    PlayersDataOnline[i][IsAFK] = true;
			    //Delete3DTextLabelEx(i,label);
			}
		}
	}
	SetTimer("CheckPlayersAFK", 200, false);
}
public LoadLastOptionsServer()
{
	// DDoS Protection.
	SetTimer("CheckVehicleGas", TIME_CHECK_GAS_VEHICLES, false);
	SetTimer("CheckHoraNew", TIME_CHECK_NEW_HORA, false);

	for ( new i = 0; i < MAX_OBJECT_MAPPING_COUNT;i++)
	{
		ObjectMapping[i][Objectid] = -1;
		ObjectMapping[i][TextTagS] = -1;
	}
	// TextDraw Garages
	GarageTextDraw = TextDrawCreateEx(200.0, 380.0, "~B~Lugar: ~W~Garage");
	TextDrawUseBox(GarageTextDraw, 1);
	TextDrawBackgroundColor(GarageTextDraw ,0x000000FF);
	TextDrawBoxColor(GarageTextDraw, 0x00000066);
	TextDrawTextSize(GarageTextDraw, 350.0, 380.0);
	TextDrawSetShadow(GarageTextDraw, 1);
	TextDrawLetterSize(GarageTextDraw, 0.5 , 1.2);
	
	format(DataCars[0][MatriculaString], 32, "Ninguno");

	// TIMER GLOBAL
	SetTimerGlobal();
	CheckPlayersAFK();
	RespawnAutomatico();
}
public ShowPlayerLogin(playerid, option)
{
	new MsgWelcome[50];
	format(MsgWelcome, sizeof(MsgWelcome), "{FF0000}[SGW] Loguee %s!", PlayersDataOnline[playerid][NameOnline]);

    if ( option )
    {
		ShowPlayerDialogEx(playerid, 1, DIALOG_STYLE_PASSWORD, MsgWelcome, "{F0F0F0}Escriba su contraseña y pulse en {F1FF00}\"Ingresar\"", "Ingresar", "Cancelar");
   	}
   	else
   	{
        ShowPlayerDialogEx(playerid, 1, DIALOG_STYLE_PASSWORD, MsgWelcome, "{F0F0F0}Intente nuevamente ingresar su contraseña y pulse en {F1FF00}\"Ingresar\"", "Ingresar", "Cancelar");
	}
}
public ShowPlayerRegister(playerid, option)
{
	new MsgWelcome[50];
    format(MsgWelcome, sizeof(MsgWelcome), "{FF0000}[SGW] Regístrese %s!", PlayersDataOnline[playerid][NameOnline]);

    if ( option )
    {
    	ShowPlayerDialogEx(playerid, 2, DIALOG_STYLE_PASSWORD, MsgWelcome, "{F0F0F0}Ingresar una contraseña para regístrarse!", "Registrar", "Cancelar");
   	}
   	else
   	{
		ShowPlayerDialogEx(playerid, 2, DIALOG_STYLE_PASSWORD, MsgWelcome, "{F0F0F0}Escribe una contraseña mayor de 4 caracteres y menor de 25!", "{F1FF00}Registrar", "Cancelar");
	}
}
public SetCameraLogin(playerid, nextcamera, avanze)
{
	if ( avanze )
	{
		nextcamera++;
	}
	else
	{
	    nextcamera--;
	}

	if ( nextcamera > MAX_CAMERAS_LOGIN )
	{
	    nextcamera = 0;
	}
	else if ( nextcamera < 0 )
	{
	    nextcamera = MAX_CAMERAS_LOGIN;
	}
	PlayersData[playerid][CameraLogin] = nextcamera;

	SetPlayerPos(playerid, CamerasLogin[nextcamera][PlayerPosLogin][0], CamerasLogin[nextcamera][PlayerPosLogin][1], CamerasLogin[nextcamera][PlayerPosLogin][2]);
	SetPlayerCameraPos(playerid, 	CamerasLogin[nextcamera][CamerasPosLogin][0], CamerasLogin[nextcamera][CamerasPosLogin][1], CamerasLogin[nextcamera][CamerasPosLogin][2]);
	SetPlayerCameraLookAt(playerid, CamerasLogin[nextcamera][CamerasLookLogin][0], CamerasLogin[nextcamera][CamerasLookLogin][1], CamerasLogin[nextcamera][CamerasLookLogin][2]);
}
public UpdateSpawnPlayer(playerid)
{
	if ( PlayersData[playerid][Nacer] == 1 && PlayersData[playerid][House] != -1)
	{
	    new HouseId;
	    if ( PlayersData[playerid][Nacer] == 1 )
	    {
			    HouseId = PlayersData[playerid][House];
		}
		SetSpawnInfo(playerid, -1, PlayersData[playerid][Skin],	HouseData[HouseId][PosX], HouseData[HouseId][PosY], HouseData[HouseId][PosZ], HouseData[HouseId][PosZZ], 0, 0, 0, 0, 0, 0);
	}
    if (PlayersData[playerid][Gang] == YAKUZA ||
		PlayersData[playerid][Gang] == RUSOS ||
		PlayersData[playerid][Gang] == ITALIANOS ||
		PlayersData[playerid][Gang] == TRIADA)
    {
		SetSpawnInfo(playerid, -1, PlayersData[playerid][Skin],	GangData[PlayersData[playerid][Gang]][Spawn_X][PlayersData[playerid][SpawnFac]], GangData[PlayersData[playerid][Gang]][Spawn_Y][PlayersData[playerid][SpawnFac]], GangData[PlayersData[playerid][Gang]][Spawn_Z][PlayersData[playerid][SpawnFac]], GangData[PlayersData[playerid][Gang]][Spawn_ZZ][PlayersData[playerid][SpawnFac]], 0, 0, 0, 0, 0, 0);
	}
	else
	{
		new Aleatorio = random(sizeof(SpawnAleatorio));
		SetSpawnInfo(playerid, -1, PlayersData[playerid][Skin],	SpawnAleatorio[Aleatorio][0], SpawnAleatorio[Aleatorio][1], SpawnAleatorio[Aleatorio][2], SpawnAleatorio[Aleatorio][3], 0, 0, 0, 0, 0, 0);
	}
}
public SaveIpUser(playerid, option)
{
	new DirBD[50], FormatConnections[80], IpGet[20], DateGet[3], TimeGet[3];
	GetPlayerIp(playerid, IpGet, sizeof(IpGet));
	format(DirBD, sizeof(DirBD), "%s%s.sgw", DIR_CONNECTIONS, IpGet);
	getdate(DateGet[0], DateGet[1], DateGet[2]);
	gettime(TimeGet[0], TimeGet[1], TimeGet[2]);
	if ( option )
	{
		format(FormatConnections, sizeof(FormatConnections), "%s [%i/%i/%i %i:%i:%i] Conectó\r\n", PlayersDataOnline[playerid][NameOnline], IpGet, DateGet[1], DateGet[2], DateGet[0], TimeGet[0], TimeGet[1], TimeGet[2]);
	}
	else
	{
		format(FormatConnections, sizeof(FormatConnections), "%s [%i/%i/%i %i:%i:%i] Desconectó\r\n", PlayersDataOnline[playerid][NameOnline], IpGet, DateGet[1], DateGet[2], DateGet[0], TimeGet[0], TimeGet[1], TimeGet[2]);
	}

	new File:SaveConnections = fopen(DirBD, io_append);
	fwrite(SaveConnections, FormatConnections);
	fclose(SaveConnections);
}/*
public SaveAccountBanking(playerid)
{
	new AccountBankData[700];
	new TempSave[60];

	format(TempSave, sizeof(TempSave), "%s³%i³%i³%i³",
	PlayersDataOnline[playerid][NameOnline],
	Banking[playerid][Balance],
	Banking[playerid][LockIn],
	Banking[playerid][LockOut]);

	strcat(AccountBankData, TempSave, sizeof(AccountBankData));

	new File:SaveAccountBankF;
	new TempDir[50];
	format(TempDir, sizeof(TempDir), "%s%i.sgw", DIR_ACCOUNT_BANK, PlayersData[playerid][AccountBankingOpen]);

    SaveAccountBankF = fopen(TempDir, io_write);
	fwrite(SaveAccountBankF, AccountBankData);
	fclose(SaveAccountBankF);
}*/
public SaveDatosPlayerDisconnect(playerid)
{
	if ( IsPlayerConnected(playerid) )
	{
	    SaveIpUser(playerid, false);
	    if ( PlayersDataOnline[playerid][State] == 3 )
	    {
		    new MyTime = gettime();
			if ( PlayersData[playerid][Jail] != 0 )
			{
				PlayersData[playerid][Jail] = PlayersData[playerid][Jail] - MyTime;
			}
			PlayersData[playerid][IsPaga] = (MyTime - PlayersDataOnline[playerid][IsPagaO]) + PlayersData[playerid][IsPaga];
			if ( PlayersData[playerid][IsPaga] < 0 )
			{
				PlayersData[playerid][IsPaga] = 0;
			}
			DataUserSave(playerid);
//			SaveAccountBanking(playerid);
			ResetPlayerWeapons(playerid);
			printf("%s[%i] se desconectó.", PlayersDataOnline[playerid][NameOnline], playerid);
			PlayersDataOnline[playerid][MarcaZZ] = true;
		}
		else
		{
			PlayersDataOnline[playerid][MarcaZZ] = true;
			KillTimer(PlayersDataOnline[playerid][TimerLoginId]);
		}
	}
	else
	{
	    printf("Error! Jugador no conectado! %s[%i]", PlayersDataOnline[playerid][NameOnline], playerid);
	}
}
public SpawnPlayerEx(playerid)
{
    SpawnPlayer(playerid);
}
public SaveHouse(houseid, bool:update)
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%sH%i.sgw", DIR_HOUSES, houseid);

    new HouseDataALL[MAX_HOUSE_DATA];
 	format(HouseDataALL, MAX_HOUSE_DATA, "%i,%s,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%f,%i,%i,%f,%f,%f,%f,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%i,%i,%i,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%i,%i,%i,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%i,%i,%i,",
	HouseData[houseid][Empy_Bug],
	HouseData[houseid][Dueno],
	HouseData[houseid][ArmarioWeapon][0],
	HouseData[houseid][ArmarioWeapon][1],
	HouseData[houseid][ArmarioWeapon][2],
	HouseData[houseid][ArmarioWeapon][3],
	HouseData[houseid][ArmarioWeapon][4],
	HouseData[houseid][ArmarioWeapon][5],
	HouseData[houseid][ArmarioWeapon][6],
	HouseData[houseid][ArmarioAmmo][0],
	HouseData[houseid][ArmarioAmmo][1],
	HouseData[houseid][ArmarioAmmo][2],
	HouseData[houseid][ArmarioAmmo][3],
	HouseData[houseid][ArmarioAmmo][4],
	HouseData[houseid][ArmarioAmmo][5],
	HouseData[houseid][ArmarioAmmo][6],
	HouseData[houseid][Chaleco],
	HouseData[houseid][Drogas],
	HouseData[houseid][Ganzuas],
	HouseData[houseid][PosX],
	HouseData[houseid][PosY],
	HouseData[houseid][PosZ],
	HouseData[houseid][PosZZ],
	HouseData[houseid][Interior],
	HouseData[houseid][TypeHouseId],
	HouseData[houseid][PriceRent],
	HouseData[houseid][Level],
	HouseData[houseid][Lock],
	HouseData[houseid][Price],
	HouseData[houseid][Bombas],
	HouseData[houseid][Deposito],
	HouseData[houseid][Materiales],
	HouseData[houseid][ArmarioLock],
	Garages[houseid][0][Xg],
	Garages[houseid][0][Yg],
	Garages[houseid][0][Zg],
	Garages[houseid][0][ZZg],
	Garages[houseid][0][XgIn],
	Garages[houseid][0][YgIn],
	Garages[houseid][0][ZgIn],
	Garages[houseid][0][ZZgIn],
	Garages[houseid][0][XgOut],
	Garages[houseid][0][YgOut],
	Garages[houseid][0][ZgOut],
	Garages[houseid][0][ZZgOut],
	Garages[houseid][0][LockIn],
	Garages[houseid][0][LockOut],
	Garages[houseid][0][TypeGarageE],
	Garages[houseid][1][Xg],
	Garages[houseid][1][Yg],
	Garages[houseid][1][Zg],
	Garages[houseid][1][ZZg],
	Garages[houseid][1][XgIn],
	Garages[houseid][1][YgIn],
	Garages[houseid][1][ZgIn],
	Garages[houseid][1][ZZgIn],
	Garages[houseid][1][XgOut],
	Garages[houseid][1][YgOut],
	Garages[houseid][1][ZgOut],
	Garages[houseid][1][ZZgOut],
	Garages[houseid][1][LockIn],
	Garages[houseid][1][LockOut],
	Garages[houseid][1][TypeGarageE],
	Garages[houseid][2][Xg],
	Garages[houseid][2][Yg],
	Garages[houseid][2][Zg],
	Garages[houseid][2][ZZg],
	Garages[houseid][2][XgIn],
	Garages[houseid][2][YgIn],
	Garages[houseid][2][ZgIn],
	Garages[houseid][2][ZZgIn],
	Garages[houseid][2][XgOut],
	Garages[houseid][2][YgOut],
	Garages[houseid][2][ZgOut],
	Garages[houseid][2][ZZgOut],
	Garages[houseid][2][LockIn],
	Garages[houseid][2][LockOut],
	Garages[houseid][2][TypeGarageE]
	);

	new File:SaveHouseF = fopen(DirBD, io_write);
	fwrite(SaveHouseF, HouseDataALL);

	format(HouseDataALL, MAX_HOUSE_DATA, "\r\n%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%i,%i,%i,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%i,%i,%i,%i,%i,%i,%i,%i,%s,%s,%s,%s,%s,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,%i,",
	Garages[houseid][3][Xg],
	Garages[houseid][3][Yg],
	Garages[houseid][3][Zg],
	Garages[houseid][3][ZZg],
	Garages[houseid][3][XgIn],
	Garages[houseid][3][YgIn],
	Garages[houseid][3][ZgIn],
	Garages[houseid][3][ZZgIn],
	Garages[houseid][3][XgOut],
	Garages[houseid][3][YgOut],
	Garages[houseid][3][ZgOut],
	Garages[houseid][3][ZZgOut],
	Garages[houseid][3][LockIn],
	Garages[houseid][3][LockOut],
	Garages[houseid][3][TypeGarageE],
	Garages[houseid][4][Xg],
	Garages[houseid][4][Yg],
	Garages[houseid][4][Zg],
	Garages[houseid][4][ZZg],
	Garages[houseid][4][XgIn],
	Garages[houseid][4][YgIn],
	Garages[houseid][4][ZgIn],
	Garages[houseid][4][ZZgIn],
	Garages[houseid][4][XgOut],
	Garages[houseid][4][YgOut],
	Garages[houseid][4][ZgOut],
	Garages[houseid][4][ZZgOut],
	Garages[houseid][4][LockIn],
	Garages[houseid][4][LockOut],
	Garages[houseid][4][TypeGarageE],
	Garages[houseid][0][WorldG],
	Garages[houseid][1][WorldG],
	Garages[houseid][2][WorldG],
	Garages[houseid][3][WorldG],
	Garages[houseid][4][WorldG],
	HouseFriends[houseid][0][Name],
	HouseFriends[houseid][1][Name],
	HouseFriends[houseid][2][Name],
	HouseFriends[houseid][3][Name],
	HouseFriends[houseid][4][Name],
	Refrigerador[houseid][Articulo][0],
	Refrigerador[houseid][Articulo][1],
	Refrigerador[houseid][Articulo][2],
	Refrigerador[houseid][Articulo][3],
	Refrigerador[houseid][Articulo][4],
	Refrigerador[houseid][Articulo][5],
	Refrigerador[houseid][Articulo][6],
	Refrigerador[houseid][Articulo][7],
	Refrigerador[houseid][Articulo][8],
	Refrigerador[houseid][Articulo][9],
	Refrigerador[houseid][Cantidad][0],
	Refrigerador[houseid][Cantidad][1],
	Refrigerador[houseid][Cantidad][2],
	Refrigerador[houseid][Cantidad][3],
	Refrigerador[houseid][Cantidad][4],
	Refrigerador[houseid][Cantidad][5],
	Refrigerador[houseid][Cantidad][6],
	Refrigerador[houseid][Cantidad][7],
	Refrigerador[houseid][Cantidad][8],
	Refrigerador[houseid][Cantidad][9],
	HouseData[houseid][RefrigeradorLock],
	HouseData[houseid][StationID],
	HouseData[houseid][VolumenHouse],
	HouseData[houseid][EcualizadorHouse][0],
	HouseData[houseid][EcualizadorHouse][1],
	HouseData[houseid][EcualizadorHouse][2],
	HouseData[houseid][EcualizadorHouse][3],
	HouseData[houseid][EcualizadorHouse][4],
	HouseData[houseid][EcualizadorHouse][5],
	HouseData[houseid][EcualizadorHouse][6],
	HouseData[houseid][EcualizadorHouse][7],
	HouseData[houseid][EcualizadorHouse][8],
	HouseData[houseid][GavetaLock],
	HouseData[houseid][GavetaObjects][0],
	HouseData[houseid][GavetaObjects][1],
	HouseData[houseid][GavetaObjects][2],
	HouseData[houseid][GavetaObjects][3],
	HouseData[houseid][GavetaObjects][4]
	);

	fwrite(SaveHouseF, HouseDataALL);

	format(HouseDataALL, MAX_HOUSE_DATA, "\r\n%i,%i,%i,",
	HouseData[houseid][GavetaObjects][5],
	HouseData[houseid][GavetaObjects][6],
	HouseData[houseid][GavetaObjects][7]
	);

	fwrite(SaveHouseF, HouseDataALL);
	fclose(SaveHouseF);

	if ( update )
	{
		ActTextDrawHouse(houseid);
	}
}
public SaveGasolineras()
{
	new DirBD[50];
	format(DirBD, sizeof(DirBD), "%sGasolineras.sgw", DIR_MISC);

	new GasData[MAX_PLAYER_DATA];
	new TempConvert[MAX_PLAYER_DATA];
	for (new i = 0; i <= MAX_GASOLINERAS; i++)
	{
	    format(TempConvert, sizeof(TempConvert), "%i,", Gasolineras[i][Fuel]);
        strcat(GasData, TempConvert, sizeof(GasData));
	}

	new File:SaveGas = fopen(DirBD, io_write);
	fwrite(SaveGas, GasData);
	fclose(SaveGas);
}
public SaveBombas()
{
	new TempDirBombas[25];
    new BombasDataALL[MAX_PLAYER_DATA];
	for (new i = 0; i < MAX_BOMBAS_COUNT; i++ )
	{
	    format(TempDirBombas, sizeof(TempDirBombas), "%s%i.sgw", DIR_BOMBAS, i);

	 	format(BombasDataALL, MAX_PLAYER_DATA, "%i|%i|%f|%f|%f|%i|",
	 	BombasO[i][TypeBomba],
		BombasO[i][ObjectID],
		BombasO[i][PosX],
		BombasO[i][PosY],
		BombasO[i][PosZ],
		BombasO[i][ObjectIDO]);

		new File:LoadBombasF = fopen(TempDirBombas, io_write);
		fwrite(LoadBombasF, BombasDataALL);
		fclose(LoadBombasF);
	}
}
public IsValidName(name[])
{
	// Nombres no permitidos por windows, para archivos.
//CON, PRN, AUX, NUL, COM0, COM1, COM2, COM3, COM4, COM5, COM6, COM7, COM8, COM9,
// LPT0, LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, and LPT9

	if ( strcmp(name, "CON", true, 3) == 0
	||  strcmp(name, "PRN", true, 3) == 0
	||  strcmp(name, "AUX", true, 3) == 0
	||  strcmp(name, "NUL", true, 3) == 0
	||  strcmp(name, "COM0", true, 4) == 0
	||  strcmp(name, "COM1", true, 4) == 0
	||  strcmp(name, "COM2", true, 4) == 0
	||  strcmp(name, "COM3", true, 4) == 0
	||  strcmp(name, "COM4", true, 4) == 0
	||  strcmp(name, "COM5", true, 4) == 0
	||  strcmp(name, "COM6", true, 4) == 0
	||  strcmp(name, "COM7", true, 4) == 0
	||  strcmp(name, "COM8", true, 4) == 0
	||  strcmp(name, "COM9", true, 4) == 0
	||  strcmp(name, "LPT0", true, 4) == 0
	||  strcmp(name, "LPT1", true, 4) == 0
	||  strcmp(name, "LPT2", true, 4) == 0
	||  strcmp(name, "LPT3", true, 4) == 0
	||  strcmp(name, "LPT4", true, 4) == 0
	||  strcmp(name, "LPT5", true, 4) == 0
	||  strcmp(name, "LPT6", true, 4) == 0
	||  strcmp(name, "LPT7", true, 4) == 0
	||  strcmp(name, "LPT8", true, 4) == 0
	||  strcmp(name, "LPT9", true, 4) == 0 )
	{
		return false;
	}
	else
	{
		return true;
	}
}
public RemoveRayaName(playerid)
{
	new h = strlen(PlayersDataOnline[playerid][NameOnline]);
    for( new i = 0; i < h; i++)
    {
        if ( PlayersDataOnline[playerid][NameOnline][i] == '_')
        {
			format(PlayersDataOnline[playerid][NameOnline], MAX_PLAYER_NAME, "%s", PlayersDataOnline[playerid][NameOnline]);
			PlayersDataOnline[playerid][NameOnline][i] = ' ';
			return true;
		}
	}
	format(PlayersDataOnline[playerid][NameOnline], MAX_PLAYER_NAME, "%s", PlayersDataOnline[playerid][NameOnline]);
	return false;
}
public IsValidWeapon(playerid, weaponid)
{
	if ( weaponid >= 0 &&
	 	 weaponid <= 46 &&
	 	 weaponid != 19 &&
	 	 weaponid != 20 &&
	 	 weaponid != 21 )
	{
	    return true;
    }
    else
    {
		new MsgAvisoBug[MAX_TEXT_CHAT];
	    format(MsgAvisoBug, sizeof(MsgAvisoBug), "%s Bug´s Owned - El jugador %s[%i] se le bugueo un arma ID: %i.", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, weaponid);
		MsgCheatsReportsToAdmins(MsgAvisoBug);
        return false;
	}
}
public SetPlayerVirtualWorldEx(playerid, wolrdid)
{
	SetPlayerVirtualWorld(playerid, wolrdid);
}
public SetPlayerInteriorEx(playerid, newinterior)
{
	if (newinterior >= 0 && newinterior < MAX_INTERIORS)
	{
     	PlayersDataOnline[playerid][LastInterior] = newinterior;
    	SetPlayerInterior(playerid, newinterior);
   	}
   	else
   	{
	   	KickEx(playerid, 10);
   	}
}
public RemoveSpectatePlayer(playerid)
{
	if ( PlayersDataOnline[playerid][Espectando] != -1 )
	{
        PlayersDataOnline[playerid][Spawn]      = true;
		PlayersDataOnline[playerid][StateDeath] = true;
    	TogglePlayerSpectating(playerid, 0);
    	SetSpawnInfoEx(playerid);
    	CheckSpectToPlayer(PlayersDataOnline[playerid][Espectando]);
	    PlayersDataOnline[playerid][Espectando] = -1;
	    return true;
	}
	else
	{
	    return false;
	}
}
public SetSpawnInfoEx(playerid)
{
	if ( CheckArmaCheat(playerid) )
	{
		PlayersDataOnline[playerid][StateWeaponPass] 	= gettime() + 5;
	}
	PlayersDataOnline[playerid][ChalecoOn] = PlayersData[playerid][Chaleco];
	PlayersDataOnline[playerid][VidaOn] = PlayersData[playerid][Vida];
 	SetPlayerPos(playerid, PlayersData[playerid][Spawn_X], PlayersData[playerid][Spawn_Y], PlayersData[playerid][Spawn_Z]);
    SetPlayerFacingAngle(playerid, PlayersData[playerid][Spawn_ZZ]);
	SetPlayerInteriorEx(playerid, PlayersData[playerid][Interior]);
	SetPlayerVirtualWorldEx(playerid, 0);
}
public CheckSpectToPlayer(playerid)
{
	for ( new i = 0; i < MAX_PLAYERS; i++)
	{
	    if ( PlayersDataOnline[i][Espectando] == playerid )
	    {
			PlayersDataOnline[playerid][IsEspectando] = true;
			return true;
		}
	}
	PlayersDataOnline[playerid][IsEspectando] = false;
	return true;
}
public CheckArmaCheat(playerid)
{
	if ( PlayersDataOnline[playerid][StateWeaponPass] <= gettime())
	{
		new WeapoindID, AmmoQl;
		for (new i = 0; i < 13; i++)
		{
			GetPlayerWeaponData(playerid, i, WeapoindID, AmmoQl);
			if ( PlayersData[playerid][WeaponS][i] == WeapoindID && PlayersData[playerid][AmmoS][i] >= AmmoQl || AmmoQl == 0)
			{
			 	//   printf("%i - %i || %i - %i", PlayersData[playerid][WeaponS][i], PlayersData[playerid][AmmoS][i], WeapoindID, AmmoQl);
			    PlayersData[playerid][WeaponS][i] = WeapoindID;
	            PlayersData[playerid][AmmoS][i] = AmmoQl;
			}
			else
			{
				RemovePlayerWeapon(playerid, 46);
				PlayersDataOnline[playerid][CountCheat]++;
				if ( PlayersDataOnline[playerid][CountCheat] % 100 == 0 )
				{
					new MsgAvisoWeapon[MAX_TEXT_CHAT];
				    format(MsgAvisoWeapon, sizeof(MsgAvisoWeapon), "%s AntiCheat-Weapon - %s[%i] posible {F1FF00}Weapon Cheat.", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid);
					MsgCheatsReportsToAdmins(MsgAvisoWeapon);
				    printf("%s", MsgAvisoWeapon);
			    }
				return false;
			}
		}
	}
	return true;
}
public SetPlayerLockAllVehicles(playerid)
{
	for (new i = 1; i <= MAX_CAR; i++)
	{
		if ( i <= MAX_CAR_DUENO )
		{
		    if (strlen(DataCars[i][Dueno]) != 1)
			SetVehicleParamsForPlayer(i, playerid, 0, DataCars[i][Lock]);
			else
			SetVehicleParamsForPlayer(i, playerid, 0, 0);

		}
		else if ( i <= MAX_CAR_GANG )
		{
		    if ( PlayersData[playerid][Gang] == DataCars[i][Time] )
			SetVehicleParamsForPlayer(i, playerid, 0, DataCars[i][Lock]);
			else
			SetVehicleParamsForPlayer(i, playerid, 0, 1);
		}
		else
		{
			SetVehicleParamsForPlayer(i, playerid, 0, 0);
		}
	}
}
public ResetPlayerWeaponsEx(playerid)
{
	for (new i = 0; i < 13; i++)
	{
		PlayersData[playerid][WeaponS][i]	= 0;
		PlayersData[playerid][AmmoS][i]		= 0;
	}
	ResetPlayerWeapons(playerid);
}
public SetPlayerJail(playerid)
{
	ResetPlayerWeaponsEx(playerid);
	SetPlayerPos(playerid,
	JailsType[PlayersData[playerid][IsInJail]][PosX_Preso],
	JailsType[PlayersData[playerid][IsInJail]][PosY_Preso],
	JailsType[PlayersData[playerid][IsInJail]][PosZ_Preso]);
	SetPlayerFacingAngle(playerid, 	JailsType[PlayersData[playerid][IsInJail]][PosZZ_Preso]);
	SetPlayerInteriorEx(playerid, JailsType[PlayersData[playerid][IsInJail]][Interior_Preso]);
	SetSpawnInfo(playerid, -1, PlayersData[playerid][Skin],
	JailsType[PlayersData[playerid][IsInJail]][PosX_Liberado],
	JailsType[PlayersData[playerid][IsInJail]][PosY_Liberado],
	JailsType[PlayersData[playerid][IsInJail]][PosZ_Liberado],
	JailsType[PlayersData[playerid][IsInJail]][PosZZ_Liberado], 0, 0, 0, 0, 0, 0);
    SetCameraBehindPlayer(playerid);
    SetPlayerVirtualWorldEx(playerid, WORLD_DEFAULT_INTERIOR);
}
public GivePlayerMoneyEx(playerid, money)
{
	PlayersDataOnline[playerid][StateMoneyPass] = gettime() + 5;
    PlayersData[playerid][Dinero] += money;
}
public CleanDataDeath(playerid)
{
	DisablePlayerCheckpoint(playerid);
	PlayersDataOnline[playerid][SubAfterMenuRow] 			= 0;
	PlayersDataOnline[playerid][AfterMenuRow] 	 			= 0;
}
public SetVehicleHidden(vehicleid)
{
	if ( GetVehicleVirtualWorld(vehicleid) != 999 )
	{
		SetVehicleVirtualWorld(vehicleid, 999);
		DataCars[vehicleid][RespawnTimerId] = SetTimerEx("SetVehicleShow", MAX_TIME_VEHICLE_HIDDEN, false, "d", vehicleid);
		DataCars[vehicleid][WorldLast] 		= DataCars[vehicleid][World];
		DataCars[vehicleid][InteriorLast]	= DataCars[vehicleid][Interior];
	}
}
public SendChatStream(playerid, text[])
{
	new Float:X, Float:Y, Float:Z;
	new MsgSendChat[MAX_TEXT_CHAT];
	GetPlayerPos(playerid,X,Y,Z);
	
	format(MsgSendChat, sizeof(MsgSendChat), "[SGW]: %s Dice: %s", PlayersDataOnline[playerid][NameOnline], text);
	
    new MyWorrld = GetPlayerVirtualWorld(playerid);
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i,30.0,X,Y,Z) && GetPlayerVirtualWorld(i) == MyWorrld)
	    {
		    if(IsPlayerInRangeOfPoint(i,5.0,X,Y,Z))
		    {
		    	SendClientMessage(i, SendChatStreamColors[0],MsgSendChat);
			}
		    else if(IsPlayerInRangeOfPoint(i,10.0,X,Y,Z))
		    {
		    	SendClientMessage(i, SendChatStreamColors[1],MsgSendChat);
			}
		    else if(IsPlayerInRangeOfPoint(i,15.0,X,Y,Z))
		    {
		    	SendClientMessage(i, SendChatStreamColors[2],MsgSendChat);
			}
		    else if(IsPlayerInRangeOfPoint(i,20.0,X,Y,Z))
		    {
		    	SendClientMessage(i, SendChatStreamColors[3],MsgSendChat);
			}
		    else if(IsPlayerInRangeOfPoint(i,25.0,X,Y,Z))
		    {
		    	SendClientMessage(i, SendChatStreamColors[4],MsgSendChat);
			}
		    else if(IsPlayerInRangeOfPoint(i,30.0,X,Y,Z))
		    {
		    	SendClientMessage(i, SendChatStreamColors[5],MsgSendChat);
			}
		}
	}
}
public GetMaxGangRango(faccionid)
{
	new i;
	for (;i < MAX_GANG_RANGOS; i++)
	{
		if ( GangData[faccionid][Paga][i] == 0 )
		{
			break;
		}
	}
	return i - 1;
}
public MsgAdminUseCommands(level, playerid, commands[])
{
	if ( PlayersData[playerid][Admin] != 9 )
	{
	    new MsgPerNivel9[256];
	    if ( PlayersData[playerid][Admin] )
	    {
	    	format(MsgPerNivel9, sizeof(MsgPerNivel9), "{A49C00}%s %s[%i] ha usado el comando: %s", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, commands);
	   	}
	   	else
	   	{
	    	format(MsgPerNivel9, sizeof(MsgPerNivel9), "{A49C00}%s %s[%i] {B90000}(NO ES ADMIN) {A49C00}ha usado el comando: %s", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, commands);
	   	}
		for (new e = 0; e < MAX_PLAYERS; e++)
		{
		    if ( IsPlayerConnected(e) && PlayersData[e][Admin] == level && PlayersDataOnline[e][State] == 3 && PlayersDataOnline[e][SendCommands] )
		    {
		        SendClientMessage(e, COLOR_CHEATS_REPORTES, MsgPerNivel9);
		    }
	    }
		printf("%s", MsgPerNivel9);
	}
}
public LoadAllAnims()
{
	//////	ANIMACIONES
	// ATTRACTORS - 2
	ATTRACTORS_ANIMATIONS [0]   = "Stepsit_in";
	ATTRACTORS_ANIMATIONS [1]   = "Stepsit_loop";
	ATTRACTORS_ANIMATIONS [2]   = "Stepsit_out";
	// BAR - 11
	BAR_ANIMATIONS[0]   = "Barcustom_get";
	BAR_ANIMATIONS[1]   = "Barcustom_loop";
	BAR_ANIMATIONS[2]   = "Barcustom_order";
	BAR_ANIMATIONS[3]   = "BARman_idle";
	BAR_ANIMATIONS[4]   = "Barserve_bottle";
	BAR_ANIMATIONS[5]   = "Barserve_give";
	BAR_ANIMATIONS[6]   = "Barserve_glass";
	BAR_ANIMATIONS[7]   = "Barserve_in";
	BAR_ANIMATIONS[8]   = "Barserve_loop";
	BAR_ANIMATIONS[9]   = "Barserve_order";
	BAR_ANIMATIONS[10]   = "dnk_stndF_loop";
	BAR_ANIMATIONS[11]   = "dnk_stndM_loop";
	// BAT - 10
	BAT_ANIMATIONS [0]   = "Bat_1";
	BAT_ANIMATIONS [1]   = "Bat_2";
	BAT_ANIMATIONS [2]   = "Bat_3";
	BAT_ANIMATIONS [3]   = "Bat_4";
	BAT_ANIMATIONS [4]   = "Bat_block";
	BAT_ANIMATIONS [5]   = "Bat_Hit_1";
	BAT_ANIMATIONS [6]   = "Bat_Hit_2";
	BAT_ANIMATIONS [7]   = "Bat_Hit_3";
	BAT_ANIMATIONS [8]   = "Bat_IDLE";
	BAT_ANIMATIONS [9]   = "Bat_M";
	BAT_ANIMATIONS [10]   = "BAT_PART";
	// FIRE - 12
	FIRE_ANIMATIONS [0]   = "BD_Fire1";
	FIRE_ANIMATIONS [1]   = "BD_Fire2";
	FIRE_ANIMATIONS [2]   = "BD_Fire3";
	FIRE_ANIMATIONS [3]   = "BD_GF_Wave";
	FIRE_ANIMATIONS [4]   = "BD_Panic_01";
	FIRE_ANIMATIONS [5]   = "BD_Panic_02";
	FIRE_ANIMATIONS [6]   = "BD_Panic_03";
	FIRE_ANIMATIONS [7]   = "BD_Panic_04";
	FIRE_ANIMATIONS [8]   = "BD_Panic_Loop";
	FIRE_ANIMATIONS [9]   = "Grlfrd_Kiss_03";
	FIRE_ANIMATIONS [10]   = "M_smklean_loop";
	FIRE_ANIMATIONS [11]   = "Playa_Kiss_03";
	FIRE_ANIMATIONS [12]   = "wash_up";
	// PLAYA - 4
	PLAYA_ANIMATIONS [0]   = "bather";
	PLAYA_ANIMATIONS [1]   = "Lay_Bac_Loop";
	PLAYA_ANIMATIONS [2]   = "ParkSit_M_loop";
	PLAYA_ANIMATIONS [3]   = "ParkSit_W_loop";
	PLAYA_ANIMATIONS [4]   = "SitnWait_loop_W";
	// GYM - 6
	GYM_ANIMATIONS [0]   = "gym_bp_celebrate";
	GYM_ANIMATIONS [1]   = "gym_bp_down";
	GYM_ANIMATIONS [2]   = "gym_bp_getoff";
	GYM_ANIMATIONS [3]   = "gym_bp_geton";
	GYM_ANIMATIONS [4]   = "gym_bp_up_A";
	GYM_ANIMATIONS [5]   = "gym_bp_up_B";
	GYM_ANIMATIONS [6]   = "gym_bp_up_smooth";
	// BFINJECT - 3
	BFINJECT_ANIMATIONS [0]   = "BF_getin_LHS";
	BFINJECT_ANIMATIONS [1]   = "BF_getin_RHS";
	BFINJECT_ANIMATIONS [2]   = "BF_getout_LHS";
	BFINJECT_ANIMATIONS [3]   = "BF_getout_RHS";
	// BICID - 18
	BICID_ANIMATIONS [0]   = "BIKEd_Back";
	BICID_ANIMATIONS [1]   = "BIKEd_drivebyFT";
	BICID_ANIMATIONS [2]   = "BIKEd_drivebyLHS";
	BICID_ANIMATIONS [3]   = "BIKEd_drivebyRHS";
	BICID_ANIMATIONS [4]   = "BIKEd_Fwd";
	BICID_ANIMATIONS [5]   = "BIKEd_getoffBACK";
	BICID_ANIMATIONS [6]   = "BIKEd_getoffLHS";
	BICID_ANIMATIONS [7]   = "BIKEd_getoffRHS";
	BICID_ANIMATIONS [8]   = "BIKEd_hit";
	BICID_ANIMATIONS [9]   = "BIKEd_jumponL";
	BICID_ANIMATIONS [10]   = "BIKEd_jumponR";
	BICID_ANIMATIONS [11]   = "BIKEd_kick";
	BICID_ANIMATIONS [12]   = "BIKEd_Left";
	BICID_ANIMATIONS [13]   = "BIKEd_passenger";
	BICID_ANIMATIONS [14]   = "BIKEd_pushes";
	BICID_ANIMATIONS [15]   = "BIKEd_Ride";
	BICID_ANIMATIONS [16]   = "BIKEd_Right";
	BICID_ANIMATIONS [17]   = "BIKEd_shuffle";
	BICID_ANIMATIONS [18]   = "BIKEd_Still";
	// BICIH - 17
	BICIH_ANIMATIONS [0]   = "BIKEh_Back";
	BICIH_ANIMATIONS [1]   = "BIKEh_drivebyFT";
	BICIH_ANIMATIONS [2]   = "BIKEh_drivebyLHS";
	BICIH_ANIMATIONS [3]   = "BIKEh_drivebyRHS";
	BICIH_ANIMATIONS [4]   = "BIKEh_Fwd";
	BICIH_ANIMATIONS [5]   = "BIKEh_getoffBACK";
	BICIH_ANIMATIONS [6]   = "BIKEh_getoffLHS";
	BICIH_ANIMATIONS [7]   = "BIKEh_getoffRHS";
	BICIH_ANIMATIONS [8]   = "BIKEh_hit";
	BICIH_ANIMATIONS [9]   = "BIKEh_jumponL";
	BICIH_ANIMATIONS [10]   = "BIKEh_jumponR";
	BICIH_ANIMATIONS [11]   = "BIKEh_kick";
	BICIH_ANIMATIONS [12]   = "BIKEh_Left";
	BICIH_ANIMATIONS [13]   = "BIKEh_passenger";
	BICIH_ANIMATIONS [14]   = "BIKEh_pushes";
	BICIH_ANIMATIONS [15]   = "BIKEh_Ride";
	BICIH_ANIMATIONS [16]   = "BIKEh_Right";
	BICIH_ANIMATIONS [17]   = "BIKEh_Still";
	// BICIL - 8
	BICIL_ANIMATIONS [0]   = "bk_blnce_in";
	BICIL_ANIMATIONS [1]   = "bk_blnce_out";
	BICIL_ANIMATIONS [2]   = "bk_jmp";
	BICIL_ANIMATIONS [3]   = "bk_rdy_in";
	BICIL_ANIMATIONS [4]   = "bk_rdy_out";
	BICIL_ANIMATIONS [5]   = "struggle_cesar";
	BICIL_ANIMATIONS [6]   = "struggle_driver";
	BICIL_ANIMATIONS [7]   = "truck_driver";
	BICIL_ANIMATIONS [8]   = "truck_getin";
	// BICIS - 19
	BICIS_ANIMATIONS [0]   = "BIKEs_Back";
	BICIS_ANIMATIONS [1]   = "BIKEs_drivebyFT";
	BICIS_ANIMATIONS [2]   = "BIKEs_drivebyLHS";
	BICIS_ANIMATIONS [3]   = "BIKEs_drivebyRHS";
	BICIS_ANIMATIONS [4]   = "BIKEs_Fwd";
	BICIS_ANIMATIONS [5]   = "BIKEs_getoffBACK";
	BICIS_ANIMATIONS [6]   = "BIKEs_getoffLHS";
	BICIS_ANIMATIONS [7]   = "BIKEs_getoffRHS";
	BICIS_ANIMATIONS [8]   = "BIKEs_hit";
	BICIS_ANIMATIONS [9]   = "BIKEs_jumponL";
	BICIS_ANIMATIONS [10]   = "BIKEs_jumponR";
	BICIS_ANIMATIONS [11]   = "BIKEs_kick";
	BICIS_ANIMATIONS [12]   = "BIKEs_Left";
	BICIS_ANIMATIONS [13]   = "BIKEs_passenger";
	BICIS_ANIMATIONS [14]   = "BIKEs_pushes";
	BICIS_ANIMATIONS [15]   = "BIKEs_Ride";
	BICIS_ANIMATIONS [16]   = "BIKEs_Right";
	BICIS_ANIMATIONS [17]   = "BIKEs_Snatch_L";
	BICIS_ANIMATIONS [18]   = "BIKEs_Snatch_R";
	BICIS_ANIMATIONS [19]   = "BIKEs_Still";
	// BICIV - 17
	BICIV_ANIMATIONS [0]   = "BIKEv_Back";
	BICIV_ANIMATIONS [1]   = "BIKEv_drivebyFT";
	BICIV_ANIMATIONS [2]   = "BIKEv_drivebyLHS";
	BICIV_ANIMATIONS [3]   = "BIKEv_drivebyRHS";
	BICIV_ANIMATIONS [4]   = "BIKEv_Fwd";
	BICIV_ANIMATIONS [5]   = "BIKEv_getoffBACK";
	BICIV_ANIMATIONS [6]   = "BIKEv_getoffLHS";
	BICIV_ANIMATIONS [7]   = "BIKEv_getoffRHS";
	BICIV_ANIMATIONS [8]   = "BIKEv_hit";
	BICIV_ANIMATIONS [9]   = "BIKEv_jumponL";
	BICIV_ANIMATIONS [10]   = "BIKEv_jumponR";
	BICIV_ANIMATIONS [11]   = "BIKEv_kick";
	BICIV_ANIMATIONS [12]   = "BIKEv_Left";
	BICIV_ANIMATIONS [13]   = "BIKEv_passenger";
	BICIV_ANIMATIONS [14]   = "BIKEv_pushes";
	BICIV_ANIMATIONS [15]   = "BIKEv_Ride";
	BICIV_ANIMATIONS [16]   = "BIKEv_Right";
	BICIV_ANIMATIONS [17]   = "BIKEv_Still";
	// BICI - 3
	BICI_ANIMATIONS [0]   = "Pass_Driveby_BWD";
	BICI_ANIMATIONS [1]   = "Pass_Driveby_FWD";
	BICI_ANIMATIONS [2]   = "Pass_Driveby_LHS";
	BICI_ANIMATIONS [3]   = "Pass_Driveby_RHS";
	// GOLPE - 11
	GOLPE_ANIMATIONS [0]   = "BJ_COUCH_START_W";
	GOLPE_ANIMATIONS [1]   = "BJ_COUCH_LOOP_W";
	GOLPE_ANIMATIONS [2]   = "BJ_COUCH_END_W";
	GOLPE_ANIMATIONS [3]   = "BJ_COUCH_START_P";
	GOLPE_ANIMATIONS [4]   = "BJ_COUCH_LOOP_P";
	GOLPE_ANIMATIONS [5]   = "BJ_COUCH_END_P";
	GOLPE_ANIMATIONS [6]   = "BJ_STAND_START_W";
	GOLPE_ANIMATIONS [7]   = "BJ_STAND_LOOP_W";
	GOLPE_ANIMATIONS [8]   = "BJ_STAND_END_W";
	GOLPE_ANIMATIONS [9]   = "BJ_STAND_START_P";
	GOLPE_ANIMATIONS [10]   = "BJ_STAND_LOOP_P";
	GOLPE_ANIMATIONS [11]   = "BJ_STAND_END_P";
	// BMX - 17
	BMX_ANIMATIONS [0]   = "BMX_back";
	BMX_ANIMATIONS [1]   = "BMX_bunnyhop";
	BMX_ANIMATIONS [2]   = "BMX_drivebyFT";
	BMX_ANIMATIONS [3]   = "BMX_driveby_LHS";
	BMX_ANIMATIONS [4]   = "BMX_driveby_RHS";
	BMX_ANIMATIONS [5]   = "BMX_fwd";
	BMX_ANIMATIONS [6]   = "BMX_getoffBACK";
	BMX_ANIMATIONS [7]   = "BMX_getoffLHS";
	BMX_ANIMATIONS [8]   = "BMX_getoffRHS";
	BMX_ANIMATIONS [9]   = "BMX_jumponL";
	BMX_ANIMATIONS [10]   = "BMX_jumponR";
	BMX_ANIMATIONS [11]   = "BMX_Left";
	BMX_ANIMATIONS [12]   = "BMX_pedal";
	BMX_ANIMATIONS [13]   = "BMX_pushes";
	BMX_ANIMATIONS [14]   = "BMX_Ride";
	BMX_ANIMATIONS [15]   = "BMX_Right";
	BMX_ANIMATIONS [16]   = "BMX_sprint";
	BMX_ANIMATIONS [17]   = "BMX_still";
	// BOMBER - 5
	BOMBER_ANIMATIONS [0]   = "BOM_Plant";
	BOMBER_ANIMATIONS [1]   = "BOM_Plant_2Idle";
	BOMBER_ANIMATIONS [2]   = "BOM_Plant_Crouch_In";
	BOMBER_ANIMATIONS [3]   = "BOM_Plant_Crouch_Out";
	BOMBER_ANIMATIONS [4]   = "BOM_Plant_In";
	BOMBER_ANIMATIONS [5]   = "BOM_Plant_Loop";
	// BOX - 9
	BOX_ANIMATIONS [0]   = "boxhipin";
	BOX_ANIMATIONS [1]   = "boxhipup";
	BOX_ANIMATIONS [2]   = "boxshdwn";
	BOX_ANIMATIONS [3]   = "boxshup";
	BOX_ANIMATIONS [4]   = "bxhipwlk";
	BOX_ANIMATIONS [5]   = "bxhwlki";
	BOX_ANIMATIONS [6]   = "bxshwlk";
	BOX_ANIMATIONS [7]   = "bxshwlki";
	BOX_ANIMATIONS [8]   = "bxwlko";
	BOX_ANIMATIONS [9]   = "catch_box";
	// BALL - 40
	BALL_ANIMATIONS [0]   = "BBALL_def_jump_shot";
	BALL_ANIMATIONS [1]   = "BBALL_def_loop";
	BALL_ANIMATIONS [2]   = "BBALL_def_stepL";
	BALL_ANIMATIONS [3]   = "BBALL_def_stepR";
	BALL_ANIMATIONS [4]   = "BBALL_Dnk";
	BALL_ANIMATIONS [5]   = "BBALL_Dnk_Gli";
	BALL_ANIMATIONS [6]   = "BBALL_Dnk_Gli_O";
	BALL_ANIMATIONS [7]   = "BBALL_Dnk_Lnch";
	BALL_ANIMATIONS [8]   = "BBALL_Dnk_Lnch_O";
	BALL_ANIMATIONS [9]   = "BBALL_Dnk_Lnd";
	BALL_ANIMATIONS [10]   = "BBALL_Dnk_O";
	BALL_ANIMATIONS [11]   = "BBALL_idle";
	BALL_ANIMATIONS [12]   = "BBALL_idle2";
	BALL_ANIMATIONS [13]   = "BBALL_idle2_O";
	BALL_ANIMATIONS [14]   = "BBALL_idleloop";
	BALL_ANIMATIONS [15]   = "BBALL_idleloop_O";
	BALL_ANIMATIONS [16]   = "BBALL_idle_O";
	BALL_ANIMATIONS [17]   = "BBALL_Jump_Cancel";
	BALL_ANIMATIONS [18]   = "BBALL_Jump_Cancel_O";
	BALL_ANIMATIONS [19]   = "BBALL_Jump_End";
	BALL_ANIMATIONS [20]   = "BBALL_Jump_Shot";
	BALL_ANIMATIONS [21]   = "BBALL_Jump_Shot_O";
	BALL_ANIMATIONS [22]   = "BBALL_Net_Dnk_O";
	BALL_ANIMATIONS [23]   = "BBALL_pickup";
	BALL_ANIMATIONS [24]   = "BBALL_pickup_O";
	BALL_ANIMATIONS [25]   = "BBALL_react_miss";
	BALL_ANIMATIONS [26]   = "BBALL_react_score";
	BALL_ANIMATIONS [27]   = "BBALL_run";
	BALL_ANIMATIONS [28]   = "BBALL_run_O";
	BALL_ANIMATIONS [29]   = "BBALL_SkidStop_L";
	BALL_ANIMATIONS [30]   = "BBALL_SkidStop_L_O";
	BALL_ANIMATIONS [31]   = "BBALL_SkidStop_R";
	BALL_ANIMATIONS [32]   = "BBALL_SkidStop_R_O";
	BALL_ANIMATIONS [33]   = "BBALL_walk";
	BALL_ANIMATIONS [34]   = "BBALL_WalkStop_L";
	BALL_ANIMATIONS [35]   = "BBALL_WalkStop_L_O";
	BALL_ANIMATIONS [36]   = "BBALL_WalkStop_R";
	BALL_ANIMATIONS [37]   = "BBALL_WalkStop_R_O";
	BALL_ANIMATIONS [38]   = "BBALL_walk_O";
	BALL_ANIMATIONS [39]   = "BBALL_walk_start";
	BALL_ANIMATIONS [40]   = "BBALL_walk_start_O";
	// BUDDY - 4
	BUDDY_ANIMATIONS [0]   = "buddy_crouchfire";
	BUDDY_ANIMATIONS [1]   = "buddy_crouchreload";
	BUDDY_ANIMATIONS [2]   = "buddy_fire";
	BUDDY_ANIMATIONS [3]   = "buddy_fire_poor";
	BUDDY_ANIMATIONS [4]   = "buddy_reload";
	// BUS - 8
	BUS_ANIMATIONS [0]   = "BUS_close";
	BUS_ANIMATIONS [1]   = "BUS_getin_LHS";
	BUS_ANIMATIONS [2]   = "BUS_getin_RHS";
	BUS_ANIMATIONS [3]   = "BUS_getout_LHS";
	BUS_ANIMATIONS [4]   = "BUS_getout_RHS";
	BUS_ANIMATIONS [5]   = "BUS_jacked_LHS";
	BUS_ANIMATIONS [6]   = "BUS_open";
	BUS_ANIMATIONS [7]   = "BUS_open_RHS";
	BUS_ANIMATIONS [8]   = "BUS_pullout_LHS";
	// CAM - 13
	CAM_ANIMATIONS [0]   = "camcrch_cmon";
	CAM_ANIMATIONS [1]   = "camcrch_idleloop";
	CAM_ANIMATIONS [2]   = "camcrch_stay";
	CAM_ANIMATIONS [3]   = "camcrch_to_camstnd";
	CAM_ANIMATIONS [4]   = "camstnd_cmon";
	CAM_ANIMATIONS [5]   = "camstnd_idleloop";
	CAM_ANIMATIONS [6]   = "camstnd_lkabt";
	CAM_ANIMATIONS [7]   = "camstnd_to_camcrch";
	CAM_ANIMATIONS [8]   = "piccrch_in";
	CAM_ANIMATIONS [9]   = "piccrch_out";
	CAM_ANIMATIONS [10]   = "piccrch_take";
	CAM_ANIMATIONS [11]   = "picstnd_in";
	CAM_ANIMATIONS [12]   = "picstnd_out";
	CAM_ANIMATIONS [13]   = "picstnd_take";
	// CAR - 10
	CAR_ANIMATIONS [0]   = "Fixn_Car_Loop";
	CAR_ANIMATIONS [1]   = "Fixn_Car_Out";
	CAR_ANIMATIONS [2]   = "flag_drop";
	CAR_ANIMATIONS [3]   = "Sit_relaxed";
	CAR_ANIMATIONS [4]   = "Tap_hand";
	CAR_ANIMATIONS [5]   = "Tyd2car_bump";
	CAR_ANIMATIONS [6]   = "Tyd2car_high";
	CAR_ANIMATIONS [7]   = "Tyd2car_low";
	CAR_ANIMATIONS [8]   = "Tyd2car_med";
	CAR_ANIMATIONS [9]   = "Tyd2car_TurnL";
	CAR_ANIMATIONS [10]   = "Tyd2car_TurnR";
	// CARRY - 6
	CARRY_ANIMATIONS [0]   = "crry_prtial";
	CARRY_ANIMATIONS [1]   = "liftup";
	CARRY_ANIMATIONS [2]   = "liftup05";
	CARRY_ANIMATIONS [3]   = "liftup105";
	CARRY_ANIMATIONS [4]   = "putdwn";
	CARRY_ANIMATIONS [5]   = "putdwn05";
	CARRY_ANIMATIONS [6]   = "putdwn105";
	// CARCHAT - 20
	CARCHAT_ANIMATIONS [0]   = "carfone_in";
	CARCHAT_ANIMATIONS [1]   = "carfone_loopA";
	CARCHAT_ANIMATIONS [2]   = "carfone_loopA_to_B";
	CARCHAT_ANIMATIONS [3]   = "carfone_loopB";
	CARCHAT_ANIMATIONS [4]   = "carfone_loopB_to_A";
	CARCHAT_ANIMATIONS [5]   = "carfone_out";
	CARCHAT_ANIMATIONS [6]   = "CAR_Sc1_BL";
	CARCHAT_ANIMATIONS [7]   = "CAR_Sc1_BR";
	CARCHAT_ANIMATIONS [8]   = "CAR_Sc1_FL";
	CARCHAT_ANIMATIONS [9]   = "CAR_Sc1_FR";
	CARCHAT_ANIMATIONS [10]   = "CAR_Sc2_FL";
	CARCHAT_ANIMATIONS [11]   = "CAR_Sc3_BR";
	CARCHAT_ANIMATIONS [12]   = "CAR_Sc3_FL";
	CARCHAT_ANIMATIONS [13]   = "CAR_Sc3_FR";
	CARCHAT_ANIMATIONS [14]   = "CAR_Sc4_BL";
	CARCHAT_ANIMATIONS [15]   = "CAR_Sc4_BR";
	CARCHAT_ANIMATIONS [16]   = "CAR_Sc4_FL";
	CARCHAT_ANIMATIONS [17]   = "CAR_Sc4_FR";
	CARCHAT_ANIMATIONS [18]   = "car_talkm_in";
	CARCHAT_ANIMATIONS [19]   = "car_talkm_loop";
	CARCHAT_ANIMATIONS [20]   = "car_talkm_out";
	// CASINO - 24
	CASINO_ANIMATIONS [0]   = "cards_in";
	CASINO_ANIMATIONS [1]   = "cards_loop";
	CASINO_ANIMATIONS [2]   = "cards_lose";
	CASINO_ANIMATIONS [3]   = "cards_out";
	CASINO_ANIMATIONS [4]   = "cards_pick_01";
	CASINO_ANIMATIONS [5]   = "cards_pick_02";
	CASINO_ANIMATIONS [6]   = "cards_raise";
	CASINO_ANIMATIONS [7]   = "cards_win";
	CASINO_ANIMATIONS [8]   = "dealone";
	CASINO_ANIMATIONS [9]   = "manwinb";
	CASINO_ANIMATIONS [10]   = "manwind";
	CASINO_ANIMATIONS [11]   = "Roulette_bet";
	CASINO_ANIMATIONS [12]   = "Roulette_in";
	CASINO_ANIMATIONS [13]   = "Roulette_loop";
	CASINO_ANIMATIONS [14]   = "Roulette_lose";
	CASINO_ANIMATIONS [15]   = "Roulette_out";
	CASINO_ANIMATIONS [16]   = "Roulette_win";
	CASINO_ANIMATIONS [17]   = "Slot_bet_01";
	CASINO_ANIMATIONS [18]   = "Slot_bet_02";
	CASINO_ANIMATIONS [19]   = "Slot_in";
	CASINO_ANIMATIONS [20]   = "Slot_lose_out";
	CASINO_ANIMATIONS [21]   = "Slot_Plyr";
	CASINO_ANIMATIONS [22]   = "Slot_wait";
	CASINO_ANIMATIONS [23]   = "Slot_win_out";
	CASINO_ANIMATIONS [24]   = "wof";
	// CHAINSAW - 10
	CHAINSAW_ANIMATIONS [0]   = "CSAW_1";
	CHAINSAW_ANIMATIONS [1]   = "CSAW_2";
	CHAINSAW_ANIMATIONS [2]   = "CSAW_3";
	CHAINSAW_ANIMATIONS [3]   = "CSAW_G";
	CHAINSAW_ANIMATIONS [4]   = "CSAW_Hit_1";
	CHAINSAW_ANIMATIONS [5]   = "CSAW_Hit_2";
	CHAINSAW_ANIMATIONS [6]   = "CSAW_Hit_3";
	CHAINSAW_ANIMATIONS [7]   = "csaw_part";
	CHAINSAW_ANIMATIONS [8]   = "IDLE_csaw";
	CHAINSAW_ANIMATIONS [9]   = "WEAPON_csaw";
	CHAINSAW_ANIMATIONS [10]   = "WEAPON_csawlo";
	// CHOPA - 17
	CHOPA_ANIMATIONS [0]   = "CHOPPA_back";
	CHOPA_ANIMATIONS [1]   = "CHOPPA_bunnyhop";
	CHOPA_ANIMATIONS [2]   = "CHOPPA_drivebyFT";
	CHOPA_ANIMATIONS [3]   = "CHOPPA_driveby_LHS";
	CHOPA_ANIMATIONS [4]   = "CHOPPA_driveby_RHS";
	CHOPA_ANIMATIONS [5]   = "CHOPPA_fwd";
	CHOPA_ANIMATIONS [6]   = "CHOPPA_getoffBACK";
	CHOPA_ANIMATIONS [7]   = "CHOPPA_getoffLHS";
	CHOPA_ANIMATIONS [8]   = "CHOPPA_getoffRHS";
	CHOPA_ANIMATIONS [9]   = "CHOPPA_jumponL";
	CHOPA_ANIMATIONS [10]   = "CHOPPA_jumponR";
	CHOPA_ANIMATIONS [11]   = "CHOPPA_Left";
	CHOPA_ANIMATIONS [12]   = "CHOPPA_pedal";
	CHOPA_ANIMATIONS [13]   = "CHOPPA_Pushes";
	CHOPA_ANIMATIONS [14]   = "CHOPPA_ride";
	CHOPA_ANIMATIONS [15]   = "CHOPPA_Right";
	CHOPA_ANIMATIONS [16]   = "CHOPPA_sprint";
	CHOPA_ANIMATIONS [17]   = "CHOPPA_Still";
	// CLOTHES - 12
	CLOTHES_ANIMATIONS [0]   = "CLO_Buy";
	CLOTHES_ANIMATIONS [1]   = "CLO_In";
	CLOTHES_ANIMATIONS [2]   = "CLO_Out";
	CLOTHES_ANIMATIONS [3]   = "CLO_Pose_Hat";
	CLOTHES_ANIMATIONS [4]   = "CLO_Pose_In";
	CLOTHES_ANIMATIONS [5]   = "CLO_Pose_In_O";
	CLOTHES_ANIMATIONS [6]   = "CLO_Pose_Legs";
	CLOTHES_ANIMATIONS [7]   = "CLO_Pose_Loop";
	CLOTHES_ANIMATIONS [8]   = "CLO_Pose_Out";
	CLOTHES_ANIMATIONS [9]   = "CLO_Pose_Out_O";
	CLOTHES_ANIMATIONS [10]   = "CLO_Pose_Shoes";
	CLOTHES_ANIMATIONS [11]   = "CLO_Pose_Torso";
	CLOTHES_ANIMATIONS [12]   = "CLO_Pose_Watch";
	// COACH - 5
	COACH_ANIMATIONS [0]   = "COACH_inL";
	COACH_ANIMATIONS [1]   = "COACH_inR";
	COACH_ANIMATIONS [2]   = "COACH_opnL";
	COACH_ANIMATIONS [3]   = "COACH_opnR";
	COACH_ANIMATIONS [4]   = "COACH_outL";
	COACH_ANIMATIONS [5]   = "COACH_outR";
	// COLT - 6
	COLT_ANIMATIONS [0]   = "2guns_crouchfire";
	COLT_ANIMATIONS [1]   = "colt45_crouchfire";
	COLT_ANIMATIONS [2]   = "colt45_crouchreload";
	COLT_ANIMATIONS [3]   = "colt45_fire";
	COLT_ANIMATIONS [4]   = "colt45_fire_2hands";
	COLT_ANIMATIONS [5]   = "colt45_reload";
	COLT_ANIMATIONS [6]   = "sawnoff_reload";
	// COP - 11
	COP_ANIMATIONS [0]   = "Copbrowse_in";
	COP_ANIMATIONS [1]   = "Copbrowse_loop";
	COP_ANIMATIONS [2]   = "Copbrowse_nod";
	COP_ANIMATIONS [3]   = "Copbrowse_out";
	COP_ANIMATIONS [4]   = "Copbrowse_shake";
	COP_ANIMATIONS [5]   = "Coplook_in";
	COP_ANIMATIONS [6]   = "Coplook_loop";
	COP_ANIMATIONS [7]   = "Coplook_nod";
	COP_ANIMATIONS [8]   = "Coplook_out";
	COP_ANIMATIONS [9]   = "Coplook_shake";
	COP_ANIMATIONS [10]   = "Coplook_think";
	COP_ANIMATIONS [11]   = "Coplook_watch";
	// COPD - 3
	COPD_ANIMATIONS [0]   = "COP_Dvby_B";
	COPD_ANIMATIONS [1]   = "COP_Dvby_FT";
	COPD_ANIMATIONS [2]   = "COP_Dvby_L";
	COPD_ANIMATIONS [3]   = "COP_Dvby_R";
	// CRACK - 9
	CRACK_ANIMATIONS [0]   = "Bbalbat_Idle_01";
	CRACK_ANIMATIONS [1]   = "Bbalbat_Idle_02";
	CRACK_ANIMATIONS [2]   = "crckdeth1";
	CRACK_ANIMATIONS [3]   = "crckdeth2";
	CRACK_ANIMATIONS [4]   = "crckdeth3";
	CRACK_ANIMATIONS [5]   = "crckdeth4";
	CRACK_ANIMATIONS [6]   = "crckidle1";
	CRACK_ANIMATIONS [7]   = "crckidle2";
	CRACK_ANIMATIONS [8]   = "crckidle3";
	CRACK_ANIMATIONS [9]   = "crckidle4";
	// CRIB - 4
	CRIB_ANIMATIONS [0]   = "CRIB_Console_Loop";
	CRIB_ANIMATIONS [1]   = "CRIB_Use_Switch";
	CRIB_ANIMATIONS [2]   = "PED_Console_Loop";
	CRIB_ANIMATIONS [3]   = "PED_Console_Loose";
	CRIB_ANIMATIONS [4]   = "PED_Console_Win";
	// DAM - 4
	DAM_ANIMATIONS [0]   = "DAM_Dive_Loop";
	DAM_ANIMATIONS [1]   = "DAM_Land";
	DAM_ANIMATIONS [2]   = "DAM_Launch";
	DAM_ANIMATIONS [3]   = "Jump_Roll";
	DAM_ANIMATIONS [4]   = "SF_JumpWall";
	// DANCE - 12
	DANCE_ANIMATIONS [0]   = "bd_clap";
	DANCE_ANIMATIONS [1]   = "bd_clap1";
	DANCE_ANIMATIONS [2]   = "dance_loop";
	DANCE_ANIMATIONS [3]   = "DAN_Down_A";
	DANCE_ANIMATIONS [4]   = "DAN_Left_A";
	DANCE_ANIMATIONS [5]   = "DAN_Loop_A";
	DANCE_ANIMATIONS [6]   = "DAN_Right_A";
	DANCE_ANIMATIONS [7]   = "DAN_Up_A";
	DANCE_ANIMATIONS [8]   = "dnce_M_a";
	DANCE_ANIMATIONS [9]   = "dnce_M_b";
	DANCE_ANIMATIONS [10]   = "dnce_M_c";
	DANCE_ANIMATIONS [11]   = "dnce_M_d";
	DANCE_ANIMATIONS [12]   = "dnce_M_e";
	// DEALER - 6
	DEALER_ANIMATIONS [0]   = "DEALER_DEAL";
	DEALER_ANIMATIONS [1]   = "DEALER_IDLE";
	DEALER_ANIMATIONS [2]   = "DEALER_IDLE_01";
	DEALER_ANIMATIONS [3]   = "DEALER_IDLE_02";
	DEALER_ANIMATIONS [4]   = "DEALER_IDLE_03";
	DEALER_ANIMATIONS [5]   = "DRUGS_BUY";
	DEALER_ANIMATIONS [6]   = "shop_pay";
	// DILDO - 8
	DILDO_ANIMATIONS [0]   = "DILDO_1";
	DILDO_ANIMATIONS [1]   = "DILDO_2";
	DILDO_ANIMATIONS [2]   = "DILDO_3";
	DILDO_ANIMATIONS [3]   = "DILDO_block";
	DILDO_ANIMATIONS [4]   = "DILDO_G";
	DILDO_ANIMATIONS [5]   = "DILDO_Hit_1";
	DILDO_ANIMATIONS [6]   = "DILDO_Hit_2";
	DILDO_ANIMATIONS [7]   = "DILDO_Hit_3";
	DILDO_ANIMATIONS [8]   = "DILDO_IDLE";
	// DODGE - 3
	DODGE_ANIMATIONS [0]   = "Cover_Dive_01";
	DODGE_ANIMATIONS [1]   = "Cover_Dive_02";
	DODGE_ANIMATIONS [2]   = "Crushed";
	DODGE_ANIMATIONS [3]   = "Crush_Jump";
	// DOZER - 9
	DOZER_ANIMATIONS [0]   = "DOZER_Align_LHS";
	DOZER_ANIMATIONS [1]   = "DOZER_Align_RHS";
	DOZER_ANIMATIONS [2]   = "DOZER_getin_LHS";
	DOZER_ANIMATIONS [3]   = "DOZER_getin_RHS";
	DOZER_ANIMATIONS [4]   = "DOZER_getout_LHS";
	DOZER_ANIMATIONS [5]   = "DOZER_getout_RHS";
	DOZER_ANIMATIONS [6]   = "DOZER_Jacked_LHS";
	DOZER_ANIMATIONS [7]   = "DOZER_Jacked_RHS";
	DOZER_ANIMATIONS [8]   = "DOZER_pullout_LHS";
	DOZER_ANIMATIONS [9]   = "DOZER_pullout_RHS";
	// DRIVE - 7
	DRIVE_ANIMATIONS [0]   = "Gang_DrivebyLHS";
	DRIVE_ANIMATIONS [1]   = "Gang_DrivebyLHS_Bwd";
	DRIVE_ANIMATIONS [2]   = "Gang_DrivebyLHS_Fwd";
	DRIVE_ANIMATIONS [3]   = "Gang_DrivebyRHS";
	DRIVE_ANIMATIONS [4]   = "Gang_DrivebyRHS_Bwd";
	DRIVE_ANIMATIONS [5]   = "Gang_DrivebyRHS_Fwd";
	DRIVE_ANIMATIONS [6]   = "Gang_DrivebyTop_LHS";
	DRIVE_ANIMATIONS [7]   = "Gang_DrivebyTop_RHS";
	// FAT - 17
	FAT_ANIMATIONS [0]   = "FatIdle";
	FAT_ANIMATIONS [1]   = "FatIdle_armed";
	FAT_ANIMATIONS [2]   = "FatIdle_Csaw";
	FAT_ANIMATIONS [3]   = "FatIdle_Rocket";
	FAT_ANIMATIONS [4]   = "FatRun";
	FAT_ANIMATIONS [5]   = "FatRun_armed";
	FAT_ANIMATIONS [6]   = "FatRun_Csaw";
	FAT_ANIMATIONS [7]   = "FatRun_Rocket";
	FAT_ANIMATIONS [8]   = "FatSprint";
	FAT_ANIMATIONS [9]   = "FatWalk";
	FAT_ANIMATIONS [10]   = "FatWalkstart";
	FAT_ANIMATIONS [11]   = "FatWalkstart_Csaw";
	FAT_ANIMATIONS [12]   = "FatWalkSt_armed";
	FAT_ANIMATIONS [13]   = "FatWalkSt_Rocket";
	FAT_ANIMATIONS [14]   = "FatWalk_armed";
	FAT_ANIMATIONS [15]   = "FatWalk_Csaw";
	FAT_ANIMATIONS [16]   = "FatWalk_Rocket";
	FAT_ANIMATIONS [17]   = "IDLE_tired";
	// FIGHTB - 9
	FIGHTB_ANIMATIONS [0]   = "FightB_1";
	FIGHTB_ANIMATIONS [1]   = "FightB_2";
	FIGHTB_ANIMATIONS [2]   = "FightB_3";
	FIGHTB_ANIMATIONS [3]   = "FightB_block";
	FIGHTB_ANIMATIONS [4]   = "FightB_G";
	FIGHTB_ANIMATIONS [5]   = "FightB_IDLE";
	FIGHTB_ANIMATIONS [6]   = "FightB_M";
	FIGHTB_ANIMATIONS [7]   = "HitB_1";
	FIGHTB_ANIMATIONS [8]   = "HitB_2";
	FIGHTB_ANIMATIONS [9]   = "HitB_3";
	// FIGHTC - 11
	FIGHTC_ANIMATIONS [0]   = "FightC_1";
	FIGHTC_ANIMATIONS [1]   = "FightC_2";
	FIGHTC_ANIMATIONS [2]   = "FightC_3";
	FIGHTC_ANIMATIONS [3]   = "FightC_block";
	FIGHTC_ANIMATIONS [4]   = "FightC_blocking";
	FIGHTC_ANIMATIONS [5]   = "FightC_G";
	FIGHTC_ANIMATIONS [6]   = "FightC_IDLE";
	FIGHTC_ANIMATIONS [7]   = "FightC_M";
	FIGHTC_ANIMATIONS [8]   = "FightC_Spar";
	FIGHTC_ANIMATIONS [9]   = "HitC_1";
	FIGHTC_ANIMATIONS [10]   = "HitC_2";
	FIGHTC_ANIMATIONS [11]   = "HitC_3";
	// FIGHTD - 9
	FIGHTD_ANIMATIONS [0]   = "FightD_1";
	FIGHTD_ANIMATIONS [1]   = "FightD_2";
	FIGHTD_ANIMATIONS [2]   = "FightD_3";
	FIGHTD_ANIMATIONS [3]   = "FightD_block";
	FIGHTD_ANIMATIONS [4]   = "FightD_G";
	FIGHTD_ANIMATIONS [5]   = "FightD_IDLE";
	FIGHTD_ANIMATIONS [6]   = "FightD_M";
	FIGHTD_ANIMATIONS [7]   = "HitD_1";
	FIGHTD_ANIMATIONS [8]   = "HitD_2";
	FIGHTD_ANIMATIONS [9]   = "HitD_3";
	// FIGHTE - 3
	FIGHTE_ANIMATIONS [0]   = "FightKick";
	FIGHTE_ANIMATIONS [1]   = "FightKick_B";
	FIGHTE_ANIMATIONS [2]   = "Hit_fightkick";
	FIGHTE_ANIMATIONS [3]   = "Hit_fightkick_B";
	// FINALE - 15
	FINALE_ANIMATIONS [0]   = "FIN_Climb_In";
	FINALE_ANIMATIONS [1]   = "FIN_Cop1_ClimbOut2";
	FINALE_ANIMATIONS [2]   = "FIN_Cop1_Loop";
	FINALE_ANIMATIONS [3]   = "FIN_Cop1_Stomp";
	FINALE_ANIMATIONS [4]   = "FIN_Hang_L";
	FINALE_ANIMATIONS [5]   = "FIN_Hang_Loop";
	FINALE_ANIMATIONS [6]   = "FIN_Hang_R";
	FINALE_ANIMATIONS [7]   = "FIN_Hang_Slip";
	FINALE_ANIMATIONS [8]   = "FIN_Jump_On";
	FINALE_ANIMATIONS [9]   = "FIN_Land_Car";
	FINALE_ANIMATIONS [10]   = "FIN_Land_Die";
	FINALE_ANIMATIONS [11]   = "FIN_LegsUp";
	FINALE_ANIMATIONS [12]   = "FIN_LegsUp_L";
	FINALE_ANIMATIONS [13]   = "FIN_LegsUp_Loop";
	FINALE_ANIMATIONS [14]   = "FIN_LegsUp_R";
	FINALE_ANIMATIONS [15]   = "FIN_Let_Go";
	// FINALE2 - 7
	FINALE2_ANIMATIONS [0]   = "FIN_Cop1_ClimbOut";
	FINALE2_ANIMATIONS [1]   = "FIN_Cop1_Fall";
	FINALE2_ANIMATIONS [2]   = "FIN_Cop1_Loop";
	FINALE2_ANIMATIONS [3]   = "FIN_Cop1_Shot";
	FINALE2_ANIMATIONS [4]   = "FIN_Cop1_Swing";
	FINALE2_ANIMATIONS [5]   = "FIN_Cop2_ClimbOut";
	FINALE2_ANIMATIONS [6]   = "FIN_Switch_P";
	FINALE2_ANIMATIONS [7]   = "FIN_Switch_S";
	// FLAME - 0
	FLAME_ANIMATIONS [0]   = "FLAME_fire";
	// FLOWERS - 2
	FLOWERS_ANIMATIONS [0]   = "Flower_attack";
	FLOWERS_ANIMATIONS [1]   = "Flower_attack_M";
	FLOWERS_ANIMATIONS [2]   = "Flower_Hit";
	// FOOD - 32
	FOOD_ANIMATIONS [0]   = "EAT_Burger";
	FOOD_ANIMATIONS [1]   = "EAT_Chicken";
	FOOD_ANIMATIONS [2]   = "EAT_Pizza";
	FOOD_ANIMATIONS [3]   = "EAT_Vomit_P";
	FOOD_ANIMATIONS [4]   = "EAT_Vomit_SK";
	FOOD_ANIMATIONS [5]   = "FF_Dam_Bkw";
	FOOD_ANIMATIONS [6]   = "FF_Dam_Fwd";
	FOOD_ANIMATIONS [7]   = "FF_Dam_Left";
	FOOD_ANIMATIONS [8]   = "FF_Dam_Right";
	FOOD_ANIMATIONS [9]   = "FF_Die_Bkw";
	FOOD_ANIMATIONS [10]   = "FF_Die_Fwd";
	FOOD_ANIMATIONS [11]   = "FF_Die_Left";
	FOOD_ANIMATIONS [12]   = "FF_Die_Right";
	FOOD_ANIMATIONS [13]   = "FF_Sit_Eat1";
	FOOD_ANIMATIONS [14]   = "FF_Sit_Eat2";
	FOOD_ANIMATIONS [15]   = "FF_Sit_Eat3";
	FOOD_ANIMATIONS [16]   = "FF_Sit_In";
	FOOD_ANIMATIONS [17]   = "FF_Sit_In_L";
	FOOD_ANIMATIONS [18]   = "FF_Sit_In_R";
	FOOD_ANIMATIONS [19]   = "FF_Sit_Look";
	FOOD_ANIMATIONS [20]   = "FF_Sit_Loop";
	FOOD_ANIMATIONS [21]   = "FF_Sit_Out_180";
	FOOD_ANIMATIONS [22]   = "FF_Sit_Out_L_180";
	FOOD_ANIMATIONS [23]   = "FF_Sit_Out_R_180";
	FOOD_ANIMATIONS [24]   = "SHP_Thank";
	FOOD_ANIMATIONS [25]   = "SHP_Tray_In";
	FOOD_ANIMATIONS [26]   = "SHP_Tray_Lift";
	FOOD_ANIMATIONS [27]   = "SHP_Tray_Lift_In";
	FOOD_ANIMATIONS [28]   = "SHP_Tray_Lift_Loop";
	FOOD_ANIMATIONS [29]   = "SHP_Tray_Lift_Out";
	FOOD_ANIMATIONS [30]   = "SHP_Tray_Out";
	FOOD_ANIMATIONS [31]   = "SHP_Tray_Pose";
	FOOD_ANIMATIONS [32]   = "SHP_Tray_Return";
	// GYMA - 8
	GYMA_ANIMATIONS [0]   = "gym_barbell";
	GYMA_ANIMATIONS [1]   = "gym_free_A";
	GYMA_ANIMATIONS [2]   = "gym_free_B";
	GYMA_ANIMATIONS [3]   = "gym_free_celebrate";
	GYMA_ANIMATIONS [4]   = "gym_free_down";
	GYMA_ANIMATIONS [5]   = "gym_free_loop";
	GYMA_ANIMATIONS [6]   = "gym_free_pickup";
	GYMA_ANIMATIONS [7]   = "gym_free_putdown";
	GYMA_ANIMATIONS [8]   = "gym_free_up_smooth";
	// GANGS - 32
	GANGS_ANIMATIONS [0]   = "DEALER_DEAL";
	GANGS_ANIMATIONS [1]   = "DEALER_IDLE";
	GANGS_ANIMATIONS [2]   = "drnkbr_prtl";
	GANGS_ANIMATIONS [3]   = "drnkbr_prtl_F";
	GANGS_ANIMATIONS [4]   = "DRUGS_BUY";
	GANGS_ANIMATIONS [5]   = "hndshkaa";
	GANGS_ANIMATIONS [6]   = "hndshkba";
	GANGS_ANIMATIONS [7]   = "hndshkca";
	GANGS_ANIMATIONS [8]   = "hndshkcb";
	GANGS_ANIMATIONS [9]   = "hndshkda";
	GANGS_ANIMATIONS [10]   = "hndshkea";
	GANGS_ANIMATIONS [11]   = "hndshkfa";
	GANGS_ANIMATIONS [12]   = "hndshkfa_swt";
	GANGS_ANIMATIONS [13]   = "Invite_No";
	GANGS_ANIMATIONS [14]   = "Invite_Yes";
	GANGS_ANIMATIONS [15]   = "leanIDLE";
	GANGS_ANIMATIONS [16]   = "leanIN";
	GANGS_ANIMATIONS [17]   = "leanOUT";
	GANGS_ANIMATIONS [18]   = "prtial_gngtlkA";
	GANGS_ANIMATIONS [19]   = "prtial_gngtlkB";
	GANGS_ANIMATIONS [20]   = "prtial_gngtlkC";
	GANGS_ANIMATIONS [21]   = "prtial_gngtlkD";
	GANGS_ANIMATIONS [22]   = "prtial_gngtlkE";
	GANGS_ANIMATIONS [23]   = "prtial_gngtlkF";
	GANGS_ANIMATIONS [24]   = "prtial_gngtlkG";
	GANGS_ANIMATIONS [25]   = "prtial_gngtlkH";
	GANGS_ANIMATIONS [26]   = "prtial_hndshk_01";
	GANGS_ANIMATIONS [27]   = "prtial_hndshk_biz_01";
	GANGS_ANIMATIONS [28]   = "shake_cara";
	GANGS_ANIMATIONS [29]   = "shake_carK";
	GANGS_ANIMATIONS [30]   = "shake_carSH";
	GANGS_ANIMATIONS [31]   = "smkcig_prtl";
	GANGS_ANIMATIONS [32]   = "smkcig_prtl_F";
	// GHANDS - 19
	GHANDS_ANIMATIONS [0]   = "gsign1";
	GHANDS_ANIMATIONS [1]   = "gsign1LH";
	GHANDS_ANIMATIONS [2]   = "gsign2";
	GHANDS_ANIMATIONS [3]   = "gsign2LH";
	GHANDS_ANIMATIONS [4]   = "gsign3";
	GHANDS_ANIMATIONS [5]   = "gsign3LH";
	GHANDS_ANIMATIONS [6]   = "gsign4";
	GHANDS_ANIMATIONS [7]   = "gsign4LH";
	GHANDS_ANIMATIONS [8]   = "gsign5";
	GHANDS_ANIMATIONS [9]   = "gsign5LH";
	GHANDS_ANIMATIONS [10]   = "LHGsign1";
	GHANDS_ANIMATIONS [11]   = "LHGsign2";
	GHANDS_ANIMATIONS [12]   = "LHGsign3";
	GHANDS_ANIMATIONS [13]   = "LHGsign4";
	GHANDS_ANIMATIONS [14]   = "LHGsign5";
	GHANDS_ANIMATIONS [15]   = "RHGsign1";
	GHANDS_ANIMATIONS [16]   = "RHGsign2";
	GHANDS_ANIMATIONS [17]   = "RHGsign3";
	GHANDS_ANIMATIONS [18]   = "RHGsign4";
	GHANDS_ANIMATIONS [19]   = "RHGsign5";
	// GHETTO - 6
	GHETTO_ANIMATIONS [0]   = "GDB_Car2_PLY";
	GHETTO_ANIMATIONS [1]   = "GDB_Car2_SMO";
	GHETTO_ANIMATIONS [2]   = "GDB_Car2_SWE";
	GHETTO_ANIMATIONS [3]   = "GDB_Car_PLY";
	GHETTO_ANIMATIONS [4]   = "GDB_Car_RYD";
	GHETTO_ANIMATIONS [5]   = "GDB_Car_SMO";
	GHETTO_ANIMATIONS [6]   = "GDB_Car_SWE";
	// GOGGLES - 0
	GOGGLES_ANIMATIONS [0]   = "goggles_put_on";
	// GRAFFITI - 1
	GRAFFITI_ANIMATIONS [0]   = "graffiti_Chkout";
	GRAFFITI_ANIMATIONS [1]   = "spraycan_fire";
	// GRAVE - 2
	GRAVE_ANIMATIONS [0]   = "mrnF_loop";
	GRAVE_ANIMATIONS [1]   = "mrnM_loop";
	GRAVE_ANIMATIONS [2]   = "prst_loopa";
	// GRENADE - 2
	GRENADE_ANIMATIONS [0]   = "WEAPON_start_throw";
	GRENADE_ANIMATIONS [1]   = "WEAPON_throw";
	GRENADE_ANIMATIONS [2]   = "WEAPON_throwu";
	// GYMB - 23
	GYMB_ANIMATIONS [0]   = "GYMshadowbox";
	GYMB_ANIMATIONS [1]   = "gym_bike_celebrate";
	GYMB_ANIMATIONS [2]   = "gym_bike_fast";
	GYMB_ANIMATIONS [3]   = "gym_bike_faster";
	GYMB_ANIMATIONS [4]   = "gym_bike_getoff";
	GYMB_ANIMATIONS [5]   = "gym_bike_geton";
	GYMB_ANIMATIONS [6]   = "gym_bike_pedal";
	GYMB_ANIMATIONS [7]   = "gym_bike_slow";
	GYMB_ANIMATIONS [8]   = "gym_bike_still";
	GYMB_ANIMATIONS [9]   = "gym_jog_falloff";
	GYMB_ANIMATIONS [10]   = "gym_shadowbox";
	GYMB_ANIMATIONS [11]   = "gym_tread_celebrate";
	GYMB_ANIMATIONS [12]   = "gym_tread_falloff";
	GYMB_ANIMATIONS [13]   = "gym_tread_getoff";
	GYMB_ANIMATIONS [14]   = "gym_tread_geton";
	GYMB_ANIMATIONS [15]   = "gym_tread_jog";
	GYMB_ANIMATIONS [16]   = "gym_tread_sprint";
	GYMB_ANIMATIONS [17]   = "gym_tread_tired";
	GYMB_ANIMATIONS [18]   = "gym_tread_walk";
	GYMB_ANIMATIONS [19]   = "gym_walk_falloff";
	GYMB_ANIMATIONS [20]   = "Pedals_fast";
	GYMB_ANIMATIONS [21]   = "Pedals_med";
	GYMB_ANIMATIONS [22]   = "Pedals_slow";
	GYMB_ANIMATIONS [23]   = "Pedals_still";
	// HAIR - 12
	HAIR_ANIMATIONS [0]   = "BRB_Beard_01";
	HAIR_ANIMATIONS [1]   = "BRB_Buy";
	HAIR_ANIMATIONS [2]   = "BRB_Cut";
	HAIR_ANIMATIONS [3]   = "BRB_Cut_In";
	HAIR_ANIMATIONS [4]   = "BRB_Cut_Out";
	HAIR_ANIMATIONS [5]   = "BRB_Hair_01";
	HAIR_ANIMATIONS [6]   = "BRB_Hair_02";
	HAIR_ANIMATIONS [7]   = "BRB_In";
	HAIR_ANIMATIONS [8]   = "BRB_Loop";
	HAIR_ANIMATIONS [9]   = "BRB_Out";
	HAIR_ANIMATIONS [10]   = "BRB_Sit_In";
	HAIR_ANIMATIONS [11]   = "BRB_Sit_Loop";
	HAIR_ANIMATIONS [12]   = "BRB_Sit_Out";
	// HEIST - 9
	HEIST_ANIMATIONS [0]   = "CAS_G2_GasKO";
	HEIST_ANIMATIONS [1]   = "swt_wllpk_L";
	HEIST_ANIMATIONS [2]   = "swt_wllpk_L_back";
	HEIST_ANIMATIONS [3]   = "swt_wllpk_R";
	HEIST_ANIMATIONS [4]   = "swt_wllpk_R_back";
	HEIST_ANIMATIONS [5]   = "swt_wllshoot_in_L";
	HEIST_ANIMATIONS [6]   = "swt_wllshoot_in_R";
	HEIST_ANIMATIONS [7]   = "swt_wllshoot_out_L";
	HEIST_ANIMATIONS [8]   = "swt_wllshoot_out_R";
	HEIST_ANIMATIONS [9]   = "Use_SwipeCard";
	// HOUSE - 9
	HOUSE_ANIMATIONS [0]   = "BED_In_L";
	HOUSE_ANIMATIONS [1]   = "BED_In_R";
	HOUSE_ANIMATIONS [2]   = "BED_Loop_L";
	HOUSE_ANIMATIONS [3]   = "BED_Loop_R";
	HOUSE_ANIMATIONS [4]   = "BED_Out_L";
	HOUSE_ANIMATIONS [5]   = "BED_Out_R";
	HOUSE_ANIMATIONS [6]   = "LOU_In";
	HOUSE_ANIMATIONS [7]   = "LOU_Loop";
	HOUSE_ANIMATIONS [8]   = "LOU_Out";
	HOUSE_ANIMATIONS [9]   = "wash_up";
	// OFFICE - 9
	OFFICE_ANIMATIONS [0]   = "FF_Dam_Fwd";
	OFFICE_ANIMATIONS [1]   = "OFF_Sit_2Idle_180";
	OFFICE_ANIMATIONS [2]   = "OFF_Sit_Bored_Loop";
	OFFICE_ANIMATIONS [3]   = "OFF_Sit_Crash";
	OFFICE_ANIMATIONS [4]   = "OFF_Sit_Drink";
	OFFICE_ANIMATIONS [5]   = "OFF_Sit_Idle_Loop";
	OFFICE_ANIMATIONS [6]   = "OFF_Sit_In";
	OFFICE_ANIMATIONS [7]   = "OFF_Sit_Read";
	OFFICE_ANIMATIONS [8]   = "OFF_Sit_Type_Loop";
	OFFICE_ANIMATIONS [9]   = "OFF_Sit_Watch";
	// INTSHOP - 7
	INTSHOP_ANIMATIONS [0]   = "shop_cashier";
	INTSHOP_ANIMATIONS [1]   = "shop_in";
	INTSHOP_ANIMATIONS [2]   = "shop_lookA";
	INTSHOP_ANIMATIONS [3]   = "shop_lookB";
	INTSHOP_ANIMATIONS [4]   = "shop_loop";
	INTSHOP_ANIMATIONS [5]   = "shop_out";
	INTSHOP_ANIMATIONS [6]   = "shop_pay";
	INTSHOP_ANIMATIONS [7]   = "shop_shelf";
	// BUISNESS - 3
	BUISNESS_ANIMATIONS [0]   = "girl_01";
	BUISNESS_ANIMATIONS [1]   = "girl_02";
	BUISNESS_ANIMATIONS [2]   = "player_01";
	BUISNESS_ANIMATIONS [3]   = "smoke_01";
	// KART - 3
	KART_ANIMATIONS [0]   = "KART_getin_LHS";
	KART_ANIMATIONS [1]   = "KART_getin_RHS";
	KART_ANIMATIONS [2]   = "KART_getout_LHS";
	KART_ANIMATIONS [3]   = "KART_getout_RHS";
	// KISSING - 14
	KISSING_ANIMATIONS [0]   = "BD_GF_Wave";
	KISSING_ANIMATIONS [1]   = "gfwave2";
	KISSING_ANIMATIONS [2]   = "GF_CarArgue_01";
	KISSING_ANIMATIONS [3]   = "GF_CarArgue_02";
	KISSING_ANIMATIONS [4]   = "GF_CarSpot";
	KISSING_ANIMATIONS [5]   = "GF_StreetArgue_01";
	KISSING_ANIMATIONS [6]   = "GF_StreetArgue_02";
	KISSING_ANIMATIONS [7]   = "gift_get";
	KISSING_ANIMATIONS [8]   = "gift_give";
	KISSING_ANIMATIONS [9]   = "Grlfrd_Kiss_01";
	KISSING_ANIMATIONS [10]   = "Grlfrd_Kiss_02";
	KISSING_ANIMATIONS [11]   = "Grlfrd_Kiss_03";
	KISSING_ANIMATIONS [12]   = "Playa_Kiss_01";
	KISSING_ANIMATIONS [13]   = "Playa_Kiss_02";
	KISSING_ANIMATIONS [14]   = "Playa_Kiss_03";
	// KNIFE - 15
	KNIFE_ANIMATIONS [0]   = "KILL_Knife_Ped_Damage";
	KNIFE_ANIMATIONS [1]   = "KILL_Knife_Ped_Die";
	KNIFE_ANIMATIONS [2]   = "KILL_Knife_Player";
	KNIFE_ANIMATIONS [3]   = "KILL_Partial";
	KNIFE_ANIMATIONS [4]   = "knife_1";
	KNIFE_ANIMATIONS [5]   = "knife_2";
	KNIFE_ANIMATIONS [6]   = "knife_3";
	KNIFE_ANIMATIONS [7]   = "Knife_4";
	KNIFE_ANIMATIONS [8]   = "knife_block";
	KNIFE_ANIMATIONS [9]   = "Knife_G";
	KNIFE_ANIMATIONS [10]   = "knife_hit_1";
	KNIFE_ANIMATIONS [11]   = "knife_hit_2";
	KNIFE_ANIMATIONS [12]   = "knife_hit_3";
	KNIFE_ANIMATIONS [13]   = "knife_IDLE";
	KNIFE_ANIMATIONS [14]   = "knife_part";
	KNIFE_ANIMATIONS [15]   = "WEAPON_knifeidle";
	// LAPDAN - 1
	LAPDAN1_ANIMATIONS [0]   = "LAPDAN_D";
	LAPDAN1_ANIMATIONS [1]   = "LAPDAN_P";
	// LAPDAN - 2
	LAPDAN2_ANIMATIONS [0]   = "LAPDAN_D";
	LAPDAN2_ANIMATIONS [1]   = "LAPDAN_P";
	// LAPDAN - 3
	LAPDAN3_ANIMATIONS [0]   = "LAPDAN_D";
	LAPDAN3_ANIMATIONS [1]   = "LAPDAN_P";
	// LOWRIDER - 38
	LOWRIDER_ANIMATIONS [0]   = "F_smklean_loop";
	LOWRIDER_ANIMATIONS [1]   = "lrgirl_bdbnce";
	LOWRIDER_ANIMATIONS [2]   = "lrgirl_hair";
	LOWRIDER_ANIMATIONS [3]   = "lrgirl_hurry";
	LOWRIDER_ANIMATIONS [4]   = "lrgirl_idleloop";
	LOWRIDER_ANIMATIONS [5]   = "lrgirl_idle_to_l0";
	LOWRIDER_ANIMATIONS [6]   = "lrgirl_l0_bnce";
	LOWRIDER_ANIMATIONS [7]   = "lrgirl_l0_loop";
	LOWRIDER_ANIMATIONS [8]   = "lrgirl_l0_to_l1";
	LOWRIDER_ANIMATIONS [9]   = "lrgirl_l12_to_l0";
	LOWRIDER_ANIMATIONS [10]   = "lrgirl_l1_bnce";
	LOWRIDER_ANIMATIONS [11]   = "lrgirl_l1_loop";
	LOWRIDER_ANIMATIONS [12]   = "lrgirl_l1_to_l2";
	LOWRIDER_ANIMATIONS [13]   = "lrgirl_l2_bnce";
	LOWRIDER_ANIMATIONS [14]   = "lrgirl_l2_loop";
	LOWRIDER_ANIMATIONS [15]   = "lrgirl_l2_to_l3";
	LOWRIDER_ANIMATIONS [16]   = "lrgirl_l345_to_l1";
	LOWRIDER_ANIMATIONS [17]   = "lrgirl_l3_bnce";
	LOWRIDER_ANIMATIONS [18]   = "lrgirl_l3_loop";
	LOWRIDER_ANIMATIONS [19]   = "lrgirl_l3_to_l4";
	LOWRIDER_ANIMATIONS [20]   = "lrgirl_l4_bnce";
	LOWRIDER_ANIMATIONS [21]   = "lrgirl_l4_loop";
	LOWRIDER_ANIMATIONS [22]   = "lrgirl_l4_to_l5";
	LOWRIDER_ANIMATIONS [23]   = "lrgirl_l5_bnce";
	LOWRIDER_ANIMATIONS [24]   = "lrgirl_l5_loop";
	LOWRIDER_ANIMATIONS [25]   = "M_smklean_loop";
	LOWRIDER_ANIMATIONS [26]   = "M_smkstnd_loop";
	LOWRIDER_ANIMATIONS [27]   = "prtial_gngtlkB";
	LOWRIDER_ANIMATIONS [28]   = "prtial_gngtlkC";
	LOWRIDER_ANIMATIONS [29]   = "prtial_gngtlkD";
	LOWRIDER_ANIMATIONS [30]   = "prtial_gngtlkE";
	LOWRIDER_ANIMATIONS [31]   = "prtial_gngtlkF";
	LOWRIDER_ANIMATIONS [32]   = "prtial_gngtlkG";
	LOWRIDER_ANIMATIONS [33]   = "prtial_gngtlkH";
	LOWRIDER_ANIMATIONS [34]   = "RAP_A_Loop";
	LOWRIDER_ANIMATIONS [35]   = "RAP_B_Loop";
	LOWRIDER_ANIMATIONS [36]   = "RAP_C_Loop";
	LOWRIDER_ANIMATIONS [37]   = "Sit_relaxed";
	LOWRIDER_ANIMATIONS [38]   = "Tap_hand";
	// CHASE - 24
	CHASE_ANIMATIONS [0]   = "Carhit_Hangon";
	CHASE_ANIMATIONS [1]   = "Carhit_Tumble";
	CHASE_ANIMATIONS [2]   = "donutdrop";
	CHASE_ANIMATIONS [3]   = "Fen_Choppa_L1";
	CHASE_ANIMATIONS [4]   = "Fen_Choppa_L2";
	CHASE_ANIMATIONS [5]   = "Fen_Choppa_L3";
	CHASE_ANIMATIONS [6]   = "Fen_Choppa_R1";
	CHASE_ANIMATIONS [7]   = "Fen_Choppa_R2";
	CHASE_ANIMATIONS [8]   = "Fen_Choppa_R3";
	CHASE_ANIMATIONS [9]   = "Hangon_Stun_loop";
	CHASE_ANIMATIONS [10]   = "Hangon_Stun_Turn";
	CHASE_ANIMATIONS [11]   = "MD_BIKE_2_HANG";
	CHASE_ANIMATIONS [12]   = "MD_BIKE_Jmp_BL";
	CHASE_ANIMATIONS [13]   = "MD_BIKE_Jmp_F";
	CHASE_ANIMATIONS [14]   = "MD_BIKE_Lnd_BL";
	CHASE_ANIMATIONS [15]   = "MD_BIKE_Lnd_Die_BL";
	CHASE_ANIMATIONS [16]   = "MD_BIKE_Lnd_Die_F";
	CHASE_ANIMATIONS [17]   = "MD_BIKE_Lnd_F";
	CHASE_ANIMATIONS [18]   = "MD_BIKE_Lnd_Roll";
	CHASE_ANIMATIONS [19]   = "MD_BIKE_Lnd_Roll_F";
	CHASE_ANIMATIONS [20]   = "MD_BIKE_Punch";
	CHASE_ANIMATIONS [21]   = "MD_BIKE_Punch_F";
	CHASE_ANIMATIONS [22]   = "MD_BIKE_Shot_F";
	CHASE_ANIMATIONS [23]   = "MD_HANG_Lnd_Roll";
	CHASE_ANIMATIONS [24]   = "MD_HANG_Loop";
	// END - 7
	END_ANIMATIONS [0]   = "END_SC1_PLY";
	END_ANIMATIONS [1]   = "END_SC1_RYD";
	END_ANIMATIONS [2]   = "END_SC1_SMO";
	END_ANIMATIONS [3]   = "END_SC1_SWE";
	END_ANIMATIONS [4]   = "END_SC2_PLY";
	END_ANIMATIONS [5]   = "END_SC2_RYD";
	END_ANIMATIONS [6]   = "END_SC2_SMO";
	END_ANIMATIONS [7]   = "END_SC2_SWE";
	// MEDIC - 0
	MEDIC_ANIMATIONS [0]   = "CPR";
	// MISC - 40
	MISC_ANIMATIONS [0]   = "bitchslap";
	MISC_ANIMATIONS [1]   = "BMX_celebrate";
	MISC_ANIMATIONS [2]   = "BMX_comeon";
	MISC_ANIMATIONS [3]   = "bmx_idleloop_01";
	MISC_ANIMATIONS [4]   = "bmx_idleloop_02";
	MISC_ANIMATIONS [5]   = "bmx_talkleft_in";
	MISC_ANIMATIONS [6]   = "bmx_talkleft_loop";
	MISC_ANIMATIONS [7]   = "bmx_talkleft_out";
	MISC_ANIMATIONS [8]   = "bmx_talkright_in";
	MISC_ANIMATIONS [9]   = "bmx_talkright_loop";
	MISC_ANIMATIONS [10]   = "bmx_talkright_out";
	MISC_ANIMATIONS [11]   = "bng_wndw";
	MISC_ANIMATIONS [12]   = "bng_wndw_02";
	MISC_ANIMATIONS [13]   = "Case_pickup";
	MISC_ANIMATIONS [14]   = "door_jet";
	MISC_ANIMATIONS [15]   = "GRAB_L";
	MISC_ANIMATIONS [16]   = "GRAB_R";
	MISC_ANIMATIONS [17]   = "Hiker_Pose";
	MISC_ANIMATIONS [18]   = "Hiker_Pose_L";
	MISC_ANIMATIONS [19]   = "Idle_Chat_02";
	MISC_ANIMATIONS [20]   = "KAT_Throw_K";
	MISC_ANIMATIONS [21]   = "KAT_Throw_O";
	MISC_ANIMATIONS [22]   = "KAT_Throw_P";
	MISC_ANIMATIONS [23]   = "PASS_Rifle_O";
	MISC_ANIMATIONS [24]   = "PASS_Rifle_Ped";
	MISC_ANIMATIONS [25]   = "PASS_Rifle_Ply";
	MISC_ANIMATIONS [26]   = "pickup_box";
	MISC_ANIMATIONS [27]   = "Plane_door";
	MISC_ANIMATIONS [28]   = "Plane_exit";
	MISC_ANIMATIONS [29]   = "Plane_hijack";
	MISC_ANIMATIONS [30]   = "Plunger_01";
	MISC_ANIMATIONS [31]   = "Plyrlean_loop";
	MISC_ANIMATIONS [32]   = "plyr_shkhead";
	MISC_ANIMATIONS [33]   = "Run_Dive";
	MISC_ANIMATIONS [34]   = "Scratchballs_01";
	MISC_ANIMATIONS [35]   = "SEAT_LR";
	MISC_ANIMATIONS [36]   = "Seat_talk_01";
	MISC_ANIMATIONS [37]   = "Seat_talk_02";
	MISC_ANIMATIONS [38]   = "SEAT_watch";
	MISC_ANIMATIONS [39]   = "smalplane_door";
	MISC_ANIMATIONS [40]   = "smlplane_door";
	// MTB - 17
	MTB_ANIMATIONS [0]   = "MTB_back";
	MTB_ANIMATIONS [1]   = "MTB_bunnyhop";
	MTB_ANIMATIONS [2]   = "MTB_drivebyFT";
	MTB_ANIMATIONS [3]   = "MTB_driveby_LHS";
	MTB_ANIMATIONS [4]   = "MTB_driveby_RHS";
	MTB_ANIMATIONS [5]   = "MTB_fwd";
	MTB_ANIMATIONS [6]   = "MTB_getoffBACK";
	MTB_ANIMATIONS [7]   = "MTB_getoffLHS";
	MTB_ANIMATIONS [8]   = "MTB_getoffRHS";
	MTB_ANIMATIONS [9]   = "MTB_jumponL";
	MTB_ANIMATIONS [10]   = "MTB_jumponR";
	MTB_ANIMATIONS [11]   = "MTB_Left";
	MTB_ANIMATIONS [12]   = "MTB_pedal";
	MTB_ANIMATIONS [13]   = "MTB_pushes";
	MTB_ANIMATIONS [14]   = "MTB_Ride";
	MTB_ANIMATIONS [15]   = "MTB_Right";
	MTB_ANIMATIONS [16]   = "MTB_sprint";
	MTB_ANIMATIONS [17]   = "MTB_still";
/*	// MUSCULAR - 16
	MUSCULAR_ANIMATIONS [0]   = "MscleWalkst_armed";
	MUSCULAR_ANIMATIONS [1]   = "MscleWalkst_Csaw";
	MUSCULAR_ANIMATIONS [2]   = "Mscle_rckt_run";
	MUSCULAR_ANIMATIONS [3]   = "Mscle_rckt_walkst";
	MUSCULAR_ANIMATIONS [4]   = "Mscle_run_Csaw";
	MUSCULAR_ANIMATIONS [5]   = "MuscleIdle";
	MUSCULAR_ANIMATIONS [6]   = "MuscleIdle_armed";
	MUSCULAR_ANIMATIONS [7]   = "MuscleIdle_Csaw";
	MUSCULAR_ANIMATIONS [8]   = "MuscleIdle_rocket";
	MUSCULAR_ANIMATIONS [9]   = "MuscleRun";
	MUSCULAR_ANIMATIONS [10]   = "MuscleRun_armed";
	MUSCULAR_ANIMATIONS [11]   = "MuscleSprint";
	MUSCULAR_ANIMATIONS [12]   = "MuscleWalk";
	MUSCULAR_ANIMATIONS [13]   = "MuscleWalkstart";
	MUSCULAR_ANIMATIONS [14]   = "MuscleWalk_armed";
	MUSCULAR_ANIMATIONS [15]   = "Musclewalk_Csaw";
	MUSCULAR_ANIMATIONS [16]   = "Musclewalk_rocket";*/
/*	// NEVADA - 1
	NEVADA_ANIMATIONS [0]   = "NEVADA_getin";
	NEVADA_ANIMATIONS [1]   = "NEVADA_getout";*/
	// LOOKERS - 28
	LOOKERS_ANIMATIONS [0]   = "lkaround_in";
	LOOKERS_ANIMATIONS [1]   = "lkaround_loop";
	LOOKERS_ANIMATIONS [2]   = "lkaround_out";
	LOOKERS_ANIMATIONS [3]   = "lkup_in";
	LOOKERS_ANIMATIONS [4]   = "lkup_loop";
	LOOKERS_ANIMATIONS [5]   = "lkup_out";
	LOOKERS_ANIMATIONS [6]   = "lkup_point";
	LOOKERS_ANIMATIONS [7]   = "panic_cower";
	LOOKERS_ANIMATIONS [8]   = "panic_hide";
	LOOKERS_ANIMATIONS [9]   = "panic_in";
	LOOKERS_ANIMATIONS [10]   = "panic_loop";
	LOOKERS_ANIMATIONS [11]   = "panic_out";
	LOOKERS_ANIMATIONS [12]   = "panic_point";
	LOOKERS_ANIMATIONS [13]   = "panic_shout";
	LOOKERS_ANIMATIONS [14]   = "Pointup_in";
	LOOKERS_ANIMATIONS [15]   = "Pointup_loop";
	LOOKERS_ANIMATIONS [16]   = "Pointup_out";
	LOOKERS_ANIMATIONS [17]   = "Pointup_shout";
	LOOKERS_ANIMATIONS [18]   = "point_in";
	LOOKERS_ANIMATIONS [19]   = "point_loop";
	LOOKERS_ANIMATIONS [20]   = "point_out";
	LOOKERS_ANIMATIONS [21]   = "shout_01";
	LOOKERS_ANIMATIONS [22]   = "shout_02";
	LOOKERS_ANIMATIONS [23]   = "shout_in";
	LOOKERS_ANIMATIONS [24]   = "shout_loop";
	LOOKERS_ANIMATIONS [25]   = "shout_out";
	LOOKERS_ANIMATIONS [26]   = "wave_in";
	LOOKERS_ANIMATIONS [27]   = "wave_loop";
	LOOKERS_ANIMATIONS [28]   = "wave_out";
	// OTB - 10
	OTB_ANIMATIONS [0]   = "betslp_in";
	OTB_ANIMATIONS [1]   = "betslp_lkabt";
	OTB_ANIMATIONS [2]   = "betslp_loop";
	OTB_ANIMATIONS [3]   = "betslp_out";
	OTB_ANIMATIONS [4]   = "betslp_tnk";
	OTB_ANIMATIONS [5]   = "wtchrace_cmon";
	OTB_ANIMATIONS [6]   = "wtchrace_in";
	OTB_ANIMATIONS [7]   = "wtchrace_loop";
	OTB_ANIMATIONS [8]   = "wtchrace_lose";
	OTB_ANIMATIONS [9]   = "wtchrace_out";
	OTB_ANIMATIONS [10]   = "wtchrace_win";
	// PARA - 21
	PARA_ANIMATIONS [0]   = "FALL_skyDive";
	PARA_ANIMATIONS [1]   = "FALL_SkyDive_Accel";
	PARA_ANIMATIONS [2]   = "FALL_skyDive_DIE";
	PARA_ANIMATIONS [3]   = "FALL_SkyDive_L";
	PARA_ANIMATIONS [4]   = "FALL_SkyDive_R";
	PARA_ANIMATIONS [5]   = "PARA_decel";
	PARA_ANIMATIONS [6]   = "PARA_decel_O";
	PARA_ANIMATIONS [7]   = "PARA_float";
	PARA_ANIMATIONS [8]   = "PARA_float_O";
	PARA_ANIMATIONS [9]   = "PARA_Land";
	PARA_ANIMATIONS [10]   = "PARA_Land_O";
	PARA_ANIMATIONS [11]   = "PARA_Land_Water";
	PARA_ANIMATIONS [12]   = "PARA_Land_Water_O";
	PARA_ANIMATIONS [13]   = "PARA_open";
	PARA_ANIMATIONS [14]   = "PARA_open_O";
	PARA_ANIMATIONS [15]   = "PARA_Rip_Land_O";
	PARA_ANIMATIONS [16]   = "PARA_Rip_Loop_O";
	PARA_ANIMATIONS [17]   = "PARA_Rip_O";
	PARA_ANIMATIONS [18]   = "PARA_steerL";
	PARA_ANIMATIONS [19]   = "PARA_steerL_O";
	PARA_ANIMATIONS [20]   = "PARA_steerR";
	PARA_ANIMATIONS [21]   = "PARA_steerR_O";
	// PARK - 2
	PARK_ANIMATIONS [0]   = "Tai_Chi_in";
	PARK_ANIMATIONS [1]   = "Tai_Chi_Loop";
	PARK_ANIMATIONS [2]   = "Tai_Chi_Out";
	// PAUL - 11
	PAUL_ANIMATIONS [0]   = "Piss_in";
	PAUL_ANIMATIONS [1]   = "Piss_loop";
	PAUL_ANIMATIONS [2]   = "Piss_out";
	PAUL_ANIMATIONS [3]   = "PnM_Argue1_A";
	PAUL_ANIMATIONS [4]   = "PnM_Argue1_B";
	PAUL_ANIMATIONS [5]   = "PnM_Argue2_A";
	PAUL_ANIMATIONS [6]   = "PnM_Argue2_B";
	PAUL_ANIMATIONS [7]   = "PnM_Loop_A";
	PAUL_ANIMATIONS [8]   = "PnM_Loop_B";
	PAUL_ANIMATIONS [9]   = "wank_in";
	PAUL_ANIMATIONS [10]   = "wank_loop";
	PAUL_ANIMATIONS [11]   = "wank_out";
	// PLAYER - 3
	PLAYER_ANIMATIONS [0]   = "Plyr_DrivebyBwd";
	PLAYER_ANIMATIONS [1]   = "Plyr_DrivebyFwd";
	PLAYER_ANIMATIONS [2]   = "Plyr_DrivebyLHS";
	PLAYER_ANIMATIONS [3]   = "Plyr_DrivebyRHS";
	// PLAYID - 4
	PLAYID_ANIMATIONS [0]   = "shift";
	PLAYID_ANIMATIONS [1]   = "shldr";
	PLAYID_ANIMATIONS [2]   = "stretch";
	PLAYID_ANIMATIONS [3]   = "strleg";
	PLAYID_ANIMATIONS [4]   = "time";
	// POLICE - 9
	POLICE_ANIMATIONS [0]   = "CopTraf_Away";
	POLICE_ANIMATIONS [1]   = "CopTraf_Come";
	POLICE_ANIMATIONS [2]   = "CopTraf_Left";
	POLICE_ANIMATIONS [3]   = "CopTraf_Stop";
	POLICE_ANIMATIONS [4]   = "COP_getoutcar_LHS";
	POLICE_ANIMATIONS [5]   = "Cop_move_FWD";
	POLICE_ANIMATIONS [6]   = "crm_drgbst_01";
	POLICE_ANIMATIONS [7]   = "Door_Kick";
	POLICE_ANIMATIONS [8]   = "plc_drgbst_01";
	POLICE_ANIMATIONS [9]   = "plc_drgbst_02";
	// POOL - 20
	POOL_ANIMATIONS [0]   = "POOL_ChalkCue";
	POOL_ANIMATIONS [1]   = "POOL_Idle_Stance";
	POOL_ANIMATIONS [2]   = "POOL_Long_Shot";
	POOL_ANIMATIONS [3]   = "POOL_Long_Shot_O";
	POOL_ANIMATIONS [4]   = "POOL_Long_Start";
	POOL_ANIMATIONS [5]   = "POOL_Long_Start_O";
	POOL_ANIMATIONS [6]   = "POOL_Med_Shot";
	POOL_ANIMATIONS [7]   = "POOL_Med_Shot_O";
	POOL_ANIMATIONS [8]   = "POOL_Med_Start";
	POOL_ANIMATIONS [9]   = "POOL_Med_Start_O";
	POOL_ANIMATIONS [10]   = "POOL_Place_White";
	POOL_ANIMATIONS [11]   = "POOL_Short_Shot";
	POOL_ANIMATIONS [12]   = "POOL_Short_Shot_O";
	POOL_ANIMATIONS [13]   = "POOL_Short_Start";
	POOL_ANIMATIONS [14]   = "POOL_Short_Start_O";
	POOL_ANIMATIONS [15]   = "POOL_Walk";
	POOL_ANIMATIONS [16]   = "POOL_Walk_Start";
	POOL_ANIMATIONS [17]   = "POOL_XLong_Shot";
	POOL_ANIMATIONS [18]   = "POOL_XLong_Shot_O";
	POOL_ANIMATIONS [19]   = "POOL_XLong_Start";
	POOL_ANIMATIONS [20]   = "POOL_XLong_Start_O";
	// POOR - 1
	POOR_ANIMATIONS [0]   = "WINWASH_Start";
	POOR_ANIMATIONS [1]   = "WINWASH_Wash2Beg";
	// PYTHON - 4
	PYTHON_ANIMATIONS [0]   = "python_crouchfire";
	PYTHON_ANIMATIONS [1]   = "python_crouchreload";
	PYTHON_ANIMATIONS [2]   = "python_fire";
	PYTHON_ANIMATIONS [3]   = "python_fire_poor";
	PYTHON_ANIMATIONS [4]   = "python_reload ";
	// QUAD - 16
	QUAD_ANIMATIONS [0]   = "QUAD_back";
	QUAD_ANIMATIONS [1]   = "QUAD_driveby_FT";
	QUAD_ANIMATIONS [2]   = "QUAD_driveby_LHS";
	QUAD_ANIMATIONS [3]   = "QUAD_driveby_RHS";
	QUAD_ANIMATIONS [4]   = "QUAD_FWD";
	QUAD_ANIMATIONS [5]   = "QUAD_getoff_B";
	QUAD_ANIMATIONS [6]   = "QUAD_getoff_LHS";
	QUAD_ANIMATIONS [7]   = "QUAD_getoff_RHS";
	QUAD_ANIMATIONS [8]   = "QUAD_geton_LHS";
	QUAD_ANIMATIONS [9]   = "QUAD_geton_RHS";
	QUAD_ANIMATIONS [10]   = "QUAD_hit";
	QUAD_ANIMATIONS [11]   = "QUAD_kick";
	QUAD_ANIMATIONS [12]   = "QUAD_Left";
	QUAD_ANIMATIONS [13]   = "QUAD_passenger";
	QUAD_ANIMATIONS [14]   = "QUAD_reverse";
	QUAD_ANIMATIONS [15]   = "QUAD_ride";
	QUAD_ANIMATIONS [16]   = "QUAD_Right";
	// QUADD - 3
	QUADD_ANIMATIONS [0]   = "Pass_Driveby_BWD";
	QUADD_ANIMATIONS [1]   = "Pass_Driveby_FWD";
	QUADD_ANIMATIONS [2]   = "Pass_Driveby_LHS";
	QUADD_ANIMATIONS [3]   = "Pass_Driveby_RHS";
	// RAP - 7
	RAP_ANIMATIONS [0]   = "Laugh_01";
	RAP_ANIMATIONS [1]   = "RAP_A_IN";
	RAP_ANIMATIONS [2]   = "RAP_A_Loop";
	RAP_ANIMATIONS [3]   = "RAP_A_OUT";
	RAP_ANIMATIONS [4]   = "RAP_B_IN";
	RAP_ANIMATIONS [5]   = "RAP_B_Loop";
	RAP_ANIMATIONS [6]   = "RAP_B_OUT";
	RAP_ANIMATIONS [7]   = "RAP_C_Loop";
	// RIFLE - 4
	RIFLE_ANIMATIONS [0]   = "RIFLE_crouchfire";
	RIFLE_ANIMATIONS [1]   = "RIFLE_crouchload";
	RIFLE_ANIMATIONS [2]   = "RIFLE_fire";
	RIFLE_ANIMATIONS [3]   = "RIFLE_fire_poor";
	RIFLE_ANIMATIONS [4]   = "RIFLE_load";
	// RIOT - 6
	RIOT_ANIMATIONS [0]   = "RIOT_ANGRY";
	RIOT_ANIMATIONS [1]   = "RIOT_ANGRY_B";
	RIOT_ANIMATIONS [2]   = "RIOT_challenge";
	RIOT_ANIMATIONS [3]   = "RIOT_CHANT";
	RIOT_ANIMATIONS [4]   = "RIOT_FUKU";
	RIOT_ANIMATIONS [5]   = "RIOT_PUNCHES";
	RIOT_ANIMATIONS [6]   = "RIOT_shout";
	// ROB - 4
	ROB_ANIMATIONS [0]   = "CAT_Safe_End";
	ROB_ANIMATIONS [1]   = "CAT_Safe_Open";
	ROB_ANIMATIONS [2]   = "CAT_Safe_Open_O";
	ROB_ANIMATIONS [3]   = "CAT_Safe_Rob";
	ROB_ANIMATIONS [4]   = "SHP_HandsUp_Scr";
	// ROCKET - 4
	ROCKET_ANIMATIONS [0]   = "idle_rocket";
	ROCKET_ANIMATIONS [1]   = "RocketFire";
	ROCKET_ANIMATIONS [2]   = "run_rocket";
	ROCKET_ANIMATIONS [3]   = "walk_rocket";
	ROCKET_ANIMATIONS [4]   = "WALK_start_rocket";
	// RUSTLER - 4
	RUSTLER_ANIMATIONS [0]   = "Plane_align_LHS";
	RUSTLER_ANIMATIONS [1]   = "Plane_close";
	RUSTLER_ANIMATIONS [2]   = "Plane_getin";
	RUSTLER_ANIMATIONS [3]   = "Plane_getout";
	RUSTLER_ANIMATIONS [4]   = "Plane_open";
	// RYDER - 15
	RYDER_ANIMATIONS [0]   = "RYD_Beckon_01";
	RYDER_ANIMATIONS [1]   = "RYD_Beckon_02";
	RYDER_ANIMATIONS [2]   = "RYD_Beckon_03";
	RYDER_ANIMATIONS [3]   = "RYD_Die_PT1";
	RYDER_ANIMATIONS [4]   = "RYD_Die_PT2";
	RYDER_ANIMATIONS [5]   = "Van_Crate_L";
	RYDER_ANIMATIONS [6]   = "Van_Crate_R";
	RYDER_ANIMATIONS [7]   = "Van_Fall_L";
	RYDER_ANIMATIONS [8]   = "Van_Fall_R";
	RYDER_ANIMATIONS [9]   = "Van_Lean_L";
	RYDER_ANIMATIONS [10]   = "Van_Lean_R";
	RYDER_ANIMATIONS [11]   = "VAN_PickUp_E";
	RYDER_ANIMATIONS [12]   = "VAN_PickUp_S";
	RYDER_ANIMATIONS [13]   = "Van_Stand";
	RYDER_ANIMATIONS [14]   = "Van_Stand_Crate";
	RYDER_ANIMATIONS [15]   = "Van_Throw";
	// SCRAT - 11
	SCRAT_ANIMATIONS [0]   = "scdldlp";
	SCRAT_ANIMATIONS [1]   = "scdlulp";
	SCRAT_ANIMATIONS [2]   = "scdrdlp";
	SCRAT_ANIMATIONS [3]   = "scdrulp";
	SCRAT_ANIMATIONS [4]   = "sclng_l";
	SCRAT_ANIMATIONS [5]   = "sclng_r";
	SCRAT_ANIMATIONS [6]   = "scmid_l";
	SCRAT_ANIMATIONS [7]   = "scmid_r";
	SCRAT_ANIMATIONS [8]   = "scshrtl";
	SCRAT_ANIMATIONS [9]   = "scshrtr";
	SCRAT_ANIMATIONS [10]   = "sc_ltor";
	SCRAT_ANIMATIONS [11]   = "sc_rtol";
	// SHAMAL - 4
	SHAMAL_ANIMATIONS [0]   = "SHAMAL_align";
	SHAMAL_ANIMATIONS [1]   = "SHAMAL_getin_LHS";
	SHAMAL_ANIMATIONS [2]   = "SHAMAL_getout_LHS";
	SHAMAL_ANIMATIONS [3]   = "SHAMAL_open";
	// SHOP - 24
	SHOP_ANIMATIONS [0]   = "ROB_2Idle";
	SHOP_ANIMATIONS [1]   = "ROB_Loop";
	SHOP_ANIMATIONS [2]   = "ROB_Loop_Threat";
	SHOP_ANIMATIONS [3]   = "ROB_Shifty";
	SHOP_ANIMATIONS [4]   = "ROB_StickUp_In";
	SHOP_ANIMATIONS [5]   = "SHP_Duck";
	SHOP_ANIMATIONS [6]   = "SHP_Duck_Aim";
	SHOP_ANIMATIONS [7]   = "SHP_Duck_Fire";
	SHOP_ANIMATIONS [8]   = "SHP_Gun_Aim";
	SHOP_ANIMATIONS [9]   = "SHP_Gun_Duck";
	SHOP_ANIMATIONS [10]   = "SHP_Gun_Fire";
	SHOP_ANIMATIONS [11]   = "SHP_Gun_Grab";
	SHOP_ANIMATIONS [12]   = "SHP_Gun_Threat";
	SHOP_ANIMATIONS [13]   = "SHP_HandsUp_Scr";
	SHOP_ANIMATIONS [14]   = "SHP_Jump_Glide";
	SHOP_ANIMATIONS [15]   = "SHP_Jump_Land";
	SHOP_ANIMATIONS [16]   = "SHP_Jump_Launch";
	SHOP_ANIMATIONS [17]   = "SHP_Rob_GiveCash";
	SHOP_ANIMATIONS [18]   = "SHP_Rob_HandsUp";
	SHOP_ANIMATIONS [19]   = "SHP_Rob_React";
	SHOP_ANIMATIONS [20]   = "SHP_Serve_End";
	SHOP_ANIMATIONS [21]   = "SHP_Serve_Idle";
	SHOP_ANIMATIONS [22]   = "SHP_Serve_Loop";
	SHOP_ANIMATIONS [23]   = "SHP_Serve_Start";
	SHOP_ANIMATIONS [24]   = "Smoke_RYD";
	// SHOTGUN - 2
	SHOTGUN_ANIMATIONS [0]   = "shotgun_crouchfire";
	SHOTGUN_ANIMATIONS [1]   = "shotgun_fire";
	SHOTGUN_ANIMATIONS [2]   = "shotgun_fire_poor";
	// SILENCED - 3
	SILENCED_ANIMATIONS [0]   = "CrouchReload";
	SILENCED_ANIMATIONS [1]   = "SilenceCrouchfire";
	SILENCED_ANIMATIONS [2]   = "Silence_fire";
	SILENCED_ANIMATIONS [3]   = "Silence_reload";
	// SKATE - 2
	SKATE_ANIMATIONS [0]   = "skate_idle";
	SKATE_ANIMATIONS [1]   = "skate_run";
	SKATE_ANIMATIONS [2]   = "skate_sprint";
	// SMOK - 7
	SMOK_ANIMATIONS [0]   = "F_smklean_loop";
	SMOK_ANIMATIONS [1]   = "M_smklean_loop";
	SMOK_ANIMATIONS [2]   = "M_smkstnd_loop";
	SMOK_ANIMATIONS [3]   = "M_smk_drag";
	SMOK_ANIMATIONS [4]   = "M_smk_in";
	SMOK_ANIMATIONS [5]   = "M_smk_loop";
	SMOK_ANIMATIONS [6]   = "M_smk_out";
	SMOK_ANIMATIONS [7]   = "M_smk_tap";
	// SNIPER - 0
	SNIPER_ANIMATIONS [0]   = "WEAPON_sniper";
	// SPRAY - 1
	SPRAY_ANIMATIONS [0]   = "spraycan_fire";
	SPRAY_ANIMATIONS [1]   = "spraycan_full";
	// STRIP - 19
	STRIP_ANIMATIONS [0]   = "PLY_CASH";
	STRIP_ANIMATIONS [1]   = "PUN_CASH";
	STRIP_ANIMATIONS [2]   = "PUN_HOLLER";
	STRIP_ANIMATIONS [3]   = "PUN_LOOP";
	STRIP_ANIMATIONS [4]   = "strip_A";
	STRIP_ANIMATIONS [5]   = "strip_B";
	STRIP_ANIMATIONS [6]   = "strip_C";
	STRIP_ANIMATIONS [7]   = "strip_D";
	STRIP_ANIMATIONS [8]   = "strip_E";
	STRIP_ANIMATIONS [9]   = "strip_F";
	STRIP_ANIMATIONS [10]   = "strip_G";
	STRIP_ANIMATIONS [11]   = "STR_A2B";
	STRIP_ANIMATIONS [12]   = "STR_B2A";
	STRIP_ANIMATIONS [13]   = "STR_B2C";
	STRIP_ANIMATIONS [14]   = "STR_C1";
	STRIP_ANIMATIONS [15]   = "STR_C2";
	STRIP_ANIMATIONS [16]   = "STR_C2B";
	STRIP_ANIMATIONS [17]   = "STR_Loop_A";
	STRIP_ANIMATIONS [18]   = "STR_Loop_B";
	STRIP_ANIMATIONS [19]   = "STR_Loop_C";
	// SUNBA - 17
	SUNBA_ANIMATIONS [0]   = "batherdown";
	SUNBA_ANIMATIONS [1]   = "batherup";
	SUNBA_ANIMATIONS [2]   = "Lay_Bac_in";
	SUNBA_ANIMATIONS [3]   = "Lay_Bac_out";
	SUNBA_ANIMATIONS [4]   = "ParkSit_M_IdleA";
	SUNBA_ANIMATIONS [5]   = "ParkSit_M_IdleB";
	SUNBA_ANIMATIONS [6]   = "ParkSit_M_IdleC";
	SUNBA_ANIMATIONS [7]   = "ParkSit_M_in";
	SUNBA_ANIMATIONS [8]   = "ParkSit_M_out";
	SUNBA_ANIMATIONS [9]   = "ParkSit_W_idleA";
	SUNBA_ANIMATIONS [10]   = "ParkSit_W_idleB";
	SUNBA_ANIMATIONS [11]   = "ParkSit_W_idleC";
	SUNBA_ANIMATIONS [12]   = "ParkSit_W_in";
	SUNBA_ANIMATIONS [13]   = "ParkSit_W_out";
	SUNBA_ANIMATIONS [14]   = "SBATHE_F_LieB2Sit";
	SUNBA_ANIMATIONS [15]   = "SBATHE_F_Out";
	SUNBA_ANIMATIONS [16]   = "SitnWait_in_W";
	SUNBA_ANIMATIONS [17]   = "SitnWait_out_W";
	// SWAT - 22
	SWAT_ANIMATIONS [0]   = "gnstwall_injurd";
	SWAT_ANIMATIONS [1]   = "JMP_Wall1m_180";
	SWAT_ANIMATIONS [2]   = "Rail_fall";
	SWAT_ANIMATIONS [3]   = "Rail_fall_crawl";
	SWAT_ANIMATIONS [4]   = "swt_breach_01";
	SWAT_ANIMATIONS [5]   = "swt_breach_02";
	SWAT_ANIMATIONS [6]   = "swt_breach_03";
	SWAT_ANIMATIONS [7]   = "swt_go";
	SWAT_ANIMATIONS [8]   = "swt_lkt";
	SWAT_ANIMATIONS [9]   = "swt_sty";
	SWAT_ANIMATIONS [10]   = "swt_vent_01";
	SWAT_ANIMATIONS [11]   = "swt_vent_02";
	SWAT_ANIMATIONS [12]   = "swt_vnt_sht_die";
	SWAT_ANIMATIONS [13]   = "swt_vnt_sht_in";
	SWAT_ANIMATIONS [14]   = "swt_vnt_sht_loop";
	SWAT_ANIMATIONS [15]   = "swt_wllpk_L";
	SWAT_ANIMATIONS [16]   = "swt_wllpk_L_back";
	SWAT_ANIMATIONS [17]   = "swt_wllpk_R";
	SWAT_ANIMATIONS [18]   = "swt_wllpk_R_back";
	SWAT_ANIMATIONS [19]   = "swt_wllshoot_in_L";
	SWAT_ANIMATIONS [20]   = "swt_wllshoot_in_R";
	SWAT_ANIMATIONS [21]   = "swt_wllshoot_out_L";
	SWAT_ANIMATIONS [22]   = "swt_wllshoot_out_R";
	// SWEET - 6
	SWEET_ANIMATIONS [0]   = "ho_ass_slapped";
	SWEET_ANIMATIONS [1]   = "LaFin_Player";
	SWEET_ANIMATIONS [2]   = "LaFin_Sweet";
	SWEET_ANIMATIONS [3]   = "plyr_hndshldr_01";
	SWEET_ANIMATIONS [4]   = "sweet_ass_slap";
	SWEET_ANIMATIONS [5]   = "sweet_hndshldr_01";
	SWEET_ANIMATIONS [6]   = "Sweet_injuredloop";
	// SWIM - 6
	SWIM_ANIMATIONS [0]   = "Swim_Breast";
	SWIM_ANIMATIONS [1]   = "SWIM_crawl";
	SWIM_ANIMATIONS [2]   = "Swim_Dive_Under";
	SWIM_ANIMATIONS [3]   = "Swim_Glide";
	SWIM_ANIMATIONS [4]   = "Swim_jumpout";
	SWIM_ANIMATIONS [5]   = "Swim_Tread";
	SWIM_ANIMATIONS [6]   = "Swim_Under";
	// SWORD - 9
	SWORD_ANIMATIONS [0]   = "sword_1";
	SWORD_ANIMATIONS [1]   = "sword_2";
	SWORD_ANIMATIONS [2]   = "sword_3";
	SWORD_ANIMATIONS [3]   = "sword_4";
	SWORD_ANIMATIONS [4]   = "sword_block";
	SWORD_ANIMATIONS [5]   = "Sword_Hit_1";
	SWORD_ANIMATIONS [6]   = "Sword_Hit_2";
	SWORD_ANIMATIONS [7]   = "Sword_Hit_3";
	SWORD_ANIMATIONS [8]   = "sword_IDLE";
	SWORD_ANIMATIONS [9]   = "sword_part";
	// TANK - 5
	TANK_ANIMATIONS [0]   = "TANK_align_LHS";
	TANK_ANIMATIONS [1]   = "TANK_close_LHS";
	TANK_ANIMATIONS [2]   = "TANK_doorlocked";
	TANK_ANIMATIONS [3]   = "TANK_getin_LHS";
	TANK_ANIMATIONS [4]   = "TANK_getout_LHS";
	TANK_ANIMATIONS [5]   = "TANK_open_LHS";
	// TATTOO - 56
	TATTOO_ANIMATIONS [0]   = "TAT_ArmL_In_O";
	TATTOO_ANIMATIONS [1]   = "TAT_ArmL_In_P";
	TATTOO_ANIMATIONS [2]   = "TAT_ArmL_In_T";
	TATTOO_ANIMATIONS [3]   = "TAT_ArmL_Out_O";
	TATTOO_ANIMATIONS [4]   = "TAT_ArmL_Out_P";
	TATTOO_ANIMATIONS [5]   = "TAT_ArmL_Out_T";
	TATTOO_ANIMATIONS [6]   = "TAT_ArmL_Pose_O";
	TATTOO_ANIMATIONS [7]   = "TAT_ArmL_Pose_P";
	TATTOO_ANIMATIONS [8]   = "TAT_ArmL_Pose_T";
	TATTOO_ANIMATIONS [9]   = "TAT_ArmR_In_O";
	TATTOO_ANIMATIONS [10]   = "TAT_ArmR_In_P";
	TATTOO_ANIMATIONS [11]   = "TAT_ArmR_In_T";
	TATTOO_ANIMATIONS [12]   = "TAT_ArmR_Out_O";
	TATTOO_ANIMATIONS [13]   = "TAT_ArmR_Out_P";
	TATTOO_ANIMATIONS [14]   = "TAT_ArmR_Out_T";
	TATTOO_ANIMATIONS [15]   = "TAT_ArmR_Pose_O";
	TATTOO_ANIMATIONS [16]   = "TAT_ArmR_Pose_P";
	TATTOO_ANIMATIONS [17]   = "TAT_ArmR_Pose_T";
	TATTOO_ANIMATIONS [18]   = "TAT_Back_In_O";
	TATTOO_ANIMATIONS [19]   = "TAT_Back_In_P";
	TATTOO_ANIMATIONS [20]   = "TAT_Back_In_T";
	TATTOO_ANIMATIONS [21]   = "TAT_Back_Out_O";
	TATTOO_ANIMATIONS [22]   = "TAT_Back_Out_P";
	TATTOO_ANIMATIONS [23]   = "TAT_Back_Out_T";
	TATTOO_ANIMATIONS [24]   = "TAT_Back_Pose_O";
	TATTOO_ANIMATIONS [25]   = "TAT_Back_Pose_P";
	TATTOO_ANIMATIONS [26]   = "TAT_Back_Pose_T";
	TATTOO_ANIMATIONS [27]   = "TAT_Back_Sit_In_P";
	TATTOO_ANIMATIONS [28]   = "TAT_Back_Sit_Loop_P";
	TATTOO_ANIMATIONS [29]   = "TAT_Back_Sit_Out_P";
	TATTOO_ANIMATIONS [30]   = "TAT_Bel_In_O";
	TATTOO_ANIMATIONS [31]   = "TAT_Bel_In_T";
	TATTOO_ANIMATIONS [32]   = "TAT_Bel_Out_O";
	TATTOO_ANIMATIONS [33]   = "TAT_Bel_Out_T";
	TATTOO_ANIMATIONS [34]   = "TAT_Bel_Pose_O";
	TATTOO_ANIMATIONS [35]   = "TAT_Bel_Pose_T";
	TATTOO_ANIMATIONS [36]   = "TAT_Che_In_O";
	TATTOO_ANIMATIONS [37]   = "TAT_Che_In_P";
	TATTOO_ANIMATIONS [38]   = "TAT_Che_In_T";
	TATTOO_ANIMATIONS [39]   = "TAT_Che_Out_O";
	TATTOO_ANIMATIONS [40]   = "TAT_Che_Out_P";
	TATTOO_ANIMATIONS [41]   = "TAT_Che_Out_T";
	TATTOO_ANIMATIONS [42]   = "TAT_Che_Pose_O";
	TATTOO_ANIMATIONS [43]   = "TAT_Che_Pose_P";
	TATTOO_ANIMATIONS [44]   = "TAT_Che_Pose_T";
	TATTOO_ANIMATIONS [45]   = "TAT_Drop_O";
	TATTOO_ANIMATIONS [46]   = "TAT_Idle_Loop_O";
	TATTOO_ANIMATIONS [47]   = "TAT_Idle_Loop_T";
	TATTOO_ANIMATIONS [48]   = "TAT_Sit_In_O";
	TATTOO_ANIMATIONS [49]   = "TAT_Sit_In_P";
	TATTOO_ANIMATIONS [50]   = "TAT_Sit_In_T";
	TATTOO_ANIMATIONS [51]   = "TAT_Sit_Loop_O";
	TATTOO_ANIMATIONS [52]   = "TAT_Sit_Loop_P";
	TATTOO_ANIMATIONS [53]   = "TAT_Sit_Loop_T";
	TATTOO_ANIMATIONS [54]   = "TAT_Sit_Out_O";
	TATTOO_ANIMATIONS [55]   = "TAT_Sit_Out_P";
	TATTOO_ANIMATIONS [56]   = "TAT_Sit_Out_T";
	// TEC - 3
	TEC_ANIMATIONS [0]   = "TEC_crouchfire";
	TEC_ANIMATIONS [1]   = "TEC_crouchreload";
	TEC_ANIMATIONS [2]   = "TEC_fire";
	TEC_ANIMATIONS [3]   = "TEC_reload";
	// TRAIN - 3
	TRAIN_ANIMATIONS [0]   = "tran_gtup";
	TRAIN_ANIMATIONS [1]   = "tran_hng";
	TRAIN_ANIMATIONS [2]   = "tran_ouch";
	TRAIN_ANIMATIONS [3]   = "tran_stmb";
	// TRUCK - 16
	TRUCK_ANIMATIONS [0]   = "TRUCK_ALIGN_LHS";
	TRUCK_ANIMATIONS [1]   = "TRUCK_ALIGN_RHS";
	TRUCK_ANIMATIONS [2]   = "TRUCK_closedoor_LHS";
	TRUCK_ANIMATIONS [3]   = "TRUCK_closedoor_RHS";
	TRUCK_ANIMATIONS [4]   = "TRUCK_close_LHS";
	TRUCK_ANIMATIONS [5]   = "TRUCK_close_RHS";
	TRUCK_ANIMATIONS [6]   = "TRUCK_getin_LHS";
	TRUCK_ANIMATIONS [7]   = "TRUCK_getin_RHS";
	TRUCK_ANIMATIONS [8]   = "TRUCK_getout_LHS";
	TRUCK_ANIMATIONS [9]   = "TRUCK_getout_RHS";
	TRUCK_ANIMATIONS [10]   = "TRUCK_jackedLHS";
	TRUCK_ANIMATIONS [11]   = "TRUCK_jackedRHS";
	TRUCK_ANIMATIONS [12]   = "TRUCK_open_LHS";
	TRUCK_ANIMATIONS [13]   = "TRUCK_open_RHS";
	TRUCK_ANIMATIONS [14]   = "TRUCK_pullout_LHS";
	TRUCK_ANIMATIONS [15]   = "TRUCK_pullout_RHS";
	TRUCK_ANIMATIONS [16]   = "TRUCK_Shuffle";
	// UZI - 4
	UZI_ANIMATIONS [0]   = "UZI_crouchfire";
	UZI_ANIMATIONS [1]   = "UZI_crouchreload";
	UZI_ANIMATIONS [2]   = "UZI_fire";
	UZI_ANIMATIONS [3]   = "UZI_fire_poor";
	UZI_ANIMATIONS [4]   = "UZI_reload";
	// VAN - 7
	VAN_ANIMATIONS [0]   = "VAN_close_back_LHS";
	VAN_ANIMATIONS [1]   = "VAN_close_back_RHS";
	VAN_ANIMATIONS [2]   = "VAN_getin_Back_LHS";
	VAN_ANIMATIONS [3]   = "VAN_getin_Back_RHS";
	VAN_ANIMATIONS [4]   = "VAN_getout_back_LHS";
	VAN_ANIMATIONS [5]   = "VAN_getout_back_RHS";
	VAN_ANIMATIONS [6]   = "VAN_open_back_LHS";
	VAN_ANIMATIONS [7]   = "VAN_open_back_RHS";
	// VENDING - 5
	VENDING_ANIMATIONS      [0] = "VEND_Drink2_P";
	VENDING_ANIMATIONS      [1] = "VEND_Drink_P";
	VENDING_ANIMATIONS      [2] = "vend_eat1_P";
	VENDING_ANIMATIONS      [3] = "VEND_Eat_P";
	VENDING_ANIMATIONS      [4] = "VEND_Use";
	VENDING_ANIMATIONS      [5] = "VEND_Use_pt2";
	// VORTEX - 3
	VORTEX_ANIMATIONS [0]   = "CAR_jumpin_LHS";
	VORTEX_ANIMATIONS [1]   = "CAR_jumpin_RHS";
	VORTEX_ANIMATIONS [2]   = "vortex_getout_LHS";
	VORTEX_ANIMATIONS [3]   = "vortex_getout_RHS";
	// WAYFA - 17
	WAYFA_ANIMATIONS [0]   = "WF_Back";
	WAYFA_ANIMATIONS [1]   = "WF_drivebyFT";
	WAYFA_ANIMATIONS [2]   = "WF_drivebyLHS";
	WAYFA_ANIMATIONS [3]   = "WF_drivebyRHS";
	WAYFA_ANIMATIONS [4]   = "WF_Fwd";
	WAYFA_ANIMATIONS [5]   = "WF_getoffBACK";
	WAYFA_ANIMATIONS [6]   = "WF_getoffLHS";
	WAYFA_ANIMATIONS [7]   = "WF_getoffRHS";
	WAYFA_ANIMATIONS [8]   = "WF_hit";
	WAYFA_ANIMATIONS [9]   = "WF_jumponL";
	WAYFA_ANIMATIONS [10]   = "WF_jumponR";
	WAYFA_ANIMATIONS [11]   = "WF_kick";
	WAYFA_ANIMATIONS [12]   = "WF_Left";
	WAYFA_ANIMATIONS [13]   = "WF_passenger";
	WAYFA_ANIMATIONS [14]   = "WF_pushes";
	WAYFA_ANIMATIONS [15]   = "WF_Ride";
	WAYFA_ANIMATIONS [16]   = "WF_Right";
	WAYFA_ANIMATIONS [17]   = "WF_Still";
	// ARMA - 16
	ARMA_ANIMATIONS [0]   = "SHP_1H_Lift";
	ARMA_ANIMATIONS [1]   = "SHP_1H_Lift_End";
	ARMA_ANIMATIONS [2]   = "SHP_1H_Ret";
	ARMA_ANIMATIONS [3]   = "SHP_1H_Ret_S";
	ARMA_ANIMATIONS [4]   = "SHP_2H_Lift";
	ARMA_ANIMATIONS [5]   = "SHP_2H_Lift_End";
	ARMA_ANIMATIONS [6]   = "SHP_2H_Ret";
	ARMA_ANIMATIONS [7]   = "SHP_2H_Ret_S";
	ARMA_ANIMATIONS [8]   = "SHP_Ar_Lift";
	ARMA_ANIMATIONS [9]   = "SHP_Ar_Lift_End";
	ARMA_ANIMATIONS [10]   = "SHP_Ar_Ret";
	ARMA_ANIMATIONS [11]   = "SHP_Ar_Ret_S";
	ARMA_ANIMATIONS [12]   = "SHP_G_Lift_In";
	ARMA_ANIMATIONS [13]   = "SHP_G_Lift_Out";
	ARMA_ANIMATIONS [14]   = "SHP_Tray_In";
	ARMA_ANIMATIONS [15]   = "SHP_Tray_Out";
	ARMA_ANIMATIONS [16]   = "SHP_Tray_Pose";
	// WUZI - 11
	WUZI_ANIMATIONS [0]   = "CS_Dead_Guy";
	WUZI_ANIMATIONS [1]   = "CS_Plyr_pt1";
	WUZI_ANIMATIONS [2]   = "CS_Plyr_pt2";
	WUZI_ANIMATIONS [3]   = "CS_Wuzi_pt1";
	WUZI_ANIMATIONS [4]   = "CS_Wuzi_pt2";
	WUZI_ANIMATIONS [5]   = "Walkstart_Idle_01";
	WUZI_ANIMATIONS [6]   = "Wuzi_follow";
	WUZI_ANIMATIONS [7]   = "Wuzi_Greet_Plyr";
	WUZI_ANIMATIONS [8]   = "Wuzi_Greet_Wuzi";
	WUZI_ANIMATIONS [9]   = "Wuzi_grnd_chk";
	WUZI_ANIMATIONS [10]   = "Wuzi_stand_loop";
	WUZI_ANIMATIONS [11]   = "Wuzi_Walk";
	// PED - 285
	PED_ANIMATIONS[0]   = "abseil";
	PED_ANIMATIONS[1]   = "ARRESTgun";
	PED_ANIMATIONS[2]   = "ATM";
	PED_ANIMATIONS[3]   = "BIKE_elbowL";
	PED_ANIMATIONS[4]   = "BIKE_elbowR";
	PED_ANIMATIONS[5]   = "BIKE_fallR";
	PED_ANIMATIONS[6]   = "BIKE_fall_off";
	PED_ANIMATIONS[7]   = "BIKE_pickupL";
	PED_ANIMATIONS[8]   = "BIKE_pickupR";
	PED_ANIMATIONS[9]   = "BIKE_pullupL";
	PED_ANIMATIONS[10]   = "BIKE_pullupR";
	PED_ANIMATIONS[11]   = "bomber";
	PED_ANIMATIONS[12]   = "CAR_alignHI_LHS";
	PED_ANIMATIONS[13]   = "CAR_alignHI_RHS";
	PED_ANIMATIONS[14]   = "CAR_align_LHS";
	PED_ANIMATIONS[15]   = "CAR_align_RHS";
	PED_ANIMATIONS[16]   = "CAR_closedoorL_LHS";
	PED_ANIMATIONS[17]   = "CAR_closedoorL_RHS";
	PED_ANIMATIONS[18]   = "CAR_closedoor_LHS";
	PED_ANIMATIONS[19]   = "CAR_close_LHS";
	PED_ANIMATIONS[20]   = "CAR_close_RHS";
	PED_ANIMATIONS[21]   = "CAR_crawloutRHS";
	PED_ANIMATIONS[22]   = "CAR_dead_LHS";
	PED_ANIMATIONS[23]   = "CAR_dead_RHS";
	PED_ANIMATIONS[24]   = "CAR_doorlocked_LHS";
	PED_ANIMATIONS[25]   = "CAR_doorlocked_RHS";
	PED_ANIMATIONS[26]   = "CAR_fallout_RHS";
	PED_ANIMATIONS[27]   = "CAR_getinL_LHS";
	PED_ANIMATIONS[28]   = "CAR_getinL_RHS";
	PED_ANIMATIONS[29]   = "CAR_getin_LHS";
	PED_ANIMATIONS[30]   = "CAR_getin_RHS";
	PED_ANIMATIONS[31]   = "CAR_getoutL_LHS";
	PED_ANIMATIONS[32]   = "CAR_getoutL_RHS";
	PED_ANIMATIONS[33]   = "CAR_getout_LHS";
	PED_ANIMATIONS[34]   = "CAR_getout_RHS";
	PED_ANIMATIONS[35]   = "car_hookertalk";
	PED_ANIMATIONS[36]   = "CAR_jackedLHS";
	PED_ANIMATIONS[37]   = "CAR_jackedRHS";
	PED_ANIMATIONS[38]   = "CAR_jumpin_LHS";
	PED_ANIMATIONS[39]   = "CAR_LB";
	PED_ANIMATIONS[40]   = "CAR_LB_pro";
	PED_ANIMATIONS[41]   = "CAR_LB_weak";
	PED_ANIMATIONS[42]   = "CAR_LjackedLHS";
	PED_ANIMATIONS[43]   = "CAR_LjackedRHS";
	PED_ANIMATIONS[44]   = "CAR_Lshuffle_RHS";
	PED_ANIMATIONS[45]   = "CAR_Lsit";
	PED_ANIMATIONS[46]   = "CAR_open_LHS";
	PED_ANIMATIONS[47]   = "CAR_open_RHS";
	PED_ANIMATIONS[48]   = "CAR_pulloutL_LHS";
	PED_ANIMATIONS[49]   = "CAR_pulloutL_RHS";
	PED_ANIMATIONS[50]   = "CAR_pullout_LHS";
	PED_ANIMATIONS[51]   = "CAR_pullout_RHS";
	PED_ANIMATIONS[52]   = "CAR_Qjacked";
	PED_ANIMATIONS[53]   = "CAR_rolldoor";
	PED_ANIMATIONS[54]   = "CAR_rolldoorLO";
	PED_ANIMATIONS[55]   = "CAR_rollout_LHS";
	PED_ANIMATIONS[56]   = "CAR_rollout_RHS";
	PED_ANIMATIONS[57]   = "CAR_shuffle_RHS";
	PED_ANIMATIONS[58]   = "CAR_sit";
	PED_ANIMATIONS[59]   = "CAR_sitp";
	PED_ANIMATIONS[60]   = "CAR_sitpLO";
	PED_ANIMATIONS[61]   = "CAR_sit_pro";
	PED_ANIMATIONS[62]   = "CAR_sit_weak";
	PED_ANIMATIONS[63]   = "CAR_tune_radio";
	PED_ANIMATIONS[64]   = "CLIMB_idle";
	PED_ANIMATIONS[65]   = "CLIMB_jump";
	PED_ANIMATIONS[66]   = "CLIMB_jump2fall";
	PED_ANIMATIONS[67]   = "CLIMB_jump_B";
	PED_ANIMATIONS[68]   = "CLIMB_Pull";
	PED_ANIMATIONS[69]   = "CLIMB_Stand";
	PED_ANIMATIONS[70]   = "CLIMB_Stand_finish";
	PED_ANIMATIONS[71]   = "cower";
	PED_ANIMATIONS[72]   = "Crouch_Roll_L";
	PED_ANIMATIONS[73]   = "Crouch_Roll_R";
	PED_ANIMATIONS[74]   = "DAM_armL_frmBK";
	PED_ANIMATIONS[75]   = "DAM_armL_frmFT";
	PED_ANIMATIONS[76]   = "DAM_armL_frmLT";
	PED_ANIMATIONS[77]   = "DAM_armR_frmBK";
	PED_ANIMATIONS[78]   = "DAM_armR_frmFT";
	PED_ANIMATIONS[79]   = "DAM_armR_frmRT";
	PED_ANIMATIONS[80]   = "DAM_LegL_frmBK";
	PED_ANIMATIONS[81]   = "DAM_LegL_frmFT";
	PED_ANIMATIONS[82]   = "DAM_LegL_frmLT";
	PED_ANIMATIONS[83]   = "DAM_LegR_frmBK";
	PED_ANIMATIONS[84]   = "DAM_LegR_frmFT";
	PED_ANIMATIONS[85]   = "DAM_LegR_frmRT";
	PED_ANIMATIONS[86]   = "DAM_stomach_frmBK";
	PED_ANIMATIONS[87]   = "DAM_stomach_frmFT";
	PED_ANIMATIONS[88]   = "DAM_stomach_frmLT";
	PED_ANIMATIONS[89]   = "DAM_stomach_frmRT";
	PED_ANIMATIONS[90]   = "DOOR_LHinge_O";
	PED_ANIMATIONS[91]   = "DOOR_RHinge_O";
	PED_ANIMATIONS[92]   = "DrivebyL_L";
	PED_ANIMATIONS[93]   = "DrivebyL_R";
	PED_ANIMATIONS[94]   = "Driveby_L";
	PED_ANIMATIONS[95]   = "Driveby_R";
	PED_ANIMATIONS[96]   = "DRIVE_BOAT";
	PED_ANIMATIONS[97]   = "DRIVE_BOAT_back";
	PED_ANIMATIONS[98]   = "DRIVE_BOAT_L";
	PED_ANIMATIONS[99]   = "DRIVE_BOAT_R";
	PED_ANIMATIONS[100]   = "Drive_L";
	PED_ANIMATIONS[101]   = "Drive_LO_l";
	PED_ANIMATIONS[102]   = "Drive_LO_R";
	PED_ANIMATIONS[103]   = "Drive_L_pro";
	PED_ANIMATIONS[104]   = "Drive_L_pro_slow";
	PED_ANIMATIONS[105]   = "Drive_L_slow";
	PED_ANIMATIONS[106]   = "Drive_L_weak";
	PED_ANIMATIONS[107]   = "Drive_L_weak_slow";
	PED_ANIMATIONS[108]   = "Drive_truck";
	PED_ANIMATIONS[109]   = "DRIVE_truck_back";
	PED_ANIMATIONS[110]   = "DRIVE_truck_L";
	PED_ANIMATIONS[111]   = "DRIVE_truck_R";
	PED_ANIMATIONS[112]   = "Drown";
	PED_ANIMATIONS[113]   = "DUCK_cower";
	PED_ANIMATIONS[114]   = "endchat_01";
	PED_ANIMATIONS[115]   = "endchat_02";
	PED_ANIMATIONS[116]   = "endchat_03";
	PED_ANIMATIONS[117]   = "EV_dive";
	PED_ANIMATIONS[118]   = "EV_step";
	PED_ANIMATIONS[119]   = "facanger";
	PED_ANIMATIONS[120]   = "facgum";
	PED_ANIMATIONS[121]   = "facsurp";
	PED_ANIMATIONS[122]   = "facsurpm";
	PED_ANIMATIONS[123]   = "factalk";
	PED_ANIMATIONS[124]   = "facurios";
	PED_ANIMATIONS[125]   = "FALL_back";
	PED_ANIMATIONS[126]   = "FALL_collapse";
	PED_ANIMATIONS[127]   = "FALL_fall";
	PED_ANIMATIONS[128]   = "FALL_front";
	PED_ANIMATIONS[129]   = "FALL_glide";
	PED_ANIMATIONS[130]   = "FALL_land";
	PED_ANIMATIONS[131]   = "FALL_skyDive";
	PED_ANIMATIONS[132]   = "Fight2Idle";
	PED_ANIMATIONS[133]   = "FightA_1";
	PED_ANIMATIONS[134]   = "FightA_2";
	PED_ANIMATIONS[135]   = "FightA_3";
	PED_ANIMATIONS[136]   = "FightA_block";
	PED_ANIMATIONS[137]   = "FightA_G";
	PED_ANIMATIONS[138]   = "FightA_M";
	PED_ANIMATIONS[139]   = "FIGHTIDLE";
	PED_ANIMATIONS[140]   = "FightShB";
	PED_ANIMATIONS[141]   = "FightShF";
	PED_ANIMATIONS[142]   = "FightSh_BWD";
	PED_ANIMATIONS[143]   = "FightSh_FWD";
	PED_ANIMATIONS[144]   = "FightSh_Left";
	PED_ANIMATIONS[145]   = "FightSh_Right";
	PED_ANIMATIONS[146]   = "flee_lkaround_01";
	PED_ANIMATIONS[147]   = "FLOOR_hit";
	PED_ANIMATIONS[148]   = "FLOOR_hit_f";
	PED_ANIMATIONS[149]   = "fucku";
	PED_ANIMATIONS[150]   = "gang_gunstand";
	PED_ANIMATIONS[151]   = "gas_cwr";
	PED_ANIMATIONS[152]   = "getup";
	PED_ANIMATIONS[153]   = "getup_front";
	PED_ANIMATIONS[154]   = "gum_eat";
	PED_ANIMATIONS[155]   = "GunCrouchBwd";
	PED_ANIMATIONS[156]   = "GunCrouchFwd";
	PED_ANIMATIONS[157]   = "GunMove_BWD";
	PED_ANIMATIONS[158]   = "GunMove_FWD";
	PED_ANIMATIONS[159]   = "GunMove_L";
	PED_ANIMATIONS[160]   = "GunMove_R";
	PED_ANIMATIONS[161]   = "Gun_2_IDLE";
	PED_ANIMATIONS[162]   = "GUN_BUTT";
	PED_ANIMATIONS[163]   = "GUN_BUTT_crouch";
	PED_ANIMATIONS[164]   = "Gun_stand";
	PED_ANIMATIONS[165]   = "handscower";
	PED_ANIMATIONS[166]   = "handsup";          //////////// LEVANTAR MANOS
	PED_ANIMATIONS[167]   = "HitA_1";
	PED_ANIMATIONS[168]   = "HitA_2";
	PED_ANIMATIONS[169]   = "HitA_3";
	PED_ANIMATIONS[170]   = "HIT_back";
	PED_ANIMATIONS[171]   = "HIT_behind";
	PED_ANIMATIONS[172]   = "HIT_front";
	PED_ANIMATIONS[173]   = "HIT_GUN_BUTT";
	PED_ANIMATIONS[174]   = "HIT_L";
	PED_ANIMATIONS[175]   = "HIT_R";
	PED_ANIMATIONS[176]   = "HIT_walk";
	PED_ANIMATIONS[177]   = "HIT_wall";
	PED_ANIMATIONS[178]   = "Idlestance_fat";
	PED_ANIMATIONS[179]   = "idlestance_old";
	PED_ANIMATIONS[180]   = "IDLE_armed";
	PED_ANIMATIONS[181]   = "IDLE_chat";
	PED_ANIMATIONS[182]   = "IDLE_csaw";
	PED_ANIMATIONS[183]   = "Idle_Gang1";
	PED_ANIMATIONS[184]   = "IDLE_HBHB";
	PED_ANIMATIONS[185]   = "IDLE_ROCKET";
	PED_ANIMATIONS[186]   = "IDLE_stance";
	PED_ANIMATIONS[187]   = "IDLE_taxi";
	PED_ANIMATIONS[188]   = "IDLE_tired";
	PED_ANIMATIONS[189]   = "Jetpack_Idle";
	PED_ANIMATIONS[190]   = "JOG_femaleA";
	PED_ANIMATIONS[191]   = "JOG_maleA";
	PED_ANIMATIONS[192]   = "JUMP_glide";
	PED_ANIMATIONS[193]   = "JUMP_land";
	PED_ANIMATIONS[194]   = "JUMP_launch";
	PED_ANIMATIONS[195]   = "JUMP_launch_R";
	PED_ANIMATIONS[196]   = "KART_drive";
	PED_ANIMATIONS[197]   = "KART_L";
	PED_ANIMATIONS[198]   = "KART_LB";
	PED_ANIMATIONS[199]   = "KART_R";
	PED_ANIMATIONS[200]   = "KD_left";
	PED_ANIMATIONS[201]   = "KD_right";
	PED_ANIMATIONS[202]   = "KO_shot_face";
	PED_ANIMATIONS[203]   = "KO_shot_front";
	PED_ANIMATIONS[204]   = "KO_shot_stom";
	PED_ANIMATIONS[205]   = "KO_skid_back";
	PED_ANIMATIONS[206]   = "KO_skid_front";
	PED_ANIMATIONS[207]   = "KO_spin_L";
	PED_ANIMATIONS[208]   = "KO_spin_R";
	PED_ANIMATIONS[209]   = "pass_Smoke_in_car";
	PED_ANIMATIONS[210]   = "phone_in";
	PED_ANIMATIONS[211]   = "phone_out";
	PED_ANIMATIONS[212]   = "phone_talk";
	PED_ANIMATIONS[213]   = "Player_Sneak";
	PED_ANIMATIONS[214]   = "Player_Sneak_walkstart";
	PED_ANIMATIONS[215]   = "roadcross";                    //////////////// CRUZAR LAS MANOS?
	PED_ANIMATIONS[216]   = "roadcross_female";
	PED_ANIMATIONS[217]   = "roadcross_gang";
	PED_ANIMATIONS[218]   = "roadcross_old";
	PED_ANIMATIONS[219]   = "run_1armed";
	PED_ANIMATIONS[220]   = "run_armed";
	PED_ANIMATIONS[221]   = "run_civi";
	PED_ANIMATIONS[222]   = "run_csaw";
	PED_ANIMATIONS[223]   = "run_fat";
	PED_ANIMATIONS[224]   = "run_fatold";
	PED_ANIMATIONS[225]   = "run_gang1";
	PED_ANIMATIONS[226]   = "run_left";
	PED_ANIMATIONS[227]   = "run_old";
	PED_ANIMATIONS[228]   = "run_player";
	PED_ANIMATIONS[229]   = "run_right";
	PED_ANIMATIONS[230]   = "run_rocket";
	PED_ANIMATIONS[231]   = "Run_stop";
	PED_ANIMATIONS[232]   = "Run_stopR";
	PED_ANIMATIONS[233]   = "Run_Wuzi";
	PED_ANIMATIONS[234]   = "SEAT_down";
	PED_ANIMATIONS[235]   = "SEAT_idle";
	PED_ANIMATIONS[236]   = "SEAT_up";
	PED_ANIMATIONS[237]   = "SHOT_leftP";
	PED_ANIMATIONS[238]   = "SHOT_partial";
	PED_ANIMATIONS[239]   = "SHOT_partial_B";
	PED_ANIMATIONS[240]   = "SHOT_rightP";
	PED_ANIMATIONS[241]   = "Shove_Partial";
	PED_ANIMATIONS[242]   = "Smoke_in_car";
	PED_ANIMATIONS[243]   = "sprint_civi";
	PED_ANIMATIONS[244]   = "sprint_panic";
	PED_ANIMATIONS[245]   = "Sprint_Wuzi";
	PED_ANIMATIONS[246]   = "swat_run";
	PED_ANIMATIONS[247]   = "Swim_Tread";
	PED_ANIMATIONS[248]   = "Tap_hand";
	PED_ANIMATIONS[249]   = "Tap_handP";
	PED_ANIMATIONS[250]   = "turn_180";
	PED_ANIMATIONS[251]   = "Turn_L";
	PED_ANIMATIONS[252]   = "Turn_R";
	PED_ANIMATIONS[253]   = "WALK_armed";
	PED_ANIMATIONS[254]   = "WALK_civi";
	PED_ANIMATIONS[255]   = "WALK_csaw";
	PED_ANIMATIONS[256]   = "Walk_DoorPartial";
	PED_ANIMATIONS[257]   = "WALK_drunk";
	PED_ANIMATIONS[258]   = "WALK_fat";
	PED_ANIMATIONS[259]   = "WALK_fatold";
	PED_ANIMATIONS[260]   = "WALK_gang1";
	PED_ANIMATIONS[261]   = "WALK_gang2";
	PED_ANIMATIONS[262]   = "WALK_old";
	PED_ANIMATIONS[263]   = "WALK_player";
	PED_ANIMATIONS[264]   = "WALK_rocket";
	PED_ANIMATIONS[265]   = "WALK_shuffle";
	PED_ANIMATIONS[266]   = "WALK_start";
	PED_ANIMATIONS[267]   = "WALK_start_armed";
	PED_ANIMATIONS[268]   = "WALK_start_csaw";
	PED_ANIMATIONS[269]   = "WALK_start_rocket";
	PED_ANIMATIONS[270]   = "Walk_Wuzi";
	PED_ANIMATIONS[271]   = "WEAPON_crouch";
	PED_ANIMATIONS[272]   = "woman_idlestance";
	PED_ANIMATIONS[273]   = "woman_run";
	PED_ANIMATIONS[274]   = "WOMAN_runbusy";
	PED_ANIMATIONS[275]   = "WOMAN_runfatold";
	PED_ANIMATIONS[276]   = "woman_runpanic";
	PED_ANIMATIONS[277]   = "WOMAN_runsexy";
	PED_ANIMATIONS[278]   = "WOMAN_walkbusy";
	PED_ANIMATIONS[279]   = "WOMAN_walkfatold";
	PED_ANIMATIONS[280]   = "WOMAN_walknorm";
	PED_ANIMATIONS[281]   = "WOMAN_walkold";
	PED_ANIMATIONS[282]   = "WOMAN_walkpro";
	PED_ANIMATIONS[283]   = "WOMAN_walksexy";
	PED_ANIMATIONS[284]   = "WOMAN_walkshop";
	PED_ANIMATIONS[285]   = "XPRESSscratch";
}
public ApplyPlayerAnimCustom(playerid, animlib[], animid[], loop)
{
	if ( loop )
	{
		ApplyAnimation(playerid,animlib,animid, 4.0, 1, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid,animlib,animid, 4.0, 1, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid,animlib,animid, 4.0, 1, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid,animlib,animid, 4.0, 1, 1, 1, 1, 1, 1);
	}
	else
	{
		ApplyAnimation(playerid,animlib,animid, 4.0, 0, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid,animlib,animid, 4.0, 0, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid,animlib,animid, 4.0, 0, 1, 1, 1, 1, 1);
		ApplyAnimation(playerid,animlib,animid, 4.0, 0, 1, 1, 1, 1, 1);
	}
	PlayersDataOnline[playerid][InAnim] = true;
}
public GetPosSpace(text[], option)
{
	new SavePos = -1;
	for (new i = 1; i <= option; i++)
	{
		SavePos = strfind(text, " ", false, SavePos + 1);
	}
	return SavePos;
}/*
public CreateAccountBank(playerid)
{
	new TempDir[50];
	new AccountNumber;
	do
	{
	    AccountNumber = random(8999999) + 1000000;
		format(TempDir, sizeof(TempDir), "%s%i.sgw", DIR_ACCOUNT_BANK, AccountNumber);
	}
	while( fexist(TempDir) );
	PlayersData[playerid][AccountBankingOpen] = AccountNumber;

	CleanPlayerAccountBank(playerid);
	SaveAccountBanking(playerid);
}
public LoadAccountBanking(playerid)
{
    if ( PlayersData[playerid][AccountBankingOpen] )
    {
		new TempDir[50];
		new AccountBankData[700];
		new AccountBankSlots[MAX_ACCOUNT_BANK_SLOT][MAX_PLAYER_NAME];
		new File:LoadAccountBankF;
		format(TempDir, sizeof(TempDir), "%s%i.sgw", DIR_ACCOUNT_BANK, PlayersData[playerid][AccountBankingOpen]);
		if ( fexist(TempDir) )
		{

		    LoadAccountBankF = fopen(TempDir, io_read);
			fread(LoadAccountBankF, AccountBankData);
			fclose(LoadAccountBankF);

			new PosSplitAfter = 0;
			for ( new b = 0; b < MAX_ACCOUNT_BANK_SLOT; b++ )
			{
				PosSplitAfter = strfind(AccountBankData, "³", false);
				strmid(AccountBankSlots[b], AccountBankData, 0, PosSplitAfter, sizeof(AccountBankData));
				strdel(AccountBankData, 0, PosSplitAfter + 1);
			}

			format(Banking[playerid][Owner], MAX_PLAYER_NAME, "%s", AccountBankSlots[0]);
			Banking[playerid][Balance]			= strval(AccountBankSlots[1]);
			Banking[playerid][LockIn]			= strval(AccountBankSlots[2]);
			Banking[playerid][LockOut]			= strval(AccountBankSlots[3]);
		}
	}
	else
	{
		CreateAccountBank(playerid);
	}
}
public IsPlayerAccountBankConnected(accountcheck)
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
		if ( IsPlayerConnected(i) && PlayersDataOnline[i][State] == 3 && PlayersData[i][AccountBankingOpen] == accountcheck )
		{
		    return i;
		}
	}
	return -1;
}*/
public RemoveBuildingForPlayerEx(playerid)
{
	//  GANG DE LA CARCEL MATAS Y TODO ESO
	RemoveBuildingForPlayer(playerid, 772, -2499.1406, 494.5234, 29.0156, 0.25);
	RemoveBuildingForPlayer(playerid, 774, -2504.6406, 500.1406, 29.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 778, -2483.4375, 500.1406, 29.0703, 0.25);
	RemoveBuildingForPlayer(playerid, 737, -2436.5469, 478.6094, 29.2734, 0.25);
	RemoveBuildingForPlayer(playerid, 778, -2451.5391, 494.7734, 29.0547, 0.25);
	RemoveBuildingForPlayer(playerid, 3853, -2420.2813, 487.8281, 32.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 968, -2436.8125, 495.4688, 29.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 772, -2406.9453, 515.0078, 27.3516, 0.25);
	RemoveBuildingForPlayer(playerid, 772, -2397.0625, 517.2344, 29.6016, 0.25);
	RemoveBuildingForPlayer(playerid, 772, -2402.6094, 520.6016, 29.2891, 0.25);
	RemoveBuildingForPlayer(playerid, 778, -2428.4531, 528.8516, 29.3359, 0.25);
	RemoveBuildingForPlayer(playerid, 774, -2432.6250, 538.5469, 29.3438, 0.25);
	RemoveBuildingForPlayer(playerid, 966, -2436.8516, 495.4531, 28.9531, 0.25);
	RemoveBuildingForPlayer(playerid, 967, -2438.7266, 495.0078, 29.1016, 0.25);
	RemoveBuildingForPlayer(playerid, 968, -2436.8125, 495.4688, 29.6797, 0.25);
	RemoveBuildingForPlayer(playerid, 774, -2402.0781, 535.3828, 29.3750, 0.25);


	RemoveBuildingForPlayer(playerid, 1232, -2993.8125, 457.8672, 6.5000, 0.25);//lAMPARAS GANG ATRAS DE BANCO SF
	RemoveBuildingForPlayer(playerid, 1232, -2938.4531, 457.5313, 6.5000, 0.25);
	RemoveBuildingForPlayer(playerid, 1232, -2961.8906, 484.0156, 6.5000, 0.25);//
}
public CleanPlayerAccountBank(playerid)
{
	for ( new c = 0; c < MAX_COUNT_CHEQUES; c++ )
	{
		Cheques[playerid][c][UniqueID] = 0;
		Cheques[playerid][c][Type] = 0;
		format(Cheques[playerid][c][NombreCh], MAX_PLAYER_NAME, "No");
		Cheques[playerid][c][Ammount] = 0;
	}
}
public IsValidStringServerOther(playerid, string[])
{
	 for ( new i = 0; i < strlen(string); i++ )
	 {
	    if ( string[i] == '³' ||
	     	 string[i] == '\n' ||
			 string[i] == '\r' )
		{
			SendInfoMessage(playerid, 0, "021", "Ha introducido un carácter inválido.");
		    return false;
		}
	 }
	 return true;
}
public TogglePlayerControllableEx(playerid, toogle)
{
	TogglePlayerControllable(playerid, toogle);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public GetSpawnInfo(playerid)
{
	CheckWeapondCheat(playerid);


	PlayersData[playerid][Chaleco] = PlayersDataOnline[playerid][ChalecoOn];
	PlayersData[playerid][Vida] = PlayersDataOnline[playerid][VidaOn];

 	GetPlayerPos(playerid, PlayersData[playerid][Spawn_X], PlayersData[playerid][Spawn_Y], PlayersData[playerid][Spawn_Z]);
    GetPlayerFacingAngle(playerid, PlayersData[playerid][Spawn_ZZ]);

  	PlayersData[playerid][Interior] = GetPlayerInteriorEx(playerid);
	PlayersData[playerid][World] = GetPlayerVirtualWorld(playerid);
}
public GetPlayerInteriorEx(playerid)
{
	return PlayersDataOnline[playerid][LastInterior];
}
public CheckWeapondCheat(playerid)
{
	if ( PlayersDataOnline[playerid][StateWeaponPass] <= gettime())
	{
		new WeapoindID, AmmoQl;
		for (new i = 0; i < 13; i++)
		{
			GetPlayerWeaponData(playerid, i, WeapoindID, AmmoQl);
			if ( PlayersData[playerid][WeaponS][i] == WeapoindID && PlayersData[playerid][AmmoS][i] >= AmmoQl || AmmoQl == 0)
			{
			 	//   printf("%i - %i || %i - %i", PlayersData[playerid][WeaponS][i], PlayersData[playerid][AmmoS][i], WeapoindID, AmmoQl);
			    PlayersData[playerid][WeaponS][i] = WeapoindID;
	            PlayersData[playerid][AmmoS][i] = AmmoQl;
			}
			else
			{
				PlayersDataOnline[playerid][CountCheat]++;
				if ( PlayersDataOnline[playerid][CountCheat] % 100 == 0 )
				{
					new MsgAvisoWeapon[MAX_TEXT_CHAT];
				    format(MsgAvisoWeapon, sizeof(MsgAvisoWeapon), "%s AntiCheat-Weapon - %s[%i] posible {F1FF00}Weapon Cheat.", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid);
					MsgCheatsReportsToAdmins(MsgAvisoWeapon);
				    printf("%s", MsgAvisoWeapon);
			    }
				return false;
			}
		}
	}
	return true;
}

public HideTextDrawsTelesAndInfo(playerid)
{
	if ( PlayersDataOnline[playerid][InPickupTele] || PlayersDataOnline[playerid][InPickupInfo] )
	{
	    if ( !IsPlayerInRangeOfPoint(playerid, 2.0, PlayersDataOnline[playerid][MyPickupX_Now], PlayersDataOnline[playerid][MyPickupY_Now], PlayersDataOnline[playerid][MyPickupZ_Now]) )
	    {
	        TextDrawHideForPlayer(playerid, PlayersDataOnline[playerid][MyTextDrawShow]);
			PlayersDataOnline[playerid][InPickup] 		= -1;
			PlayersDataOnline[playerid][InPickupTele] 	= false;
			PlayersDataOnline[playerid][InPickupInfo] 	= false;
	    }
	}
}
public UpdateArmourAndArmour(playerid, Float:Health, Float:Armour)
{
	if ( PlayersDataOnline[playerid][VidaOn] >= Health && PlayersDataOnline[playerid][ChalecoOn] >= Armour )
	{
	    PlayersDataOnline[playerid][VidaOn] = Health;
	    PlayersDataOnline[playerid][ChalecoOn] = Armour;
	    return true;
	}
	else
	{
        SetPlayerHealth(playerid, PlayersDataOnline[playerid][VidaOn]);
        SetPlayerArmour(playerid, PlayersDataOnline[playerid][ChalecoOn]);
	    return false;
	}
}
public IsVehicleOpen(playerid, vehicleid, ispassenger)
{
	if (vehicleid > MAX_CAR_GANG ||
	    !DataCars[vehicleid][Lock] && vehicleid <= MAX_CAR_DUENO ||
		IsVehicleMyGang(playerid, vehicleid) && !DataCars[vehicleid][Lock] ||
		strlen(DataCars[vehicleid][Dueno]) == 1 && vehicleid <= MAX_CAR_DUENO
       )
	{
	    return true;
	}
	else
	{
	    if (vehicleid > MAX_CAR_DUENO && !DataCars[vehicleid][Lock] && ispassenger != 0)
	    {
	        return true;
	    }
	    else
	 	{
	    	return false;
    	}
	}
}
public ShowTextDrawFijosVelocimentros(playerid)
{
	TextDrawShowForPlayer(playerid, VelocimetroFijos[0]);
	TextDrawShowForPlayer(playerid, VelocimetroFijos[1]);
	TextDrawShowForPlayer(playerid, VelocimetroFijos[2]);
	TextDrawShowForPlayer(playerid, VelocimetroFijos[3]);
	TextDrawShowForPlayer(playerid, VelocimetroFijos[4]);
	TextDrawShowForPlayer(playerid, VelocimetroFijos[5]);
	TextDrawShowForPlayer(playerid, VelocimetroFijos[6]);
	ShowLockTextDraws(PlayersDataOnline[playerid][InCarId], -1);
}
public UpdateDamage(playerid, &Float:newdamage)
{
	if ( newdamage > DataCars[PlayersDataOnline[playerid][InCarId]][LastDamage] && DataCars[PlayersDataOnline[playerid][InCarId]][VehicleAnticheat] <= gettime() )
	{
		SetVehicleHealth(PlayersDataOnline[playerid][InCarId], DataCars[PlayersDataOnline[playerid][InCarId]][LastDamage]);
		UpdateVehicleDamageStatus(PlayersDataOnline[playerid][InCarId], DataCars[PlayersDataOnline[playerid][InCarId]][PanelS], DataCars[PlayersDataOnline[playerid][InCarId]][DoorS], DataCars[PlayersDataOnline[playerid][InCarId]][LightS], DataCars[PlayersDataOnline[playerid][InCarId]][TiresS]);
		newdamage = DataCars[PlayersDataOnline[playerid][InCarId]][LastDamage];
/*		new MsgAviso[MAX_TEXT_CHAT];
		format(MsgAviso, sizeof(MsgAviso), "%s AntiCheat-Repair - %s[%i] posible cheat de repair vehicle. Datos: ID del vehículo %i", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, PlayersDataOnline[playerid][InCarId]);
		MsgCheatsReportsToAdmins(MsgAviso);*/
	}
	else
	{
		new IntDamage = floatround(newdamage / 9.34);
		TextDrawHideForPlayer(playerid, BarsDamage[PlayersDataOnline[playerid][LastDamageInt]]);
		TextDrawShowForPlayer(playerid, BarsDamage[IntDamage]);
		PlayersDataOnline[playerid][LastDamageInt] = IntDamage;
		GetVehicleDamageStatus(PlayersDataOnline[playerid][InCarId], DataCars[PlayersDataOnline[playerid][InCarId]][PanelS], DataCars[PlayersDataOnline[playerid][InCarId]][DoorS], DataCars[PlayersDataOnline[playerid][InCarId]][LightS], DataCars[PlayersDataOnline[playerid][InCarId]][TiresS]);
	}
}
public UpdateGasAndOil(vehicleid)
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	    if ( IsPlayerConnected(i) && PlayersDataOnline[i][InCarId] == vehicleid)
	    {
			TextDrawHideForPlayer(i, BarsGas[PlayersDataOnline[i][LastGas]]);
			TextDrawShowForPlayer(i, BarsGas[DataCars[vehicleid][Gas]]);
			PlayersDataOnline[i][LastGas] = DataCars[vehicleid][Gas];
		}
	}
}
public OnPlayerEnterVehicleEx(playerid, vehicleid, ispassenger)
{
	PlayersDataOnline[playerid][CountIntentarVehicle] = false;
}
public OnPlayerExitVehicleEx(playerid, vehicleid, ispassenger)
{

}
public IsFixBikeEnter(playerid, vehicleid)
{
    if ( coches_Todos_Type[GetVehicleModel(vehicleid) - 400] == MOTO || coches_Todos_Type[GetVehicleModel(vehicleid) - 400] == TREN || coches_Todos_Type[GetVehicleModel(vehicleid) - 400] == BOTE)
	{
	    new Float:PosFixVeh[3]; GetPlayerPos(playerid, PosFixVeh[0], PosFixVeh[1], PosFixVeh[2]);
	    SetPlayerPos(playerid, PosFixVeh[0], PosFixVeh[1], PosFixVeh[2] + 2);
	    return true;
	}
	else
	{
	    return false;
	}
}
public UpdateTextDrawVehicle(playerid, vehicleid)
{
	new Float:Velocity[3], StringVelocity[3];
	GetVehicleVelocity(vehicleid, Velocity[0], Velocity[1], Velocity[2]);
//	new Float:VelocityInt = (floatabs(Velocity[0]) + floatabs(Velocity[1]) + floatabs(Velocity[2])) * 70;
	new VelocityInt = floatround(floatsqroot(floatpower(floatabs(Velocity[0]), 2.0) + floatpower(floatabs(Velocity[1]), 2.0) + floatpower(floatabs(Velocity[2]), 2.0)) * 120.0);
	format(StringVelocity, sizeof(StringVelocity), "%i", VelocityInt);

	TextDrawHideForPlayer(playerid, VelocimetroNumber1[PlayersDataOnline[playerid][LastVel][0]]);
	TextDrawHideForPlayer(playerid, VelocimetroNumber2[PlayersDataOnline[playerid][LastVel][1]]);
	TextDrawHideForPlayer(playerid, VelocimetroNumber3[PlayersDataOnline[playerid][LastVel][2]]);

	StringVelocity[0] = AbsVel(StringVelocity[0]);
	StringVelocity[1] = AbsVel(StringVelocity[1]);

	TextDrawShowForPlayer(playerid, VelocimetroNumber1[StringVelocity[0]]);
	if ( VelocityInt >= 10 )
	{
		TextDrawShowForPlayer(playerid, VelocimetroNumber2[StringVelocity[1]]);
		if ( VelocityInt >= 100 )
		{
			TextDrawShowForPlayer(playerid, VelocimetroNumber3[VelocityInt%10]);
		}
	}

	PlayersDataOnline[playerid][LastVel][0] = StringVelocity[0];
	PlayersDataOnline[playerid][LastVel][1] = StringVelocity[1];
	PlayersDataOnline[playerid][LastVel][2] = VelocityInt%10;

	new Float:Estado; GetVehicleHealth(vehicleid, Estado);
	if ( coches_Todos_Velocidad[DataCars[vehicleid][Modelo] - 400] )
	{
     		//PlayPlayerStreamSound(playerid, 1056);
	}
	if ( (DataCars[vehicleid][LastDamage] - Estado) != 0 )
	{
	    if ( (DataCars[vehicleid][LastDamage] - Estado) > 0.0 )
	    {
			RepairVehicle(vehicleid);
			SetVehicleHealthEx(vehicleid, 1000.0);
			Estado = 1000.0;
			UpdatePlayerVehicleStatus(vehicleid, (DataCars[vehicleid][LastDamage] - Estado) / 10);
		}
		UpdateDamage(playerid, Estado);
	}
	DataCars[vehicleid][LastDamage] 		= Estado;
	return true;
}
public RemovePlayerFromVehicleEx(playerid, seat, time)
{
	if (!seat)
	{
	    if ( !PlayersDataOnline[playerid][StateDeath] && PlayersData[playerid][IsInJail] == -1 )
	    {
			if ( PlayersDataOnline[playerid][StateMoneyPass] <= time )
			{
			    if ( !DataCars[PlayersDataOnline[playerid][InCarId]][VehicleDeath] )
			    {
					new Float:PlayerPos[3]; GetPlayerPos(playerid, PlayerPos[0], PlayerPos[1], PlayerPos[2]);
					new Float:VehiclePos[3]; GetVehiclePos(PlayersDataOnline[playerid][InCarId], VehiclePos[0], VehiclePos[1], VehiclePos[2]);
					if ( !IsPointFromPoint(50.0, PlayerPos[0], PlayerPos[1], PlayerPos[2], VehiclePos[0], VehiclePos[1], VehiclePos[2]) )
					{
				    	SetVehiclePos(PlayersDataOnline[playerid][InCarId], PlayerPos[0], PlayerPos[1] + 1, PlayerPos[2]);
			    	}
		    	}
			}
		}

	    if ( PlayersDataOnline[playerid][InCarId] == TramSFID )
		{
			SetCameraBehindPlayer(playerid);
		}

		HideTextDrawFijosVelocimentros(playerid);
		TextDrawHideForPlayer(playerid, BarsDamage[PlayersDataOnline[playerid][LastDamageInt]]);
		TextDrawHideForPlayer(playerid, BarsGas[PlayersDataOnline[playerid][LastGas]]);
		TextDrawHideForPlayer(playerid, VelocimetroNumber1[PlayersDataOnline[playerid][LastVel][0]]);
		TextDrawHideForPlayer(playerid, VelocimetroNumber2[PlayersDataOnline[playerid][LastVel][1]]);
		TextDrawHideForPlayer(playerid, VelocimetroNumber3[PlayersDataOnline[playerid][LastVel][2]]);
		TextDrawHideForPlayer(playerid, TemperaturaTextDraws[PlayersDataOnline[playerid][LastTextDrawTemperatura]]);

		PlayersDataOnline[playerid][InCarId] = false;
		TogglePlayerControllableEx(playerid, true);

	}
	else
	{
    	PlayersDataOnline[playerid][InVehicle] = false;
	}
}
public IsVehicleMyGang(playerid, vehicleid)
{
	if ( PlayersData[playerid][Gang] != SINGANG && PlayersData[playerid][Gang] == DataCars[vehicleid][Time] && vehicleid > MAX_CAR_DUENO && vehicleid <= MAX_CAR_GANG)
	{
	    return true;
	}
	else
	{
	    return false;
	}
}
public AbsVel(numberAscci)
{
	if ( numberAscci - 48 >= 0 )
	{
	    return (numberAscci - 48);
	}
	else
	{
    	return false;
	}
}
public UpdatePlayerVehicleStatus(vehicleid , Float:Healt)
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if ( IsPlayerConnected(i) && IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == vehicleid )
		{
			SetPlayerHealthEx(i, -Healt);
			if ( coches_Todos_Type[GetVehicleModel(GetPlayerVehicleID(i)) - 400] != MOTO )
			{
				ApplyPlayerAnimCustom(i,
				"PED",
				PED_ANIMATIONS[23], false);
				if ( GetPlayerVehicleSeat(i) == 0 )
				{
				    SetTimerEx("ApplyPlayerAnimAccidentD", 1000, false, "d",i);
				}
				else
				{
				    SetTimerEx("ApplyPlayerAnimAccident", 1000, false, "d",i);
				}
			}
		    if ( Healt >= 20 )
		    {
			    SetPlayerWeather(i, -15);
			    SetPlayerDrunkLevel(i, 50000);
				SetTimerEx("ReturnPlayerNormalState", 15000, false, "d", i);
		    }
		}
	}
}
public IsPointFromPoint(Float:RadioE, Float:XpointOne, Float:YpointOne, Float:ZpointOne, Float:XpointTwo, Float:YpointTwo, Float:ZpointTwo)
{
	if ( floatabs(XpointOne - XpointTwo) <= RadioE &&
		 floatabs(YpointOne - YpointTwo) <= RadioE &&
		 floatabs(ZpointOne - ZpointTwo) <= RadioE
	   )
	{
	    return true;
    }
    else
    {
        return false;
	}
}
public HideTextDrawFijosVelocimentros(playerid)
{
	TextDrawHideForPlayer(playerid, VelocimetroFijos[0]);
	TextDrawHideForPlayer(playerid, VelocimetroFijos[1]);
	TextDrawHideForPlayer(playerid, VelocimetroFijos[2]);
	TextDrawHideForPlayer(playerid, VelocimetroFijos[3]);
	TextDrawHideForPlayer(playerid, VelocimetroFijos[4]);
	TextDrawHideForPlayer(playerid, VelocimetroFijos[5]);
	TextDrawHideForPlayer(playerid, VelocimetroFijos[6]);
    if ( !DataCars[PlayersDataOnline[playerid][InCarId]][Lock] )
    {
	    TextDrawHideForPlayer(playerid, VelocimetroFijos[7]);
    }
    else
    {
	    TextDrawHideForPlayer(playerid, VelocimetroFijos[8]);
    }
}
public LoadCamerasLogin()
{
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][0] = 0.0;//1624.5200,-1179.5583,75.5165
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][1] = 0.0;//SetPlayerCameraPos(playerid, -1976.7773, -71.5020, 52.7263);
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][2] = 0.0;

	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][0] = -1690.5367;//1656.6953,-1270.7322,82.6283
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][1] = 861.5380;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][2] = 53.4397;

	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][0] = -1691.3171;//1602.2152,-1788.6689,37.0291
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][1] = 860.9173;// -1691.3171,860.9173,53.1497
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][2] = 53.1497;
	
	MAX_CAMERAS_LOGIN++;
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][0] = 2097.7078;// 2097.7078,1825.1970,0.0
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][1] = 1825.1970;
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][2] = 0.0;

	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][0] = 2097.7078;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][1] = 1825.1970;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][2] = 10.8203;

	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][0] = 2057.4226;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][1] = 1497.5380;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][2] = 103.0167;

	MAX_CAMERAS_LOGIN++;
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][0] = 1624.5200;
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][1] = -1179.5583;
	CamerasLogin[MAX_CAMERAS_LOGIN][PlayerPosLogin][2] = 75.5165;

	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][0] = 1656.6953;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][1] = -1270.7322;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasPosLogin][2] = 82.6283;

	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][0] = 1602.2152;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][1] = -1788.6689;
	CamerasLogin[MAX_CAMERAS_LOGIN][CamerasLookLogin][2] = 37.0291;
}
public CreateTextDrawGas()
{
	for (new i = 0; i <= MAX_GAS_VEHICLE; i++)
	{
		BarsGas[i] = TextDrawCreateEx(488.0, 412.0,"_");
		TextDrawUseBox(BarsGas[i], 1);
		TextDrawBackgroundColor(BarsGas[i] ,0x00000000);
		TextDrawColor(BarsGas[i], 0x00000000);
		TextDrawBoxColor(BarsGas[i], 0x2EFF03FF);
		TextDrawTextSize(BarsGas[i], 488.0 + i, 421.0);
		TextDrawSetShadow(BarsGas[i], 1);
		TextDrawLetterSize(BarsGas[i], 0.1 , 0.1);
	}
}
public IsPlayerNear(myplayerid, playerid, iderror1[], iderror2[], iderror3[], stringerror1[], stringerror2[], stringerror3[])
{
	if ( myplayerid != playerid )
	{
		if ( IsPlayerConnected(playerid) )
		{
			if (PlayersDataOnline[playerid][State] == 3)
			{
			    new Float:MyPos[3];
			    GetPlayerPos(myplayerid, MyPos[0], MyPos[1], MyPos[2]);
			    if ( IsPlayerInRangeOfPoint(playerid, 4.0, MyPos[0], MyPos[1], MyPos[2]) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(myplayerid)  )
			    {
			        return true;
	   			}
	   			else
	   			{
					SendInfoMessage(myplayerid, 0, iderror3, stringerror3);
				}
			}
			else
			{
				SendInfoMessage(myplayerid, 0, iderror2, stringerror2);
			}
		}
		else
		{
			SendInfoMessage(myplayerid, 0, iderror1, stringerror1);
		}
	}
	else
	{
		SendInfoMessage(myplayerid, 0, "213", "Has introducído tu misma ID");
	}
	return false;
}
public SetPlayerSelectedTypeSkin(playerid, option)
{
	if ( option )
	{
		PlayersDataOnline[playerid][TypeSkinList] = false;
	    SetPlayerSelectedSkin(playerid);
	}
	else
	{
		ShowPlayerDialogEx(playerid, 4, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Skin Gangster","{F0F0F0}Seleccione su skin de Gangster", "Ok","");
		PlayersDataOnline[playerid][TypeSkinList] = true;
		SetPlayerSelectedSkin(playerid);
	}

	GetSpawnInfo(playerid);
	PlayersDataOnline[playerid][Spawn]      = false;
	SetPlayerVirtualWorldEx(playerid, playerid);

	TogglePlayerControllableEx(playerid, 0);
	SetPlayerInteriorEx(playerid, 5);
	SetPlayerPos(playerid, 224.4991, -3.8912, 1002.2109);
	SetPlayerFacingAngle(playerid, 175.9992);
	SetPlayerCameraPos(playerid, 224.5770, -8.4474, 1003.1682);
	SetPlayerCameraLookAt(playerid, 224.5822, -7.4487, 1003.1475);
}
public SetPlayerSelectedSkin(playerid)
{
	PlayersDataOnline[playerid][RowSkin] = 0;
	SetPlayerRowSkin(playerid, false);
}
public SetPlayerRowSkin(playerid, response)
{
    if ( response == 0 )
    {
	    if (!PlayersDataOnline[playerid][TypeSkinList] && PlayersData[playerid][Gang] != SINGANG )
	    {
	        if ( RangosSkins[PlayersData[playerid][Gang]][PlayersData[playerid][Rango]][PlayersDataOnline[playerid][RowSkin]] != 0 )
	        {
			    PlayersData[playerid][Skin] = RangosSkins[PlayersData[playerid][Gang]][PlayersData[playerid][Rango]][PlayersDataOnline[playerid][RowSkin]];
	            SetPlayerSkinEx(playerid, RangosSkins[PlayersData[playerid][Gang]][PlayersData[playerid][Rango]][PlayersDataOnline[playerid][RowSkin]]);
	            PlayersDataOnline[playerid][RowSkin]++;
			}
			else
			{
			    PlayersData[playerid][Skin] = RangosSkins[PlayersData[playerid][Gang]][PlayersData[playerid][Rango]][0];
				SetPlayerSkinEx(playerid, RangosSkins[PlayersData[playerid][Gang]][PlayersData[playerid][Rango]][0]);
				PlayersDataOnline[playerid][RowSkin] = 1;
			}
		}
		else if ( PlayersDataOnline[playerid][TypeSkinList] )
		{
	        if ( SKIN_CIVILES[PlayersDataOnline[playerid][RowSkin]] != 999 )
	        {
	            while ( SKIN_CIVILES[PlayersDataOnline[playerid][RowSkin]] == 0 )
	            {
	                PlayersDataOnline[playerid][RowSkin]++;
				}
			    PlayersData[playerid][Skin] = SKIN_CIVILES[PlayersDataOnline[playerid][RowSkin]];
	            SetPlayerSkinEx(playerid, SKIN_CIVILES[PlayersDataOnline[playerid][RowSkin]]);
	            PlayersDataOnline[playerid][RowSkin]++;
			}
			else
			{
			    PlayersData[playerid][Skin] = SKIN_CIVILES[0];
				SetPlayerSkinEx(playerid, SKIN_CIVILES[0]);
				PlayersDataOnline[playerid][RowSkin] = 1;
			}
		}
		PlayersData[playerid][Skin] = GetPlayerSkin(playerid);
		ShowPlayerDialogEx(playerid, 5, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Seleccione el skin", "{F0F0F0}Si quiere éste skin seleccione \"Escoger\"", "Escoger", "Siguiente");
	}
	else
	{
	    UpdateSpawnPlayer(playerid);
		PlayersDataOnline[playerid][StateDeath] = true;
	    SpawnPlayerEx(playerid);
		//Streamer_UpdateEx(playerid, GangData[PlayersData[playerid][Gang]][Spawn_X], GangData[PlayersData[playerid][Gang]][Spawn_Y], GangData[PlayersData[playerid][Gang]][Spawn_Z]);
		PlayersDataOnline[playerid][Spawn]      = true;
		TogglePlayerControllableEx(playerid, 1);
		SetSpawnInfoEx(playerid);
	}
}
public SetPlayerSkinEx(playerid, skinid)
{
	SetPlayerSkin(playerid, skinid);
}
public SetPlayerGang(playerid, cmdfaccion[])
{
    if (PlayersData[playerid][Admin] >= 8)
    {
		if ( strlen(cmdfaccion) > 10)
		{

			new Datos_PicadosGang[3][10];
			            	// 00  	= 	"/Jail"
							// 01	= 	ID
							// 02   =   ID_FACCION
		       // DatosOriginales   =   RANGO

			new DatosOriginales[150];
			format(DatosOriginales, sizeof(DatosOriginales), "%s ", cmdfaccion);
			new wPos;
   			for (new i = 0; i < 3; i++)
    		{
				wPos = strfind(DatosOriginales, " ", false); // HOLA³QUE³PASA³
				strmid(Datos_PicadosGang[i], DatosOriginales, 0, wPos, sizeof(DatosOriginales));
				strdel(DatosOriginales, 0, wPos + 1);
			}

			if ( IsPlayerConnected(strval(Datos_PicadosGang[1])) )
			{
				if ( strval(Datos_PicadosGang[2]) >= SINGANG && strval(Datos_PicadosGang[2]) <= MAX_GANG )
				{
					if ( strval(DatosOriginales) <= GetMaxGangRango(strval(Datos_PicadosGang[2])) || strval(Datos_PicadosGang[2]) == 0 )
					{
                        PlayersData[strval(Datos_PicadosGang[1])][Gang] = strval(Datos_PicadosGang[2]);
                        PlayersData[strval(Datos_PicadosGang[1])][SpawnFac] = 0;
						if ( strval(Datos_PicadosGang[2]) != SINGANG )
						{
	                        PlayersData[strval(Datos_PicadosGang[1])][Rango]   = strval(DatosOriginales);
							PlayersData[strval(Datos_PicadosGang[1])][Skin] = RangosSkins[PlayersData[strval(Datos_PicadosGang[1])][Gang]][PlayersData[strval(Datos_PicadosGang[1])][Rango]][0];
							SetPlayerSkinEx(strval(Datos_PicadosGang[1]), RangosSkins[PlayersData[strval(Datos_PicadosGang[1])][Gang]][PlayersData[strval(Datos_PicadosGang[1])][Rango]][0]);

						}
						else
						{
		                    PlayersData[strval(Datos_PicadosGang[1])][Rango]   = 7;
						    PlayersData[strval(Datos_PicadosGang[1])][Skin] = 299;
						    SetPlayerSkinEx(strval(Datos_PicadosGang[1]), 299);
						}

						new MsgAcceptUser[MAX_TEXT_CHAT]; format(MsgAcceptUser, sizeof(MsgAcceptUser), "Metíste a %s a la Gang \"%s\" con rango \"%s\"", PlayersDataOnline[strval(Datos_PicadosGang[1])][NameOnline], GangData[strval(Datos_PicadosGang[2])][NameGang], GangesRangos[strval(Datos_PicadosGang[2])][PlayersData[strval(Datos_PicadosGang[1])][Rango]]);
						new MsgAcceptMe[MAX_TEXT_CHAT]; format(MsgAcceptMe, sizeof(MsgAcceptMe), "El administrador %s te ha metido ha la Gang \"%s\" con rango \"%s\"", PlayersDataOnline[playerid][NameOnline], GangData[strval(Datos_PicadosGang[2])][NameGang], GangesRangos[strval(Datos_PicadosGang[2])][PlayersData[strval(Datos_PicadosGang[1])][Rango]]);
                        SendInfoMessage(strval(Datos_PicadosGang[1]), 3, "0", MsgAcceptMe);
                        SendInfoMessage(playerid, 3, "0", MsgAcceptUser);

//						SetPlayerLockAllVehicles(strval(Datos_PicadosGang[1]));
						UpdateSpawnPlayer(strval(Datos_PicadosGang[1]));
						SetPlayerTeamEx(strval(Datos_PicadosGang[1]));
						SetPlayerColorEx(strval(Datos_PicadosGang[1]));
					}
					else
					{
						SendInfoMessage(playerid, 0, "046", "La rango que introdujo no existe para esa Gang");
					}
				}
				else
				{
					SendInfoMessage(playerid, 0, "047", "El ID de la Gang que introdujo no existe");
				}
			}
			else
			{
				SendInfoMessage(playerid, 0, "048", "El jugador que desea cambiar de Gang no se encuentra conectado");
			}
		}
		else
		{
			SendInfoMessage(playerid, 0, "049", "Ha introducído mal el sintaxis del comando /Gang. Ejemplo correcto: /Gang 2 8 2.");
		}
	}
	else
	{
		SendInfoMessage(playerid, 0, "050", "Tú no tienes acceso a el comando /Gang.");
	}
}
public Comandos_Admin(Comando, playerid, playeridAC, LV, Cantidad_o_Tipo, String[])
{
	///////// COMANDOS DE LA ADMINISTRACIÓN
	switch (Comando)
	{
		//		/Staff [ID] [Nivel]				- Dar un nivel a un miembro de el Staff
		case 1:
		{
			new StringFormat[120];
			new StringFormatEX[100];

   		    if (PlayersData[playeridAC][Admin] == 0)
   		    {
				format(StringFormat, sizeof(StringFormat), "%s %s Bienvenido al Staff de StreetGangWars!", LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline]);
				format(StringFormatEX, sizeof(StringFormatEX), "%s Has metido a ser parte del Staff a %s [%i] con nivel %i ",LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], playeridAC, Cantidad_o_Tipo);
			}
			else if (Cantidad_o_Tipo == 0)
			{
				format(StringFormatEX, sizeof(StringFormatEX), "%s has expulsado del Staff a %s [%i] ", LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], Cantidad_o_Tipo);
  				format(StringFormat, sizeof(StringFormat), "%s %s Te ha expulsado del Staff!", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline]);
			}
			else
			{
				format(StringFormatEX, sizeof(StringFormatEX), "%s Has asignado el nivel %i a %s [%i] ", LOGO_STAFF, Cantidad_o_Tipo, PlayersDataOnline[playeridAC][NameOnline], playeridAC);
  				format(StringFormat, sizeof(StringFormat), "%s %s te han asignado el nivel %i de Staff", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], Cantidad_o_Tipo);
			}

			PlayersData[playeridAC][Admin] = Cantidad_o_Tipo;
            SendClientMessage(playeridAC, COLOR_MENSAJES_DE_AVISOS, StringFormat);
            SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormatEX);

            return 1;
		}
		//		/IR [ID]						- Ir a la poición de un jugador
        case 2:
        {
			new StringFormat[120];
			new StringFormatEX[100];
			format(StringFormat, sizeof(StringFormat), "%s %s se ha teletrasportado a tu posición.",LOGO_STAFF, PlayersDataOnline[playerid][NameOnline]);
			format(StringFormatEX, sizeof(StringFormatEX), "%s Has ido hacia %s [%i]",LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], playeridAC);


            new Float:meX, Float:meY, Float:meZ;
			GetPlayerPos(playeridAC, meX, meY, meZ);

			if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && GetPlayerInteriorEx(playeridAC) == 0 && GetPlayerInteriorEx(playerid) == 0)
			{
				new CocheTraer = GetPlayerVehicleID(playerid);
				SetVehiclePos(CocheTraer, meX, meY + 2, meZ + 1);
			}
			else
			{
			    if (IsPlayerInAnyVehicle(playerid))
			    {
				    PlayersDataOnline[playerid][StateMoneyPass] 	= gettime() + 5;
				}
				SetPlayerPos(playerid, meX, meY + 2, meZ + 1);
			}

			PlayersData[playerid][IsPlayerInBizz] 				= PlayersData[playeridAC][IsPlayerInBizz];
			PlayersData[playerid][IsPlayerInBank] 				= PlayersData[playeridAC][IsPlayerInBank];
			PlayersData[playerid][IsPlayerInGarage] 			= PlayersData[playeridAC][IsPlayerInGarage];
			PlayersData[playerid][IsPlayerInVehInt] 			= PlayersData[playeridAC][IsPlayerInVehInt];


            SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(playeridAC));
			SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorld(playeridAC));

            SendClientMessage(playeridAC, COLOR_MENSAJES_DE_AVISOS, StringFormat);
            SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormatEX);
			return 1;
        }
		//		/Matar [ID]                - Matar a un jugador
		case 3:
		{
			new StringFormat[120];
			new StringFormatEX[100];

			if ( playeridAC != playerid)
			{
				format(StringFormat, sizeof(StringFormat), "%s te ha matado %s con el comando /Matar [ID].",LOGO_STAFF, PlayersDataOnline[playerid][NameOnline]);
				format(StringFormatEX, sizeof(StringFormatEX), "%s has matado a %s [%i] con el comando /Matar [ID].",LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], playeridAC);
	            SendClientMessage(playeridAC, COLOR_MENSAJES_DE_AVISOS, StringFormat);
			}
			else
			{
				format(StringFormatEX, sizeof(StringFormatEX), "%s Te has matado tú mismo con el comando /Matar [ID].",LOGO_STAFF);
			}
			UpdateSpawnPlayer(playerid);

            SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormatEX);

			// Asignamos 0 de vida para matar a el jugador
			SetPlayerHealthEx(playeridAC, -100);
			return 1;
		}
		// 		/TRAER [ID]						- Traer un jugador a tu posición
        case 4:
        {
			new StringFormat[120];
			new StringFormatEX[100];
			format(StringFormat, sizeof(StringFormat), "%s %s te ha teletrasportado a su posición.",LOGO_STAFF, PlayersDataOnline[playerid][NameOnline]);
			format(StringFormatEX, sizeof(StringFormatEX), "%s Has traido hacia a tí a %s [%i]",LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], playeridAC);

			new Float:acX, Float:acY, Float:acZ;
			GetPlayerPos(playerid, acX, acY, acZ);
			if ( IsPlayerInAnyVehicle(playeridAC) && GetPlayerVehicleSeat(playeridAC) == 0 && GetPlayerInteriorEx(playerid) == 0 && GetPlayerInteriorEx(playeridAC) == 0)
			{
				new CocheTraer = GetPlayerVehicleID(playeridAC);
				SetVehiclePos(CocheTraer, acX, acY + 2, acZ + 1);
			}
			else
			{
			    if (IsPlayerInAnyVehicle(playeridAC))
			    {
				    PlayersDataOnline[playeridAC][StateMoneyPass] 	= gettime() + 5;
				}
				SetPlayerPos(playeridAC, acX, acY + 2, acZ + 1);
			}

			PlayersData[playeridAC][IsPlayerInBizz] 			= PlayersData[playerid][IsPlayerInBizz];
			PlayersData[playeridAC][IsPlayerInBank] 			= PlayersData[playerid][IsPlayerInBank];
			PlayersData[playeridAC][IsPlayerInGarage]      		= PlayersData[playerid][IsPlayerInGarage];
			PlayersData[playeridAC][IsPlayerInVehInt] 			= PlayersData[playerid][IsPlayerInVehInt];

			SetPlayerInteriorEx(playeridAC, GetPlayerInteriorEx(playerid));
			SetPlayerVirtualWorldEx(playeridAC, GetPlayerVirtualWorld(playerid));

            SendClientMessage(playeridAC, COLOR_MENSAJES_DE_AVISOS, StringFormat);
            SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormatEX);
			return 1;
        }
		//		/BAN [ID] [Razón]				- Banear a un jugador
        case 5:
        {
			new StringFormat[250];
			new StringFormatEX[100];
			format(StringFormat, sizeof(StringFormat), "%s Han baneado a %s por %s. {F1FF00}Razón: %s",LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], PlayersDataOnline[playerid][NameOnline], String);
			format(StringFormatEX, sizeof(StringFormatEX), "%s Has baneado a %s[%i].",LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], playeridAC);
            MsgKBJWReportsToAdmins(playeridAC, StringFormat);
            SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormatEX);
            SendClientMessage(playeridAC, COLOR_MENSAJES_DE_AVISOS, "Ayuda: Recuerda sacar una Screen/Foto en este momento presionando la tecla \"F8\" será de mucha ayuda en su desban.");

			PlayersData[playeridAC][AccountState] = 3;
			BanEx(playeridAC, StringFormat);

            return 1;
        }
        // 		/KICK [ID] [Razón]				- Kikear a un jugador
        case 6:
        {
			new StringFormat[250];
			new StringFormatEX[100];
			format(StringFormat, sizeof(StringFormat), "%s Han kickeado a %s por %s. {F1FF00}Razón: %s",LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], PlayersDataOnline[playerid][NameOnline], String);
			format(StringFormatEX, sizeof(StringFormatEX), "%s Has kickeado a %s[%i].",LOGO_STAFF, PlayersDataOnline[playeridAC][NameOnline], playeridAC);
            MsgKBJWReportsToAdmins(playeridAC, StringFormat);
            SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormatEX);

			print(StringFormat);
			KickEx(playeridAC, 6);

            return 1;
        }
		//		/RESPAWN TODOS					- Respawear todos los coches
		case 7:
		{
			new StringFormat[120];
			format(StringFormat, sizeof(StringFormat), "%s Has echo un respawn general.",LOGO_STAFF);
            SendClientMessage(playerid, COLOR_MENSAJES_DE_AVISOS, StringFormat);

			new IsRespawn[MAX_VEHICLE_COUNT];
			for (new i = 0; i < MAX_PLAYERS; i++)
			{
				if( IsPlayerConnected(i) && IsPlayerInAnyVehicle(i) == 1 && GetPlayerVehicleSeat(i) == 0 )
				{
				    IsRespawn[GetPlayerVehicleID(i)] = 1;
				}
			}

			for (new i = 1; i <= MAX_CAR; i++)
			{
			    if ( IsRespawn[i] != 1 )
			    {
					SetVehicleToRespawnExTwo(i);
				}
		    }
		    return 1;
		}
        // 		/ESPECTAR [ID]					- Espectar a un jugador
        case 8:
        {       // 01 - Espectando
                // 02 - Desactivar espectar
            if (Cantidad_o_Tipo == 1)
            {
				SetPlayerSpectateToPlayer(playerid, playeridAC);
			}
			else if (Cantidad_o_Tipo == 2)
			{
			    if ( !RemoveSpectatePlayer(playerid) )
			    {
	    			SendInfoMessage(playerid, 0, "214", "No estas espectando a nadie, el comando [/Espectar] sin ID, indica volver a tu posición.");
			    }
			}
			return 1;
        }
	}
    return 1;
}


public LoadMenuStatic()
{

//=======================================================================================
//=======================================================================================
/////////// MENUS NEGOCIOS

	// CluckinBell;
    CluckinBell	 = CreateMenu("Cluckin' Bell", 2, 300.0, 200.0, 250.0, 70.0);
	AddMenuItem(CluckinBell, 0, "The Little");  				AddMenuItem(CluckinBell, 1, "$12");	CluckinBellPrecios[0] = 12;
	AddMenuItem(CluckinBell, 0, "Cluker");  					AddMenuItem(CluckinBell, 1, "$14"); CluckinBellPrecios[1] = 14;
	AddMenuItem(CluckinBell, 0, "Kids Meal");  					AddMenuItem(CluckinBell, 1, "$16");	CluckinBellPrecios[2] = 16;
	AddMenuItem(CluckinBell, 0, "Cluker Mediana");  			AddMenuItem(CluckinBell, 1, "$18");	CluckinBellPrecios[3] = 18;
	AddMenuItem(CluckinBell, 0, "Super Cluker");  				AddMenuItem(CluckinBell, 1, "$22");	CluckinBellPrecios[4] = 22;
	AddMenuItem(CluckinBell, 0, "Cluker' Bell + Coca Cola");  	AddMenuItem(CluckinBell, 1, "$25");	CluckinBellPrecios[5] = 25;
	AddMenuItem(CluckinBell, 0, "Especial Bell");  				AddMenuItem(CluckinBell, 1, "$30");	CluckinBellPrecios[6] = 30;
	// BurgerShot;
    BurgerShot	 = CreateMenu("Burger Shot", 2, 300.0, 200.0, 250.0, 70.0);
	AddMenuItem(BurgerShot, 0, "Simple Shot");  		AddMenuItem(BurgerShot, 1, "$14"); 	BurgerShotPrecios[0] = 14;
	AddMenuItem(BurgerShot, 0, "Doble Barreled");  		AddMenuItem(BurgerShot, 1, "$15"); 	BurgerShotPrecios[1] = 15;
	AddMenuItem(BurgerShot, 0, "Buckshot Especial");	AddMenuItem(BurgerShot, 1, "$18"); 	BurgerShotPrecios[2] = 18;
	AddMenuItem(BurgerShot, 0, "Parilla vegetariana"); 	AddMenuItem(BurgerShot, 1, "$17"); 	BurgerShotPrecios[3] = 17;
	AddMenuItem(BurgerShot, 0, "Filete de Mariscos");	AddMenuItem(BurgerShot, 1, "$35");	BurgerShotPrecios[4] = 35;
	AddMenuItem(BurgerShot, 0, "Pollo Bits");			AddMenuItem(BurgerShot, 1, "$30");	BurgerShotPrecios[5] = 30;
	AddMenuItem(BurgerShot, 0, "Caf\x9e");  			AddMenuItem(BurgerShot, 1, "$15");	BurgerShotPrecios[6] = 15;
	AddMenuItem(BurgerShot, 0, "Shake");  				AddMenuItem(BurgerShot, 1, "$16");	BurgerShotPrecios[7] = 16;
	// PizzaStack;
    PizzaStack	 = CreateMenu("Pizza Stack", 2, 300.0, 200.0, 250.0, 70.0);
	AddMenuItem(PizzaStack, 0, "The Bustert");  				AddMenuItem(PizzaStack, 1, "$14"); 	PizzaStackPrecios[0] = 14;
	AddMenuItem(PizzaStack, 0, "The Double D-Lux");  			AddMenuItem(PizzaStack, 1, "$15"); 	PizzaStackPrecios[1] = 15;
	AddMenuItem(PizzaStack, 0, "The Full Rack");				AddMenuItem(PizzaStack, 1, "$18"); 	PizzaStackPrecios[2] = 18;
	AddMenuItem(PizzaStack, 0, "Pizza Jam\xa6n y Queso"); 		AddMenuItem(PizzaStack, 1, "$22"); 	PizzaStackPrecios[3] = 22;
	AddMenuItem(PizzaStack, 0, "Pizza Comepleta + Coca Cola");	AddMenuItem(PizzaStack, 1, "$28");	PizzaStackPrecios[4] = 28;
	AddMenuItem(PizzaStack, 0, "Plato Del Hoy");				AddMenuItem(PizzaStack, 1, "$25");	PizzaStackPrecios[5] = 25;
	AddMenuItem(PizzaStack, 0, "Especial Pizza Familiar");		AddMenuItem(PizzaStack, 1, "$40");	PizzaStackPrecios[6] = 40;
	// JaysDiner;
    JaysDiner	 = CreateMenu("Jay's Diner", 2, 300.0, 200.0, 250.0, 70.0);
	AddMenuItem(JaysDiner, 0, "Spunk");  				AddMenuItem(JaysDiner, 1, "$14"); 	JaysDinerPrecios[0] = 14;
	AddMenuItem(JaysDiner, 0, "Bocadillo + Spunk");  	AddMenuItem(JaysDiner, 1, "$20"); 	JaysDinerPrecios[1] = 20;
	AddMenuItem(JaysDiner, 0, "Almuerzo Sencillo");		AddMenuItem(JaysDiner, 1, "$28"); 	JaysDinerPrecios[2] = 28;
	AddMenuItem(JaysDiner, 0, "Pollo a la Parilla"); 	AddMenuItem(JaysDiner, 1, "$22"); 	JaysDinerPrecios[3] = 22;
	AddMenuItem(JaysDiner, 0, "Cena completa");			AddMenuItem(JaysDiner, 1, "$60");	JaysDinerPrecios[4] = 60;
	AddMenuItem(JaysDiner, 0, "Caf\x9e");				AddMenuItem(JaysDiner, 1, "$15");	JaysDinerPrecios[5] = 15;
	AddMenuItem(JaysDiner, 0, "Postre");				AddMenuItem(JaysDiner, 1, "$19");	JaysDinerPrecios[6] = 19;
	// RingDonuts;
    RingDonuts	 = CreateMenu("Ring Donuts", 2, 300.0, 200.0, 250.0, 70.0);
	AddMenuItem(RingDonuts, 0, "Battered Ring");  				AddMenuItem(RingDonuts, 1, "$14"); 	RingDonutsPrecios[0] = 14;
	AddMenuItem(RingDonuts, 0, "Ring Donuts");  				AddMenuItem(RingDonuts, 1, "$15"); 	RingDonutsPrecios[1] = 15;
	AddMenuItem(RingDonuts, 0, "Especial Ring");				AddMenuItem(RingDonuts, 1, "$18"); 	RingDonutsPrecios[2] = 18;
	AddMenuItem(RingDonuts, 0, "Ring Dung del D\xa2a"); 		AddMenuItem(RingDonuts, 1, "$22"); 	RingDonutsPrecios[3] = 22;
	AddMenuItem(RingDonuts, 0, "Cena de Pareja");				AddMenuItem(RingDonuts, 1, "$28");	RingDonutsPrecios[4] = 28;
	AddMenuItem(RingDonuts, 0, "El especial del Chef");			AddMenuItem(RingDonuts, 1, "$45");	RingDonutsPrecios[5] = 45;
	AddMenuItem(RingDonuts, 0, "Completa de Rings");			AddMenuItem(RingDonuts, 1, "$30");	RingDonutsPrecios[6] = 30;
	// M24_7;
    M24_7	 = CreateMenu("24/7", 2, 300.0, 200.0, 250.0, 70.0);
	AddMenuItem(M24_7, 0, "C\x98mara de Fotos");  		AddMenuItem(M24_7, 1, "$200"); 	M24_7_Precios[0] = 200;
	AddMenuItem(M24_7, 0, "Patines");	  				AddMenuItem(M24_7, 1, "$150"); 	M24_7_Precios[1] = 150;
	AddMenuItem(M24_7, 0, "Dados");						AddMenuItem(M24_7, 1, "$60"); 	M24_7_Precios[2] = 60;
	AddMenuItem(M24_7, 0, "Flores"); 					AddMenuItem(M24_7, 1, "$50"); 	M24_7_Precios[3] = 50;
	AddMenuItem(M24_7, 0, "Condones"); 				    AddMenuItem(M24_7, 1, "$80"); 	M24_7_Precios[4] = 80;
	AddMenuItem(M24_7, 0, "Maleta"); 				    AddMenuItem(M24_7, 1, "$150"); 	M24_7_Precios[5] = 150;

	// Tipos de teléfonos móviles
    TYPE_PHONES_MENU	 = CreateMenu("Modelos de M\xa6viles", 1, 300.0, 200.0, 250.0, 70.0);
   	AddMenuItem(TYPE_PHONES_MENU, 0, "Normal");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Color Oro");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Azul Claro");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Naranja");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Negro");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Rosa");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Rojo");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Verde");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Azul Oscuro");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Amarillo");
	AddMenuItem(TYPE_PHONES_MENU, 0, "Blanco");
	
//=======================================================================================
//=======================================================================================
/////////// MENU ARMAS

	// Armas_Clases    [10][25];
	// Armas_Nombre	[10][11][25];
	// Armas_ID		[10][11];

//      \x98 = A Con tílde
// 		\x9e = E con tílde
//      \xa2 = I Con tílde
//		\xa6 = O Con tílde

	new SumarPrecios = 4;
	// Básicos I				- 01
    Armas_Clases    [0] 	= "B\x98sicos I";
    {
	    Armas_Nombre	[0][0] 	= "01-  Cuchillo"; 			Armas_ID		[0][0]  = 4;	Armas_Precios_Num	[0][0]	= 75 * SumarPrecios;	Armas_Municion[0][0]	= 1;		format(Armas_Precios[0][0], 6, "$%i", Armas_Precios_Num[0][0] * Armas_Municion[0][0]);			// 00   04 - Knife
	    Armas_Nombre	[0][1] 	= "02-  Palo de Golf";		Armas_ID		[0][1]  = 2;	Armas_Precios_Num	[0][1]	= 75 * SumarPrecios;	Armas_Municion[0][1]	= 1;		format(Armas_Precios[0][1], 6, "$%i", Armas_Precios_Num[0][1] * Armas_Municion[0][1]);			// 01   02 - Golf Club
	    Armas_Nombre	[0][2] 	= "03-  Bast\xa6n Normal"; 	Armas_ID		[0][2]  = 5;	Armas_Precios_Num	[0][2]	= 50 * SumarPrecios;	Armas_Municion[0][2]	= 1;		format(Armas_Precios[0][2], 6, "$%i", Armas_Precios_Num[0][2] * Armas_Municion[0][2]);			// 02	15 - Cane
	    Armas_Nombre	[0][3] 	= "04-  Pala"; 				Armas_ID		[0][3]  = 6;	Armas_Precios_Num	[0][3]	= 75 * SumarPrecios;	Armas_Municion[0][3]	= 1;		format(Armas_Precios[0][3], 6, "$%i", Armas_Precios_Num[0][3] * Armas_Municion[0][3]);			// 03   06 - Shovel
	    Armas_Nombre	[0][4] 	= "05-  Taco de Billar"; 	Armas_ID		[0][4]  = 7;	Armas_Precios_Num	[0][4]	= 75 * SumarPrecios;	Armas_Municion[0][4]	= 1;		format(Armas_Precios[0][4], 6, "$%i", Armas_Precios_Num[0][4] * Armas_Municion[0][4]);			// 04   07 - Pool Cue
	}
	// Básicos II  			- 02
    Armas_Clases    [1] 	= "B\x98sicos II";
    {
	    Armas_Nombre	[1][0] 	= "01-  Bate"; 					Armas_ID		[1][0]  = 5;	Armas_Precios_Num	[1][0]	= 60 * SumarPrecios;	Armas_Municion[1][0]	= 1;		format(Armas_Precios[1][0], 6, "$%i", Armas_Precios_Num[1][0] * Armas_Municion[1][0]);			// 01   05 - Baseball Bat
	    Armas_Nombre	[1][1] 	= "02-  Manopla";				Armas_ID		[1][1]  = 1;	Armas_Precios_Num	[1][1]	= 75 * SumarPrecios;	Armas_Municion[1][1]	= 1;		format(Armas_Precios[1][1], 6, "$%i", Armas_Precios_Num[1][1] * Armas_Municion[1][1]);			// 02	01 - Brass Knuckles
	    Armas_Nombre	[1][2] 	= "03-  Katana"; 				Armas_ID		[1][2]  = 8;	Armas_Precios_Num	[1][2]	= 50 * SumarPrecios;	Armas_Municion[1][2]	= 1;		format(Armas_Precios[1][2], 6, "$%i", Armas_Precios_Num[1][2] * Armas_Municion[1][2]);			// 03   03 - 08 - Katana
	    Armas_Nombre	[1][3] 	= "04-  Motocierra"; 			Armas_ID		[1][3]  = 9;	Armas_Precios_Num	[1][3]	= 75 * SumarPrecios;	Armas_Municion[1][3]	= 1;		format(Armas_Precios[1][3], 6, "$%i", Armas_Precios_Num[1][3] * Armas_Municion[1][3]);			// 04   09 - Chainsaw
    }
    // Pistolas  			- 03
    Armas_Clases    [2] 	= "Pistolas";
    {
		Armas_Nombre	[2][0] 	= "01-  9mm Plateada"; 			Armas_ID		[2][0]  = 22;	Armas_Precios_Num	[2][0]	= 7 * SumarPrecios;	Armas_Municion[2][0]	= 60;		format(Armas_Precios[2][0], 6, "$%i", Armas_Precios_Num[2][0] * Armas_Municion[2][0]);			// 00	22 - 9mm
		Armas_Nombre	[2][1] 	= "02-  Silenciada 9mm"; 		Armas_ID		[2][1]  = 23;	Armas_Precios_Num	[2][1]	= 6 * SumarPrecios;	Armas_Municion[2][1]	= 60;		format(Armas_Precios[2][1], 6, "$%i", Armas_Precios_Num[2][1] * Armas_Municion[2][1]);			// 01	23 - Silenced 9mm
		Armas_Nombre	[2][2] 	= "03-  Desert Eagle Plateada"; Armas_ID		[2][2]  = 24;	Armas_Precios_Num	[2][2]	= 10 * SumarPrecios;	Armas_Municion[2][2]	= 50;		format(Armas_Precios[2][2], 6, "$%i", Armas_Precios_Num[2][2] * Armas_Municion[2][2]);			// 02	24 - Desert Eagle
    }
    // Escopetas  			- 04
    Armas_Clases    [3] 	= "Escopetas";
    {
		Armas_Nombre	[3][0] 	= "01-  Escopeta Normal"; 		Armas_ID		[3][0]  = 25;	Armas_Precios_Num	[3][0]	= 9 * SumarPrecios;	Armas_Municion[3][0]	= 25;		format(Armas_Precios[3][0], 6, "$%i", Armas_Precios_Num[3][0] * Armas_Municion[3][0]);		// 00	25 - Shotgun
		Armas_Nombre	[3][1] 	= "02-  Escopeta de Combate";	Armas_ID		[3][1]  = 27;	Armas_Precios_Num	[3][1]	= 18 * SumarPrecios;	Armas_Municion[3][1]	= 40;		format(Armas_Precios[3][1], 6, "$%i", Armas_Precios_Num[3][1] * Armas_Municion[3][1]);		// 01	27 - Combat Shotgun
    }
    // Sub-Fusiles 			- 05
    Armas_Clases    [4] 	= "Sub-Fusiles";
    {
		Armas_Nombre	[4][0] 	= "01-  MP5";Armas_ID		[4][0]  = 29;	Armas_Precios_Num	[4][0]	= 7 * SumarPrecios;	Armas_Municion[4][0]	= 200;		format(Armas_Precios[4][0], 6, "$%i", Armas_Precios_Num[4][0] * Armas_Municion[4][0]);			// 00  29 - MP5
    }
    // Fusiles              - 06
    Armas_Clases    [5] 	= "Fusiles";
    {
		Armas_Nombre	[5][0] 	= "01-  AK47";				 	Armas_ID		[5][0]  = 30;	Armas_Precios_Num	[5][0]	= 6 * SumarPrecios;	Armas_Municion[5][0]	= 150;		format(Armas_Precios[5][0], 6, "$%i", Armas_Precios_Num[5][0] * Armas_Municion[5][0]);			// 00	 30 - AK47
		Armas_Nombre	[5][1] 	= "02-  M4"; 					Armas_ID		[5][1]  = 31;	Armas_Precios_Num	[5][1]	= 8 * SumarPrecios;	Armas_Municion[5][1]	= 150;		format(Armas_Precios[5][1], 6, "$%i", Armas_Precios_Num[5][1] * Armas_Municion[5][1]);			// 01	 31 - M4
    }
    // Rifles               - 07
    Armas_Clases    [6] 	= "Rifles";
    {
		Armas_Nombre	[6][0] 	= "01-  Rifle Corto Alcance";	Armas_ID		[6][0]  = 33;	Armas_Precios_Num	[6][0]	= 20 * SumarPrecios;	Armas_Municion[6][0]	= 100;		format(Armas_Precios[6][0], 6, "$%i", Armas_Precios_Num[6][0] * Armas_Municion[6][0]);			// 00  33 - Country Rifle
		Armas_Nombre	[6][1] 	= "02-  Rifle Largo Alcance"; 	Armas_ID		[6][1]  = 34;	Armas_Precios_Num	[6][1]	= 22 * SumarPrecios;	Armas_Municion[6][1]	= 100;		format(Armas_Precios[6][1], 6, "$%i", Armas_Precios_Num[6][1] * Armas_Municion[6][1]);			// 01  34 - Sniper Rifle
	}
    // Alto Riesgo          - 08
    Armas_Clases    [7] 	= "Alto Riesgo";
    {
		Armas_Nombre	[7][0] 	= "01-  Granadas"; 				Armas_ID		[7][0]  = 16;	Armas_Precios_Num	[7][0]	= 9 * SumarPrecios;	Armas_Municion[7][0]	= 60;		format(Armas_Precios[7][0], 6, "$%i", Armas_Precios_Num[7][0] *	Armas_Municion[7][0]);			// 00	16 - Grenade
		Armas_Nombre	[7][1] 	= "02-  Molotovs"; 				Armas_ID		[7][1]  = 18;	Armas_Precios_Num	[7][1]	= 10 * SumarPrecios;	Armas_Municion[7][1]= 70;		format(Armas_Precios[7][1], 6, "$%i", Armas_Precios_Num[7][1] * Armas_Municion[7][1]);			// 01	18 - Molotov Cocktail
		Armas_Nombre	[7][2] 	= "03-  Extintor"; 				Armas_ID		[7][2]  = 42;	Armas_Precios_Num	[7][2]	= 1 * SumarPrecios;	Armas_Municion[7][2]	= 250;		format(Armas_Precios[7][2], 6, "$%i", Armas_Precios_Num[7][2] * Armas_Municion[7][2]);			// 02	42 - Fire Extinguisher
    }
    // Otros                - 09
    Armas_Clases    [8] 	= "Otros";
    {
		Armas_Nombre	[8][0] 	= "01-  Spray de Grafitis"; 	Armas_ID		[8][0]  = 41;	Armas_Precios_Num	[8][0]	= 5 * SumarPrecios;	Armas_Municion[8][0]	= 100;		format(Armas_Precios[8][0], 6, "$%i", Armas_Precios_Num[8][0] * Armas_Municion[8][0]);				// 00   41 - Spraycan
		Armas_Nombre	[8][1] 	= "04-  Chaleco"; 				Armas_ID		[8][1]  = 0;	Armas_Precios_Num	[8][1]	= 150 * SumarPrecios;	Armas_Municion[8][1]	= 1;		format(Armas_Precios[8][1], 6, "$%i", Armas_Precios_Num[8][1] * Armas_Municion[8][1]);			// 01   00 - Chaleco
		Armas_Nombre	[8][2] 	= "03-  Paraca\xa2das"; 		Armas_ID		[8][2]  = 46;	Armas_Precios_Num	[8][2]	= 75 * SumarPrecios;	Armas_Municion[8][2]	= 1;		format(Armas_Precios[8][2], 6, "$%i", Armas_Precios_Num[8][2] * Armas_Municion[8][2]);			// 02   46 - Parachute
    }

    // Menu prncipal
	Menu_Principal_Armas = CreateMenu("Menu Principal", 2, 200.0, 100.0, 150.0, 150.0);
	SetMenuColumnHeader(Menu_Principal_Armas, 0, "ID");
	SetMenuColumnHeader(Menu_Principal_Armas, 1, "Clases");

	AddMenuItem(Menu_Principal_Armas, 0, "01-");
	AddMenuItem(Menu_Principal_Armas, 0, "02-");
	AddMenuItem(Menu_Principal_Armas, 0, "03-");
	AddMenuItem(Menu_Principal_Armas, 0, "04-");
	AddMenuItem(Menu_Principal_Armas, 0, "05-");
	AddMenuItem(Menu_Principal_Armas, 0, "06-");
	AddMenuItem(Menu_Principal_Armas, 0, "07-");
	AddMenuItem(Menu_Principal_Armas, 0, "08-");
	AddMenuItem(Menu_Principal_Armas, 0, "09-");

	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [0]);
	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [1]);
	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [2]);
	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [3]);
	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [4]);
	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [5]);
	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [6]);
	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [7]);
	AddMenuItem(Menu_Principal_Armas, 1, Armas_Clases    [8]);

	// Básico I    		- 01
	Menues_Armas					[0] = CreateMenu("01- B\x98sico I", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[0], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[0], 1, "Precio");

	AddMenuItem(Menues_Armas[0], 0, Armas_Nombre		[0][0]);  	AddMenuItem(Menues_Armas[0], 1, Armas_Precios	[0][0]);
	AddMenuItem(Menues_Armas[0], 0, Armas_Nombre		[0][1]);  	AddMenuItem(Menues_Armas[0], 1, Armas_Precios	[0][1]);
	AddMenuItem(Menues_Armas[0], 0, Armas_Nombre		[0][2]);  	AddMenuItem(Menues_Armas[0], 1, Armas_Precios	[0][2]);
	AddMenuItem(Menues_Armas[0], 0, Armas_Nombre		[0][3]);  	AddMenuItem(Menues_Armas[0], 1, Armas_Precios	[0][3]);
	AddMenuItem(Menues_Armas[0], 0, Armas_Nombre		[0][4]);  	AddMenuItem(Menues_Armas[0], 1, Armas_Precios	[0][4]);

	// Básico II 		- 02
   	Menues_Armas					[1] = CreateMenu("02- B\x98sico II", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[1], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[1], 1, "Precio");

	AddMenuItem(Menues_Armas[1], 0, Armas_Nombre		[1][0]);  	AddMenuItem(Menues_Armas[1], 1, Armas_Precios	[1][0]);
	AddMenuItem(Menues_Armas[1], 0, Armas_Nombre		[1][1]);  	AddMenuItem(Menues_Armas[1], 1, Armas_Precios	[1][1]);
	AddMenuItem(Menues_Armas[1], 0, Armas_Nombre		[1][2]);  	AddMenuItem(Menues_Armas[1], 1, Armas_Precios	[1][2]);
	AddMenuItem(Menues_Armas[1], 0, Armas_Nombre		[1][3]);  	AddMenuItem(Menues_Armas[1], 1, Armas_Precios	[1][3]);

	// Pistolas  			- 03
   	Menues_Armas					[2] = CreateMenu("03- Pistolas", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[2], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[2], 1, "Precio");

	AddMenuItem(Menues_Armas[2], 0, Armas_Nombre		[2][0]);  	AddMenuItem(Menues_Armas[2], 1, Armas_Precios	[2][0]);
	AddMenuItem(Menues_Armas[2], 0, Armas_Nombre		[2][1]);  	AddMenuItem(Menues_Armas[2], 1, Armas_Precios	[2][1]);
	AddMenuItem(Menues_Armas[2], 0, Armas_Nombre		[2][2]);  	AddMenuItem(Menues_Armas[2], 1, Armas_Precios	[2][2]);

    // Escopetas  			- 04
   	Menues_Armas					[3] = CreateMenu("04- Escopetas", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[3], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[3], 1, "Precio");

	AddMenuItem(Menues_Armas[3], 0, Armas_Nombre		[3][0]);  	AddMenuItem(Menues_Armas[3], 1, Armas_Precios	[3][0]);
	AddMenuItem(Menues_Armas[3], 0, Armas_Nombre		[3][1]);  	AddMenuItem(Menues_Armas[3], 1, Armas_Precios	[3][1]);

    // Sub-Fusiles 			- 05
   	Menues_Armas					[4] = CreateMenu("05- Sub-Fusiles", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[4], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[4], 1, "Precio");

	AddMenuItem(Menues_Armas[4], 0, Armas_Nombre		[4][0]);  	AddMenuItem(Menues_Armas[4], 1, Armas_Precios	[4][0]);

    // Fusiles              - 06
   	Menues_Armas					[5] = CreateMenu("06- Fusiles", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[5], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[5], 1, "Precio");

	AddMenuItem(Menues_Armas[5], 0, Armas_Nombre		[5][0]);  	AddMenuItem(Menues_Armas[5], 1, Armas_Precios	[5][0]);
	AddMenuItem(Menues_Armas[5], 0, Armas_Nombre		[5][1]);  	AddMenuItem(Menues_Armas[5], 1, Armas_Precios	[5][1]);

    // Rifles               - 07
   	Menues_Armas					[6] = CreateMenu("07- Rifles", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[6], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[6], 1, "Precio");

	AddMenuItem(Menues_Armas[6], 0, Armas_Nombre		[6][0]);  	AddMenuItem(Menues_Armas[6], 1, Armas_Precios	[6][0]);
	AddMenuItem(Menues_Armas[6], 0, Armas_Nombre		[6][1]);  	AddMenuItem(Menues_Armas[6], 1, Armas_Precios	[6][1]);

    // Alto Riesgo          - 08
  	Menues_Armas					[7] = CreateMenu("08- Armas de Alto Riesgo", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[7], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[7], 1, "Precio");

	AddMenuItem(Menues_Armas[7], 0, Armas_Nombre		[7][0]);  	AddMenuItem(Menues_Armas[7], 1, Armas_Precios	[7][0]);
	AddMenuItem(Menues_Armas[7], 0, Armas_Nombre		[7][1]);  	AddMenuItem(Menues_Armas[7], 1, Armas_Precios	[7][1]);
	AddMenuItem(Menues_Armas[7], 0, Armas_Nombre		[7][2]);  	AddMenuItem(Menues_Armas[7], 1, Armas_Precios	[7][2]);

     // Otros                - 09
  	Menues_Armas					[8] = CreateMenu("09- Otros", 2, 300.0, 200.0, 250.0, 70.0);
	SetMenuColumnHeader(Menues_Armas[8], 0, "ID   Arma");
	SetMenuColumnHeader(Menues_Armas[8], 1, "Precio");

	AddMenuItem(Menues_Armas[8], 0, Armas_Nombre		[8][0]);  	AddMenuItem(Menues_Armas[8], 1, Armas_Precios	[8][0]);
	AddMenuItem(Menues_Armas[8], 0, Armas_Nombre		[8][1]);  	AddMenuItem(Menues_Armas[8], 1, Armas_Precios	[8][1]);
	AddMenuItem(Menues_Armas[8], 0, Armas_Nombre		[8][2]);  	AddMenuItem(Menues_Armas[8], 1, Armas_Precios	[8][2]);
}
public ResetServer()
{
	OnGameModeExitEx();
	ResetGM = true;
	SendRconCommand("gmx");
    for ( new i = 0; i < 10; i++)
    {
    	SendClientMessageToAll(0x000000FF, " ");
	}
	SendClientMessageToAll(COLOR_MESSAGES[2], "{1ABEEA}Reiniciando servidor, por favor {FF0000}NO SE DESCONECTE.");
	SendClientMessageToAll(COLOR_MESSAGES[2], ReasonReset);
}
public SendMessageDeathMatch(playerid)
{
	new MsgGameText[MAX_TEXT_CHAT];
	switch ( random(8) )
	{
	    case 0:
	    {
			format(MsgGameText, sizeof(MsgGameText), "~>~~>~ ~r~Asesino ~<~~<~");
		}
	    case 1:
	    {
			format(MsgGameText, sizeof(MsgGameText), "~>~~>~ ~r~Criminal ~<~~<~");
		}
	    case 2:
	    {
			format(MsgGameText, sizeof(MsgGameText), "~>~~>~ ~r~Homicida ~<~~<~");
		}
	    case 3:
	    {
			format(MsgGameText, sizeof(MsgGameText), "~>~~>~ ~r~Gangster ~<~~<~");
		}
	    case 4:
	    {
			format(MsgGameText, sizeof(MsgGameText), "~>~~>~ ~r~Murder ~<~~<~");
		}
	    case 5:
	    {
			format(MsgGameText, sizeof(MsgGameText), "~>~~>~ ~r~Gangsta ~<~~<~");
		}
	    case 6:
	    {
			format(MsgGameText, sizeof(MsgGameText), "~>~~>~ ~r~Real Gangster ~<~~<~");
		}
	    case 7:
	    {
			format(MsgGameText, sizeof(MsgGameText), "~>~~>~ ~r~Serial Kill ~<~~<~");
		}
	}
	GameTextForPlayer(playerid, MsgGameText, 500, 5);
}

public IsPlayerNearBomba(playerid, Float:Range, option)
{
	if ( option == -1 )
	{
		for (new i = 0; i < MAX_BOMBAS_COUNT; i++ )
		{
	        if ( IsPlayerNearBombaEx(playerid, i, Range) )
	        {
	            return i;
			}
		}
	}
	else
	{
        if ( IsPlayerNearBombaEx(playerid, option, Range) )
        {
            return option;
		}
	}
	return -1;
}
public IntentarAccion(playerid, text[], rndNum)
{
	if ( gettime() - PlayersDataOnline[playerid][Intentar]  >= 3 )
	{
	    PlayersDataOnline[playerid][Intentar] = gettime();
	    if ( rndNum )
	    {
            Acciones(playerid, 2, text);
            return true;
        }
        else
        {
            Acciones(playerid, 3, text);
		}
	}
	else
	{
		SendInfoMessage(playerid, 0, "057", "Tiene que esperar 3 segundos entre cada uso de /Intentar [Acción].");
	}
    return false;
}
public DesactivarBomba(playerid, bombaid)
{
	if ( BombasO[bombaid][TypeBomba] != BOMBA_TYPE_NONE )
	{
    	PlayersData[playerid][Bombas]++;
		RemoveBomba(bombaid);
		return true;
	}
	return false;
}
public ActivarBomba(bombaid, count)
{
	if ( BombasO[bombaid][TypeBomba] != BOMBA_TYPE_NONE )
	{
	    if ( BombasO[bombaid][TypeBomba] == BOMBA_TYPE_CAR )
		{
		    GetVehiclePos(BombasO[bombaid][ObjectID], BombasO[bombaid][PosX], BombasO[bombaid][PosY], BombasO[bombaid][PosZ]);
		}
		for (new i = 0; i < count; i++)
		{
			CreateExplosion(BombasO[bombaid][PosX], BombasO[bombaid][PosY], BombasO[bombaid][PosZ], 2, 10.0);
		}
		RemoveBomba(bombaid);
		return true;
	}
	return false;
}
public RemoveBomba(bombaid)
{
	if ( BombasO[bombaid][TypeBomba] != BOMBA_TYPE_NONE )
	{
	    if ( BombasO[bombaid][TypeBomba] == BOMBA_TYPE_FOOT )
	    {
		    DestroyDynamicObject(BombasO[bombaid][ObjectID]);
		}
		BombasO[bombaid][TypeBomba] = BOMBA_TYPE_NONE;
//		KillTimer(BombasO[bombaid][TimerID]);
	    return true;
	}
	return false;
}
public ShowBombas(playerid)
{
	new BombasDialog[1750];
	new TempConvert[60];
	new ConteoBombas = -1;
	new TiposBomb[2][9] = {"Piso", "Vehículo"};
	for (new i = 0; i < MAX_BOMBAS_COUNT; i++ )
	{
	    if ( BombasO[i][TypeBomba] != BOMBA_TYPE_NONE )
	    {
			if ( ConteoBombas != -1 )
			{
			    format(TempConvert, sizeof(TempConvert), "\r\n{E6E6E6}Bomba {F5FF00}#%i {00A5FF}[%s]", i, TiposBomb[BombasO[i][TypeBomba] - 1]);
	    	}
			else
			{
			    format(TempConvert, sizeof(TempConvert), "{E6E6E6}Bomba {F5FF00}#%i {00A5FF}[%s]", i, TiposBomb[BombasO[i][TypeBomba] - 1]);
			}
	        strcat(BombasDialog, TempConvert, sizeof(BombasDialog));
	        ConteoBombas++;
	        PlayersDataOnline[playerid][SaveAfterAgenda][ConteoBombas] = i;
        }
	}
	if (ConteoBombas != -1)
	{
		ShowPlayerDialogEx(playerid,7,DIALOG_STYLE_LIST,"{FF0000}[SGW] Bombas - Control", BombasDialog, "Detonar", "Salir");
	}
	else
	{
		ShowPlayerDialogEx(playerid,999,DIALOG_STYLE_MSGBOX,"{FF0000}[SGW] Bombas - Control", "{F0F0F0}No se encontrarón bombas.", "Ok", "");
	}
}
public IsPlayerNearBombaEx(playerid, bombaid, Float:Range)
{
    new Float:VehPos[3];
    if ( BombasO[bombaid][TypeBomba] != BOMBA_TYPE_NONE )
    {
	    if ( BombasO[bombaid][TypeBomba] == BOMBA_TYPE_FOOT )
		{
			if ( IsPlayerInRangeOfPoint(playerid, Range,
												 BombasO[bombaid][PosX], BombasO[bombaid][PosY], BombasO[bombaid][PosZ] ) )
			{
				return true;
			}
		}
		else
		{
			GetVehiclePos(BombasO[bombaid][ObjectID], VehPos[0], VehPos[1], VehPos[2]);
			if ( IsPlayerInRangeOfPoint(playerid, Range,
												 VehPos[0], VehPos[1], VehPos[2] ) )
			{
				return true;
			}
		}
	}
	return false;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(PlayersData[playerid][Admin] >= 1 && PlayersDataOnline[playerid][AdminOn])
    {
        SetPlayerPos(playerid, Float:fX, Float:fY, Float:fZ);
    }
    else
    {
        new MsgAvisoBug[MAX_TEXT_CHAT];
        format(MsgAvisoBug, sizeof(MsgAvisoBug), "%s %s[%i] Ha hecho clic en el mapa, {99A4AA}( x: %f | y: %f | z: %f) /Pos [%i]", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, fX, fY, fZ, playerid);
        MsgCheatsReportsToAdmins(MsgAvisoBug);
    }
    return 1;
}
public SendMessageFamily(playerid, text[])
{
	new MsgFamily[MAX_TEXT_CHAT];
	format(MsgFamily, sizeof(MsgFamily), "[SGW][Gang Chat]: %s %s: %s", GangesRangos[PlayersData[playerid][Gang]][PlayersData[playerid][Rango]], PlayersDataOnline[playerid][NameOnline], text);
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if ( IsPlayerConnected(i) && PlayersData[i][Gang] == PlayersData[playerid][Gang] && PlayersDataOnline[i][State] == 3  && PlayersDataOnline[i][StateChannelFamily])
		{
			SendClientMessage(i, COLOR_FAMILY, MsgFamily);
		}
	}
	print(MsgFamily);
}
public GetVagonByVagonID(vehicleid, vagonid)
{
	for ( new t = 0; t <= MAX_TRAIN; t++ )
	{
		for ( new i = 0; i < 4; i++ )
		{
	    	if ( TrainGroups[t][i] == vehicleid )
	    	{
				return TrainGroups[t][vagonid];
			}
	   	}
   	}
   	return false;
}
public LoadTelesPublics()
{
	/////////////////////////////////////////////////////////////////////
	Teles[MAX_TELE][PosX] 		= -2675.2092;
	Teles[MAX_TELE][PosY] 		= 552.2344;
	Teles[MAX_TELE][PosZ] 		= 14.6094;
	Teles[MAX_TELE][PosZZ] 		= 0.8626;
	Teles[MAX_TELE][PickupID] 	= CreatePickup	(1239, 	1, 	Teles[MAX_TELE][PosX],Teles[MAX_TELE][PosY],Teles[MAX_TELE][PosZ],	 	WORLD_NORMAL);
	Teles[MAX_TELE][PickupIDGo] = MAX_TELE + 1;
	Teles[MAX_TELE][Interior] 	= 0;
	Teles[MAX_TELE][World] 		= WORLD_NORMAL;
	Teles[MAX_TELE][Lock] 		= false;
	SetStyleTextDrawTeles(MAX_TELE, "Teles Public 1");
	Teles[MAX_TELE][Dueno]      = YAKUZA;
	////////////////

	MAX_TELE++;
	Teles[MAX_TELE][PosX]       = -2766.0508;
	Teles[MAX_TELE][PosY]       = 375.5933;
	Teles[MAX_TELE][PosZ]       = 6.3347;
	Teles[MAX_TELE][PosZZ]       = 271.1547;
	Teles[MAX_TELE][PickupID]           = CreatePickup   (1274,    1,    Teles[MAX_TELE][PosX], Teles[MAX_TELE][PosY], Teles[MAX_TELE][PosZ],       WORLD_NORMAL);
	Teles[MAX_TELE][PickupIDGo]        = MAX_TELE + 1;
	Teles[MAX_TELE][Interior]            = 0;
	Teles[MAX_TELE][World]       = WORLD_NORMAL;
	Teles[MAX_TELE][Lock]       = false;
	SetStyleTextDrawTeles(MAX_TELE, "Banco de San Fierro");
	BANCO_PICKUPID_out = Teles[MAX_TELE][PickupID];
	Teles[MAX_TELE][Dueno]      = SINGANG;
	//////////////////////////////
	MAX_TELE++;
	Teles[MAX_TELE][PosX]       = 2305.4546;
	Teles[MAX_TELE][PosY]       = -16.1226;
	Teles[MAX_TELE][PosZ]       = 26.7496;
	Teles[MAX_TELE][PosZZ]       = 270.0407;
	Teles[MAX_TELE][PickupID]           = CreatePickup   (1274,    1,    Teles[MAX_TELE][PosX], Teles[MAX_TELE][PosY], Teles[MAX_TELE][PosZ],       WORLD_DEFAULT_INTERIOR);
	Teles[MAX_TELE][PickupIDGo]        = MAX_TELE - 1;
	Teles[MAX_TELE][Interior]            = 0;
	Teles[MAX_TELE][World]       = WORLD_DEFAULT_INTERIOR;
	Teles[MAX_TELE][Lock]       = false;
	SetStyleTextDrawTeles(MAX_TELE, "Banco de San Fierro");
	Teles[MAX_TELE][Dueno]      = SINGANG;
}

public SaveDataGang(faccionid)
{
	new TempDirGang[25];
    format(TempDirGang, sizeof(TempDirGang), "%s%i.sgw", DIR_GANGES, faccionid);

    new GangDataALL[MAX_PLAYER_DATA];
 	format(GangDataALL, MAX_PLAYER_DATA, "%s|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%i|%f|%f|%f|%f|%f|%f|%f|%f|%i|%i|%i|%i|%i|%i|",
 	GangData[faccionid][Lider],
	GangData[faccionid][Deposito],
	GangData[faccionid][Almacen][0],
	GangData[faccionid][Almacen][1],
	GangData[faccionid][LockA][0],
	GangData[faccionid][LockA][1],
	GangData[faccionid][Lock],
	WeaponsGang[faccionid][0][0],
	WeaponsGang[faccionid][0][1],
	WeaponsGang[faccionid][0][2],
	WeaponsGang[faccionid][0][3],
	WeaponsGang[faccionid][0][4],
	WeaponsGang[faccionid][0][5],
	WeaponsGang[faccionid][0][6],
	WeaponsGang[faccionid][0][7],
	WeaponsGang[faccionid][0][8],
	WeaponsGang[faccionid][0][9],
	WeaponsGang[faccionid][1][0],
	WeaponsGang[faccionid][1][1],
	WeaponsGang[faccionid][1][2],
	WeaponsGang[faccionid][1][3],
	WeaponsGang[faccionid][1][4],
	WeaponsGang[faccionid][1][5],
	WeaponsGang[faccionid][1][6],
	WeaponsGang[faccionid][1][7],
	WeaponsGang[faccionid][1][8],
	WeaponsGang[faccionid][1][9],
	AmmoGang[faccionid][0][0],
	AmmoGang[faccionid][0][1],
	AmmoGang[faccionid][0][2],
	AmmoGang[faccionid][0][3],
	AmmoGang[faccionid][0][4],
	AmmoGang[faccionid][0][5],
	AmmoGang[faccionid][0][6],
	AmmoGang[faccionid][0][7],
	AmmoGang[faccionid][0][8],
	AmmoGang[faccionid][0][9],
	AmmoGang[faccionid][1][0],
	AmmoGang[faccionid][1][1],
	AmmoGang[faccionid][1][2],
	AmmoGang[faccionid][1][3],
	AmmoGang[faccionid][1][4],
	AmmoGang[faccionid][1][5],
	AmmoGang[faccionid][1][6],
	AmmoGang[faccionid][1][7],
	AmmoGang[faccionid][1][8],
	AmmoGang[faccionid][1][9],
	GangesChaleco[faccionid][0][0],
	GangesChaleco[faccionid][0][1],
	GangesChaleco[faccionid][0][2],
	GangesChaleco[faccionid][0][3],
	GangesChaleco[faccionid][1][0],
	GangesChaleco[faccionid][1][1],
	GangesChaleco[faccionid][1][2],
	GangesChaleco[faccionid][1][3],
	GangData[faccionid][Drogas][0],
	GangData[faccionid][Drogas][1],
	GangData[faccionid][Ganzuas][0],
	GangData[faccionid][Ganzuas][1],
	GangData[faccionid][Bombas][0],
	GangData[faccionid][Bombas][1]);

	new File:SaveGang = fopen(TempDirGang, io_write);
	fwrite(SaveGang, GangDataALL);
	fclose(SaveGang);
}
public LoadTextDrawInfo()
{
	// PESCA
    TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoX] = 612.8910;// 612.8910 -2995.3770 7.2706
    TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoY] = -2995.3770;
    TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoZ] = 7.2706;
    TextDrawInfo[MAX_TEXT_DRAW_INFO][PickupidTextInfo] = CreatePickup	(1239, 	1,  TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoX], TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoY], TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoZ],	 	WORLD_NORMAL);
	SetStyleTextDrawTextDrawInfo(MAX_TEXT_DRAW_INFO, "Da faq!");

	////////////////////////////////////////////////
	MAX_TEXT_DRAW_INFO++;
    TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoX] = -1503.5508; // -1503.5508 1380.0824 3.4375
    TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoY] = 1380.0824;
    TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoZ] = 3.4375;
    TextDrawInfo[MAX_TEXT_DRAW_INFO][PickupidTextInfo] = CreatePickup	(1239, 	1,  TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoX], TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoY], TextDrawInfo[MAX_TEXT_DRAW_INFO][PosInfoZ],	 	WORLD_NORMAL);
	SetStyleTextDrawTextDrawInfo(MAX_TEXT_DRAW_INFO, "lol");
}
public SetStyleTextDrawTextDrawInfo(textdrawid, text[])
{
	new TextDrawTextDrawInfoText[MAX_TEXT_CHAT];
	format(TextDrawTextDrawInfoText, sizeof(TextDrawTextDrawInfoText), "~B~Info: ~W~%s", text);
	TextDrawInfoTextDraws[textdrawid] = TextDrawCreateEx(200.0, 380.0, TextDrawTextDrawInfoText);
	TextDrawUseBox(TextDrawInfoTextDraws[textdrawid], 1);
	TextDrawBackgroundColor(TextDrawInfoTextDraws[textdrawid] ,0x000000FF);
	TextDrawBoxColor(TextDrawInfoTextDraws[textdrawid], 0x00000066);
	TextDrawTextSize(TextDrawInfoTextDraws[textdrawid], 350.0, 380.0);
	TextDrawSetShadow(TextDrawInfoTextDraws[textdrawid], 1);
	TextDrawLetterSize(TextDrawInfoTextDraws[textdrawid], 0.5 , 1.2);
	return textdrawid;
}
public LoadGarages()
{
//	printf("LoadGaragesExLock");
	for (new h = 1; h <= MAX_HOUSE; h++)
	{
		for ( new i = 0; i < MAX_GARAGE_FOR_HOUSE; i++ )
		{
	        if ( Garages[h][i][WorldG] )
	        {
		        Garages[h][i][PickupidOut] = CreatePickup	(1239, 	1, 	Garages[h][i][Xg], Garages[h][i][Yg], Garages[h][i][Zg],	 	-1);
		        if ( !MAX_GARAGE_PICKUP )
				{
					MIN_GARAGE_PICKUP = Garages[h][i][PickupidOut];
				}
	            Garages[h][i][PickupidIn]  = CreatePickup	(1239, 	1, 	Garages[h][i][XgIn], Garages[h][i][YgIn], Garages[h][i][ZgIn], h);
	            MAX_GARAGE_PICKUP = Garages[h][i][PickupidIn];
	            MAX_GARAGES++;
			}
		}
	}
}
public SetPlayerHealthEx(playerid, Float:Health)
{
	if ( PlayersDataOnline[playerid][VidaOn] + Health >= 100.0 )
	{
	    PlayersDataOnline[playerid][VidaOn] = 100.0;
	}
	else
	{
		PlayersDataOnline[playerid][VidaOn] = PlayersDataOnline[playerid][VidaOn] + Health;
	}
	PlayersDataOnline[playerid][ChangeVC] = 10;
}
public SetPlayerArmourEx(playerid, Float:Armour)
{
	if ( PlayersDataOnline[playerid][ChalecoOn] + Armour >= 85.0 )
	{
	    PlayersDataOnline[playerid][ChalecoOn] = 85.0;
	}
	else
	{
		PlayersDataOnline[playerid][ChalecoOn] = PlayersDataOnline[playerid][ChalecoOn] + Armour;
	}
	PlayersDataOnline[playerid][ChangeVC] = 10;
}
public GivePlayerWeaponEx(playerid, weaponid, ammo)
{
	if ( IsValidWeapon(playerid, weaponid) )
	{
		PlayersDataOnline[playerid][StateWeaponPass] 	= gettime() + 5;
		PlayersData[playerid][WeaponS][SlotIDWeapon[weaponid]] = weaponid;
	    PlayersData[playerid][AmmoS][SlotIDWeapon[weaponid]] = PlayersData[playerid][AmmoS][SlotIDWeapon[weaponid]] + ammo;
		GivePlayerWeapon(playerid, weaponid, ammo);
	}
}
public GetObjectByType(playerid, type)
{
	new TypeSaveTemp;
	for (new i = 0; i < MAX_OBJECTS_PLAYERS; i++)
	{
	    if ( PlayersData[playerid][Objetos][i] )
	    {
            TypeSaveTemp = GetTypeObject(PlayersData[playerid][Objetos][i]);
            if ( type == ObjectPlayersInt[TypeSaveTemp][2] )
            {
                return i;
            }
	    }
    }
    return -1;
}
public IsPlayerNotFullObjects(playerid, msg)
{
	for (new i = 0; i < MAX_OBJECTS_PLAYERS; i++)
	{
	    if ( !PlayersData[playerid][Objetos][i] )
	    {
	        return i;
	    }
	}
	if ( msg )
	{
		SendInfoMessage(playerid, 0, "1575", "No puedes llevar más objetos encima!");
	}
	return -1;
}
public AddObjectHoldToPlayer(playerid, objectid)
{
	new SaveNotFull = IsPlayerNotFullObjects(playerid, false);
	if ( SaveNotFull != -1 )
	{
	    PlayersData[playerid][Objetos][SaveNotFull] = objectid;
		if ( AllowForItSkin(PlayersData[playerid][Skin], GetTypeObjectEx(objectid)) )
		{
    	}
    	else
    	{
    	}
		SetObjectHoldToPlayer(playerid, objectid, SaveNotFull);
		return true;
	}
	else
	{
	    return false;
	}
}
public ReturnObjetsToPlayer(playerid)
{
	for (new i = 0; i < MAX_OBJECTS_PLAYERS; i++)
	{
	    if ( PlayersData[playerid][Objetos][i] )
	    {
	        if ( !AllowForItSkin(PlayersData[playerid][Skin], GetTypeObjectEx(PlayersData[playerid][Objetos][i])) )
	        {
				RemovePlayerAttachedObject(playerid, i);
	            continue;
           	}
           	SetObjectHoldToPlayer(playerid, PlayersData[playerid][Objetos][i], i);
	    }
    }
}
public GetTypeObject(objectid)
{
	for (new i = 0; i < sizeof(ObjectPlayersInt); i++)
	{
		if ( ObjectPlayersInt[i][0] == objectid )
		{
		    return i;
		}
	}
	return -1;
}
public AllowForItSkin(skinid, type)
{
	if ( type == TYPE_MALETIN)
	{
	    return false;
	}
	else
	{
	    return true;
	}
}
public SetObjectHoldToPlayer(playerid, objectid, index)
{
	new Float:OffsetsPos[9];
	new SaveRowID = GetTypeObject(objectid);
	if ( SaveRowID != -1 )
	{
		switch (ObjectPlayersInt[SaveRowID][2])
		{
		    case TYPE_MALETIN:
		    {
		        for ( new i = 0; i < sizeof(OffsetsPos); i++ )
		        {
	            	OffsetsPos[i] = ObjectsPlayers[0][i];
            	}
			}
		}
		SetPlayerAttachedObject(playerid, index, objectid, ObjectPlayersInt[SaveRowID][1], OffsetsPos[0],OffsetsPos[1],OffsetsPos[2],OffsetsPos[3],OffsetsPos[4],OffsetsPos[5],OffsetsPos[6],OffsetsPos[7],OffsetsPos[8]);
		return true;
		}
	return false;
}
public GetTypeObjectEx(objectid)
{
	for (new i = 0; i < sizeof(ObjectPlayersInt); i++)
	{
		if ( ObjectPlayersInt[i][0] == objectid )
		{
		    return ObjectPlayersInt[i][2];
		}
	}
	return -1;
}
public ShowObjectos(playerid)
{
	new ObjetosDialog[500];
	new TempConvert[50];
	new ConteoObjetos = -1;
	for (new i = 0; i < MAX_OBJECTS_PLAYERS; i++)
	{
	    if ( PlayersData[playerid][Objetos][i] )
	    {
			if ( ConteoObjetos != -1 )
			{
			    if ( !ObjectsVisibleOrInvisible[GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])] )
			    {
			    	format(TempConvert, sizeof(TempConvert), "\r\n{00A5FF}%s", ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][i])]);
		    	}
		    	else
		    	{
			    	format(TempConvert, sizeof(TempConvert), "\r\n{00F50A}%s", ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][i])]);
		    	}
	    	}
			else
			{
			    if ( !ObjectsVisibleOrInvisible[GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])] )
			    {
			    	format(TempConvert, sizeof(TempConvert), "{00A5FF}%s", ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][i])]);
		    	}
		    	else
		    	{
			    	format(TempConvert, sizeof(TempConvert), "{00F50A}%s", ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][i])]);
		    	}
			}
	        strcat(ObjetosDialog, TempConvert, sizeof(ObjetosDialog));
	        ConteoObjetos++;
	        PlayersDataOnline[playerid][SaveAfterAgenda][ConteoObjetos] = i;
        }
	}
	if (ConteoObjetos != -1)
	{
		ShowPlayerDialogEx(playerid,12,DIALOG_STYLE_LIST,"{00A5FF}Objetos - Control de los objetos", ObjetosDialog, "Opciones", "Salir");
	}
	else
	{
		ShowPlayerDialogEx(playerid,999,DIALOG_STYLE_MSGBOX,"{00A5FF}Objetos - Información", "{F0F0F0}No llevas objetos.", "Ok", "");
	}
}
public ShowObjetosOpciones(playerid)
{
	new ObjetTitleName[MAX_TEXT_CHAT];
	format(ObjetTitleName, sizeof(ObjetTitleName), "{00A5FF}Objetos - Opciones del {F5FF00}%s", ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])]);
	if ( !PlayersDataOnline[playerid][SaveAfterAgenda][10] )
	{
		ShowPlayerDialogEx(playerid,13,DIALOG_STYLE_LIST, ObjetTitleName, "{00A5FF}1 - {F0F0F0}Dar\r\n{00A5FF}2 - {F0F0F0}Tirar\r\n{00A5FF}3 - {F0F0F0}Guardar", "Seleccionar", "Volver");
	}
	else
	{
		ShowPlayerDialogEx(playerid,13,DIALOG_STYLE_LIST, ObjetTitleName, "{00A5FF}1 - {F0F0F0}Dar\r\n{00A5FF}2 - {F0F0F0}Tirar\r\n{00A5FF}3 - {F0F0F0}Sacar", "Seleccionar", "Volver");
	}
}
public ShowDarObjeto(playerid)
{
	new ObjetTitleName[MAX_TEXT_CHAT];
	format(ObjetTitleName, sizeof(ObjetTitleName), "{00A5FF}Objetos - Dar {F5FF00}%s", ObjectsNames[GetTypeObjectEx(PlayersData[playerid][Objetos][PlayersDataOnline[playerid][SaveAfterAgenda][10]])]);
	ShowPlayerDialogEx(playerid,14,DIALOG_STYLE_INPUT, ObjetTitleName, "{F0F0F0}Ingrese la ID del jugador al que desea dar éste objeto.", "Dar", "Volver");
}
public RemoveObjectHoldToPlayer(playerid, objectid, index)
{
    RemovePlayerAttachedObject(playerid, index);
	if ( objectid != -1 )
	{
	    index = HaveObjectPlayer(playerid, objectid);
	    if ( index == -1 )
	    {
	        return false;
        }
	}
    PlayersData[playerid][Objetos][index] = false;
    return true;
}
public ReverseEx(&number)
{
	if ( number )
	{
	    number = false;
	}
	else
	{
	    number = true;
	}
}
public HaveObjectPlayer(playerid, objectid)
{
	for (new i = 0; i < MAX_OBJECTS_PLAYERS; i++)
	{
	    if ( PlayersData[playerid][Objetos][i] == objectid )
	    {
	        return i;
	    }
	}
	return -1;
}
public SetFunctionsForBizz(playerid, bizzid)
{
	switch (bizzid)
	{
	    case 24,22,25,23,16,17,18,27, 28, 29, 12,11,10,9,8,7,6,5,4,3,2,1,0:
	    {
	    	SetPlayerCheckpoint(playerid, NegociosType[bizzid][PosInX_PC], NegociosType[bizzid][PosInY_PC], NegociosType[bizzid][PosInZ_PC], 1.0);
		}
	}
}
public IsGarageToHouse(playerid, pickupid)
{
	for ( new i = 0; i <= MAX_GARAGE_TYPE; i++ )
	{
		if ( TypeGarage[i][PickupIdh] == pickupid )
		{
		    return true;
		}
	}
	return false;
}
public ShowPlayerMenuSelectWalk(playerid)
{
	new ListDialog[350];
	for (new i = 0; i < sizeof(ModeWalkID); i++)
	{
	    if ( i != 0 )
	    {
	    	strcat(ListDialog, "\r\n{E6E6E6}", sizeof(ListDialog));
		}
	    if ( PlayersData[playerid][MyStyleWalk] == i)
	    {
	    	strcat(ListDialog, "{00F50A}> ", sizeof(ListDialog));
	    	strcat(ListDialog, ModeWalkName[i], sizeof(ListDialog));
    	}
    	else
    	{
	    	strcat(ListDialog, ModeWalkName[i], sizeof(ListDialog));
		}
	}
	ShowPlayerDialogEx(playerid,15,DIALOG_STYLE_LIST,"{FF0000}[SGW] Seleccionar mi estilo de caminar", ListDialog, "Seleccionar", "Cancelar");
}
public SetPlayerSpectateToPlayer(playerid, spectateplayerid)
{
	if (PlayersDataOnline[playerid][Espectando] == -1 )
    {
        PlayersDataOnline[playerid][Spawn]      = false;
        GetSpawnInfo(playerid);
		PlayersDataOnline[playerid][StateDeath] = true;
		TogglePlayerSpectating(playerid, 1);
	}
	else
	{
		new IdLast = PlayersDataOnline[playerid][Espectando];
		PlayersDataOnline[spectateplayerid][IsEspectando] = true;
		CheckSpectToPlayer(IdLast);
	}
    PlayersDataOnline[playerid][Espectando] = spectateplayerid;
    SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorld(spectateplayerid));
    SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(spectateplayerid));
    if ( IsPlayerInAnyVehicle(spectateplayerid) && PlayersDataOnline[playerid][EspectVehOrPlayer])
    {
        PlayersDataOnline[playerid][EspectVehOrPlayer] = false;
		PlayerSpectateVehicle(playerid, GetPlayerVehicleID(spectateplayerid));
	}
	else
	{
        PlayersDataOnline[playerid][EspectVehOrPlayer] = true;
		PlayerSpectatePlayer(playerid, spectateplayerid);
	}
	if ( PlayersData[spectateplayerid][Admin] == 9 )
	{
	    new MsgPerNivel9[MAX_TEXT_CHAT];
	    format(MsgPerNivel9, sizeof(MsgPerNivel9), "%s %s está espectado a %s!", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], PlayersDataOnline[spectateplayerid][NameOnline]);
	    MsgCheatsReportsToAdminsEx(MsgPerNivel9, 9);
	}
}
public IntermitenteEncendido(playerid)
{
	if (IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] == 0 )
	{
	    if ( DataCars[GetPlayerVehicleID(playerid)][LightState] )
	    {
	        DataCars[GetPlayerVehicleID(playerid)][LightState] = false;
		}
		else
		{
			DataCars[GetPlayerVehicleID(playerid)][LightState] = true;
		}
	    IsVehicleOff(GetPlayerVehicleID(playerid));
	}
	else if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && DataCars[GetPlayerVehicleID(playerid)][StateEncendido] && DataCars[GetPlayerVehicleID(playerid)][IsIntermitente])
	{
	    DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] = 0;
	}
}
public NextPlayerSpect(playerid)
{
	if ( PlayersDataOnline[playerid][Espectando] != -1 )
	{
		new i = PlayersDataOnline[playerid][Espectando] + 1;
		if ( i > 499 )
		{
		    i = 0;
		}
		for (; i < MAX_PLAYERS; i++)
		{
			if ( i == PlayersDataOnline[playerid][Espectando] )
			{
			    return true;
			}
			if ( i != playerid && IsPlayerConnected(i) && PlayersDataOnline[i][StateDeath] != 2 )
			{
			    SetPlayerSpectateToPlayer(playerid, i);
			    return true;
			}
			if ( i == 499 )
			{
			    i = -1;
			}
		}
	}
	return false;
}
public LastPlayerSpect(playerid)
{
	if ( PlayersDataOnline[playerid][Espectando] != -1 )
	{
		new i = PlayersDataOnline[playerid][Espectando] - 1;
		if ( i < 0 )
		{
		    i = 499;
		}
		for (; i < MAX_PLAYERS; i--)
		{
			if ( i == PlayersDataOnline[playerid][Espectando] )
			{
			    return true;
			}
			if ( i != playerid && IsPlayerConnected(i) && PlayersDataOnline[i][StateDeath] != 2)
			{
			    SetPlayerSpectateToPlayer(playerid, i);
			    return true;
			}
			if ( i == 0 )
			{
			    i = 500;
			}
		}
	}
	return false;
}
public IntermitenteIzquierdo(playerid)
{
	if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] != 1 )
	{
		new Panels, Doors1, Lights, Tires;
		GetVehicleDamageStatus(GetPlayerVehicleID(playerid), Panels, Doors1, Lights, Tires);
		UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), Panels, Doors1, encode_lights(1,0,0,0), Tires);
		if ( !DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] )
		{
		    SetTimerEx("TimerIntermitentes", 500, false, "d", GetPlayerVehicleID(playerid));
	    }
	    DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] = 1;
	    DataCars[GetPlayerVehicleID(playerid)][ConteoIntermitente] = false;
	}
}
public IntermitenteDerecho(playerid)
{
	if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] != 2 )
	{
		new Panels, Doors1, Lights, Tires;
		GetVehicleDamageStatus(GetPlayerVehicleID(playerid), Panels, Doors1, Lights, Tires);
		UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), Panels, Doors1, encode_lights(0,0,0,1), Tires);
		if ( !DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] )
		{
		    SetTimerEx("TimerIntermitentes", 500, false, "d", GetPlayerVehicleID(playerid));
	    }
	    DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] = 2;
	    DataCars[GetPlayerVehicleID(playerid)][ConteoIntermitente] = false;
	}
}
public IntermitenteEstacionamiento(playerid)
{
	if ( IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0 && DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] != 3 )
	{
		new Panels, Doors1, Lights, Tires;
		GetVehicleDamageStatus(GetPlayerVehicleID(playerid), Panels, Doors1, Lights, Tires);
		UpdateVehicleDamageStatus(GetPlayerVehicleID(playerid), Panels, Doors1, encode_lights(1,1,1,1), Tires);
		if ( !DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] )
		{
		    SetTimerEx("TimerIntermitentes", 500, false, "d", GetPlayerVehicleID(playerid));
	    }
	    DataCars[GetPlayerVehicleID(playerid)][IsIntermitente] = 3;
	    DataCars[GetPlayerVehicleID(playerid)][ConteoIntermitente] = false;
	}
}
public GetMyNearDoor(playerid, key, option)
{
	new iBucle;
	new i = -1;
	new Float:RangoC;
    do
    {
	    RangoC++;
	    iBucle = 0;
		for (; iBucle <= MAX_DOORS; iBucle++)
		{
		    if ( (Doors[iBucle][speedmove] == STANDARD_SPEED_DOORS || Doors[iBucle][speedmove] == STANDARD_SPEED_BARRAS) && !option  || Doors[iBucle][speedmove] == STANDARD_SPEED_DOORS_GRUAS && option)
		    {
				if (IsPlayerInRangeOfPoint(playerid, RangoC, Doors[iBucle][PosXTrue], Doors[iBucle][PosYTrue], Doors[iBucle][PosZTrue]) ||
				     IsPlayerInRangeOfPoint(playerid, RangoC, Doors[iBucle][PosXFalse], Doors[iBucle][PosYFalse], Doors[iBucle][PosZFalse]) )
				{
				    i = iBucle;
				    RangoC = 10.0;
			       	break;
				}
			}
		}
	}
	while ( RangoC != 10.0 );

	if ( i != -1 )
	{
	    if ( Doors[i][Dueno] == SINGANG || Doors[i][Dueno] == PlayersData[playerid][Gang] )
	    {
		    new Float:TempPosObject[3]; GetDynamicObjectPos(Doors[i][objectanimid], TempPosObject[0], TempPosObject[1], TempPosObject[2]);
			new Float:TempRotObject[3]; GetDynamicObjectRot(Doors[i][objectanimid], TempRotObject[0], TempRotObject[1], TempRotObject[2]);

		    if ( TempPosObject[0] == Doors[i][PosXTrue] 	&& TempPosObject[1] == Doors[i][PosYTrue] 		&& TempPosObject[2] == Doors[i][PosZTrue] &&
			     TempRotObject[0] == Doors[i][PosRotXTrue] 	&& TempRotObject[1] == Doors[i][PosRotYTrue] 	&& TempRotObject[2] == Doors[i][PosRotZTrue]
				||
				 TempPosObject[0] == Doors[i][PosXFalse] 		&& TempPosObject[1] == Doors[i][PosYFalse] 		&& TempPosObject[2] == Doors[i][PosZFalse] &&
			     TempRotObject[0] == Doors[i][PosRotXFalse] 	&& TempRotObject[1] == Doors[i][PosRotYFalse] 	&& TempRotObject[2] == Doors[i][PosRotZFalse] )
			{
				if ( Doors[i][typeanim] == 0)
				{
				    if ( TempPosObject[0] == Doors[i][PosXFalse] 	&& TempPosObject[1] == Doors[i][PosYFalse]		&& TempPosObject[2] == Doors[i][PosZFalse] &&
			     		 TempRotObject[0] == Doors[i][PosRotXFalse] && TempRotObject[1] == Doors[i][PosRotYFalse] 	&& TempRotObject[2] == Doors[i][PosRotZFalse] )
				    {
						MoveDynamicObject(Doors[i][objectanimid], Doors[i][PosXTrue], Doors[i][PosYTrue], Doors[i][PosZTrue], Doors[i][speedmove], Doors[i][PosRotXTrue], Doors[i][PosRotYTrue], Doors[i][PosRotZTrue]);
//						SetDynamicObjectRot(Doors[i][objectanimid], Doors[i][PosRotXTrue], Doors[i][PosRotYTrue], Doors[i][PosRotZTrue]);
					}
					else
					{
						MoveDynamicObject(Doors[i][objectanimid], Doors[i][PosXFalse], Doors[i][PosYFalse], Doors[i][PosZFalse], Doors[i][speedmove], Doors[i][PosRotXFalse], Doors[i][PosRotYFalse], Doors[i][PosRotZFalse]);
//						SetDynamicObjectRot(Doors[i][objectanimid], Doors[i][PosRotXFalse], Doors[i][PosRotYFalse], Doors[i][PosRotZFalse]);
					}
				}
				else if ( Doors[i][typeanim] == 1 )
				{
				    if ( TempPosObject[0] == Doors[i][PosXFalse] 		&& TempPosObject[1] == Doors[i][PosYFalse] 		&& TempPosObject[2] == Doors[i][PosZFalse] &&
			     		 TempRotObject[0] == Doors[i][PosRotXFalse] 	&& TempRotObject[1] == Doors[i][PosRotYFalse] 	&& TempRotObject[2] == Doors[i][PosRotZFalse] )
				    {
						MoveDoorDynamicTwo(i, 0.0);
//						MoveDynamicObject(Doors[i][objectanimid], Doors[i][PosXTrue], Doors[i][PosYTrue], Doors[i][PosZTrue], Doors[i][speedmove], Doors[i][PosRotXTrue], Doors[i][PosRotYTrue], Doors[i][PosRotZTrue]);
				    }
					else
					{
						MoveDoorDynamicOne(i, 0.0);
//						MoveDynamicObject(Doors[i][objectanimid], Doors[i][PosXFalse], Doors[i][PosYFalse], Doors[i][PosZFalse], Doors[i][speedmove], Doors[i][PosRotXFalse], Doors[i][PosRotYFalse], Doors[i][PosRotZFalse]);
					}
				}
				else if ( Doors[i][typeanim] == 2 )
				{
				    if ( TempPosObject[0] == Doors[i][PosXFalse] 		&& TempPosObject[1] == Doors[i][PosYFalse] 		&& TempPosObject[2] == Doors[i][PosZFalse] &&
			     		 TempRotObject[0] == Doors[i][PosRotXFalse] 	&& TempRotObject[1] == Doors[i][PosRotYFalse] 	&& TempRotObject[2] == Doors[i][PosRotZFalse] )
				    {
				        SetDynamicObjectPos(Doors[i][objectanimid], Doors[i][PosXTrue], Doors[i][PosYTrue], Doors[i][PosZTrue]);
						SetDynamicObjectRot(Doors[i][objectanimid], Doors[i][PosRotXTrue], Doors[i][PosRotYTrue], Doors[i][PosRotZTrue]);
				    }
					else
					{
						SetDynamicObjectPos(Doors[i][objectanimid], Doors[i][PosXFalse], Doors[i][PosYFalse], Doors[i][PosZFalse]);
						SetDynamicObjectRot(Doors[i][objectanimid], Doors[i][PosRotXFalse], Doors[i][PosRotYFalse], Doors[i][PosRotZFalse]);
					}
				}
				return i;
			}
			else
			{
			    if ( !option )
			    {
					SendInfoMessage(playerid, 0, "779", "La puerta que desea abrir o cerrar, todavía se esta abriendo o cerrando");
				}
				else
				{
					SendInfoMessage(playerid, 0, "1502", "La grúa que desea levantar o bajar, todavía esta bajando o subiendo");
				}
				return -1;
			}
		}
		else
		{
		    if ( !option )
		    {
				SendInfoMessage(playerid, 0, "778", "No tienes las llaves de esta puerta");
			}
			else
			{
				SendInfoMessage(playerid, 0, "1408", "No tienes el control de esta grúa");
			}
			return -1;
		}
	}

	if ( !key )
	{
	    if ( !option )
	    {
			SendInfoMessage(playerid, 0, "777", "No hay ninguna puerta a su alrededor");
		}
		else
		{
			SendInfoMessage(playerid, 0, "1395", "No hay ninguna grúa a su alrededor");
		}
	}
	return -1;
}
public IsPlayerNearGarage(vehicleid, playerid)
{
	new MyWorld = GetPlayerVirtualWorld(playerid);
	for (new h = 1; h <= MAX_HOUSE; h++)
	{
		for ( new i = 0; i < MAX_GARAGE_FOR_HOUSE; i++ )
		{
	        if ( Garages[h][i][PickupidIn] )
			{
				if ( IsPlayerInRangeOfPoint(playerid, 3.0,
								 Garages[h][i][XgOut],
								 Garages[h][i][YgOut],
								 Garages[h][i][ZgOut]) ||
				 IsPlayerInRangeOfPoint(playerid, 3.0,
								 TypeGarage[Garages[h][i][TypeGarageE]][PosXc],
								 TypeGarage[Garages[h][i][TypeGarageE]][PosYc],
								 TypeGarage[Garages[h][i][TypeGarageE]][PosZc])
								 &&
								 MyWorld == Garages[h][i][WorldG] &&
								 PlayersData[playerid][IsPlayerInHouse] &&
								 PlayersData[playerid][IsPlayerInGarage] >= 0 )
				 {
		            if ( !Garages[h][i][LockOut] || PlayersDataOnline[playerid][AdminOn] )
		            {
						if ( IsPlayerInRangeOfPoint(playerid, 3.0,
										 TypeGarage[Garages[h][i][TypeGarageE]][PosXc],
										 TypeGarage[Garages[h][i][TypeGarageE]][PosYc],
										 TypeGarage[Garages[h][i][TypeGarageE]][PosZc])
										 &&
										 MyWorld == Garages[h][i][WorldG] &&
										 PlayersData[playerid][IsPlayerInHouse] &&
										 PlayersData[playerid][IsPlayerInGarage] >= 0 )
						{
							for (new s = 0; s < MAX_PLAYERS;s++)
							{
							    if ( IsPlayerConnected(s) && IsPlayerInVehicle(s, vehicleid) )
							    {
						        	SetPlayerVirtualWorldEx(s, 0);
						        	SetPlayerInteriorEx(s, 0);
						            PlayersData[s][IsPlayerInHouse]  =  0;
				                    PlayersData[s][IsPlayerInGarage] =  -1;
							    }
							}
				        	SetVehicleVirtualWorldEx(vehicleid, 0);
				        	LinkVehicleToInteriorEx(vehicleid, 0);
							SetVehiclePos(vehicleid, Garages[h][i][XgOut], Garages[h][i][YgOut],Garages[h][i][ZgOut]);
							SetVehicleZAngle(vehicleid, Garages[h][i][ZZgOut]);
			        	}
			        	else if ( MyWorld == 0 )
			        	{
							for (new s = 0; s < MAX_PLAYERS;s++)
							{
							    if ( IsPlayerConnected(s) && IsPlayerInVehicle(s, vehicleid) )
							    {
						        	SetPlayerVirtualWorldEx(s, Garages[h][i][WorldG]);
						        	SetPlayerInteriorEx(s, TypeGarage[Garages[h][i][TypeGarageE]][Interior]);
				            		PlayersData[s][IsPlayerInHouse]  =  h;
		                    		PlayersData[s][IsPlayerInGarage] =  i;
							    }
							}
				        	SetVehicleVirtualWorldEx(vehicleid, Garages[h][i][WorldG]);
				        	LinkVehicleToInteriorEx(vehicleid, TypeGarage[Garages[h][i][TypeGarageE]][Interior]);
							SetVehiclePos(vehicleid, TypeGarage[Garages[h][i][TypeGarageE]][PosXc], TypeGarage[Garages[h][i][TypeGarageE]][PosYc], TypeGarage[Garages[h][i][TypeGarageE]][PosZc]);
							SetVehicleZAngle(vehicleid, TypeGarage[Garages[h][i][TypeGarageE]][PosZZc]);
			        	}
						return true;
		        	}
		        	else
		        	{
						GameTextForPlayer(playerid, "~W~Garage ~R~Cerrado!", 1000, 6);
						break;
					}
				}
			}
		}
	}
	return false;
}
public IsPlayerNearGarageEx(vehicleid, playerid)
{
	new MyWorld = GetPlayerVirtualWorld(playerid);
	for (new i = 0; i <= MAX_GARAGES_EX; i++)
	{
		if ( IsPlayerInRangeOfPoint(playerid, 3.0,
						 GaragesEx[i][PosXOne],
						 GaragesEx[i][PosYOne],
						 GaragesEx[i][PosZOne]) && MyWorld == WORLD_DEFAULT_INTERIOR ||
		 IsPlayerInRangeOfPoint(playerid, 3.0,
						 GaragesEx[i][PosXTwo],
						 GaragesEx[i][PosYTwo],
						 GaragesEx[i][PosZTwo]) )
		 {
            if ( !GaragesEx[i][Lock] || PlayersDataOnline[playerid][AdminOn] )
            {
				if ( IsPlayerInRangeOfPoint(playerid, 3.0,
						 GaragesEx[i][PosXOne],
						 GaragesEx[i][PosYOne],
						 GaragesEx[i][PosZOne])  )
				{
		        	SetVehicleVirtualWorldEx(vehicleid, 0);
		        	LinkVehicleToInteriorEx(vehicleid, 0);
					SetVehiclePos(vehicleid, GaragesEx[i][PosXTwo], GaragesEx[i][PosYTwo],GaragesEx[i][PosZTwo]);
					SetVehicleZAngle(vehicleid, GaragesEx[i][PosZZTwo]);
					for (new s = 0; s < MAX_PLAYERS;s++)
					{
					    if ( IsPlayerConnected(s) && IsPlayerInVehicle(s, vehicleid) )
					    {
				        	SetPlayerVirtualWorldEx(s, 0);
				        	SetPlayerInteriorEx(s, 0);
					    }
					}
	        	}
	        	else if ( MyWorld == 0 )
	        	{
		        	SetVehicleVirtualWorldEx(vehicleid, GaragesEx[i][World]);
		        	LinkVehicleToInteriorEx(vehicleid, GaragesEx[i][Interior]);
					SetVehiclePos(vehicleid, GaragesEx[i][PosXOne], GaragesEx[i][PosYOne], GaragesEx[i][PosZOne]);
					SetVehicleZAngle(vehicleid, GaragesEx[i][PosZZOne]);

					for (new s = 0; s < MAX_PLAYERS;s++)
					{
					    if ( IsPlayerConnected(s) && IsPlayerInVehicle(s, vehicleid) )
					    {
				        	SetPlayerVirtualWorldEx(s, GaragesEx[i][World]);
				        	SetPlayerInteriorEx(s, GaragesEx[i][Interior]);
					    }
					}
	        	}
				return true;
        	}
        	else
        	{
				GameTextForPlayer(playerid, "~W~Garage ~R~Cerrado!", 1000, 6);
				break;
			}
		}
	}
	return false;
}
public GetMySecondNearVehicle(playerid)
{
    new MyVehicle = GetPlayerVehicleID(playerid);
    new Float:X, Float:Y, Float:Z;
	for (new i = 1; i <= MAX_CAR; i++)
	{
	    GetVehiclePos(i, X, Y, Z);
		if (IsPlayerInRangeOfPoint(playerid, 9.0,
			X,
			Y,
			Z) && i != MyVehicle)
		{
		    return i;
		}
	}
	return false;
}

public MsgCheatsReportsToAdminsEx(text[], level)
{
	for (new e = 0; e < MAX_PLAYERS; e++)
	{
	    if ( IsPlayerConnected(e) && PlayersData[e][Admin] == level && PlayersDataOnline[e][State] == 3 )
	    {
	        SendClientMessage(e, COLOR_CHEATS_REPORTES, text);
	    }
    }
	printf("%s", text);
}
public encode_lights(light1, light2, light3, light4)
{
	return light1 | (light2 << 1) | (light3 << 2) | (light4 << 3);
}
public MoveDoorDynamicOne(doorid, Float:Progress)
{
	new Float:NextPos[6];
	NextPos[0] = Doors[doorid][PosXTrue];
	NextPos[1] = Doors[doorid][PosYTrue];
	NextPos[2] = Doors[doorid][PosZTrue];
	NextPos[3] = Doors[doorid][PosRotXTrue];
	NextPos[4] = Doors[doorid][PosRotYTrue];
	NextPos[5] = Doors[doorid][PosRotZTrue];

	Progress += VELOCITY_DOORS_PORCENT;
	/////////////////////////////// X POS
	if ( Doors[doorid][PosXTrue] > Doors[doorid][PosXFalse] )
	{
        NextPos[0] -= ((Doors[doorid][PosXTrue] - Doors[doorid][PosXFalse]) * Progress) / 100;
	}
	else
	{
        NextPos[0] += ((Doors[doorid][PosXFalse] - Doors[doorid][PosXTrue]) * Progress) / 100;
	}
	/////////////////////////////// Y POS
	if ( Doors[doorid][PosYTrue] > Doors[doorid][PosYFalse] )
	{
        NextPos[1] -= ((Doors[doorid][PosYTrue] - Doors[doorid][PosYFalse]) * Progress) / 100;
	}
	else
	{
        NextPos[1] += ((Doors[doorid][PosYFalse] - Doors[doorid][PosYTrue]) * Progress) / 100;
	}
	/////////////////////////////// Z POS
	if ( Doors[doorid][PosZTrue] > Doors[doorid][PosZFalse] )
	{
        NextPos[2] -= ((Doors[doorid][PosZTrue] - Doors[doorid][PosZFalse]) * Progress) / 100;
	}
	else
	{
        NextPos[2] += ((Doors[doorid][PosZFalse] - Doors[doorid][PosZTrue]) * Progress) / 100;
	}
	/////////////////////////////// X ROT
	if ( Doors[doorid][PosRotXTrue] > Doors[doorid][PosRotXFalse] )
	{
        NextPos[3] -= ((Doors[doorid][PosRotXTrue] - Doors[doorid][PosRotXFalse]) * Progress) / 100;
	}
	else
	{
        NextPos[3] += ((Doors[doorid][PosRotXFalse] - Doors[doorid][PosRotXTrue]) * Progress) / 100;
	}
	/////////////////////////////// Y ROT
	if ( Doors[doorid][PosRotYTrue] > Doors[doorid][PosRotYFalse] )
	{
        NextPos[4] -= ((Doors[doorid][PosRotYTrue] - Doors[doorid][PosRotYFalse]) * Progress) / 100;
	}
	else
	{
        NextPos[4] += ((Doors[doorid][PosRotYFalse] - Doors[doorid][PosRotYTrue]) * Progress) / 100;
	}
	/////////////////////////////// Z ROT
	if ( Doors[doorid][PosRotZTrue] > Doors[doorid][PosRotZFalse] )
	{
        NextPos[5] -= ((Doors[doorid][PosRotZTrue] - Doors[doorid][PosRotZFalse]) * Progress) / 100;
	}
	else
	{
        NextPos[5] += ((Doors[doorid][PosRotZFalse] - Doors[doorid][PosRotZTrue]) * Progress) / 100;
	}

	if ( Progress < 100.0 )
	{
        SetDynamicObjectPos(Doors[doorid][objectanimid], NextPos[0], NextPos[1], NextPos[2]);
		SetDynamicObjectRot(Doors[doorid][objectanimid], NextPos[3], NextPos[4], NextPos[5]);
		SetTimerEx("MoveDoorDynamicOne", VELOCITY_DOORS_TIME, false, "df", doorid, Progress);
	}
	else
	{
        SetDynamicObjectPos(Doors[doorid][objectanimid], Doors[doorid][PosXFalse], Doors[doorid][PosYFalse], Doors[doorid][PosZFalse]);
		SetDynamicObjectRot(Doors[doorid][objectanimid], Doors[doorid][PosRotXFalse], Doors[doorid][PosRotYFalse], Doors[doorid][PosRotZFalse]);
	}
}
public MoveDoorDynamicTwo(doorid, Float:Progress)
{
	new Float:NextPos[6];
	NextPos[0] = Doors[doorid][PosXFalse];
	NextPos[1] = Doors[doorid][PosYFalse];
	NextPos[2] = Doors[doorid][PosZFalse];
	NextPos[3] = Doors[doorid][PosRotXFalse];
	NextPos[4] = Doors[doorid][PosRotYFalse];
	NextPos[5] = Doors[doorid][PosRotZFalse];

	Progress += VELOCITY_DOORS_PORCENT;
	/////////////////////////////// X POS
	if ( Doors[doorid][PosXFalse] > Doors[doorid][PosXTrue] )
	{
        NextPos[0] -= ((Doors[doorid][PosXFalse] - Doors[doorid][PosXTrue]) * Progress) / 100;
	}
	else
	{
        NextPos[0] += ((Doors[doorid][PosXTrue] - Doors[doorid][PosXFalse]) * Progress) / 100;
	}
	/////////////////////////////// Y POS
	if ( Doors[doorid][PosYFalse] > Doors[doorid][PosYTrue] )
	{
        NextPos[1] -= ((Doors[doorid][PosYFalse] - Doors[doorid][PosYTrue]) * Progress) / 100;
	}
	else
	{
        NextPos[1] += ((Doors[doorid][PosYTrue] - Doors[doorid][PosYFalse]) * Progress) / 100;
	}
	/////////////////////////////// Z POS
	if ( Doors[doorid][PosZFalse] > Doors[doorid][PosZTrue] )
	{
        NextPos[2] -= ((Doors[doorid][PosZFalse] - Doors[doorid][PosZTrue]) * Progress) / 100;
	}
	else
	{
        NextPos[2] += ((Doors[doorid][PosZTrue] - Doors[doorid][PosZFalse]) * Progress) / 100;
	}
	/////////////////////////////// X ROT
	if ( Doors[doorid][PosRotXFalse] > Doors[doorid][PosRotXTrue] )
	{
        NextPos[3] -= ((Doors[doorid][PosRotXFalse] - Doors[doorid][PosRotXTrue]) * Progress) / 100;
	}
	else
	{
        NextPos[3] += ((Doors[doorid][PosRotXTrue] - Doors[doorid][PosRotXFalse]) * Progress) / 100;
	}
	/////////////////////////////// Y ROT
	if ( Doors[doorid][PosRotYFalse] > Doors[doorid][PosRotYTrue] )
	{
        NextPos[4] -= ((Doors[doorid][PosRotYFalse] - Doors[doorid][PosRotYTrue]) * Progress) / 100;
	}
	else
	{
        NextPos[4] += ((Doors[doorid][PosRotYTrue] - Doors[doorid][PosRotYFalse]) * Progress) / 100;
	}
	/////////////////////////////// Z ROT
	if ( Doors[doorid][PosRotZFalse] > Doors[doorid][PosRotZTrue] )
	{
        NextPos[5] -= ((Doors[doorid][PosRotZFalse] - Doors[doorid][PosRotZTrue]) * Progress) / 100;
	}
	else
	{
        NextPos[5] += ((Doors[doorid][PosRotZTrue] - Doors[doorid][PosRotZFalse]) * Progress) / 100;
	}

	if ( Progress < 100.0 )
	{
        SetDynamicObjectPos(Doors[doorid][objectanimid], NextPos[0], NextPos[1], NextPos[2]);
		SetDynamicObjectRot(Doors[doorid][objectanimid], NextPos[3], NextPos[4], NextPos[5]);
		SetTimerEx("MoveDoorDynamicTwo", VELOCITY_DOORS_TIME, false, "df", doorid, Progress);
	}
	else
	{
        SetDynamicObjectPos(Doors[doorid][objectanimid], Doors[doorid][PosXTrue], Doors[doorid][PosYTrue], Doors[doorid][PosZTrue]);
		SetDynamicObjectRot(Doors[doorid][objectanimid], Doors[doorid][PosRotXTrue], Doors[doorid][PosRotYTrue], Doors[doorid][PosRotZTrue]);
	}
}
public LinkVehicleToInteriorEx(vehicleid, interiorid)
{
    LinkVehicleToInterior(vehicleid, interiorid);
	DataCars[vehicleid][InteriorLast] = interiorid;
}
public SetVehicleVirtualWorldEx(vehicleid, worldid)
{
    SetVehicleVirtualWorld(vehicleid, worldid);
	DataCars[vehicleid][WorldLast] = worldid;
}
////////////////// AUDIO
//Acá mapping
public LoadStaticObjects()
{

/////////////////// MAP ATRAS DE EL BANCO SF LWIS TEJADA
	CrearObjetoDinamicoSGW(987, -2943.1999511719, 454.70001220703, 3.9000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2955.1999511719, 454.70001220703, 3.9000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2967.1198730469, 454.70001220703, 3.9000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2979.1000976563, 454.70001220703, 3.9000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2991.1101074219, 454.69998168945, 3.9000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2996.8999023438, 454.70001220703, 3.9000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2996.6999511719, 466.5, 3.9000000953674, 0, 0, 270, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2996.6999511719, 478.5, 3.9000000953674, 0, 0, 270, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2996.6999511719, 486.39999389648, 3.9000000953674, 0, 0, 270, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2979, 486.5, 3.9000000953674, 0, 0, 180, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2984.8000488281, 486.70001220703, 3.9000000953674, 0, 0, 181.99450683594, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2961.5, 486.39999389648, 3.9000000953674, 0, 0, 179.99401855469, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2950.8994140625, 486.3994140625, 3.9000000953674, 0, 0, 179.98352050781, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(5269, -2976.1999511719, 485.29998779297, 5.5, 0, 0, 270, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(5269, -2946.8999023438, 485.60000610352, 5.5, 0, 0, 270, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2933.1000976563, 486.70001220703, 3.9000000953674, 0, 0, 179.98352050781, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(2669, -2966.1999511719, 483.29998779297, 5.1999998092651, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(16326, -2988.1999511719, 459.70001220703, 3.9000000953674, 0, 0, 270, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3934, -2988.8000488281, 477.79998779297, 3.9000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3279, -2936.8000488281, 460.20001220703, 3.9000000953674, 0, 0, 182, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(18452, -2947.8000488281, 479.10000610352, 6.9000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(4597, -2961.8999023438, 472.5, 4.4000000953674, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2931.3999023438, 486.70001220703, 3.9000000953674, 0, 0, 179.98352050781, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2931.3000488281, 454.60000610352, 3.9000000953674, 0, 0, 89.983520507813, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987, -2931.1999511719, 466.5, 3.9000000953674, 0, 0, 89.983520507813, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3061,-2985.724853, 457.623321, 4.914062, 0.000000, 0.000000, 0.000000,-1,-1,-1,MAX_RADIO_STREAM); //Puerta de la gangMapeada
	
	//MAPEO LICENCIEROS LWIS
	CrearObjetoDinamicoSGW(3934, -2124.1999511719, -123.5, 35.799999237061, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(10244, -2143.1000976563, -99.900001525879, 35.900001525879, 0, 0, 92, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3884, -2133.1999511719, -81.099998474121, 40.200000762939, 0, 0, 358, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3884, -2121, -80.900001525879, 40.200000762939, 0, 0, 357.99499511719, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3115, -2123.6000976563, -124.40000152588, 35.200000762939, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(2985, -2096.6000976563, -80.800003051758, 40.700000762939, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3271, -2076.8999023438, -94.800003051758, 34.200000762939, 0, 0, 282, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(16093, -2147.6000976563, -164.19999694824, 34.299999237061, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(16641, -2126.3000488281, -149.39999389648, 36.099998474121, 0, 0, 0, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(12912, -2126.8999023438, -101, 25, 0, 0, 268, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3279, -2101.3999023438, -88, 34.299999237061, 0, 0, 274, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2133.6000976563, -80.099998474121, 38.299999237061, 90, 0, 182, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2136.3000488281, -80.099998474121, 38.299999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2139.1000976563, -80.199996948242, 38.299999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2142.6000976563, -80, 38.299999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2147.1000976563, -80, 38.299999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2152.3000488281, -80.099998474121, 38.299999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2119.8999023438, -80.199996948242, 38.299999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2116.1999511719, -80.199996948242, 38.299999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2109.3999023438, -80.199996948242, 36.299999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3280, -2100.8999023438, -80.199996948242, 38.799999237061, 90, 0, 181.99951171875, -1, -1, -1, MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(8077,-2138.768798,-184.588638,38.070323,0.000000,0.000000,-90.000000,-1,-1,-1,MAX_RADIO_STREAM);
	
	////////////////// MAPEO GANG CARCEL LWIS
	CrearObjetoDinamicoSGW(980,-2126.422363,-80.885536,31.620315,0.000000,0.000000,-0.100000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3361,-2431.300048,523.099975,30.899999,0.000000,0.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3867,-2454.100097,504.200012,44.099998,0.000000,0.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3934,-2441.500000,523.500000,33.200000,0.000000,0.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(1490,-2438.399902,505.600006,29.000000,0.000000,90.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(1526,-2423.600097,513.099975,28.939998,-0.800000,90.000000,-0.900000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(1527,-2446.230224,509.000000,32.400001,0.000000,9.000000,180.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(1530,-2440.100097,525.799987,28.920000,0.000000,90.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3279,-2450.199951,496.100006,29.100000,0.000000,0.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(984,-2428.364257,498.998413,28.087270,-90.000000,0.000000,-69.000000,-1,-1,-1,MAX_RADIO_STREAM);//Reja para cuadrar la puerta movible
	//Armas interior gang yakuza
	CrearObjetoDinamicoSGW(350,2318.358642,-1017.546875,1050.710815,-66.000000,12.000000,86.899993,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(362,2318.403564,-1018.500671,1049.211181,-19.899999,-60.000000,70.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(348,2318.401855,-1018.037170,1049.911010,-90.000000,-90.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	
	//Map último Gang Bahía ADP
	CrearObjetoDinamicoSGW(987,-2084.134765,1436.793334,6.100665,0.000000,0.000000,180.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2072.141357,1436.806762,6.091562,0.000000,0.000000,-180.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2060.513427,1436.708496,6.100666,0.000000,0.000000,-180.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2060.582031,1424.854003,6.100666,0.000000,0.000000,-270.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2060.532226,1413.133789,6.101562,0.000000,0.000000,-630.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2060.510498,1401.122192,6.100666,0.000000,0.000000,-270.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2060.500732,1389.179199,6.101562,0.000000,0.000000,-270.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2060.541748,1377.209350,6.100666,0.000000,0.000000,810.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2072.485351,1377.125976,6.100666,0.000000,0.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2095.988037,1377.185791,6.101562,0.000000,0.000000,0.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2095.917236,1389.189697,6.101562,0.000000,0.000000,-90.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2095.806884,1401.297485,6.100666,0.000000,0.000000,-90.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2095.787597,1413.338378,6.101562,0.000000,0.000000,-90.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2095.833984,1425.164794,6.100666,0.000000,0.000000,270.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(987,-2095.891357,1436.717773,6.101562,0.000000,0.000000,-90.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3279,-2067.253173,1385.423681,6.091562,0.000000,0.000000,90.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3279,-2088.566162,1385.423681,6.101562,0.000000,0.000000,90.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(3934,-2071.697753,1425.449218,6.100666,0.000000,0.000000,90.000000,-1,-1,-1,MAX_RADIO_STREAM);
	CrearObjetoDinamicoSGW(16326,-2088.956542,1428.768432,6.101562,0.000000,0.000000,180.000000,-1,-1,-1,MAX_RADIO_STREAM);
}
public CrearObjetoDinamicoSGW(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid, interior, playerid, Float:distance)
{
	return CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interior, -1, distance);
}
public LockVehicle(playerid)
{
	new MyNearCar = IsPlayerInNearVehicle(playerid);
	if ( MyNearCar )
	{
		if (IsVehicleMyVehicle(playerid, MyNearCar) ||
			IsVehicleMyGang(playerid, MyNearCar) && PlayersData[playerid][Rango] <= 1 ||
			IsVehicleMyGang(playerid, MyNearCar))
		{
		    new MsgLock[MAX_TEXT_CHAT];
		    if ( DataCars[MyNearCar][Lock] )
		    {
		    	DataCars[MyNearCar][Lock] = false;
				ShowLockTextDraws(MyNearCar, true);
				GameTextForPlayer(playerid, "~w~Coche ~g~Abierto", 1000, 3);
	    	}
	    	else
	    	{
		    	DataCars[MyNearCar][Lock] = true;
				ShowLockTextDraws(MyNearCar, false);
				GameTextForPlayer(playerid, "~w~Coche ~r~Cerrado", 1000, 3);
			}

			if ( MyNearCar <= MAX_CAR_DUENO )
			{
				format(MsgLock, 50, "%s su vehículo.", NamesLook[DataCars[MyNearCar][Lock]]);
				for (new i = 0; i < MAX_PLAYERS; i++)
		    	{
			  	    if(IsPlayerConnected(i))
					{
						SetVehicleParamsForPlayer(MyNearCar, i, 0, DataCars[MyNearCar][Lock]);
					}
				}
			}
			else
			{
				format(MsgLock, 50, "%s un vehículo de facción.", NamesLook[DataCars[MyNearCar][Lock]]);
				for (new i = 0; i < MAX_PLAYERS; i++)
		    	{
			  	    if(IsPlayerConnected(i)&&PlayersData[playerid][Gang]==PlayersData[i][Gang])
			  	    {
						SetVehicleParamsForPlayer(MyNearCar, i, 0, DataCars[MyNearCar][Lock]);
					}
				}
			}
		    SendInfoMessage(playerid, 2, "0", MsgLock);
			//PlayPlayerStreamSound(playerid, SOUND_ALARM_CAR);
		    return true;
	    }
	    else
		{
			SendInfoMessage(playerid, 0, "217", "Este no es su vehículo");
		    return false;
		}
	}
	else
	{
	    return false;
	}
}
public IsPlayerInNearVehicle(playerid)
{
	if ( !IsPlayerInAnyVehicle(playerid) )
	{
	    new TheVehicle;
	    new i;
	    new Float:RangoC;
	    new Float:X, Float:Y, Float:Z;
		new MyWorld = GetPlayerVirtualWorld(playerid);
	    do
	    {
		    RangoC++;
			i = 1;
			for (; i <= MAX_CAR; i++)
			{
			    GetVehiclePos(i, X, Y, Z);
				if (IsPlayerInRangeOfPoint(playerid, RangoC,
					X,
					Y,
					Z) && MyWorld == DataCars[i][WorldLast])
				{
				    TheVehicle = i;
				    RangoC = 8.0;
				    break;
				}
			}
		}
		while( RangoC != 8.0 );

		if ( TheVehicle && coches_Todos_Type[GetVehicleModel(TheVehicle) - 400] != BICI )
		{
		    return TheVehicle;
		}
		else
		{
			SendInfoMessage(playerid, 0, "222", "No hay ningún vehículo a su alrededor");
		}
		return false;
	}
	else
	{
		return GetPlayerVehicleID(playerid);
	}
}
public SetPlayerColorEx(playerid)
{
	switch(PlayersData[playerid][Gang])
	{
		case SINGANG:
		{
			SetPlayerColor(playerid, 0xFFFFFFFF);//Blanco
		}
		case YAKUZA:
		{
			SetPlayerColor(playerid, 0xFFE900FF);//Amarillo claro un poco
		}
		case RUSOS:
		{
			SetPlayerColor(playerid, 0xFF0000FF);//Rojo
		}
		case ITALIANOS:
		{
			SetPlayerColor(playerid, 0x08FF00FF);//Verde
		}
		case TRIADA:
		{
			SetPlayerColor(playerid, 0x1EDBF4FF);//Celeste - VerdeAguamarina, algo asi xD
		}
	}
}
public CheckHoraNew()
{
	new RconCommand[50];
	new SaveTime[3];gettime(SaveTime[0], SaveTime[1], SaveTime[2]);
	format(RconCommand, sizeof(RconCommand), "worldtime Hora %i:%i:%d", SaveTime[0], SaveTime[1], SaveTime[2]);
	SendRconCommand(RconCommand);
	SetTimer("CheckHoraNew", TIME_CHECK_NEW_HORA, false);
}
public OnGameModeExitEx()
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if ( IsPlayerConnected(i) )
		{
	    	SaveDatosPlayerDisconnect(i);
    	}
	}
	for (new i = 0; i < MAX_GANG_COUNT; i++ )
	{
	    new TempDirGang[25];
	    format(TempDirGang, sizeof(TempDirGang), "%s%i.sgw", DIR_GANGES, i);
		if ( fexist(TempDirGang) )
		{
			SaveDataGang(i);
		}
		else
		{
		    break;
		}
	}
	// Negocios
	for (new i = 1; i <= MAX_BIZZ; i++)
	{
		DataSaveBizz(i, true);
	}
	// Houses
	for (new i = 1; i <= MAX_HOUSE; i++)
	{
		SaveHouse(i, true);
	}
	// Otros
	SaveGasolineras();
	SaveBombas();
	// Save Car's
	for (new i = 1; i <= MAX_CAR; i++)
	{
	    GetVehiclePos(i, DataCars[i][LastX], DataCars[i][LastY], DataCars[i][LastZ]);
		GetVehicleZAngle(i, DataCars[i][LastZZ]);
		GetVehicleDamageStatus(i, DataCars[i][PanelS], DataCars[i][DoorS], DataCars[i][LightS], DataCars[i][TiresS]);
		if ( DataCars[i][LlenandoGas] )
		{
            DataCars[i][Gas] = DataCars[i][LlenandoGas];
		}
		DataCars[i][IsLastSpawn] = true;
	}
	for (new i = 1; i <= MAX_CAR_DUENO; i++ )
	{
		SaveDataVehicle(i, DIR_VEHICLES);
	}
	for (new i = MAX_CAR_DUENO + 1; i <= MAX_CAR_GANG; i++)
	{
		SaveDataVehicle(i, DIR_VEHICLESF);
    }
	for ( new i = MAX_CAR_GANG + 1; i <= MAX_CAR_PUBLIC; i++)
	{
		SaveDataVehicle(i, DIR_VEHICLESP);
    }
	// Save Teles

	DestroyAllDynamicObjects();
	print("___________________ GAMEMODE DESCARGADO CORRECTAMENTE! ___________________");
}
public IsPlayerInPincho(playerid, pickupid)
{
	for (new i=0; i < MAX_OBJECTS_VALLAS_CONOS_PINCHOS; i++)
	{
	    if ( VCP[i][objectid_vcp] != -1 && VCP[i][pickupidVCP] == pickupid && IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
	    {
	        new MyVehicle = GetPlayerVehicleID(playerid);
			new Vpanel, Vdoors, Vlights, Vtires;
			GetVehicleDamageStatus(MyVehicle, Vpanel, Vdoors, Vlights, Vtires);
			UpdateVehicleDamageStatus(MyVehicle, Vpanel, Vdoors, Vlights, 15);
	        return true;
	    }
	}
	return false;
}
public LoadDoors()
{
	Doors[MAX_DOORS][objectmodel]    = 980;
	Doors[MAX_DOORS][PosXTrue]       = -2931.237304;
	Doors[MAX_DOORS][PosYTrue]       = 481.035247;
	Doors[MAX_DOORS][PosZTrue]       = 6.704062;
	Doors[MAX_DOORS][PosRotXTrue]    = 0;
	Doors[MAX_DOORS][PosRotYTrue]    = 0;
	Doors[MAX_DOORS][PosRotZTrue]    = 270;
	Doors[MAX_DOORS][PosXFalse]    = -2931.237304;
	Doors[MAX_DOORS][PosYFalse]    = 473.035247;
	Doors[MAX_DOORS][PosZFalse]    = 6.654060;
	Doors[MAX_DOORS][PosRotXFalse]    = 0;
	Doors[MAX_DOORS][PosRotYFalse]    = 0;
	Doors[MAX_DOORS][PosRotZFalse]    = 270;
	Doors[MAX_DOORS][typeanim]       = 0;
	Doors[MAX_DOORS][speedmove]    = STANDARD_SPEED_DOORS;
	Doors[MAX_DOORS][Dueno]       = YAKUZA;

	MAX_DOORS++;
	Doors[MAX_DOORS][objectmodel]    = 980;
	Doors[MAX_DOORS][PosXTrue]       = -2126.422363;
	Doors[MAX_DOORS][PosYTrue]       = -80.885536;
	Doors[MAX_DOORS][PosZTrue]       = 37.120315;
	Doors[MAX_DOORS][PosRotXTrue]    = 0;
	Doors[MAX_DOORS][PosRotYTrue]    = 0;
	Doors[MAX_DOORS][PosRotZTrue]    = 0;
	Doors[MAX_DOORS][PosXFalse]    = -2126.422363;
	Doors[MAX_DOORS][PosYFalse]    = -80.885536;
	Doors[MAX_DOORS][PosZFalse]    = 31.620315;
	Doors[MAX_DOORS][PosRotXFalse]    = 0;
	Doors[MAX_DOORS][PosRotYFalse]    = 0;
	Doors[MAX_DOORS][PosRotZFalse]    = 0;
	Doors[MAX_DOORS][typeanim]       = 0;
	Doors[MAX_DOORS][speedmove]    = STANDARD_SPEED_DOORS;
	Doors[MAX_DOORS][Dueno]       = RUSOS;

	MAX_DOORS++;
	Doors[MAX_DOORS][objectmodel]    = 980;
	Doors[MAX_DOORS][PosXTrue]       = -2434.252441;
	Doors[MAX_DOORS][PosYTrue]       = 496.518035;
	Doors[MAX_DOORS][PosZTrue]       = 31.697975;
	Doors[MAX_DOORS][PosRotXTrue]    = 0;
	Doors[MAX_DOORS][PosRotYTrue]    = 0;
	Doors[MAX_DOORS][PosRotZTrue]    = 203.000000;
	Doors[MAX_DOORS][PosXFalse]    = -2434.252441;
	Doors[MAX_DOORS][PosYFalse]    = 496.518035;
	Doors[MAX_DOORS][PosZFalse]    = 26.170984;
	Doors[MAX_DOORS][PosRotXFalse]    = 0;
	Doors[MAX_DOORS][PosRotYFalse]    = 0;
	Doors[MAX_DOORS][PosRotZFalse]    = 203.000000;
	Doors[MAX_DOORS][typeanim]       = 0;
	Doors[MAX_DOORS][speedmove]    = STANDARD_SPEED_DOORS;
	Doors[MAX_DOORS][Dueno]       = ITALIANOS;

	MAX_DOORS++;
	Doors[MAX_DOORS][objectmodel]    = 980;
	Doors[MAX_DOORS][PosXTrue]       = -2078.276855;
	Doors[MAX_DOORS][PosYTrue]       = 1377.029296;
	Doors[MAX_DOORS][PosZTrue]       = 8.801561;
	Doors[MAX_DOORS][PosRotXTrue]    = 0;
	Doors[MAX_DOORS][PosRotYTrue]    = 0;
	Doors[MAX_DOORS][PosRotZTrue]    = 180;
	Doors[MAX_DOORS][PosXFalse]    = -2078.276855;
	Doors[MAX_DOORS][PosYFalse]    = 1377.029296;
	Doors[MAX_DOORS][PosZFalse]    = 3.331561;
	Doors[MAX_DOORS][PosRotXFalse]    = 0;
	Doors[MAX_DOORS][PosRotYFalse]    = 0;
	Doors[MAX_DOORS][PosRotZFalse]    = 180;
	Doors[MAX_DOORS][typeanim]       = 0;
	Doors[MAX_DOORS][speedmove]    = STANDARD_SPEED_DOORS;
	Doors[MAX_DOORS][Dueno]       = TRIADA;
	
	MAX_DOORS++;
	Doors[MAX_DOORS][objectmodel]    = 3567;
	Doors[MAX_DOORS][PosXTrue]       = 1571.212890625;// 1571.212890625 -1642.8984375 11.699999809265
	Doors[MAX_DOORS][PosYTrue]       = -1642.8984375;
	Doors[MAX_DOORS][PosZTrue]       = 11.699999809265;
	Doors[MAX_DOORS][PosRotXTrue]    = 0;
	Doors[MAX_DOORS][PosRotYTrue]    = 0;
	Doors[MAX_DOORS][PosRotZTrue]    = 0;
	Doors[MAX_DOORS][PosXFalse]    = 1571.212890625;
	Doors[MAX_DOORS][PosYFalse]    = -1642.8984375;
	Doors[MAX_DOORS][PosZFalse]    = 26.5;
	Doors[MAX_DOORS][PosRotXFalse]    = 0;
	Doors[MAX_DOORS][PosRotYFalse]    = 0;
	Doors[MAX_DOORS][PosRotZFalse]    = 0;
	Doors[MAX_DOORS][typeanim]       = 0;
	Doors[MAX_DOORS][speedmove]    = STANDARD_SPEED_DOORS;
	Doors[MAX_DOORS][Dueno]       = YAKUZA;
	
	for ( new i = 0; i <= MAX_DOORS; i++ )
	{
	    if ( Doors[i][PosXTrue] == Doors[i][PosXFalse] &&
             Doors[i][PosYTrue] == Doors[i][PosYFalse] &&
             Doors[i][PosZTrue] == Doors[i][PosZFalse] )
		{
/*		    Doors[i][PosXTrue] += 0.000001;
		    Doors[i][PosYTrue] += 0.000001;
		    Doors[i][PosZTrue] += 0.000001;*/
		}
		Doors[i][objectanimid]   = CreateDynamicObject(Doors[i][objectmodel], Doors[i][PosXTrue], Doors[i][PosYTrue], Doors[i][PosZTrue], Doors[i][PosRotXTrue], Doors[i][PosRotYTrue], Doors[i][PosRotZTrue], -1, -1, -1, MAX_RADIO_STREAM);
	}
	// END DOORS
}
public SaveTelesLock()
{
	new DirBD[50];
	new DataSave[20];
	new File:SaveTeles;
	for(new i=0;i<=MAX_TELE;i++)
	{
		format(DirBD, sizeof(DirBD), "%s%i.sgw", DIR_TELES, i);
		format(DataSave, sizeof(DataSave), "%i", Teles[i][Lock]);
		SaveTeles = fopen(DirBD, io_write);
		fwrite(SaveTeles, DataSave);
		fclose(SaveTeles);
	}
}
public LoadTelesLock()
{
	new DirBD[50];
    new DataRead[20];
	new File:ReadDataT;
	for(new i=0;i<=MAX_TELE;i++)
	{
		format(DirBD, sizeof(DirBD), "%s%i.sgw", DIR_TELES, i);
		if ( fexist(DirBD) )
		{
	        ReadDataT = fopen(DirBD, io_read);
	      	fread(ReadDataT, DataRead);
			fclose(ReadDataT);
			Teles[i][Lock] = strval(DataRead);
		}
	}
}
public strvalEx(string[])
{
	new stringConvert[20];
	format(stringConvert, sizeof(stringConvert), "%s", string);
    return strval(stringConvert);
}
public MsgKBJWReportsToAdmins(playerid, text[])
{
	for (new e = 0; e < MAX_PLAYERS; e++)
	{
	    if ( IsPlayerConnected(e) && PlayersDataOnline[e][State] == 3 &&( PlayersData[e][Admin] >= 1 || playerid == e ) )
	    {
	        SendClientMessage(e, COLOR_KICK_JAIL_BAN, text);
	    }
    }
	printf("%s", text);
}
public UnBanUser(playerid_admin, playeridname[], option)
{
	new playerid = 499;
	format(PlayersDataOnline[playerid][NameOnline], MAX_PLAYER_NAME, "%s", playeridname);

	if ( !IsValidName(PlayersDataOnline[playerid][NameOnline]) )
	{
		SendInfoMessage(playerid_admin, 0, "676", "El nick que introdujo está deshabilitado por cuestiones de seguridad.");
	}
	else if ( DataUserLoad(playerid) )
	{
	    new MsgDesban[MAX_TEXT_CHAT];
	    if ( PlayersData[playerid][Admin] == 9 )
	    {
			SendInfoMessage(playerid_admin, 0, "1451", "No existe ese jugador en la base de datos!");
			return false;
		}
	    if ( !option )
	    {
			if ( PlayersData[playerid][AccountState] == 3 )
			{
			    PlayersData[playerid][AccountState] = 0;
				PlayersDataOnline[playerid][Spawn] = false;
				format(MsgDesban, sizeof(MsgDesban), "Has desbaneado a %s", playeridname);
				new UnBanIpCommand[MAX_TEXT_CHAT];
				format(UnBanIpCommand, sizeof(UnBanIpCommand), "unbanip %s", PlayersData[playerid][MyIP]);
				SendRconCommand(UnBanIpCommand);
				SendInfoMessage(playerid_admin, 3, "0", MsgDesban);
				DataUserSave(playerid);
			}
			else
			{
				format(MsgDesban, sizeof(MsgDesban), "El jugador %s no se encuentra baneado", playeridname);
				SendInfoMessage(playerid_admin, 0, "673", MsgDesban);
			}
		}
		else
		{
			if ( PlayersData[playerid][AccountState] != 3 )
			{
			    PlayersData[playerid][AccountState] = 3;
				PlayersDataOnline[playerid][Spawn] = false;
				format(MsgDesban, sizeof(MsgDesban), "Has baneado a %s", playeridname);
				new BanIpCommand[MAX_TEXT_CHAT];
				format(BanIpCommand, sizeof(BanIpCommand), "banip %s", PlayersData[playerid][MyIP]);
				SendRconCommand(BanIpCommand);
				SendInfoMessage(playerid_admin, 3, "0", MsgDesban);
				DataUserSave(playerid);
			}
			else
			{
				format(MsgDesban, sizeof(MsgDesban), "El jugador %s ya se encuentra baneado", playeridname);
				SendInfoMessage(playerid_admin, 0, "972", MsgDesban);
			}
		}
	}
	else
	{
		SendInfoMessage(playerid_admin, 0, "212", "No existe ese jugador en la base de datos!");
	}
	return true;
}

forward MyHttpResponse(index, response_code, data[]);
public MyHttpResponse(index, response_code, data[])
{
    // In this callback "index" would normally be called "playerid" ( if you didn't get it already :) )
    new buffer[128];
    if(response_code == 200)
    {
        //Yes!
        format(buffer, sizeof(buffer), "La URL es: %s", data);
        SendClientMessage(index, 0xFFFFFFFF, buffer);
    }
    else
    {
        //No!
        format(buffer, sizeof(buffer), "Fallo maricaaa: %d", response_code);
        SendClientMessage(index, 0xFFFFFFFF, buffer);
    }
}
public SetVehicleToRespawnEx(vehicleid)
{
	if ( coches_Todos_Type[DataCars[vehicleid][Modelo] - 400] != TREN )
	{

		DestroyVehicle(vehicleid);
		CleanTunningSlots(vehicleid);
		CreateVehicleEx(DataCars[vehicleid][Modelo],
		DataCars[vehicleid][PosX],
		DataCars[vehicleid][PosY],
		DataCars[vehicleid][PosZ],
		DataCars[vehicleid][PosZZ],
		DataCars[vehicleid][Color1],
		DataCars[vehicleid][Color2],
		vehicleid
		);
	}
	else
	{
	    SetVehicleToRespawn(vehicleid);
	}
	if ( DataCars[vehicleid][VehicleDeath] )
	{
		DataCars[vehicleid][VehicleDeath] = false;
		KillTimer(DataCars[vehicleid][TimerIdBug]);
	}
	GetVehicleHealth(vehicleid, DataCars[vehicleid][LastDamage]);
    DataCars[vehicleid][WorldLast]    = DataCars[vehicleid][World];
    DataCars[vehicleid][InteriorLast] = DataCars[vehicleid][Interior];
}
public SetVehicleToRespawnExTwo(vehicleid)
{
	if ( coches_Todos_Type[DataCars[vehicleid][Modelo] - 400] != TREN )
	{

		DestroyVehicle(vehicleid);

		CreateVehicleEx(DataCars[vehicleid][Modelo],
		DataCars[vehicleid][PosX],
		DataCars[vehicleid][PosY],
		DataCars[vehicleid][PosZ],
		DataCars[vehicleid][PosZZ],
		DataCars[vehicleid][Color1],
		DataCars[vehicleid][Color2],
		vehicleid
		);

		if ( DataCars[vehicleid][Vinillo] != -1 && IsValidVehiclePaintJob(DataCars[vehicleid][Modelo]) )
		{
			ChangeVehiclePaintjob(vehicleid, DataCars[vehicleid][Vinillo]);
		}
		else
		{
			DataCars[vehicleid][Vinillo] = -1;
		}
		for (new t = 0; t < 14; t++ )
		{
		    if ( DataCars[vehicleid][SlotsTunning][t] )
		    {
				AddVehicleComponentEx(vehicleid, DataCars[vehicleid][SlotsTunning][t]);
			}
		}
	}
	else
	{
	    SetVehicleToRespawn(vehicleid);
	}
	if ( DataCars[vehicleid][VehicleDeath] )
	{
		DataCars[vehicleid][VehicleDeath] = false;
		KillTimer(DataCars[vehicleid][TimerIdBug]);
	}
	GetVehicleHealth(vehicleid, DataCars[vehicleid][LastDamage]);
    DataCars[vehicleid][WorldLast]    = DataCars[vehicleid][World];
    DataCars[vehicleid][InteriorLast] = DataCars[vehicleid][Interior];
}
public GetPlayerStats(playerid, playeridshow)
{
	new MsnDialogStats[500];
	new Float:Vida1, Float:Chaleco1;
	GetPlayerHealth(playerid, Vida1);
	GetPlayerArmour(playerid, Chaleco1);

	format(MsnDialogStats, sizeof(MsnDialogStats),
	 "{AFEBFF}ID: %i | Nombre: %s | Interior: %i | Mundo: %i | Nivel: %i | Horas Jugadas: %i\nSexo: %s | Skin: %i \nGang: %s | Rango: %s | Dinero: $%i\nMuerto: %i | Muertos: %i | Explosivos: %i ",
			playerid,
			PlayersDataOnline[playerid][NameOnline],
			GetPlayerInteriorEx(playerid),
			GetPlayerVirtualWorld(playerid),
			PlayersData[playerid][KilledCount],
			PlayersData[playerid][HoursPlaying],
			Sexos[PlayersData[playerid][Sexo]],
			PlayersData[playerid][Skin],
			GangData[PlayersData[playerid][Gang]][NameGang],
			GangesRangos[PlayersData[playerid][Gang]][PlayersData[playerid][Rango]],
			PlayersData[playerid][Dinero],
			PlayersData[playerid][DeahtCount],
			PlayersData[playerid][KilledCount],
			PlayersData[playerid][Minas]);
			
	ShowPlayerDialogEx(playerid, 999, DIALOG_STYLE_MSGBOX, "{FF0000}[SGW] Estadísticas del Jugador", MsnDialogStats, "Ok", "");
}
public RespawnCoches()
{
	new IsRespawn[MAX_VEHICLE_COUNT];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if( IsPlayerConnected(i) && IsPlayerInAnyVehicle(i) == 1 && GetPlayerVehicleSeat(i) == 0 )
		{
		    IsRespawn[GetPlayerVehicleID(i)] = 1;
		}
	}
	for (new i = 1; i <= MAX_CAR; i++)
	{
	    if ( IsRespawn[i] != 1 )
	    {
			SetVehicleToRespawnExTwo(i);
		}
    }
    return 1;
}
public SetPlayerTeamEx(playerid)
{
	switch(PlayersData[playerid][Gang])
	{
	    case SINGANG:
	    {
	        SetPlayerTeam(playerid, NO_TEAM);
	    }
	    case YAKUZA:
	    {
	        SetPlayerTeam(playerid, 1);
	    }
	    case RUSOS:
	    {
	        SetPlayerTeam(playerid, 2);
	    }
	    case ITALIANOS:
	    {
	        SetPlayerTeam(playerid, 3);
	    }
	    case TRIADA:
	    {
	        SetPlayerTeam(playerid, 4);
	    }
	}
}
public Delete3DTextLabelEx(playerid, Text3D:id)
{
	if ( !Delete3DTextLabel(id) )
	{
	}
}
public DetectarSpam(playerid, text[])
{
	if ( strfind(text, " server ", false, 0) 					!= -1 ||
		 strfind(text, "server ", false, 0) 					== 0 ||
		 strfind(text, " svr ", false, 0) 						!= -1 ||
		 strfind(text, "svr ", false, 0) 						== 0 ||
		 strfind(text, " .com ", false, 0) 						!= -1 ||
		 strfind(text, ".com ", false, 0) 						== 0 ||
		 strfind(text, " :7777 ", false, 0) 					!= -1 ||
		 strfind(text, ":7777 ", false, 0) 						== 0 ||
		 strfind(text, ":7777", false, 0) 						!= -1 ||
		 strfind(text, ":7777", false, 0) 						== 0 ||
		 strfind(text, " .net ", false, 0) 						!= -1 ||
		 strfind(text, ".net ", false, 0) 						== 0 ||
	     strfind(text, " servidor ", false, 0) 					!= -1 ||
		 strfind(text, "servidor ", false, 0) 					== 0 ||
		 strfind(text, " dm ", false, 0) 						!= -1 ||
		 strfind(text, "dm ", false, 0)							== 0 ||
		 strfind(text, "87.98.229.188:7232", false, 0)			!= -1 ||
		 strfind(text, "213.5.176.155:8888", false, 0) 			!= -1 ||
		 strfind(text, "217.18.70.93:8800", false, 0) 			!= -1 ||
		 strfind(text, "66.7.194.75:5555", false, 0) 			!= -1 ||
		 strfind(text, "173.192.22.150:7777", false, 0) 		!= -1 ||
		 strfind(text, "78.129.221.58:7787", false, 0)			!= -1 ||
 		 strfind(text, "184.82.169.84:7781", false, 0) 			!= -1 ||
 		 strfind(text, "188.138.106.41:7777", false, 0) 		!= -1 ||
 		 strfind(text, "Rol Iberico", false, 0) 				!= -1 ||
		 strfind(text, "Gamerol.net", false, 0) 				!= -1 ||
		 strfind(text, "Gamerol", false, 0) 					!= -1 ||
		 strfind(text, "CiudadMetropolis.com", false, 0) 		!= -1 ||
		 strfind(text, "Ciudad Metropolis", false, 0) 			!= -1 ||
		 strfind(text, "Spacerol.net", false, 0) 				!= -1 ||
		 strfind(text, "Spacerol", false, 0) 					!= -1
	  )
	{
	    format(text, 256, "{FF0000}[SGW] {EDEF00}[Chat General] [%i] %s: %s",playerid, PlayersDataOnline[playerid][NameOnline], text);
		SendClientMessage(playerid, 0x0FFF00FF, text);
		new MsgAviso[MAX_TEXT_CHAT];
	    format(MsgAviso, sizeof(MsgAviso), "%s AntiSpam - %s[%i] posible spammer. Texto del anuncio: %s", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid, text);
	    MsgCheatsReportsToAdmins(MsgAviso);
		return true;
	}
	else
	{
	    return false;
	}
}

public RespawnAutomatico()
{
	new IsRespawn[MAX_VEHICLE_COUNT];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		if( IsPlayerConnected(i) && IsPlayerInAnyVehicle(i) == 1 && GetPlayerVehicleSeat(i) == 0 )
		{
		    IsRespawn[GetPlayerVehicleID(i)] = 1;
		}
	}
	for (new i = 1; i <= MAX_CAR; i++)
	{
	    if ( IsRespawn[i] != 1 )
	    {
			SetVehicleToRespawnExTwo(i);
		}
    }
	SetTimer("RespawnAutomatico", 120000, false);
}
public MaterialTextLogin()
{
	new myobject = CreateObject(19353, -1698.31, 853.99, 52.49, 0.0, 0.0, 45.0);
	SetObjectMaterialText(myobject, "{FFFFFF}Bienvenido a \n{FFFB00}Street {0010FF}Gang {FF1200}Wars!", 0, OBJECT_MATERIAL_SIZE_256x128,\
	"Arial", 30, 0, 0xFFFF8200, 0xFF000000, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid)
{
	new Asesino=issuerid;
	if ( issuerid != INVALID_PLAYER_ID )
	{
		if(weaponid == 34)
		{
			if(ModeMina[issuerid] == true)
			{
			    SetMinaToPlayer(playerid);
			    PlayersData[Asesino][Minas]--;
			}
		}
	}
}
public SetMinaToPlayer(playerid)
{
    SetTimerEx("TimerMine", 2000, false, "i", playerid);
	SendInfoMessage(playerid, 2, "0", "Te han disparado una mina.");
}

public TimerMine(playerid)
{
	new Float:Pos[3];
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	CreateExplosion(Pos[0], Pos[1], Pos[2], 12, 10.0);
}
public CargarMapIcons()
{
    CreateDynamicMapIconSGW(-2983.1213, 462.07512, 7.5094, 44);//Gang1
    CreateDynamicMapIconSGW(-2148.4658, -163.1070, 35.4328, 59);//Gang2
    CreateDynamicMapIconSGW(-2445.4912, 529.4976, 29.9212, 23);//Gang3
    CreateDynamicMapIconSGW(-2090.8271, 1425.6425, 7.1016, 43);//Gang4
}
public RemovePlayerWeapon(playerid, weaponid)
{
    SetPlayerArmedWeapon(playerid, weaponid);
    GivePlayerWeapon(playerid, weaponid, -(GetPlayerAmmo(playerid)));
    SetPlayerArmedWeapon(playerid, 0);
    return 1;
}
public AntiFakeKill(playerid)
{
    FakeKill[playerid] --;
    if(FakeKill[playerid] > 5)
    {
		new MsgAvisoFakeKill[MAX_TEXT_CHAT];
	    format(MsgAvisoFakeKill, sizeof(MsgAvisoFakeKill), "%s AntiCheat-FakeKill - %s[%i] posible {F1FF00}FakeKill.", LOGO_STAFF, PlayersDataOnline[playerid][NameOnline], playerid);
		MsgCheatsReportsToAdmins(MsgAvisoFakeKill);
	    printf("%s", MsgAvisoFakeKill);
    }
    return 1;
}
