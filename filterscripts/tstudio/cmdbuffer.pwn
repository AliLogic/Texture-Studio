#define MAX_COMMAND_BUFFER          (20)

new List:CommandBuffer[MAX_PLAYERS];

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

new bool:HoldKeyPressed;

#include <YSI_Coding\y_hooks>
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(HoldKeyPressed && PRESSED(KEY_CROUCH) && !list_size(CommandBuffer[playerid]))
	{
		new commandtext[256];
		list_get_str(CommandBuffer[playerid], 0, commandtext);
		Command_ReProcess(playerid, commandtext, 0); //BroadcastCommand(playerid, CommandBuffer[playerid][0]);
	}
	
	if(PRESSED(KEY_WALK))
		HoldKeyPressed = true;
	else if(RELEASED(KEY_WALK))
		HoldKeyPressed = false;
	
	return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnPlayerCommandText(playerid, const cmdtext[]) 
{
	if(list_valid(CommandBuffer[playerid]))
	{
		list_remove_if(CommandBuffer[playerid], expr_parse("$key >= 20"));
		list_add_str(CommandBuffer[playerid], cmdtext, 0);
	}

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	if(!list_valid(CommandBuffer[playerid]))
		CommandBuffer[playerid] = list_new();
	else
		list_clear(CommandBuffer[playerid]);

	return Y_HOOKS_CONTINUE_RETURN_1;
}
