/// @description Resize Trigger
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

#region Resize Trigger (If Main Triggered)
	
	if(M.alarm[0] > 0)
		alarm[0] = 2
	
#endregion