	// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region Button Related...
	
	function draw_button_fxl(xy,bgc,fgc,str,actn,enabled){
		
		// If not enabled, halve alpha
		if(!enabled) {
			
			bgc[0] = bgc[0]/2
			fgc[0] = fgc[0]/2
			
		}
		
		// Set AO
		var ao = draw_get_alpha()
		
		#region Body
			
			// BG
			draw_set_alpha(bgc[0])
			draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],
				bgc[1],bgc[2],bgc[3],bgc[4],F)
			
			// Outline
			draw_set_alpha(fgc[0])
			draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],
				fgc[1],fgc[2],fgc[3],fgc[4],T)
			
		#endregion
		
		#region Interaction
		
			if(mouse_in_rectangle(xy) and enabled) {
			
				// Hilight
				if(MBL) draw_set_alpha(fgc[0]*.25)
				else draw_set_alpha(fgc[0]*.5)
				draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],
					fgc[1],fgc[2],fgc[3],fgc[4],F)
				
				// Do button action
				if(MBLR) {
					
					// Reset Alpha and Do Action
					draw_set_alpha(ao)
					button_action(actn)
					
				}
				
			}
		
		#endregion
		
		#region Text
			
			var midx = lerp(xy[0],xy[2],0.5)
			var midy = lerp(xy[1],xy[3],0.5)
			draw_set_font(fHUD)
			draw_set_hvalign([fa_center,fa_middle])
			draw_text_color(midx,midy,str,fgc[1],fgc[2],
				fgc[3],fgc[4],fgc[0])
			
		#endregion
		
		// Reset Alpha
		draw_set_alpha(ao)
		
	}
	
	function button_action(actn) {
		
		switch(actn) {
			
			case BUTTON.PLAY: {
				
				if(D.game_state == GAME.MENU) {
					
					D.game_state = GAME.PLAY
					D.scene_state = GAME.INIT
					D.scni = SCENE.APARTMENT
					audio_stop_all()
					sfx_gunshot(1)
					M.introInst = instance_create_layer(0,0,"GUI",oIntro)
					room_goto(rGame)
					
				}
				
				break
				
			}
			
			case BUTTON.EXIT: {
				
				game_end()
				
			}
			
			default: break
			
		}
		
	}
	
#endregion

#region Base Draw Functions...
	
	#region HVAlign
		
		function draw_set_hvalign(hva) {
			
			draw_set_halign(hva[0])
			draw_set_valign(hva[1])
			
		}
		
		function draw_get_hvalign() {
			
			return [draw_get_halign(),draw_get_valign()]
			
		}
		
	#endregion
	
	#region Draw Globals
		
		function draw_reset() {
			
			try {
				
				with(D) {
					
					// This is also the first defaults... Ideally outside of specific draw lines these should return to these values...
					// Can use this to reset to defaults if needed?
					HVO = [fa_left,fa_top]
					FO = fNeu
					AO = 1
					CO = c.wht
					
				}
				
			} catch(_ex) {
				
				// Must be in Data Create Event...
				// D wouldn't be set yet...
				HVO = [fa_left,fa_top]
				FO = fNeu
				AO = 1
				CO = c.wht
				
			}
			
		}
		
		function draw_olds_pull() {
			
			with(D) {
				
				// Set Olds
				HVO = draw_get_hvalign()
				FO = draw_get_font()
				AO = draw_get_alpha()
				CO = draw_get_color()
				
			}
			
		}
		
		function draw_olds_push() {
			
			with(D) {
				
				// Apply Olds
				draw_set_hvalign(HVO)
				draw_set_font(FO)
				draw_set_alpha(AO)
				draw_set_color(CO)
				
			}
			
		}
		
	#endregion
	
	#region Text
		
		// Line before: var _str,_strw,_strh,_bgc,_fgc
		// Since this is setting where it is called from...
		function text_prep(str) {
			
			// the usual init; non-ext
			str_  = str
			strw_ = string_width(str)
			strh_ = string_height(str)
			bgc_  = [1/3,c.dgry,c.dgry,c.blk,c.blk] // Background Default
			fgc_  = [1,c.wht,c.wht,c.lgry,c.lgry] // Foreground/Text Default
			
		}
		
	#endregion
	
#endregion