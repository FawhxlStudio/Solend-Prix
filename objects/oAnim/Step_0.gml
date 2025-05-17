/// @description Updates


if(D.game_state == GAME.PLAY) {
	
	// Dialogue Instance
	if(diaInst == N and is_string(animStr)) diaInst = NS[$ animStr];
	
	// Iterate fx Inst
	if((lightFX or actionPan) and is_struct(fxInst)) trig_iter(fxInst);
	
	#region Init
		
		// Var Init
		var _w = 1
		var _h = 1
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
					
					if(is_array(diaInst[$ K.BG0+K.SPR]) and !arrSprDone) {
						
						#region BG0 Array
							
							if(is_undefined(n_z)) n_z = 1;
							if(!arrSpri) arrSpri = 0;
							proc_fx_arr(diaInst[$ K.BG0+K.SPR][arrSpri+1],(arrSpri == array_length(diaInst[$ K.BG0+K.SPR])-2))
							_w = (sprite_get_width(diaInst[$ K.BG0+K.SPR][arrSpri])*scl)*n_z
							_h = (sprite_get_height(diaInst[$ K.BG0+K.SPR][arrSpri])*scl)*n_z
							
						#endregion
						
					} else if(!is_array(diaInst[$ K.BG0+K.SPR])){
						
						#region BG0 Single Sprite
							
							_w = sprite_get_width(diaInst[$ K.BG0+K.SPR])*scl
							_h = sprite_get_height(diaInst[$ K.BG0+K.SPR])*scl
							
						#endregion
						
					}
					
					// Set Delta W/H
					_dw = max(0,_w-WW)
					_dh = max(0,_h-WH)
					
				#endregion
				
			} else {
				
				#region Default/None
					
					_w = 1
					_h = 1
					_dw = max(0,_w-WW)
					_dh = max(0,_h-WH)
					
				#endregion
				
			}
			
		}
		
	#endregion
	
	// Image Scale
	if(tightPan) {
		
		image_xscale = scl
		image_yscale = scl
		
	} else {
		
		image_xscale = scl*D.z
		image_yscale = scl*D.z
		
	}
	
	#region X Axis Updates
		
		if(!is(xpct)) {
			
			if(actionPan) {
				
				#region Action/Auto Panning
					
					var _pct = fxInst.sn/4
					dltx = -(lerp(-_dw/2,_dw/2,_pct)*panMult)
					xbd = xx-(lerp(-_dw/2,_dw/2,_pct)*panMultBD)
					xship = xx-(lerp(-_dw/2,_dw/2,_pct)*panMultShip)+xxship
					xbg = xx-(lerp(-_dw/2,_dw/2,_pct)*panMultBG)
					
				#endregion
				
			} else {
				
				var _pct = MXPCT
				#region Manual/Mouse Panning
					
					#region X Alignment
						
						if(!is_undefined(n_aln) and is_array_ext(n_aln,2,N)) {
							
							if(n_aln[0] == fa_left) _pct = 0;
							else if(n_aln[0] == fa_right) _pct = 1;
							else _pct = .5;
							
						}
						
					#endregion
					
					dltx = -(lerp(-_dw/2,_dw/2,_pct)*panMult)
					xbd = xx-(lerp(-_dw/2,_dw/2,_pct)*panMultBD)
					xship = xx-(lerp(-_dw/2,_dw/2,_pct)*panMultShip)+xxship
					xbg = xx-(lerp(-_dw/2,_dw/2,_pct)*panMultBG)
					
					
				#endregion
				
			}
			
			#region Ship XX/Velocity Updates
				
				velship = .5*D.z
				xxship += velship*(1-shipDel2Pct)
				
			#endregion
			
			// Apply
			x = xx+dltx
			
		} else {
			
			if(actionPan) x = lerp(0,(WW+D.bgImg.dltx)*D.z,fxInst.sn/2);
			else {
				
				var _pct = xpct
				#region X Alignment
					
					if(!is_undefined(n_aln) and is_array_ext(n_aln,2,N)) {
						
						if(n_aln[0] == fa_left) _pct = 0;
						else if(n_aln[0] == fa_right) _pct = 1;
						else _pct = .5;
						
					}
					
				#endregion
				x = lerp(0,(WW+D.bgImg.dltx)*D.z,_pct)
				
			}
			
		}
		
	#endregion
	
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
	
	#region Y Axis Updates...
		
		if(!is(ypct)) {
			
			if(actionPan) {
				
				var _pct = fxInst.csn2/4
				#region Action/Auto Panning
					
					dlty = -(lerp(-_dh/2,_dh/2,_pct)*panMult)
					ybd = yy-(lerp(-_dh/2,_dh/2,_pct)*panMultBD)
					yship = yy-(lerp(-_dh/2,_dh/2,_pct)*panMultShip)
					ybg = yy-(lerp(-_dh/2,_dh/2,_pct)*panMultBG)
					
				#endregion
				
			} else {
				
				var _pct = MYPCT
				#region Manual/Mouse Panning
					
					#region Y Alignment
						
						if(!is_undefined(n_aln) and is_array_ext(n_aln,2,N)) {
							
							if(n_aln[1] == fa_top) _pct = 0;
							else if(n_aln[1] == fa_bottom) _pct = 1;
							else _pct = .5;
							
						}
						
					#endregion
					dlty = -(lerp(-_dh/2,_dh/2,_pct)*panMult)
					ybd = yy-(lerp(-_dh/2,_dh/2,_pct)*panMultBD)
					yship = yy-(lerp(-_dh/2,_dh/2,_pct)*panMultShip)
					ybg = yy-(lerp(-_dh/2,_dh/2,_pct)*panMultBG)
					
				#endregion
				
			}
			
			// Apply
			y = yy+dlty
			
		} else {
			
			if(actionPan) y = lerp(0,(WH+D.bgImg.dlty)*D.z,fxInst.csn2);
			else {
				
				var _pct = ypct
				#region Y Alignment
					
					if(!is_undefined(n_aln) and is_array_ext(n_aln,2,N)) {
						
						if(n_aln[1] == fa_top) _pct = 0;
						else if(n_aln[1] == fa_bottom) _pct = 1;
						else _pct = .5;
						
					}
					
				#endregion
				y = lerp(0,(WH+D.bgImg.dlty)*D.z,_pct)
				
			}
			
		}
		
	#endregion
	
	// Rescale Trigger
	if(M.alarm[0] > 0) alarm[0] = 2;
	
}