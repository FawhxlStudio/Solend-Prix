/// @description Updates
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY
	and is(sprite_index)) {

	// Image Scale
	image_xscale = scl*D.z
	image_yscale = scl*D.z
	
	var _w = sprite_width
	var _h = sprite_height
	var _dw = _w-WW
	var _dh = _h-WH
	
	if(!is(xpct)) { 
		
		dltx = -(lerp(-_dw/2,_dw/2,MXPCT)*panMult)
		x = xx+dltx
		xbd = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultBD)
		velship = .5*D.z
		xxship += velship
		xship = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultShip)+xxship
		xbg = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultBG)
		
	} else {
		
		x = lerp(0,(WW+D.bgImg.dltx)*D.z,xpct)
		
	}
	
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