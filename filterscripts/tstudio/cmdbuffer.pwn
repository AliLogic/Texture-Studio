#define MAX_COMMAND_BUFFER          (20)

new CommandBuffer[MAX_PLAYERS][MAX_COMMAND_BUFFER][128];

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

new bool:HoldKeyPressed;

#include <YSI_Coding\y_hooks>
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(HoldKeyPressed && PRESSED(KEY_CROUCH) && !isnull(CommandBuffer[playerid][0]))
        Command_ReProcess(playerid, CommandBuffer[playerid][0], 0); //BroadcastCommand(playerid, CommandBuffer[playerid][0]);
    
	if(PRESSED(KEY_WALK))
        HoldKeyPressed = true;
	else if(RELEASED(KEY_WALK))
        HoldKeyPressed = false;
    
    return Y_HOOKS_CONTINUE_RETURN_0;
}

hook OnPlayerCommandText(playerid, const cmdtext[]) 
{
	//print(cmdtext);

	// Make every slot, start from slot 2, take the data from the slot before
	for(new i = MAX_COMMAND_BUFFER - 1; i > 0; --i) {
		//printf("i = %2i 1, CB[i] = %s, CB[i-1] = %s", i, CommandBuffer[playerid][i], CommandBuffer[playerid][i - 1]);
		//CommandBuffer[playerid][i] = CommandBuffer[playerid][i - 1];
		//printf("i = %2i 2, CB[i] = %s, CB[i-1] = %s", i, CommandBuffer[playerid][i], CommandBuffer[playerid][i - 1]);
		format(CommandBuffer[playerid][i], 128, "%s", CommandBuffer[playerid][i - 1]);
	}
	
	// Insert the command and it's parameters into the buffer
	//CommandBuffer[playerid][0][0] = EOS;
	format(CommandBuffer[playerid][0], 128, "%s", cmdtext);

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
    // Reset the player's buffer
    new tmpCommandBuffer[MAX_COMMAND_BUFFER][128];
    CommandBuffer[playerid] = tmpCommandBuffer;

	return Y_HOOKS_CONTINUE_RETURN_1;
}
