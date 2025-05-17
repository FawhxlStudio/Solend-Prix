/// @description Draw & interact


if(D.game_state == GAME.PLAY
	and is(sprite_index)) {
	
	image_blend = D.scnBlend3
	draw_self()
	
	#region Interaction (To Make Universal)
		
		if(interact and !D.ctrlOverride and D.fd <= 0 and !TRAN.override) {
			
			if(bbox_sanity(id)) {
				
				if(mouse_in_rectangle([bbox_left,bbox_top,bbox_right,bbox_bottom])
					and is_hover(id)) {
					
					// Set Hover
					D.isHvr = id
					
					#region Shader Draw
						
						shader_set(shWhite)
							
							if(MBL) {
								
								var _a = shader_get_uniform(shWhite,"alpha")
								shader_set_uniform_f(_a,D.hvrPct/6)
								
							} else {
								
								var _a = shader_get_uniform(shWhite,"alpha")
								shader_set_uniform_f(_a,D.hvrPct/5)
								
							}
							draw_self()
							
						shader_reset()
						
					#endregion
					
					if(is_string(str) and str != "") {
						
						#region Draw Hover/Found Messages on Cursor
							
							// Init
							draw_set_font(fNeu)
							var _w = D.bgImg.sprite_width/6
							var strw = string_width_ext(str,STRH,_w)
							var strh = string_height_ext(str,STRH,_w)
							var hvo = [draw_get_halign(),draw_get_valign()]
							var ao = draw_get_alpha()
							var hv = [fa_left,fa_top]
							var xx = WMX+STRH
							var yy = WMY+STRH
							
							// If Offscreen: Invert Text Alignment/Draw Origin
							if(xx+strw > WW) {
								
								hv[0] = fa_right
								xx = WMX-STRH
								
							}
							
							if(yy+strh > WH) {
								
								hv[1] = fa_bottom
								yy = WMY-STRH
								
							}
							
							// Draw
							draw_set_hvalign(hv)
							draw_text_ext_color(xx,yy,str,STRH,_w,c.wht,c.wht,c.wht,c.wht,D.hvrPct)
							draw_set_hvalign(hvo)
							draw_set_font(fNeu)
							
						#endregion
						
					}
					
					if(MBLP) {
						
						#region Pseudo-Destroy (Reset, hidden and defaulted)
							
							P.suited   = T
							P.suitCrateInst = N
							reset_image()
							
						#endregion
						
					}
					
				}
				
			}
			
		}
		
	#endregion
	
}