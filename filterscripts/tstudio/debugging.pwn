#include <YSI_Coding\y_hooks>
hook OnPlayerCommandText(playerid, const cmdtext[]) 
{
	print(cmdtext);
	return Y_HOOKS_CONTINUE_RETURN_0;
}