/// @description Updates
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY) {
	
	// Dialogue Instance
	if(diaInst == N and is_string(animStr)) diaInst = NS[$ animStr];
	
	// Image Scale
	image_xscale = scl*D.z
	image_yscale = scl*D.z
	
	// Init
	var _w = sprite_width
	var _h = sprite_height
	var _dw = _w-WW
	var _dh = _h-WH
	
	if(!is(xpct)) { 
		
		dltx = -(lerp(-_dw/2,_dw/2,MXPCT)*panMult)
		x = xx+dltx
		xbd = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultBD)
		velship = .5*D.z
		xxship += velship*(1-shipDel2Pct)
		xship = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultShip)+xxship
		xbg = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultBG)
		
	} else x = lerp(0,(WW+D.bgImg.dltx)*D.z,xpct);
	
	#region Iterate Ship Delay
		
		#region Iterate the Delis, 1 before 2, and deiterate 2 if 1 is not 100%
		
		if(shipDeli < shipDel) {
			
			shipDeli++;
			if(shipDel2i > 0) shipDel2i-=10;
			
		} else if(shipDel2i < shipDel) shipDel2i++;
		
		// Reset Ship Delays
		if(window_mouse_get_delta_x() != 0 or window_mouse_get_delta_y() != 0)
			shipDeli = 0;
		
		// Update Percents
		shipDelPct = shipDeli/shipDel
		shipDel2Pct = shipDel2i/shipDel
		
	#endregion
	
	if(!is(ypct)) {
		
		dlty = -(lerp(-_dh/2,_dh/2,MYPCT)*panMult)
		y = yy+dlty
		ybd = yy-(lerp(-_dh/2,_dh/2,MYPCT)*panMultBD)
		yship = yy-(lerp(-_dh/2,_dh/2,MYPCT)*panMultShip)
		ybg = yy-(lerp(-_dh/2,_dh/2,MYPCT)*panMultBG)
		
	} else {
		
		y = lerp(0,(WH+D.bgImg.dlty)*D.z,ypct)
		
	}
	
	// Rescale Trigger
	if(M.alarm[0] > 0)
		alarm[0] = 2;
	
}