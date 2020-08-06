#include <YSI_Coding\y_hooks>
#include <colandreas>

hook OnScriptInit() 
{
	CA_Init();
	return Y_HOOKS_CONTINUE_RETURN_1;
}

/* TODO
- Figure out why y_hooks fails to process the AddDynamicObject hook below.
- Figure out why cloned objects are not being created in CA until next object is cloned.
- Move CA objects when objects are moved.
- Rotate CA objects when objects are rotated.
*/

/*hook function AddDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, index = -1, bool:sqlsave = true, Float:dd = 300.0)
{
	new tmp = continue(modelid, x, y, z, rx, ry, rz, index, sqlsave, dd);
	
	if(tmp != -1) {
		ObjectData[index][oCAID] = CA_CreateObject(modelid, x, y, z, rx, ry, rz, true);
	}
	
	return tmp;
}

hook function DeleteDynamicObject(index, bool:sqlsave = true)
{
	new tmp = continue(index, sqlsave);
	
	if(tmp != -1) {
		CA_DestroyObject(ObjectData[index][oCAID]);
	}
	
	return tmp;
}*/
