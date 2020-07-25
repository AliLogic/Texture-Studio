#if defined ALLOBJECTS
	#endinput
#endif
#define ALLOBJECTS

new DB:AO_DB, DBResult:AO_RESULT;

#include <YSI_Coding\y_hooks>
hook OnScriptInit()
{
	if((AO_DB = db_open("tstudio/allbuildings.db")) == DB:0)
		print("All Buildings - Loading Failed (Database Could Not Be Opened).");
	
	return Y_HOOKS_CONTINUE_RETURN_1;
}

#define SEARCH_DATA_SIZE (44763)
