/// @description Resize?
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(room_width != WW or room_height != WH)
	alarm[0] = 1
