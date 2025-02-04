/// @description Updates
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY) {
	
	// Dialogue Instance
	if(diaInst == N and is_string(animStr)) diaInst = NS[$ animStr];
	
	// Image Scale
	if(tightPan) {
		
		image_xscale = scl
		image_yscale = scl
		
	} else {
		
		image_xscale = scl*D.z
		image_yscale = scl*D.z
		
	}
	
	// Iterate fx Inst
	if((lightFX or actionPan) and is_struct(fxInst)) trig_iter(fxInst);
	
	#region Init
		
		// Var Init
		var _w = 0
		var _h = 0
		var _dw = 0
		var _dh = 0
		
		// Target?
		if(sprite_index != sprNA) {
			
			#region Sprite Index NOT sprNA (Sprite Index Used)
				
				_w = sprite_width
				_h = sprite_height
				_dw = max(0,_w-WW)
				_dh = max(0,_h-WH)
				
			#endregion
			
		} else {
			
			if((is_string(animStr) and variable_instance_exists(NS[$ animStr],K.BG0+K.SPR)) or diaInst != N) {
				
				#region diaInst BG0
					
					_w = sprite_get_width(diaInst[$ K.BG0+K.SPR])*scl
					_h = sprite_get_height(diaInst[$ K.BG0+K.SPR])*scl
					_dw = max(0,_w-WW)
					_dh = max(0,_h-WH)
					
				#endregion
				
			} else {
				
				#region Default/None
					
					_w = 0
					_h = 0
					_dw = max(0,_w-WW)
					_dh = max(0,_h-WH)
					
				#endregion
				
			}
			
		}
		
	#endregion
	
	if(!is(xpct)) { 
		
		if(actionPan) {
			
			dltx = -(lerp(-_dw/2,_dw/2,fxInst.sn2)*panMult)
			xbd = xx-(lerp(-_dw/2,_dw/2,fxInst.sn2)*panMultBD)
			xship = xx-(lerp(-_dw/2,_dw/2,fxInst.sn2)*panMultShip)+xxship
			xbg = xx-(lerp(-_dw/2,_dw/2,fxInst.sn2)*panMultBG)
			
		} else {
			
			dltx = -(lerp(-_dw/2,_dw/2,MXPCT)*panMult)
			xbd = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultBD)
			xship = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultShip)+xxship
			xbg = xx-(lerp(-_dw/2,_dw/2,MXPCT)*panMultBG)
			
		}
		velship = .5*D.z
		xxship += velship*(1-shipDel2Pct)
		x = xx+dltx
		
	} else {
		
		if(actionPan) x = lerp(0,(WW+D.bgImg.dltx)*D.z,fxInst.sn2);
		else x = lerp(0,(WW+D.bgImg.dltx)*D.z,xpct);
		
	}
	
	#region Iterate Ship Delay
		
		#region Iterate the Delis, 1 before 2, and deiterate 2 if 1 is not 100%
			
			if(shipDeli < shipDel) {
				
				shipDeli++
				if(shipDel2i > 0) shipDel2i-=10;
				
			} else if(shipDel2i < shipDel) shipDel2i++;
			
		#endregion
		
		// Reset Ship Delays
		if(window_mouse_get_delta_x() != 0 or window_mouse_get_delta_y() != 0)
			shipDeli = 0;
		
		// Update Percents
		shipDelPct = shipDeli/shipDel
		shipDel2Pct = shipDel2i/shipDel
		
	#endregion
	
	if(!is(ypct)) {
		
		if(actionPan) {
			
			dlty = -(lerp(-_dh/2,_dh/2,fxInst.csn2)*panMult)
			ybd = yy-(lerp(-_dh/2,_dh/2,fxInst.csn2)*panMultBD)
			yship = yy-(lerp(-_dh/2,_dh/2,fxInst.csn2)*panMultShip)
			ybg = yy-(lerp(-_dh/2,_dh/2,fxInst.csn2)*panMultBG)
			
		} else {
			
			dlty = -(lerp(-_dh/2,_dh/2,MYPCT)*panMult)
			ybd = yy-(lerp(-_dh/2,_dh/2,MYPCT)*panMultBD)
			yship = yy-(lerp(-_dh/2,_dh/2,MYPCT)*panMultShip)
			ybg = yy-(lerp(-_dh/2,_dh/2,MYPCT)*panMultBG)
			
		}
		y = yy+dlty
		
	} else {
		
		if(actionPan) y = lerp(0,(WH+D.bgImg.dlty)*D.z,fxInst.csn2);
		else y = lerp(0,(WH+D.bgImg.dlty)*D.z,ypct);
		
	}
	
	// Rescale Trigger
	if(M.alarm[0] > 0) alarm[0] = 2;
	
}