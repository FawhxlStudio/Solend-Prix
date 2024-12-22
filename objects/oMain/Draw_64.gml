/// @description Menu/Dialogue
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

#region Menu Skip (Debug)*
	
	if(D.game_state == GAME.MENU and DBG.introSkip) {
		
		D.game_state = GAME.PLAY
		D.scene_state = GAME.INIT
		D.scni = SCENE.CLUB
		audio_stop_all()
		sfx_gunshot(1)
		introInst = instance_create_layer(0,0,"GUI",oIntro)
		room_goto(rGame)
		
	}
	
#endregion Menu

#region Dialogue Logic
	
	if(!ds_list_empty(D.diaParLst) and !D.diaOverride
		and D.fd <= 0 and !TRAN.override) {
		
		#region Init Parent Dialogue if we haven't (Based on Focuses being noone or not)
			
			#region Init
				
				// Get Dialogue Array [ 0:actor_uid , 1:dia_instance ]..
				var e = D.diaParLst[|0]
				
				// Set Control Override
				D.ctrlOverride = T
				
				// Swoosh SFX @ Start; Is given a couple frames to ensure played if needed...
				if(!audio_is_playing(sfxSwoosh) and D.diaDeli <= 3 and !audio_is_playing(sfxZip))
					audio_play_sound(sfxSwoosh,0,F,random_range(.9,1),0,random_range(.9,1.1));
				
			#endregion
			
			#region Primary Focus setup and checks...
				
				if(is_array(e)) {
					
					if(array_length(e) == 2) {
						
						if(is_struct(e[1])) {
							
							var act = actor_find(e[0])
							if(act != N) {
								
								#region Set Primary Focus...
									
									if(!D.focus) {
										
										D.focus = act;
										D.diad = GSPD
										
										if(D.focusL != act and D.focusR != act and D.focusM != act) {
											
											if(!D.focusL) D.focusL = act;
											else if(!D.focusR) D.focusR = act;
											else if(!D.focusM) D.focusM = act;
											
										}
										
									}
									
								#endregion
								
							} else {
								
								if(is_struct(e[1])) e[$ K.DN] = T; // Bypass
								ds_list_delete(D.diaParLst,0); // Cancel
								
							}
							
						} else {
							
							if(is_struct(e[1])) e[$ K.DN] = T; // Bypass
							ds_list_delete(D.diaParLst,0); // Cancel
							
						}
						
						
					} else {
						
						if(is_struct(e[1])) e[$ K.DN] = T; // Bypass
						ds_list_delete(D.diaParLst,0); // Cancel
						
					}
					
					
				} else {
					
					if(is_struct(e[1])) e[$ K.DN] = T; // Bypass
					ds_list_delete(D.diaParLst,0); // Cancel
					
				}
				
			#endregion
			
		#endregion
			
		#region Scene Darken
			
			var ao = draw_get_alpha()
			draw_set_alpha((2/3)*(D.diaDelPct))
			draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
			draw_set_alpha(ao)
			
		#endregion
		
		#region Draw & Iterate Transitions...
			
			if(e == D.diaParLst[|0] and is_struct(e[1]) and ds_list_empty(D.diaNestLst)) {
				
				#region Un-Nested Dialogue (There is no Nested Dialogue (yet))
					
					#region Draw Calls...
						
						if(D.focusL) diaNar_draw(D.focusL,e[1],0);
						if(D.focusR) diaNar_draw(D.focusR,e[1],0);
						if(D.focusM) diaNar_draw(D.focusM,e[1],0);
						
					#endregion
					
					#region Iterate Dialogue Transition
						
						if(D.diaDeli < D.diaDel) D.diaDeli++;
						if(D.diaDelPct >= 1) D.diaDeli2++;
						
					#endregion
					
				#endregion
				
			} else if(e == D.diaParLst[|0] and is_struct(e[1]) and !ds_list_empty(D.diaNestLst)) {
				
				#region Nested Dialogue (We are currently in a nested diaParLst instance)
					
					#region Do Nested Dialogue Draw Calls & Recursion...
						
						if(D.focusL) diaNar_draw(D.focusL,ds_list_top(D.diaNestLst),ds_list_size(D.diaNestLst));
						if(D.focusR) diaNar_draw(D.focusR,ds_list_top(D.diaNestLst),ds_list_size(D.diaNestLst));
						if(D.focusM) diaNar_draw(D.focusM,ds_list_top(D.diaNestLst),ds_list_size(D.diaNestLst));
						
					#endregion
					
					#region Iterate Dialogue Transition
						
						if(D.diaDeli < D.diaDel) D.diaDeli++;
						if(D.diaDelPct >= 1) D.diaDeli2++;
						
					#endregion
					
				#endregion
				
			}
			
		#endregion
		
	} else {
		
		#region No more diaParLst?
			
			diaNar_focus_reset() // Focus Sanity...
			// De-Iterate
			D.diaDeli--
			D.diaDeli2--
			
		#endregion
		
	}
	
	#region Update diaDelis
		
		// Iterators
		D.diaDeli = clamp(D.diaDeli,0,D.diaDel)
		D.diaDeli2 = clamp(D.diaDeli2,0,D.diaDel)
		// Percents
		D.diaDelPct = D.diaDeli/D.diaDel
		D.diaDelPct2 = D.diaDeli2/D.diaDel
		
		// Deiterate diad(elay)
		if(D.diad > 0) D.diad = clamp(D.diad-1,0,D.diad);
		
	#endregion
	
	#region Parent Dialogue Checks; This is where diaParLst is initiated!
		
		for(var i = 0; i < ds_list_size(D.actorLst); i++) {
			
			var act = D.actorLst[|i]
			diaNar_iterate_level(NS,act.uid,0)
			
		}
		
	#endregion
	
	#region Scene Darken (If no diaParLst)
		
		if(ds_list_empty(D.diaParLst)) {
			
			var ao = draw_get_alpha()
			draw_set_alpha((2/3)*(D.diaDelPct))
			draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
			draw_set_alpha(ao)
			
		}
		
	#endregion
	
	#region Letterboxing
		
		draw_set_alpha(1)
		draw_rectangle_color(0,0,WW,(WH*.1)*D.diaDelPct,c.blk,c.blk,c.blk,c.blk,F)
		draw_rectangle_color(0,WH-((WH*.1)*D.diaDelPct),WW,WH,c.blk,c.blk,c.blk,c.blk,F)
		
	#endregion

#endregion