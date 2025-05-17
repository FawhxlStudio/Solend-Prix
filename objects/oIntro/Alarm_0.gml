/// @description Flush & Fetch...
if(load) {
	
	var _rdy = load_intro()
	if(_rdy) {
		
		load = F
		if(surface_exists(narSurf)) surface_free(narSurf);
		narSurf = N
		
	} else alarm[0] = 1;
	
}