/// @description Scale & BD/BG Look & Scene Sanity
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
if(D.game_state == GAME.PLAY
	and is(sprite_index)) {
	
	#region Scene Sanity
		
		if(is(inScn)) {
			
			if(inScn != D.scni) {
				
				if(P.suitInst == id)
					P.suitInst = N;
				
				reset_image()
				
			}
			
		}
		
	#endregion
	
	// Image Scale
	image_xscale = scl*D.z
	image_yscale = scl*D.z
	
	var _w = D.bgImg.sprite_width
	var _h = D.bgImg.sprite_height
	var _dw = _w-WW
	var _dh = _h-WH
	
	if(is_bg_img() and mouse_in_window()) { 
		
		if(TRAN.delpct > 0 and is_array_ext(TRAN.zXYpct,2,"real")) {
			
			// Transition...
			if(!TRAN.done) { 
				
				// Zooming into zXY...
				dltx = -lerp(lerp(-_dw/2,_dw/2,MXpcto),lerp(-_dw/2,_dw/2,TRAN.zXYpct[0]),TRAN.delpct)*panMult
				dlty = -lerp(lerp(-_dh/2,_dh/2,MYpcto),lerp(-_dh/2,_dh/2,TRAN.zXYpct[1]),TRAN.delpct)*panMult
				
			} else {
				
				// Zooming out to zXY...
				dltx = -lerp(lerp(-_dw/2,_dw/2,TRAN.zXYpct[0]),lerp(-_dw/2,_dw/2,MXpcto),TRAN.delpct)*panMult
				dlty = -lerp(lerp(-_dh/2,_dh/2,TRAN.zXYpct[1]),lerp(-_dh/2,_dh/2,MYpcto),TRAN.delpct)*panMult
				
			}
			
		} else {
			
			// Default
			dltx = -lerp(lerp(-_dw/2,_dw/2,MXPCT),lerp(-_dw/2,_dw/2,.5),D.diaDelPct)*panMult
			dlty = -lerp(lerp(-_dh/2,_dh/2,MYPCT),lerp(-_dh/2,_dh/2,4/5),D.diaDelPct)*panMult
			MXpcto = MXPCT
			MYpcto = MYPCT
			
		}
		x = xx+dltx
		y = yy+dlty
		
	}
	
}