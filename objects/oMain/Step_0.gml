/// @description Logic
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

#region Window Resize
	
	if((WW != room_width or WH != room_height) and alarm[0] < 0)
		alarm[0] = 2
	
#endregion