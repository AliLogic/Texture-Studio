//3DMenu. Author: SDraw
//Original posts are on forum.sa-mp.com, pawno.ru
/* Fake natives. Thanks to TheArcher.
native Create3DMenu(Float:x,Float:y,Float:z,Float:rotation,boxes,playerid);
native SetBoxText(MenuID,box,text[],materialsize,fontface[],fontsize,bold,fontcolor,selectcolor,unselectcolor,textalignment);
native Select3DMenu(playerid,MenuID);
native CancelSelect3DMenu(playerid);
native Destroy3DMenu(MenuID);
*/


#define INVALID_3DMENU  (0xFFFF)

#define MAX_3DMENUS (MAX_PLAYERS)
#define MAX_BOXES (16)

new SelectedMenu[MAX_PLAYERS] = { -1, ...};
new SelectedBox[MAX_PLAYERS];

enum MenuParams
{
	Float:MenuRotation,
	Boxes,
	bool:IsExist,
	Objects[MAX_BOXES],
	Float:OrigPosX[MAX_BOXES],
	Float:OrigPosY[MAX_BOXES],
	Float:OrigPosZ[MAX_BOXES],
	Float:AddingX,
	Float:AddingY,
	SelectColor[MAX_BOXES],
	UnselectColor[MAX_BOXES],
	Player
}

new Menu3DInfo[MAX_3DMENUS][MenuParams];

//Callbacks
forward OnPlayerSelect3DMenuBox(playerid,MenuID,boxid);
forward OnPlayerChange3DMenuBox(playerid,MenuID,boxid);

// Create a new menu
Create3DMenu(playerid,Float:x,Float:y,Float:z,Float:rotation,boxes)
{
	// Make sure box is in range
	if(boxes > MAX_BOXES || boxes <= 0) return -1;

	// Create 3D Menu
	for(new i = 0; i < MAX_3DMENUS; i++)
	{
		// Menu exists continue
		if(Menu3DInfo[i][IsExist]) continue;

		new Float:NextLineX,Float:NextLineY;
		new lineindx,binc;

		Menu3DInfo[i][MenuRotation] = rotation;
		Menu3DInfo[i][Boxes] = boxes;
		Menu3DInfo[i][AddingX] = 0.25*floatsin(rotation,degrees);
		Menu3DInfo[i][AddingY] = -floatcos(rotation,degrees)*0.25;

		NextLineX = floatcos(rotation,degrees)+0.05*floatcos(rotation,degrees);
		NextLineY = floatsin(rotation,degrees)+0.05*floatsin(rotation,degrees);

		// Create menu objects
		for(new b = 0; b < boxes; b++)
		{
			if(b%4 == 0 && b != 0) lineindx++,binc+=4;
			Menu3DInfo[i][Objects][b] = CreateDynamicObject(2661,x+NextLineX*lineindx,y+NextLineY*lineindx,z+1.65-0.55*(b-binc),0,0,rotation,-1,-1,playerid,100.0);
			GetDynamicObjectPos(Menu3DInfo[i][Objects][b],Menu3DInfo[i][OrigPosX][b],Menu3DInfo[i][OrigPosY][b],Menu3DInfo[i][OrigPosZ][b]);
		}
		Menu3DInfo[i][IsExist] = true;
		Menu3DInfo[i][Player] = playerid;
		Streamer_Update(playerid);
		return i;
	}
	return -1;
}

SetBoxMaterial(MenuID,box,index,model,const txd[],const texture[], selectcolor, unselectcolor)
{
	if(!Menu3DInfo[MenuID][IsExist]) return -1;
	if(box == Menu3DInfo[MenuID][Boxes] || box < 0) return -1;
	if(Menu3DInfo[MenuID][Objects][box] == INVALID_OBJECT_ID) return -1;
	Menu3DInfo[MenuID][SelectColor][box] = selectcolor;
	Menu3DInfo[MenuID][UnselectColor][box] = unselectcolor;
	if(SelectedBox[Menu3DInfo[MenuID][Player]] == box) SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][box], index, model, txd, texture, selectcolor);
	else SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][box], index, model, txd, texture, unselectcolor);
	return 1;
}

Select3DMenu(playerid,MenuID)
{
	if(!IsPlayerConnected(playerid)) return -1;
	if(!Menu3DInfo[MenuID][IsExist]) return -1;
	if(Menu3DInfo[MenuID][Player] != playerid) return -1;
	if(SelectedMenu[playerid] != -1) CancelSelect3DMenu(playerid);

	SelectedMenu[playerid] = MenuID;

	Select3DMenuBox(playerid, MenuID, 0);
	
	return 1;
}

#include <YSI_Coding\y_hooks>
hook OnScriptInit()
{
	for(new i = 0; i < MAX_3DMENUS; i++)
	{
		for(new b = 0; b < MAX_BOXES; b++) Menu3DInfo[i][Objects][b] = INVALID_OBJECT_ID;
		Menu3DInfo[i][Boxes] = 0;
		Menu3DInfo[i][IsExist] = false;
		Menu3DInfo[i][AddingX] = 0.0;
		Menu3DInfo[i][AddingY] = 0.0;
		Menu3DInfo[i][Player] = -1;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnScriptExit()
{
	for(new i = 0; i < MAX_3DMENUS; i++)
	{
		if(Menu3DInfo[i][IsExist]) Destroy3DMenu(i);
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	SelectedMenu[playerid] = -1;
	SelectedBox[playerid] = -1;

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid,reason)
{
	if(SelectedMenu[playerid] != -1) CancelSelect3DMenu(playerid);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(SelectedMenu[playerid] != -1)
	{
		new MenuID = SelectedMenu[playerid];

		if(OnPlayerKeyStateChangeMenu(playerid,newkeys,oldkeys)) return Y_HOOKS_BREAK_RETURN_1;


		if(newkeys == KEY_CTRL_BACK || (IsFlyMode(playerid) && (newkeys & KEY_ANALOG_LEFT && (newkeys & KEY_SECONDARY_ATTACK || oldkeys & KEY_SECONDARY_ATTACK) )))
		{
			new model,txd[32],texture[32], color;
			GetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0,model, txd, texture, color);
			SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, Menu3DInfo[MenuID][UnselectColor][SelectedBox[playerid]]);

			MoveDynamicObject(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosX][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosY][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosZ][SelectedBox[playerid]],1.0);
			SelectedBox[playerid]++;

			if(SelectedBox[playerid] == Menu3DInfo[MenuID][Boxes]) SelectedBox[playerid] = 0;

			GetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0,model, txd, texture, color);
			SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, Menu3DInfo[MenuID][SelectColor][SelectedBox[playerid]]);

			MoveDynamicObject(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosX][SelectedBox[playerid]]+Menu3DInfo[MenuID][AddingX],Menu3DInfo[MenuID][OrigPosY][SelectedBox[playerid]]+Menu3DInfo[MenuID][AddingY],Menu3DInfo[MenuID][OrigPosZ][SelectedBox[playerid]],1.0);

			if(funcidx("OnPlayerChange3DMenuBox") != -1) OnPlayerChange3DMenuBox(playerid,MenuID,SelectedBox[playerid]);

			return Y_HOOKS_BREAK_RETURN_1;
		}
		if(newkeys == KEY_YES || (IsFlyMode(playerid) && (newkeys & KEY_ANALOG_RIGHT && (newkeys & KEY_SECONDARY_ATTACK || oldkeys & KEY_SECONDARY_ATTACK) )))
		{
			new model,txd[32],texture[32], color;
			GetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0,model, txd, texture, color);
			SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, Menu3DInfo[MenuID][UnselectColor][SelectedBox[playerid]]);

			MoveDynamicObject(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosX][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosY][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosZ][SelectedBox[playerid]],1.0);
			SelectedBox[playerid]--;

			if(SelectedBox[playerid] < 0) SelectedBox[playerid] = Menu3DInfo[MenuID][Boxes]-1;

			GetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0,model, txd, texture, color);
			SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, Menu3DInfo[MenuID][SelectColor][SelectedBox[playerid]]);

			MoveDynamicObject(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosX][SelectedBox[playerid]]+Menu3DInfo[MenuID][AddingX],Menu3DInfo[MenuID][OrigPosY][SelectedBox[playerid]]+Menu3DInfo[MenuID][AddingY],Menu3DInfo[MenuID][OrigPosZ][SelectedBox[playerid]],1.0);

			if(funcidx("OnPlayerChange3DMenuBox") != -1) OnPlayerChange3DMenuBox(playerid,MenuID,SelectedBox[playerid]);

			return Y_HOOKS_BREAK_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_0;
}

CancelSelect3DMenu(playerid)
{
	if(!IsPlayerConnected(playerid)) return -1;
	if(SelectedMenu[playerid] == -1) return -1;
	new MenuID = SelectedMenu[playerid];

	if(SelectedBox[playerid] != -1)
	{
		new model,txd[32],texture[32], color;
		GetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0,model, txd, texture, color);
		SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, Menu3DInfo[MenuID][UnselectColor][SelectedBox[playerid]]);

		MoveDynamicObject(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosX][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosY][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosZ][SelectedBox[playerid]],1.0);
	}
	
	SelectedMenu[playerid] = -1;
	SelectedBox[playerid] = -1;
	return 1;
}

Select3DMenuBox(playerid,MenuID,BoxID)
{
	if(!IsPlayerConnected(playerid)) return -1;
	if(!Menu3DInfo[MenuID][IsExist]) return -1;
	if(Menu3DInfo[MenuID][Player] != playerid) return -1;

	new model,txd[32],texture[32], color;
	if(SelectedBox[playerid] != -1)
	{
		GetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0,model, txd, texture, color);
		SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, Menu3DInfo[MenuID][UnselectColor][SelectedBox[playerid]]);
		
		MoveDynamicObject(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosX][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosY][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosZ][SelectedBox[playerid]],1.0);
	}


	SelectedBox[playerid] = BoxID;

	GetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, color);
	SetDynamicObjectMaterial(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],0, model, txd, texture, Menu3DInfo[MenuID][SelectColor][SelectedBox[playerid]]);

	MoveDynamicObject(Menu3DInfo[MenuID][Objects][SelectedBox[playerid]],Menu3DInfo[MenuID][OrigPosX][SelectedBox[playerid]]+Menu3DInfo[MenuID][AddingX],Menu3DInfo[MenuID][OrigPosY][SelectedBox[playerid]]+Menu3DInfo[MenuID][AddingY],Menu3DInfo[MenuID][OrigPosZ][SelectedBox[playerid]],1.0);

	return 1;
}

Destroy3DMenu(MenuID)
{
	if(!Menu3DInfo[MenuID][IsExist]) return -1;
	if(SelectedMenu[Menu3DInfo[MenuID][Player]] == MenuID) CancelSelect3DMenu(Menu3DInfo[MenuID][Player]);
	for(new i = 0; i < Menu3DInfo[MenuID][Boxes]; i++)
	{
		DestroyDynamicObject(Menu3DInfo[MenuID][Objects][i]);
		Menu3DInfo[MenuID][Objects][i] = INVALID_OBJECT_ID;
	}
	Menu3DInfo[MenuID][Boxes] = 0;
	Menu3DInfo[MenuID][IsExist] = false;
	Menu3DInfo[MenuID][AddingX] = 0.0;
	Menu3DInfo[MenuID][AddingY] = 0.0;
	Menu3DInfo[MenuID][Player] = -1;
	return 1;
}
