new aWeaponNames[][32] = //weapon info, taken from fsdebug
{
	{"Unarmed (Fist)"}, // 0
	{"Brass Knuckles"}, // 1
	{"Golf Club"}, // 2
	{"Night Stick"}, // 3
	{"Knife"}, // 4
	{"Baseball Bat"}, // 5
	{"Shovel"}, // 6
	{"Pool Cue"}, // 7
	{"Katana"}, // 8
	{"Chainsaw"}, // 9
	{"Purple Dildo"}, // 10
	{"Big White Vibrator"}, // 11
	{"Medium White Vibrator"}, // 12
	{"Small White Vibrator"}, // 13
	{"Flowers"}, // 14
	{"Cane"}, // 15
	{"Grenade"}, // 16
	{"Teargas"}, // 17
	{"Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"Colt 45"}, // 22
	{"Colt 45 (Silenced)"}, // 23
	{"Desert Eagle"}, // 24
	{"Normal Shotgun"}, // 25
	{"Sawnoff Shotgun"}, // 26
	{"Combat Shotgun"}, // 27
	{"Micro Uzi (Mac 10)"}, // 28
	{"MP5"}, // 29
	{"AK47"}, // 30
	{"M4"}, // 31
	{"Tec9"}, // 32
	{"Country Rifle"}, // 33
	{"Sniper Rifle"}, // 34
	{"Rocket Launcher"}, // 35
	{"Heat-Seeking Rocket Launcher"}, // 36
	{"Flamethrower"}, // 37
	{"Minigun"}, // 38
	{"Satchel Charge"}, // 39
	{"Detonator"}, // 40
	{"Spray Can"}, // 41
	{"Fire Extinguisher"}, // 42
	{"Camera"}, // 43
	{"Night Vision Goggles"}, // 44
	{"Infrared Vision Goggles"}, // 45
	{"Parachute"}, // 46
	{"Fake Pistol"} // 47
};

YCMD:weather(playerid, arg[], help)
{
	if(help)
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_GREEN, "Set the weather of the server. Valid IDs are 0 to 45.");
		return 1;
	}

	extract arg -> new weatherid; else
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_YELLOW, "Usage: /weather <Weather ID>");
		return 1;
	}

	if(weatherid < 0 || weatherid > 45)
		return SendClientMessage(playerid, STEALTH_YELLOW, "Invalid weather ID. Please use 0 to 45 as valid IDs.");

	new playerName[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, playerName, sizeof(playerName));

	SetWeather(weatherid);
	SendClientMessageToAll(STEALTH_GREEN, sprintf("%s has changed the weather to ID %i.", playerName, weatherid));
	return 1;
}
YCMD:time(playerid, arg[], help)
{
	if(help)
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_GREEN, "Set the time of the server. Valid hours are 0 to 23.");
		return 1;
	}

	extract arg -> new hour; else
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_YELLOW, "Usage: /time <Hour>");
		return 1;
	}

	if(hour < 0 || hour > 23)
		return SendClientMessage(playerid, STEALTH_YELLOW, "Invalid hour. Please use 0 to 23 as an hour.");

	new playerName[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, playerName, sizeof(playerName));

	SetWorldTime(hour);
	SendClientMessageToAll(STEALTH_GREEN, sprintf("%s has changed the hour to %i.", playerName, hour));
	return 1;
}
YCMD:skin(playerid, arg[], help)
{
	if(help)
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_GREEN, "Changes your player model. Valid skin IDs range from 0 to 311 (excluding 74).");
		return 1;
	}

	extract arg -> new skinid; else
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_YELLOW, "Usage: /skin <Skin ID>");
		return 1;
	}

	if(skinid < 0 || skinid > 311 || skinid == 74)
		return SendClientMessage(playerid, STEALTH_YELLOW, "Invalid skin ID. Valid skin IDs range from 0 to 311 (excluding 74).");

	SetPlayerSkin(playerid, skinid);
	SendClientMessage(playerid, STEALTH_YELLOW, sprintf("You have changed your player model to ID %i.", skinid));
	return 1;
}
YCMD:goto(playerid, arg[], help)
{
	if(help)
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_GREEN, "Teleports you to another player on the server.");
		return 1;
	}

	extract arg -> new player:targetid; else
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_YELLOW, "Usage: /goto <Player ID or name>");
		return 1;
	}

	if(!IsPlayerConnected(targetid))
		return SendClientMessage(playerid, STEALTH_YELLOW, "That player is not connected to the server.");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	SetPlayerPos(playerid, x - 0.5, y - 0.5, z);

	new playerName[MAX_PLAYER_NAME + 1], targetName[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	GetPlayerName(targetid, targetName, sizeof(targetName));

	SendClientMessage(targetid, STEALTH_YELLOW, sprintf("%s (ID %i) has teleported to you.", playerName, playerid));
	SendClientMessage(playerid, STEALTH_YELLOW, sprintf("You have teleported to %s. (ID %i)", targetName, targetid));
	return 1;
}
YCMD:get(playerid, arg[], help)
{
	if(help)
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_GREEN, "Brings another player on the server to your position.");
		return 1;
	}

	extract arg -> new player:targetid; else
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_YELLOW, "Usage: /get <Player ID or name>");
		return 1;
	}

	if(!IsPlayerConnected(targetid))
		return SendClientMessage(playerid, STEALTH_YELLOW, "That player is not connected to the server.");

	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPlayerPos(targetid, x - 0.5, y - 0.5, z);

	new playerName[MAX_PLAYER_NAME + 1], targetName[MAX_PLAYER_NAME + 1];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	GetPlayerName(targetid, targetName, sizeof(targetName));

	SendClientMessage(targetid, STEALTH_YELLOW, sprintf("%s (ID %i) has teleported you to them.", playerName, playerid));
	SendClientMessage(playerid, STEALTH_YELLOW, sprintf("You have teleported %s (ID %i) to yourself.", targetName, targetid));
	return 1;
}
YCMD:setposition(playerid, arg[], help)
{
	if(help)
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_GREEN, "Teleports you to any specified position on the map.");
		return 1;
	}

	extract arg -> new Float:x, Float:y, Float:z; else
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_YELLOW, "Usage: /setposition <X position> <Y Position> <Z Position>");
		return 1;
	}

	SetPlayerPos(playerid, x, y, z);
	SendClientMessage(playerid, STEALTH_YELLOW, sprintf("You have teleported to the map position of: %.5f %.5f %.5f", x, y, z));
	return 1;
}
YCMD:setinterior(playerid, arg[], help)
{
	if(help)
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_GREEN, "Sets your interior world ID. Useful for testing how things look when a map is set in an interior.");
		return 1;
	}

	extract arg -> new interiorid; else
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_YELLOW, "Usage: /setinterior <Interior ID>");
		return 1;
	}

	if(interiorid < 0)
		return SendClientMessage(playerid, STEALTH_YELLOW, "Invalid interior ID.");

	SetPlayerInterior(playerid, interiorid);
	SendClientMessage(playerid, STEALTH_YELLOW, sprintf("You have set your Interior ID to %i.", interiorid));
	return 1;
}
YCMD:weapon(playerid, arg[], help)
{
	if(help)
	{
		SendClientMessage(playerid, STEALTH_ORANGE, "______________________________________________");
		SendClientMessage(playerid, STEALTH_GREEN, "Gives you any weapon in the game. IDs and partial/full names are valid.");
		return 1;
	}

	new weaponid = -1;
	if(!isnumeric(arg))
	{
		weaponid = GetWeaponIDFromName(arg);
	}
	else weaponid = strval(arg);
	if(InvalidWeaponID(weaponid))
		return SendClientMessage(playerid, STEALTH_YELLOW, "Invalid weapon.");

	GivePlayerWeapon(playerid, weaponid, 500);
	SendClientMessage(playerid, STEALTH_YELLOW, sprintf("Weapon spawned: %s.", aWeaponNames[weaponid]));
	return 1;
}

GetWeaponIDFromName(const name[])
{
	for(new i = 0; i < sizeof(aWeaponNames); i++)
	{
		if(strfind(aWeaponNames[i], name, true) != -1)
		{
			return i;
		}
	}
	return -1;
}
InvalidWeaponID(weaponid)
{
	switch(weaponid)
	{
		case 1..18: return false;
		case 22..46: return false;
		case 55: return false;
	}
	return true;
}