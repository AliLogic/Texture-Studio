#include "localinputguidata.pwn"

#include <YSI_Coding\y_hooks>

#define CLICK_EXIT_MENU              (1005)

#define CLICK_TOOL_MAPMENU           (1000)
#define CLICK_TOOL_OBJMENU           (1001)
#define CLICK_TOOL_GRPMENU           (1002)
#define CLICK_TOOL_TEXSEARCH         (1003)
#define CLICK_TOOL_MODSEARCH         (1004)

#define CLICK_MAP_NEWMAP             (2000)
#define CLICK_MAP_LOADMAP            (2001)
#define CLICK_MAP_RENAMEMAP          (2002)
#define CLICK_MAP_IMPORTMAP          (2003)
#define CLICK_MAP_EXPORTMAP          (2004)

#define CLICK_OBJ_CLONE              (3000)
#define CLICK_OBJ_CREATE             (3001)
#define CLICK_OBJ_DELETE             (3002)
#define CLICK_OBJ_GROUP_INPUT        (3003)
#define CLICK_OBJ_GROUP_L            (3004)
#define CLICK_OBJ_GROUP_R            (3005)
#define CLICK_OBJ_MODEL_INPUT        (3006)
#define CLICK_OBJ_MODEL_L            (3007)
#define CLICK_OBJ_MODEL_R            (3008)
#define CLICK_OBJ_NOTE_INPUT         (3009)
#define CLICK_OBJ_TRANSFORM          (3010)

#define CLICK_OBJMOVE_BACK           (3100)
#define CLICK_OBJMOVE_MORE           (3101)
#define CLICK_OBJMOVE_X_INPUT        (3102)
#define CLICK_OBJMOVE_X_L            (3103)
#define CLICK_OBJMOVE_X_R            (3104)
#define CLICK_OBJMOVE_Y_INPUT        (3105)
#define CLICK_OBJMOVE_Y_L            (3106)
#define CLICK_OBJMOVE_Y_R            (3107)
#define CLICK_OBJMOVE_Z_INPUT        (3108)
#define CLICK_OBJMOVE_Z_L            (3109)
#define CLICK_OBJMOVE_Z_R            (3110)
#define CLICK_OBJMOVE_RX_INPUT       (3111)
#define CLICK_OBJMOVE_RX_L           (3112)
#define CLICK_OBJMOVE_RX_R           (3113)
#define CLICK_OBJMOVE_RY_INPUT       (3114)
#define CLICK_OBJMOVE_RY_L           (3115)
#define CLICK_OBJMOVE_RY_R           (3116)
#define CLICK_OBJMOVE_RZ_INPUT       (3117)
#define CLICK_OBJMOVE_RZ_L           (3118)
#define CLICK_OBJMOVE_RZ_R           (3119)
#define CLICK_OBJMOVE_RESROT         (3120)
#define CLICK_OBJMOVE_NUDPOS_INPUT   (3121)
#define CLICK_OBJMOVE_NUDPOS_L       (3122)
#define CLICK_OBJMOVE_NUDPOS_R       (3123)
#define CLICK_OBJMOVE_NUDROT_INPUT   (3124)
#define CLICK_OBJMOVE_NUDROT_L       (3125)
#define CLICK_OBJMOVE_NUDROT_R       (3126)

#define CLICK_OBJMOVEMORE_TOCURSOR   (3200)
#define CLICK_OBJMOVEMORE_TOFRONT    (3201)
#define CLICK_OBJMOVEMORE_TOGROUND   (3202)
#define CLICK_OBJMOVEMORE_TRANSFORM  (3203)

#define CLICK_GRP_CLEARSEL           (4000)
#define CLICK_GRP_SELALLOBJ          (4001)
#define CLICK_GRP_SELGRPID           (4002)
#define CLICK_GRP_ADDOBJID           (4003)
#define CLICK_GRP_ADDRANGE           (4004)
#define CLICK_GRP_ADDSELOBJ          (4005)
#define CLICK_GRP_REMOBJID           (4006)
#define CLICK_GRP_REMRANGE           (4007)
#define CLICK_GRP_REMSELOBJ          (4008)
#define CLICK_GRP_SETGRPID           (4009)
#define CLICK_GRP_TRANSFORM          (4010)

#define CLICK_GRPMOVE_BACK           (4100)
#define CLICK_GRPMOVE_MORE           (4101)
#define CLICK_GRPMOVE_X_L            (4102)
#define CLICK_GRPMOVE_X_R            (4103)
#define CLICK_GRPMOVE_Y_L            (4104)
#define CLICK_GRPMOVE_Y_R            (4105)
#define CLICK_GRPMOVE_Z_L            (4106)
#define CLICK_GRPMOVE_Z_R            (4107)
#define CLICK_GRPMOVE_RX_L           (4108)
#define CLICK_GRPMOVE_RX_R           (4109)
#define CLICK_GRPMOVE_RY_L           (4110)
#define CLICK_GRPMOVE_RY_R           (4111)
#define CLICK_GRPMOVE_RZ_L           (4112)
#define CLICK_GRPMOVE_RZ_R           (4113)
#define CLICK_GRPMOVE_NUDPOS_INPUT   (4114)
#define CLICK_GRPMOVE_NUDPOS_L       (4115)
#define CLICK_GRPMOVE_NUDPOS_R       (4116)
#define CLICK_GRPMOVE_NUDROT_INPUT   (4117)
#define CLICK_GRPMOVE_NUDROT_L       (4118)
#define CLICK_GRPMOVE_NUDROT_R       (4119)

#define CLICK_GRPMOVEMORE_TOCURSOR   (4200)
#define CLICK_GRPMOVEMORE_TOFRONT    (4201)
#define CLICK_GRPMOVEMORE_TOGROUND   (4202)
#define CLICK_GRPMOVEMORE_TRANSFORM  (4203)






// Main GUI
static GUIMenu:MenuToolBar;
static GUIMenu:MenuMap;
static GUIMenu:MenuObject;
static GUIMenu:MenuObjectMove;
static GUIMenu:MenuObjectMoveMore;
static GUIMenu:MenuGroup;
static GUIMenu:MenuGroupMove;
static GUIMenu:MenuGroupMoveMore;

static PlayerGUIMenu:PlayerMenuToolBar[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuMap[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuObject[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuObjectMove[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuObjectMoveMore[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuGroup[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuGroupMove[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuGroupMoveMore[MAX_PLAYERS];

// GUI Groups

//static PlayerGUIMenu:PlayerMenuAll[MAX_PLAYERS];
//static PlayerGUIMenu:PlayerMenuSubmenuAll[MAX_PLAYERS];

static PlayerGUIMenu:PlayerMenuMapAll[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuObjectAll[MAX_PLAYERS];
static PlayerGUIMenu:PlayerMenuGroupAll[MAX_PLAYERS];

// Element data, for textdraws specific to a player
enum PLAYER_MENU_DATA {
	E_ToolBarInfo,
	E_MapProp,
	E_ObjModel,
	E_ObjGroup,
	E_ObjNote,
	E_ObjProp,
	E_ObjX,
	E_ObjY,
	E_ObjZ,
	E_ObjRX,
	E_ObjRY,
	E_ObjRZ,
	E_ObjNudPos,
	E_ObjNudRot,
	E_GrpNudPos,
	E_GrpNudRot
}
new PlayerElementData[MAX_PLAYERS][PLAYER_MENU_DATA];





hook OnScriptInit()
{
	new tmpArray[MAX_ELEMENTS][GUIDEF], tmpCount;
	
	// TOOL BAR

	MenuToolBar = CreateGUI("MenuToolBar");

	LoadGUIMenu(MenuToolBar, ToolBarBox, 0.0, 428.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuToolBar, E_INDEX[0], 640.0, 20.0);

	LoadGUIMenu(MenuToolBar, ToolBarButton, 2.0, 430.0, CLICK_TOOL_MAPMENU, E_INDEX);
	GUISetTextSize(MenuToolBar, E_INDEX[0], 48.0, 16.0);
	GUISetPlayerText(MenuToolBar, E_INDEX[1], "Map_Menu");

	LoadGUIMenu(MenuToolBar, ToolBarButton, 52.0, 430.0, CLICK_TOOL_OBJMENU, E_INDEX);
	GUISetTextSize(MenuToolBar, E_INDEX[0], 58.0, 16.0);
	GUISetPlayerText(MenuToolBar, E_INDEX[1], "Object_Menu");

	LoadGUIMenu(MenuToolBar, ToolBarButton, 112.0, 430.0, CLICK_TOOL_GRPMENU, E_INDEX);
	GUISetTextSize(MenuToolBar, E_INDEX[0], 58.0, 16.0);
	GUISetPlayerText(MenuToolBar, E_INDEX[1], "Group_Menu");

	LoadGUIMenu(MenuToolBar, ToolBarButton, 484.0, 430.0, CLICK_TOOL_TEXSEARCH, E_INDEX);
	GUISetTextSize(MenuToolBar, E_INDEX[0], 67.0, 16.0);
	GUISetPlayerText(MenuToolBar, E_INDEX[1], "Texture_Search");

	LoadGUIMenu(MenuToolBar, ToolBarButton, 553.0, 430.0, CLICK_TOOL_MODSEARCH, E_INDEX);
	GUISetTextSize(MenuToolBar, E_INDEX[0], 61.0, 16.0);
	GUISetPlayerText(MenuToolBar, E_INDEX[1], "Model_Search");

	LoadGUIMenu(MenuToolBar, ToolBarButton, 616.0, 430.0, CLICK_EXIT_MENU, E_INDEX);
	GUISetTextSize(MenuToolBar, E_INDEX[0], 22.0, 16.0);
	GUISetPlayerText(MenuToolBar, E_INDEX[1], "Exit");

	// MAP MENU

	MenuMap = CreateGUI("MenuMap");

	LoadGUIMenu(MenuMap, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 120.0, 146.0); // back box

	LoadGUIMenu(MenuMap, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuMap, E_INDEX[1], "Map_Menu");

	/* THEORY */
	/*AdjustGUIMenuDataFloat(tmpArray, 0, GUITextSizeX, 37.0, GUITextSizeY, 16.0);*/
	/*AdjustGUIMenuData(tmpArray, 0, GUITextSizeX, 37.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, GUITextSizeY, 16.0);*/
	/*AdjustGUIMenuDataText(tmpArray, 1, "New");*/
	//tmpArray[0][GUITextSizeX] = 37.0;
	//tmpArray[0][GUITextSizeY] = 16.0;
	//tmpArray[1][GUIText] = "New";
	/* THEORY */
	
	/*tmpCount = CopyGUIMenuData(MenuButton, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setText = "X", .setAlignment = 2);
	LoadGUIMenu(MenuMap, tmpArray, 502.0, 146.0, CLICK_MAP_NEWMAP, E_INDEX, tmpCount);
	GUISetTextSize(MenuMap, E_INDEX[0], 37.0, 16.0);*/
	
	LoadGUIMenu(MenuMap, MenuButton, 502.0, 146.0, CLICK_MAP_NEWMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 37.0, 16.0); // new map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "New");
	
	LoadGUIMenu(MenuMap, MenuButton, 541.0, 146.0, CLICK_MAP_LOADMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 37.0, 16.0); // load map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "Load");

	LoadGUIMenu(MenuMap, MenuButton, 580.0, 146.0, CLICK_MAP_RENAMEMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 38.0, 16.0); // rename map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "Rename");

	LoadGUIMenu(MenuMap, MenuButton, 502.0, 164.0, CLICK_MAP_IMPORTMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 57.0, 16.0); // import map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "Import");

	LoadGUIMenu(MenuMap, MenuButton, 561.0, 164.0, CLICK_MAP_EXPORTMAP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 57.0, 16.0); // export map button
	GUISetPlayerText(MenuMap, E_INDEX[1], "Export");

	LoadGUIMenu(MenuMap, MenuHeader, 500.0, 182.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuMap, E_INDEX[0], 120.0, 16.0); // prop header box
	GUISetPlayerText(MenuMap, E_INDEX[1], "Properties");

	// OBJECT MENU

	MenuObject = CreateGUI("MenuObject");

	LoadGUIMenu(MenuObject, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 120.0, 216.0); // back box

	LoadGUIMenu(MenuObject, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuObject, E_INDEX[1], "Object_Menu");
	//
	LoadGUIMenu(MenuObject, MenuButton, 502.0, 146.0, CLICK_OBJ_CREATE, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 37.0, 16.0); // create button
	GUISetPlayerText(MenuObject, E_INDEX[1], "Create");

	LoadGUIMenu(MenuObject, MenuButton, 541.0, 146.0, CLICK_OBJ_DELETE, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 37.0, 16.0); // delete button
	GUISetPlayerText(MenuObject, E_INDEX[1], "Delete");

	LoadGUIMenu(MenuObject, MenuButton, 580.0, 146.0, CLICK_OBJ_CLONE, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 38.0, 16.0); // clone button
	GUISetPlayerText(MenuObject, E_INDEX[1], "Clone");
	//
	LoadGUIMenu(MenuObject, MenuText, 502.0, 164.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 31.0, 16.0); // model text
	GUISetPlayerText(MenuObject, E_INDEX[1], "Model");

	LoadGUIMenu(MenuObject, MenuSpriteButton, 602.0, 164.0, CLICK_OBJ_MODEL_R, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 16.0, 16.0); // model right button
	GUISetPlayerText(MenuObject, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObject, MenuSpriteButton, 584.0, 164.0, CLICK_OBJ_MODEL_L, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 16.0, 16.0); // model left button
	GUISetPlayerText(MenuObject, E_INDEX[1], "LD_BEAT:left");
	
	//
	LoadGUIMenu(MenuObject, MenuText, 502.0, 182.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 31.0, 16.0); // group text
	GUISetPlayerText(MenuObject, E_INDEX[1], "Group");

	LoadGUIMenu(MenuObject, MenuSpriteButton, 602.0, 182.0, CLICK_OBJ_GROUP_R, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 16.0, 16.0); // group right button
	GUISetPlayerText(MenuObject, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObject, MenuSpriteButton, 584.0, 182.0, CLICK_OBJ_GROUP_L, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 16.0, 16.0); // group left button
	GUISetPlayerText(MenuObject, E_INDEX[1], "LD_BEAT:left");
	
	//
	LoadGUIMenu(MenuObject, MenuText, 502.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 27.0, 16.0); // note text
	GUISetPlayerText(MenuObject, E_INDEX[1], "Note");
	
	//
	LoadGUIMenu(MenuObject, MenuButton, 502.0, 218.0, CLICK_OBJ_TRANSFORM, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 116.0, 16.0); // transform button
	GUISetPlayerText(MenuObject, E_INDEX[1], "Transform_Menu");
	//
	LoadGUIMenu(MenuObject, MenuHeader, 500.0, 236.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObject, E_INDEX[0], 120.0, 16.0); // prop header box
	GUISetPlayerText(MenuObject, E_INDEX[1], "Properties");

	// OBJECT-MOVE MENU

	MenuObjectMove = CreateGUI("MenuObjectMove");

	LoadGUIMenu(MenuObjectMove, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 120.0, 216.0); // back box

	LoadGUIMenu(MenuObjectMove, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Object_Movement");
	//
	LoadGUIMenu(MenuObjectMove, MenuHeaderMoreButton, 604.0, 128.0, CLICK_OBJMOVE_MORE, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // header more button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "...");

	LoadGUIMenu(MenuObjectMove, MenuHeaderButton, 579.0, 128.0, CLICK_OBJMOVE_BACK, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 25.0, 16.0); // header back button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Back");
	//
	
	/*//TMP
	tmpCount = CopyGUIMenuData(MenuSpriteButton, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 16.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setText = "LD_BEAT:right", .setFont = 4);
	LoadGUIMenu(MenuObjectMove, tmpArray, 602.0, 146.0, CLICK_OBJMOVE_X_L, E_INDEX, tmpCount);
	//TMP*/
	
	tmpCount = CopyGUIMenuData(MenuText, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 16.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 8.0, .setText = "X", .setAlignment = 2);
	
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 146.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "X"); // X text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 146.0, CLICK_OBJMOVE_X_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // X left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 146.0, CLICK_OBJMOVE_X_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // X right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 164.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Y"); // Y text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 164.0, CLICK_OBJMOVE_Y_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // Y left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 164.0, CLICK_OBJMOVE_Y_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // Y right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 182.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Z"); // Z text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 182.0, CLICK_OBJMOVE_Z_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // Z left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 182.0, CLICK_OBJMOVE_Z_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // Z right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, MenuHeader, 500.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 120.0, 16.0); // rot header box
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Rotation");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 218.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "RX"); // RX text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 218.0, CLICK_OBJMOVE_RX_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RX left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 218.0, CLICK_OBJMOVE_RX_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RX right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 236.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "RY"); // RY text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 236.0, CLICK_OBJMOVE_RY_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RY left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 236.0, CLICK_OBJMOVE_RY_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RY right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, tmpArray, 502.0, 254.0, CLICK_NO_GROUP, E_INDEX, tmpCount);
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "RZ"); // RZ text

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 254.0, CLICK_OBJMOVE_RZ_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RZ left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 254.0, CLICK_OBJMOVE_RZ_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // RZ right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");

	LoadGUIMenu(MenuObjectMove, MenuButton, 502.0, 272.0, CLICK_OBJMOVE_RESROT, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 116.0, 16.0); // reset rot right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Reset_Rotation");
	//
	LoadGUIMenu(MenuObjectMove, MenuHeader, 500.0, 290.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 120.0, 16.0); // nudge header box
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Nudge_Settings");
	//
	LoadGUIMenu(MenuObjectMove, MenuText, 502.0, 308.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 20.0, 16.0); // nudge pos text
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Pos");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 308.0, CLICK_OBJMOVE_NUDPOS_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // nudge pos right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 308.0, CLICK_OBJMOVE_NUDPOS_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // nudge pos left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuObjectMove, MenuText, 502.0, 326.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 20.0, 16.0); // nudge rot text
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "Rot");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 602.0, 326.0, CLICK_OBJMOVE_NUDROT_R, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // nudge rot right button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuObjectMove, MenuSpriteButton, 584.0, 326.0, CLICK_OBJMOVE_NUDROT_L, E_INDEX);
	GUISetTextSize(MenuObjectMove, E_INDEX[0], 16.0, 16.0); // nudge rot left button
	GUISetPlayerText(MenuObjectMove, E_INDEX[1], "LD_BEAT:left");

	// OBJECT-MOVE MORE MENU

	MenuObjectMoveMore = CreateGUI("MenuObjectMoveMore");

	LoadGUIMenu(MenuObjectMoveMore, MenuBox, 420.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 80.0, 90.0); // back box

	LoadGUIMenu(MenuObjectMoveMore, MenuHeader, 420.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 80.0, 16.0); // header box
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Extra");
	//
	LoadGUIMenu(MenuObjectMoveMore, MenuButton, 422.0, 146.0, CLICK_OBJMOVEMORE_TRANSFORM, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 76.0, 16.0); // transform button
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Transform");

	LoadGUIMenu(MenuObjectMoveMore, MenuButton, 422.0, 164.0, CLICK_OBJMOVEMORE_TOCURSOR, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 76.0, 16.0); // to cursor button
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Move_to_Cursor");

	LoadGUIMenu(MenuObjectMoveMore, MenuButton, 422.0, 182.0, CLICK_OBJMOVEMORE_TOGROUND, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 76.0, 16.0); // to ground button
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Move_to_Ground");

	LoadGUIMenu(MenuObjectMoveMore, MenuButton, 422.0, 200.0, CLICK_OBJMOVEMORE_TOFRONT, E_INDEX);
	GUISetTextSize(MenuObjectMoveMore, E_INDEX[0], 76.0, 16.0); // to front button
	GUISetPlayerText(MenuObjectMoveMore, E_INDEX[1], "Move_to_Front");

	// GROUP MENU

	MenuGroup = CreateGUI("MenuGroup");

	LoadGUIMenu(MenuGroup, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 120.0, 199.0); // back box

	LoadGUIMenu(MenuGroup, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Group_Menu");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 146.0, CLICK_GRP_SELALLOBJ, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // select all objects button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Select_all_objects");

	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 164.0, CLICK_GRP_SELGRPID, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // select group id button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Select_Group_ID");

	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 182.0, CLICK_GRP_CLEARSEL, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // clear sel button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Clear_selection");
	//
	LoadGUIMenu(MenuGroup, MenuHeader, 500.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 120.0, 16.0); // selection header box
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Selection");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 218.0, CLICK_GRP_SETGRPID, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // set group id
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Set_Group_ID");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 236.0, CLICK_GRP_ADDSELOBJ, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // add selected button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Add_Selected_Object");

	LoadGUIMenu(MenuGroup, MenuText, 502.0, 254.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 22.0, 16.0); // add text
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Add");

	LoadGUIMenu(MenuGroup, MenuButton, 526.0, 254.0, CLICK_GRP_ADDOBJID, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 46.0, 16.0); // add object id button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Object_ID");

	LoadGUIMenu(MenuGroup, MenuButton, 574.0, 254.0, CLICK_GRP_ADDRANGE, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 44.0, 16.0); // add range button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Range");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 272.0, CLICK_GRP_REMSELOBJ, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // rem selected button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Rem_Selected_Object");

	LoadGUIMenu(MenuGroup, MenuText, 502.0, 290.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 22.0, 16.0); // rem text
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Rem");

	LoadGUIMenu(MenuGroup, MenuButton, 526.0, 290.0, CLICK_GRP_REMOBJID, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 46.0, 16.0); // rem object id button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Object_ID");

	LoadGUIMenu(MenuGroup, MenuButton, 574.0, 290.0, CLICK_GRP_REMRANGE, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 44.0, 16.0); // rem range button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Range");
	//
	LoadGUIMenu(MenuGroup, MenuButton, 502.0, 308.0, CLICK_GRP_TRANSFORM, E_INDEX);
	GUISetTextSize(MenuGroup, E_INDEX[0], 116.0, 16.0); // transform button
	GUISetPlayerText(MenuGroup, E_INDEX[1], "Transform_Menu");

	// GROUP-MOVE MENU

	MenuGroupMove = CreateGUI("MenuGroupMove");

	LoadGUIMenu(MenuGroupMove, MenuBox, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 120.0, 198.0); // back box

	LoadGUIMenu(MenuGroupMove, MenuHeader, 500.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 120.0, 16.0); // header box
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Group_Movement");
	//
	LoadGUIMenu(MenuGroupMove, MenuHeaderMoreButton, 604.0, 128.0, CLICK_GRPMOVE_MORE, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // header more button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "...");

	LoadGUIMenu(MenuGroupMove, MenuHeaderButton, 579.0, 128.0, CLICK_GRPMOVE_BACK, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 25.0, 16.0); // header back button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Back");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 146.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // X text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "X");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 146.0, CLICK_GRPMOVE_X_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // X left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 146.0, CLICK_GRPMOVE_X_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // X right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 164.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // Y text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Y");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 164.0, CLICK_GRPMOVE_Y_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // Y left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 164.0, CLICK_GRPMOVE_Y_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // Y right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 182.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // Z text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Z");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 182.0, CLICK_GRPMOVE_Z_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // Z left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 182.0, CLICK_GRPMOVE_Z_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // Z right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuHeader, 500.0, 200.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 120.0, 16.0); // rot header box
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Rotation");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 218.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // RX text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "RX");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 218.0, CLICK_GRPMOVE_RX_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RX left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 218.0, CLICK_GRPMOVE_RX_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RX right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 236.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // RY text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "RY");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 236.0, CLICK_GRPMOVE_RY_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RY left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 236.0, CLICK_GRPMOVE_RY_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RY right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 254.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 80.0, 16.0); // RZ text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "RZ");
	GUISetAlignment(MenuGroupMove, E_INDEX[1], 1);

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 254.0, CLICK_GRPMOVE_RZ_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RZ left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 254.0, CLICK_GRPMOVE_RZ_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // RZ right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuHeader, 500.0, 272.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 120.0, 16.0); // nudge header box
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Nudge_Settings");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 290.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 20.0, 16.0); // nudge pos text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Pos");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 290.0, CLICK_GRPMOVE_NUDPOS_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // nudge pos right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 290.0, CLICK_GRPMOVE_NUDPOS_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // nudge pos left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");
	//
	LoadGUIMenu(MenuGroupMove, MenuText, 502.0, 308.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 20.0, 16.0); // nudge rot text
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "Rot");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 602.0, 308.0, CLICK_GRPMOVE_NUDROT_R, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // nudge rot right button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:right");

	LoadGUIMenu(MenuGroupMove, MenuSpriteButton, 584.0, 308.0, CLICK_GRPMOVE_NUDROT_L, E_INDEX);
	GUISetTextSize(MenuGroupMove, E_INDEX[0], 16.0, 16.0); // nudge rot left button
	GUISetPlayerText(MenuGroupMove, E_INDEX[1], "LD_BEAT:left");

	// GROUP-MOVE MORE MENU

	MenuGroupMoveMore = CreateGUI("MenuGroupMoveMore");

	LoadGUIMenu(MenuGroupMoveMore, MenuBox, 420.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 80.0, 90.0); // back box

	LoadGUIMenu(MenuGroupMoveMore, MenuHeader, 420.0, 128.0, CLICK_NO_GROUP, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 80.0, 16.0); // header box
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Extra");
	//
	LoadGUIMenu(MenuGroupMoveMore, MenuButton, 422.0, 146.0, CLICK_GRPMOVEMORE_TRANSFORM, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 76.0, 16.0); // transform button
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Transform");

	LoadGUIMenu(MenuGroupMoveMore, MenuButton, 422.0, 164.0, CLICK_GRPMOVEMORE_TOCURSOR, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 76.0, 16.0); // to cursor button
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Move_to_Cursor");

	LoadGUIMenu(MenuGroupMoveMore, MenuButton, 422.0, 182.0, CLICK_GRPMOVEMORE_TOGROUND, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 76.0, 16.0); // to ground button
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Move_to_Ground");

	LoadGUIMenu(MenuGroupMoveMore, MenuButton, 422.0, 200.0, CLICK_GRPMOVEMORE_TOFRONT, E_INDEX);
	GUISetTextSize(MenuGroupMoveMore, E_INDEX[0], 76.0, 16.0); // to front button
	GUISetPlayerText(MenuGroupMoveMore, E_INDEX[1], "Move_to_Front");

	// Create player menus

	foreach(new i : Player)
	{
		CreatePlayerMenus(i);
	}

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	CreatePlayerMenus(playerid);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

static CreatePlayerMenus(playerid)
{
	new tmpArray[MAX_ELEMENTS][GUIDEF], tmpCount;
	
	// Set selection color
	SetPlayerGUISelectionColor(playerid, 0xFFFF00FF);

	// Toolbar menu
	PlayerMenuToolBar[playerid] = PlayerCreateGUI(playerid, "MenuToolBar");
	
	tmpCount = CopyGUIMenuData(ToolBarInfo, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 240.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setText = "N/A", .setAlignment = 2);
	
	PlayerLoadGUIMenu(playerid, PlayerMenuToolBar[playerid], tmpArray, 200.0, 430.0, CLICK_NO_GROUP, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ToolBarInfo] = E_PLAYERINDEX[1]; // toolbar info
	
	// Map menu
	PlayerMenuMap[playerid] = PlayerCreateGUI(playerid, "MenuMap");
	
	PlayerLoadGUIMenu(playerid, PlayerMenuMap[playerid], MenuInfo, 502.0, 200.0, CLICK_NO_GROUP, E_PLAYERINDEX);
	PlayerGUISetTextSize(playerid, PlayerMenuMap[playerid], E_PLAYERINDEX[0], 116.0, 72.0);
	PlayerGUISetPlayerText(playerid, PlayerMenuMap[playerid], E_PLAYERINDEX[1], "Name~n~Object_Count:_100~n~Vehicle_Count:_20~n~Spawn:_X,_Y,_Z~n~Interior_1,_World_1");
	PlayerElementData[playerid][E_MapProp] = E_PLAYERINDEX[1]; // map prop info box
	
	// Object menu
	printf("Object menu");
	PlayerMenuObject[playerid] = PlayerCreateGUI(playerid, "MenuObject");
	
	tmpCount = CopyGUIMenuData(MenuInput, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 47.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setText = "0", .setAlignment = 2);

	PlayerLoadGUIMenu(playerid, PlayerMenuObject[playerid], tmpArray, 535.0, 164.0, CLICK_OBJ_MODEL_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjModel] = E_PLAYERINDEX[1]; // model input

	PlayerLoadGUIMenu(playerid, PlayerMenuObject[playerid], tmpArray, 535.0, 182.0, CLICK_OBJ_GROUP_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjGroup] = E_PLAYERINDEX[1]; // group input
	
	tmpCount = CopyGUIMenuData(MenuInput, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 87.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 3.0, .setText = "N/A", .setAlignment = 1);
	
	PlayerLoadGUIMenu(playerid, PlayerMenuObject[playerid], tmpArray, 531.0, 200.0, CLICK_OBJ_NOTE_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjNote] = E_PLAYERINDEX[1]; // note input
	
	PlayerLoadGUIMenu(playerid, PlayerMenuObject[playerid], MenuInfo, 502.0, 254.0, CLICK_NO_GROUP, E_PLAYERINDEX);
	PlayerGUISetTextSize(playerid, PlayerMenuObject[playerid], E_PLAYERINDEX[0], 116.0, 87.0);
	PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], E_PLAYERINDEX[1], "Object_ID:_123~n~Pos:_X,_Y,_Z~n~Rot:_X,_Y,_Z~n~Model_Info:~n~-_Length:_10.00~n~-_Width:_10.00~n~-_Height:_10.00~n~Etcetera...");
	PlayerElementData[playerid][E_ObjProp] = E_PLAYERINDEX[1]; // obj prop info box
	
	// Object move menu
	printf("Object move menu");
	PlayerMenuObjectMove[playerid] = PlayerCreateGUI(playerid, "MenuObjectMove");

	tmpCount = CopyGUIMenuData(MenuInput, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 62.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 30.0, .setText = "0000.0000", .setAlignment = 2);
	
	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 146.0, CLICK_OBJMOVE_X_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjX] = E_PLAYERINDEX[1]; // X input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 164.0, CLICK_OBJMOVE_Y_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjY] = E_PLAYERINDEX[1]; // Y input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 182.0, CLICK_OBJMOVE_Z_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjZ] = E_PLAYERINDEX[1]; // Z input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 218.0, CLICK_OBJMOVE_RX_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjRX] = E_PLAYERINDEX[1]; // RX input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 236.0, CLICK_OBJMOVE_RY_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjRY] = E_PLAYERINDEX[1]; // RY input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 520.0, 254.0, CLICK_OBJMOVE_RZ_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjRZ] = E_PLAYERINDEX[1]; // RZ input
	
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 58.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 28.0, .setText = "0.0", .setAlignment = 2);

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 524.0, 308.0, CLICK_OBJMOVE_NUDPOS_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjNudPos] = E_PLAYERINDEX[1]; // nudge pos input

	PlayerLoadGUIMenu(playerid, PlayerMenuObjectMove[playerid], tmpArray, 524.0, 326.0, CLICK_OBJMOVE_NUDROT_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_ObjNudRot] = E_PLAYERINDEX[1]; // nudge rot input
	
	// Group move menu
	printf("Group move menu");
	PlayerMenuGroupMove[playerid] = PlayerCreateGUI(playerid, "MenuGroupMove");

	tmpCount = CopyGUIMenuData(MenuInput, tmpArray);
	tmpArray = AdjustGUIMenuData(tmpArray, 0, .setTextSizeX = 58.0, .setTextSizeY = 16.0);
	tmpArray = AdjustGUIMenuData(tmpArray, 1, .setOffX = 28.0, .setText = "0.0", .setAlignment = 2);

	PlayerLoadGUIMenu(playerid, PlayerMenuGroupMove[playerid], tmpArray, 524.0, 308.0, CLICK_GRPMOVE_NUDROT_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_GrpNudPos] = E_PLAYERINDEX[1]; // nudge rot input

	PlayerLoadGUIMenu(playerid, PlayerMenuGroupMove[playerid], tmpArray, 524.0, 290.0, CLICK_GRPMOVE_NUDPOS_INPUT, E_PLAYERINDEX, tmpCount);
	PlayerElementData[playerid][E_GrpNudRot] = E_PLAYERINDEX[1]; // nudge pos input
	
	// Bind menus
	printf("Bind menus");
	PlayerBindGUITextDraw(playerid, PlayerMenuToolBar[playerid], MenuToolBar);
	PlayerGUIIgnoreClose(playerid, PlayerMenuToolBar[playerid], true);
	PlayerBindGUITextDraw(playerid, PlayerMenuMap[playerid], MenuMap);
	PlayerBindGUITextDraw(playerid, PlayerMenuObject[playerid], MenuObject);
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectMove[playerid], MenuObjectMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupMove[playerid], MenuGroupMove);
	
	// Other bind menus (no ele's)
	PlayerMenuObjectMoveMore[playerid] = PlayerCreateGUI(playerid, "MenuObjectMoveMore");
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectMoveMore[playerid], MenuObjectMoveMore);
	PlayerMenuGroup[playerid] = PlayerCreateGUI(playerid, "MenuGroup");
	PlayerBindGUITextDraw(playerid, PlayerMenuGroup[playerid], MenuGroup);
	PlayerMenuGroupMoveMore[playerid] = PlayerCreateGUI(playerid, "MenuGroupMoveMore");
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupMoveMore[playerid], MenuGroupMoveMore);
	
	// Bind menu groups
	printf("Bind all menus");
	/*PlayerMenuAll[playerid] = PlayerCreateGUI(playerid, "AllMenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuToolBar);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuMap);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuObject);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuObjectMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuObjectMoveMore);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuGroup);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuGroupMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuAll[playerid], MenuGroupMoveMore);*/
	
	PlayerMenuMapAll[playerid] = PlayerCreateGUI(playerid, "AllMapMenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuMapAll[playerid], MenuMap);
	
	PlayerMenuObjectAll[playerid] = PlayerCreateGUI(playerid, "AllObjectMenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectAll[playerid], MenuObject);
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectAll[playerid], MenuObjectMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuObjectAll[playerid], MenuObjectMoveMore);
	
	PlayerMenuGroupAll[playerid] = PlayerCreateGUI(playerid, "AllGroupMenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupAll[playerid], MenuGroup);
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupAll[playerid], MenuGroupMove);
	PlayerBindGUITextDraw(playerid, PlayerMenuGroupAll[playerid], MenuGroupMoveMore);
	
	/*PlayerMenuSubmenuAll[playerid] = PlayerCreateGUI(playerid, "AllSubmenus");
	PlayerBindGUITextDraw(playerid, PlayerMenuSubmenuAll[playerid], MenuObjectMoveMore);
	PlayerBindGUITextDraw(playerid, PlayerMenuSubmenuAll[playerid], MenuGroupMoveMore);*/
	
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(IsFlyMode(playerid) && (newkeys & KEY_WALK))
	{
		//if(!EditingMode[playerid])
		{
			PlayerShowGUIMenu(playerid, PlayerMenuToolBar[playerid], true);
			PlayerSelectGUITextDraw(playerid);
			return Y_HOOKS_BREAK_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_0;
}

HideFlymodeInterface(playerid)
{
	PlayerHideGUIMenu(playerid, PlayerMenuToolBar[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuMap[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuObject[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuObjectMoveMore[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuGroup[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
	PlayerHideGUIMenu(playerid, PlayerMenuGroupMoveMore[playerid]);
	
	PlayerCancelSelectGUITextDraw(playerid);
	return 1;
}

PlayerUpdateGUIText(playerid, PlayerGUIMenu:gindex)
{
	if(gindex == PlayerMenuToolBar[playerid]) {
		/*PlayerGUISetPlayerText(playerid, PlayerMenuToolBar[playerid], PlayerElementData[playerid][E_ToolBarInfo],
			sprintf("Selected_Obj:_%i,_Object_Count:_%i",
				CurrObject[playerid], // selected id
				Iter_Count(Objects) // object count
			)//TODO set properties text
		);*/
	}
	else if(gindex == PlayerMenuMap[playerid]) {
		/*PlayerGUISetPlayerText(playerid, PlayerMenuMap[playerid], PlayerElementData[playerid][E_MapProp],
			sprintf("%s~n~Object_Count:_%i~n~Vehicle_Count:_%i~n~Spawn:_%0.2f,_%0.2f,_%0.2f~n~Interior_%i~n~World_%i"//,
				//Map name
				//Object count
				//Vehicle count
				//Spawn position
				//Interior
				//World
			)	//TODO set properties text
		);*/
		//"Name~n~Object_Count:_100~n~Vehicle_Count:_20~n~Spawn:_X,_Y,_Z~n~Interior_1,_World_1"
	}
	else if(gindex == PlayerMenuObject[playerid] && CurrObject[playerid] != -1) {
		PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjGroup], sprintf("%i", ObjectData[CurrObject[playerid]][oGroup]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjModel], sprintf("%i", ObjectData[CurrObject[playerid]][oModel]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjNote], ObjectData[CurrObject[playerid]][oNote]);
		
		/*PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjProp],
			sprintf("Object_ID:_%i~n~Pos:_%0.2f,_%0.2f,_%0.2f~n~Rot:_%0.2f,_%0.2f,_%0.2f~n~Model_Info:~n~-_Length:_%0.2f~n~-_Width:_%0.2f~n~-_Height:_%0.2f~n~Etcetera..."//,
				//Object id
				//Object position
				//Object rotation
				//Model dimensions
			)	//TODO set properties text
		);*/
		//"Object_ID:_123~n~Pos:_X,_Y,_Z~n~Rot:_X,_Y,_Z~n~Model_Info:~n~-_Length:_10.00~n~-_Width:_10.00~n~-_Height:_10.00~n~Etcetera..."
	}
	else if(gindex == PlayerMenuObjectMove[playerid] && CurrObject[playerid] != -1) {
		PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oX]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oY]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oZ]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRX]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRY]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRZ]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjNudPos], sprintf("%0.4f", CurrMovementInc[playerid]));
		PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjNudRot], sprintf("%0.4f", CurrRotationInc[playerid]));
	}
	else if(gindex == PlayerMenuGroup[playerid]) {
		//TODO ?
	}
	else if(gindex == PlayerMenuGroupMove[playerid]) {
		PlayerGUISetPlayerText(playerid, PlayerMenuGroupMove[playerid], PlayerElementData[playerid][E_GrpNudPos], sprintf("%0.4f", CurrMovementGInc[playerid]));
		PlayerGUISetPlayerText(playerid, PlayerMenuGroupMove[playerid], PlayerElementData[playerid][E_GrpNudRot], sprintf("%0.4f", CurrRotationGInc[playerid]));
	}
	return 1;
}

hook OnPlayerObjectSelect(playerid, index)
{
	PlayerUpdateGUIText(playerid, PlayerMenuObject[playerid]);
	PlayerUpdateGUIText(playerid, PlayerMenuObjectMove[playerid]);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnObjectUpdatePos(playerid, index)
{
	if(CurrObject[playerid] == index) {
		PlayerUpdateGUIText(playerid, PlayerMenuObjectMove[playerid]);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnObjectGroupChange(objectid, index)
{
	foreach(new playerid: Player) {
		if(CurrObject[playerid] == objectid) {
			PlayerUpdateGUIText(playerid, PlayerMenuObject[playerid]);
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnObjectModelChange(objectid, index)
{
	foreach(new playerid: Player) {
		if(CurrObject[playerid] == objectid) {
			PlayerUpdateGUIText(playerid, PlayerMenuObject[playerid]);
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

OnGUIClick:MenuToolBar(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			HideFlymodeInterface(playerid);
		}
		case CLICK_TOOL_MAPMENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectAll[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupAll[playerid]);
			
			PlayerHideGUIMenu(playerid, PlayerMenuObject[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
			
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuMap[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_TOOL_OBJMENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuMap[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupAll[playerid]);
			
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
			
			wait_ms(25);
			
			PlayerUpdateGUIText(playerid, PlayerMenuObject[playerid]);
			PlayerShowGUIMenu(playerid, PlayerMenuObject[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_TOOL_GRPMENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuMap[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectAll[playerid]);
			
			PlayerHideGUIMenu(playerid, PlayerMenuObject[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
			
			wait_ms(25);
			
			PlayerUpdateGUIText(playerid, PlayerMenuGroup[playerid]);
			PlayerShowGUIMenu(playerid, PlayerMenuGroup[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_TOOL_MODSEARCH:
		{
			inline ModelSearch(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/osearch %s", text));
				}
			}
			Dialog_ShowCallback(playerid, using inline ModelSearch, DIALOG_STYLE_INPUT, "Texture Studio", "Search for a model name", "Ok", "Cancel");
		}
		case CLICK_TOOL_TEXSEARCH:
		{
			inline TextureSearch(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/tsearch %s", text));
				}
			}
			Dialog_ShowCallback(playerid, using inline TextureSearch, DIALOG_STYLE_INPUT, "Texture Studio", "Search for a texture name", "Ok", "Cancel");
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuMap(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuMap[playerid]);
		}
		case CLICK_MAP_NEWMAP:
		{
			BroadcastCommand(playerid, "/newmap");
		}
		case CLICK_MAP_LOADMAP:
		{
			BroadcastCommand(playerid, "/loadmap");
		}
		case CLICK_MAP_RENAMEMAP:
		{
			BroadcastCommand(playerid, "/renamemap");
		}
		case CLICK_MAP_IMPORTMAP:
		{
			BroadcastCommand(playerid, "/importmap");
		}
		case CLICK_MAP_EXPORTMAP:
		{
			BroadcastCommand(playerid, "/export");
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuObject(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectAll[playerid]);
		}
		case CLICK_OBJ_CLONE:
		{
			BroadcastCommand(playerid, "/clone");
		}
		case CLICK_OBJ_CREATE:
		{
			inline ObjectCreate(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/cobject %s", text));
					
					PlayerUpdateGUIText(playerid, PlayerMenuObject[playerid]);
					PlayerUpdateGUIText(playerid, PlayerMenuObjectMove[playerid]);
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectCreate, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new object model ID.", "Ok", "Cancel");
		}
		case CLICK_OBJ_DELETE:
		{
			BroadcastCommand(playerid, "/dobject");
		}
		case CLICK_OBJ_GROUP_L:
		{
			EditCheck(playerid);
			BroadcastCommand(playerid, sprintf("/ogroup %i", ObjectData[CurrObject[playerid]][oGroup] - 1));
			PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjGroup], sprintf("%i", ObjectData[CurrObject[playerid]][oGroup]));
		}
		case CLICK_OBJ_GROUP_R:
		{
			EditCheck(playerid);
			BroadcastCommand(playerid, sprintf("/ogroup %i", ObjectData[CurrObject[playerid]][oGroup] + 1));
			PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjGroup], sprintf("%i", ObjectData[CurrObject[playerid]][oGroup]));
		}
		case CLICK_OBJ_MODEL_L:
		{
			EditCheck(playerid);
			BroadcastCommand(playerid, sprintf("/oswap %i", ObjectData[CurrObject[playerid]][oModel] - 1));
			PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjModel], sprintf("%i", ObjectData[CurrObject[playerid]][oModel]));
		}
		case CLICK_OBJ_MODEL_R:
		{
			EditCheck(playerid);
			BroadcastCommand(playerid, sprintf("/oswap %i", ObjectData[CurrObject[playerid]][oModel] + 1));
			PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjModel], sprintf("%i", ObjectData[CurrObject[playerid]][oModel]));
		}
		case CLICK_OBJ_TRANSFORM:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObject[playerid]);
			wait_ms(25);
			
			PlayerUpdateGUIText(playerid, PlayerMenuObjectMove[playerid]);
			PlayerShowGUIMenu(playerid, PlayerMenuObjectMove[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnPlayerGUIClick:MenuObject(playerid, group, gindex, pindex)
{
	printf("OnPlayerGUIClick:MenuObject(%i, %i, %i, %i)", playerid, group, gindex, pindex);
	switch(group)
	{
		case CLICK_OBJ_GROUP_INPUT:
		{
			inline ObjectGroupSet(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/ogroup %s", text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjGroup], sprintf("%i", ObjectData[CurrObject[playerid]][oGroup]));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectGroupSet, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new group ID.", "Ok", "Cancel");
		}
		case CLICK_OBJ_MODEL_INPUT:
		{
			inline ObjectModelSet(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/oswap %s", text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjModel], sprintf("%i", ObjectData[CurrObject[playerid]][oModel]));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectModelSet, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new model ID.", "Ok", "Cancel");
		}
		case CLICK_OBJ_NOTE_INPUT:
		{
			EditCheck(playerid);
			
			inline ObjectNoteSet(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/note %i %s", CurrObject[playerid], text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObject[playerid], PlayerElementData[playerid][E_ObjNote], ObjectData[CurrObject[playerid]][oNote]);
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectNoteSet, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new note.", "Ok", "Cancel");
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuObjectMove(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectAll[playerid]);
		}
		case CLICK_OBJMOVE_MORE:
		{
			PlayerShowGUIMenu(playerid, PlayerMenuObjectMoveMore[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_OBJMOVE_BACK:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMoveMore[playerid]);
			wait_ms(25);
			
			PlayerUpdateGUIText(playerid, PlayerMenuObject[playerid]);
			PlayerShowGUIMenu(playerid, PlayerMenuObject[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_OBJMOVE_X_L:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/dox %0.4f", -CurrMovementInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/ox %0.4f", -CurrMovementInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avox %0.4f", -CurrMovementInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oX]));
		}
		case CLICK_OBJMOVE_X_R:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/dox %0.4f", CurrMovementInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/ox %0.4f", CurrMovementInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avox %0.4f", CurrMovementInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oX]));
		}
		case CLICK_OBJMOVE_Y_L:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/doy %0.4f", -CurrMovementInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/oy %0.4f", -CurrMovementInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avoy %0.4f", -CurrMovementInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oY]));
		}
		case CLICK_OBJMOVE_Y_R:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/doy %0.4f", CurrMovementInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/oy %0.4f", CurrMovementInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avoy %0.4f", CurrMovementInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oY]));
		}
		case CLICK_OBJMOVE_Z_L:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/doz %0.4f", -CurrMovementInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/oz %0.4f", -CurrMovementInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avoz %0.4f", -CurrMovementInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oZ]));
		}
		case CLICK_OBJMOVE_Z_R:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/doz %0.4f", CurrMovementInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/oz %0.4f", CurrMovementInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avoz %0.4f", CurrMovementInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oZ]));
		}
		case CLICK_OBJMOVE_RX_L:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/drx %0.4f", -CurrRotationInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/rx %0.4f", -CurrRotationInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avrx %0.4f", -CurrRotationInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRX]));
		}
		case CLICK_OBJMOVE_RX_R:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/drx %0.4f", CurrRotationInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/rx %0.4f", CurrRotationInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avrx %0.4f", CurrRotationInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRX]));
		}
		case CLICK_OBJMOVE_RY_L:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/dry %0.4f", -CurrRotationInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/ry %0.4f", -CurrRotationInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avry %0.4f", -CurrRotationInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRY]));
		}
		case CLICK_OBJMOVE_RY_R:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/dry %0.4f", CurrRotationInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/ry %0.4f", CurrRotationInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avry %0.4f", CurrRotationInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRY]));
		}
		case CLICK_OBJMOVE_RZ_L:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/drz %0.4f", -CurrRotationInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/rz %0.4f", -CurrRotationInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avrz %0.4f", -CurrRotationInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRZ]));
		}
		case CLICK_OBJMOVE_RZ_R:
		{
			EditCheck(playerid);
			if(ObjectData[CurrObject[playerid]][oAttachedVehicle] == -1) {
				if(DeltaMapMovement[playerid])
					BroadcastCommand(playerid, sprintf("/drz %0.4f", CurrRotationInc[playerid]));
				else
					BroadcastCommand(playerid, sprintf("/rz %0.4f", CurrRotationInc[playerid]));
			}
			else
				BroadcastCommand(playerid, sprintf("/avrz %0.4f", CurrRotationInc[playerid]));
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRZ]));
		}
		case CLICK_OBJMOVE_RESROT:
		{
			EditCheck(playerid);
			BroadcastCommand(playerid, "/rreset");
			
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRX]));
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRY]));
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRZ]));
		}
		case CLICK_OBJMOVE_NUDPOS_L:
		{
			new Float:tmp = CurrMovementInc[playerid] - 0.5;
			if(tmp < -150.0 || tmp > 150.0)
				return SendClientMessage(playerid, STEALTH_YELLOW, "Out of range increment! <-150.0 - 150.0>");
			
			CurrMovementInc[playerid] = tmp;
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjNudPos], sprintf("%0.4f", tmp));
		}
		case CLICK_OBJMOVE_NUDPOS_R:
		{
			new Float:tmp = CurrMovementInc[playerid] + 0.5;
			if(tmp < -150.0 || tmp > 150.0)
				return SendClientMessage(playerid, STEALTH_YELLOW, "Out of range increment! <-150.0 - 150.0>");
			
			CurrMovementInc[playerid] = tmp;
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjNudPos], sprintf("%0.4f", tmp));
		}
		case CLICK_OBJMOVE_NUDROT_L:
		{
			new Float:tmp = CurrRotationInc[playerid] - 1.0;
			if(tmp < -180.0 || tmp > 180.0)
				return SendClientMessage(playerid, STEALTH_YELLOW, "Out of range increment! <-180.0 - 180.0>");
			
			CurrRotationInc[playerid] = tmp;
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjNudRot], sprintf("%0.4f", tmp));
		}
		case CLICK_OBJMOVE_NUDROT_R:
		{
			new Float:tmp = CurrRotationInc[playerid] + 1.0;
			if(tmp < -180.0 || tmp > 180.0)
				return SendClientMessage(playerid, STEALTH_YELLOW, "Out of range increment! <-180.0 - 180.0>");
			
			CurrRotationInc[playerid] = tmp;
			PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjNudRot], sprintf("%0.4f", tmp));
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnPlayerGUIClick:MenuObjectMove(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_OBJMOVE_X_INPUT:
		{
			inline ObjectSetX(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/sox %s", text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oX]));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectSetX, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new X position.", "Ok", "Cancel");
		}
		case CLICK_OBJMOVE_Y_INPUT:
		{
			inline ObjectSetY(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/soy %s", text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oY]));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectSetY, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new Y position.", "Ok", "Cancel");
		}
		case CLICK_OBJMOVE_Z_INPUT:
		{
			inline ObjectSetZ(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/soz %s", text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oZ]));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectSetZ, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new Z position.", "Ok", "Cancel");
		}
		case CLICK_OBJMOVE_RX_INPUT:
		{
			inline ObjectSetRX(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/srx %s", text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRX], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRX]));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectSetRX, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new X rotation.", "Ok", "Cancel");
		}
		case CLICK_OBJMOVE_RY_INPUT:
		{
			inline ObjectSetRY(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/sry %s", text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRY], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRY]));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectSetRY, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new Y rotation.", "Ok", "Cancel");
		}
		case CLICK_OBJMOVE_RZ_INPUT:
		{
			inline ObjectSetRZ(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				
				if(response) {
					BroadcastCommand(playerid, sprintf("/srz %s", text));
			
					PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjRZ], sprintf("%0.4f", ObjectData[CurrObject[playerid]][oRZ]));
				}
			}
			Dialog_ShowCallback(playerid, using inline ObjectSetRZ, DIALOG_STYLE_INPUT, "Texture Studio", "Enter new Z rotation.", "Ok", "Cancel");
		}
		case CLICK_OBJMOVE_NUDPOS_INPUT:
		{
			inline SetMovementInc(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				if(response)
				{
					new Float:tmp;
					if(sscanf(text, "f", tmp))
						return SendClientMessage(playerid, STEALTH_YELLOW, "You must supply a increment value!");
					if(tmp < -150.0 || tmp > 150.0)
						return SendClientMessage(playerid, STEALTH_YELLOW, "Out of range increment! <-150.0 - 150.0>");
					
					CurrMovementInc[playerid] = tmp;
					PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjNudPos], sprintf("%0.4f", tmp));
				}
			}
			Dialog_ShowCallback(playerid, using inline SetMovementInc, DIALOG_STYLE_INPUT, "Texture Studio", "Input object movement increment.", "Ok", "Cancel");
		}
		case CLICK_OBJMOVE_NUDROT_INPUT:
		{
			inline SetMovementRot(pid, dialogid, response, listitem, string:text[])
			{
				#pragma unused listitem, dialogid, pid, text
				if(response)
				{
					new Float:tmp;
					if(sscanf(text, "f", tmp))
						return SendClientMessage(playerid, STEALTH_YELLOW, "You must supply a increment value!");
					if(tmp < -180.0 || tmp > 180.0)
						return SendClientMessage(playerid, STEALTH_YELLOW, "Out of range increment! <-180.0 - 180.0>");
					
					CurrRotationInc[playerid] = tmp;
					PlayerGUISetPlayerText(playerid, PlayerMenuObjectMove[playerid], PlayerElementData[playerid][E_ObjNudRot], sprintf("%0.4f", tmp));
				}
			}
			Dialog_ShowCallback(playerid, using inline SetMovementRot, DIALOG_STYLE_INPUT, "Texture Studio", "Input object rotation inc", "Ok", "Cancel");
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuObjectMoveMore(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuObjectMoveMore[playerid]);
		}
		case CLICK_OBJMOVEMORE_TOCURSOR:
		{
			//TODO
		}
		case CLICK_OBJMOVEMORE_TOFRONT:
		{
			//TODO
		}
		case CLICK_OBJMOVEMORE_TOGROUND:
		{
			//TODO
		}
		case CLICK_OBJMOVEMORE_TRANSFORM:
		{
			//TODO
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuGroup(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroupAll[playerid]);
		}
		case CLICK_GRP_CLEARSEL:
		{
			//TODO
		}
		case CLICK_GRP_SELALLOBJ:
		{
			//TODO
		}
		case CLICK_GRP_SELGRPID:
		{
			//TODO
		}
		case CLICK_GRP_ADDOBJID:
		{
			//TODO
		}
		case CLICK_GRP_ADDRANGE:
		{
			//TODO
		}
		case CLICK_GRP_ADDSELOBJ:
		{
			//TODO
		}
		case CLICK_GRP_REMOBJID:
		{
			//TODO
		}
		case CLICK_GRP_REMRANGE:
		{
			//TODO
		}
		case CLICK_GRP_REMSELOBJ:
		{
			//TODO
		}
		case CLICK_GRP_SETGRPID:
		{
			//TODO
		}
		case CLICK_GRP_TRANSFORM:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroup[playerid]);
			wait_ms(25);
			
			PlayerShowGUIMenu(playerid, PlayerMenuGroupMove[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuGroupMove(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroupAll[playerid]);
		}
		case CLICK_GRPMOVE_MORE:
		{
			PlayerShowGUIMenu(playerid, PlayerMenuGroupMoveMore[playerid], true);
		}
		case CLICK_GRPMOVE_BACK:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMove[playerid]);
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMoveMore[playerid]);
			wait_ms(25);
			
			PlayerUpdateGUIText(playerid, PlayerMenuGroup[playerid]);
			PlayerShowGUIMenu(playerid, PlayerMenuGroup[playerid], true);
			PlayerSelectGUITextDraw(playerid);
		}
		case CLICK_GRPMOVE_X_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_X_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_Y_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_Y_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_Z_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_Z_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RX_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RX_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RY_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RY_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RZ_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_RZ_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDPOS_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDPOS_R:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDROT_L:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDROT_R:
		{
			//TODO
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnPlayerGUIClick:MenuGroupMove(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_GRPMOVE_NUDPOS_INPUT:
		{
			//TODO
		}
		case CLICK_GRPMOVE_NUDROT_INPUT:
		{
			//TODO
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

OnGUIClick:MenuGroupMoveMore(playerid, group, gindex, pindex)
{
	switch(group)
	{
		case CLICK_EXIT_MENU:
		{
			PlayerHideGUIMenu(playerid, PlayerMenuGroupMoveMore[playerid]);
		}
		case CLICK_GRPMOVEMORE_TOCURSOR:
		{
			//TODO
		}
		case CLICK_GRPMOVEMORE_TOFRONT:
		{
			//TODO
		}
		case CLICK_GRPMOVEMORE_TOGROUND:
		{
			//TODO
		}
		case CLICK_GRPMOVEMORE_TRANSFORM:
		{
			//TODO
		}
		default:
		{
			printf("[DEBUGG] %i, %i, %i, %i", playerid, group, gindex, pindex);
		}
	}
	return 1;
}

