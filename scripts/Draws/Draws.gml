	// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
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
