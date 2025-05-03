/// @description Menu/Dialogue
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

#region Menu Skip (Debug)*
	
	if(D.game_state == GAME.MENU and DBG.introSkip) {
		
		if(is_scn(DBG.skipTo)) set_scni(DBG.skipTo);
		else set_scni(SCENE.RESORT_BED); // Skip to not set, just skip to first room
		if(!audio_is_playing(bgm)) bgmID = audio_play_sound_on(bgmEmt,bgm,T,0,0);
		room_goto(rGame)
		
	}
	
#endregion Menu

#region Dialogue Logic
	
	if(!ds_list_empty(D.diaParL) and !D.diaOverride
		and D.fd <= 0 and !TRAN.override) {
		
		#region Init Parent Dialogue if we haven't (Based on Focuses being noone or not)
			
			#region Init
				
				// Get Dialogue Array [ 0:actor_uid , 1:dia_instance ]..
				var e = D.diaParL[|0]
				
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
								ds_list_delete(D.diaParL,0); // Cancel
								
							}
							
						} else {
							
							if(is_struct(e[1])) e[$ K.DN] = T; // Bypass
							ds_list_delete(D.diaParL,0); // Cancel
							
						}
						
						
					} else {
						
						if(is_struct(e[1])) e[$ K.DN] = T; // Bypass
						ds_list_delete(D.diaParL,0); // Cancel
						
					}
					
					
				} else {
					
					if(is_struct(e[1])) e[$ K.DN] = T; // Bypass
					ds_list_delete(D.diaParL,0); // Cancel
					
				}
				
			#endregion
			
		#endregion
			
		#region Scene Darken
			
			var ao = draw_get_alpha()
			draw_set_alpha((1/3)*(D.diaDelPct))
			draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
			draw_set_alpha(ao)
			
		#endregion
		
		#region Draw & Iterate Transitions...
			
			if(e == D.diaParL[|0] and is_struct(e[1]) and ds_list_empty(D.diaNestL)) {
				
				#region Un-Nested Dialogue (There is no Nested Dialogue (yet))
					
					#region Draw Calls...
						
						if(D.focusL and D.focusL != D.diaSpeaker) diaNar_draw(D.focusL,e[1],0);
						if(D.focusR and D.focusR != D.diaSpeaker) diaNar_draw(D.focusR,e[1],0);
						if(D.focusM and D.focusM != D.diaSpeaker) diaNar_draw(D.focusM,e[1],0);
						if(D.diaSpeaker) diaNar_draw(D.diaSpeaker,e[1],0);
						
					#endregion
					
					#region Iterate Dialogue Transition
						
						if(D.diaDeli < D.diaDel) D.diaDeli++;
						if(D.diaDelPct >= 1) D.diaDeli2++;
						
					#endregion
					
				#endregion
				
			} else if(e == D.diaParL[|0] and is_struct(e[1]) and !ds_list_empty(D.diaNestL)) {
				
				#region Nested Dialogue (We are currently in a nested diaParL instance)
					
					#region Do Nested Dialogue Draw Calls & Recursion...
						
						if(D.focusL and D.focusL != D.diaSpeaker) diaNar_draw(D.focusL,ds_list_top(D.diaNestL),ds_list_size(D.diaNestL));
						if(D.focusR and D.focusR != D.diaSpeaker) diaNar_draw(D.focusR,ds_list_top(D.diaNestL),ds_list_size(D.diaNestL));
						if(D.focusM and D.focusM != D.diaSpeaker) diaNar_draw(D.focusM,ds_list_top(D.diaNestL),ds_list_size(D.diaNestL));
						if(D.diaSpeaker) diaNar_draw(D.diaSpeaker,ds_list_top(D.diaNestL),ds_list_size(D.diaNestL));
						
					#endregion
					
					#region Iterate Dialogue Transition
						
						if(D.diaDeli < D.diaDel) D.diaDeli++;
						if(D.diaDelPct >= 1) D.diaDeli2++;
						
					#endregion
					
				#endregion
				
			}
			
		#endregion
		
	} else {
		
		#region No more diaParL?
			
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
	
	#region Parent Dialogue Checks; This is where diaParL is initiated!
		
		for(var i = 0; i < ds_list_size(D.actorL); i++) {
			
			var act = D.actorL[|i]
			// var started = ds_list_empty(D.diaParL) // Is the parent dialogue list empty?
			diaNar_iterate_level(NS,act.uid,0);
			/* Redundant?
			if(started and ds_list_empty(D.diaParL)) started = F; // If the parent dialogue WAS empty and still is, then we DIDN'T start one so switch it to false
			// No Else Needed; Since if it wasn't empty already, then started is already false.
			if(started and D.diaParL[|0][0] == act.uid) D.diaSpeaker = act; // Set whose dialogue it belongs to, to be initial focus/speaker...
			*/
			
		}
		
	#endregion
	
	#region Combat Dialogue Check TODO: Figure out how to iterate through a combat dialogue instance?
		
		if(ds_list_empty(D.diaParL) and instance_of(D.diaOpp,oChar)) {
			
			var _inst = get_combat_dia_inst(D.diaOpp)
			if(is(_inst)) {
				
				ds_list_add(D.diaParL,[D.diaOpp.ruid,_inst]);
				
			}
			
		}
		
	#endregion
	
	if((D.diaTranPct < 1 and D.diaTranPct > 0) or D.diaDelPct2 < 1 or (!D.diaLBDrawn and D.diaTranPct == 1)) {
		
		if(!D.diaLBDrawn) {
			
			#region Scene Darken (If no diaParL)
				
				if(ds_list_empty(D.diaParL)) {
					
					var ao = draw_get_alpha()
					draw_set_alpha((1/3)*(D.diaDelPct))
					draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
					draw_set_alpha(ao)
					
				}
				
			#endregion
			
			#region Letterboxing
				
				draw_set_alpha(1)
				draw_rectangle_color(0,0,WW,(WH*.1)*D.diaDelPct,c.blk,c.blk,c.blk,c.blk,F)
				draw_rectangle_color(0,WH-((WH*.1)*D.diaDelPct),WW,WH,c.blk,c.blk,c.blk,c.blk,F)
				
			#endregion
			
		}
		
	}
	
	D.diaLBDrawn = F

#endregion

#region UI?
	
	if(!ds_list_empty(P.party) and !D.ctrlOverride) {
		
		for(var i = 0; i < ds_list_size(P.party); i++) {
			
			var _e = P.party[|i]
			var _spr = sprNA
			if(_e.dia[$ K.KNW]) _spr = _e.imgSuit;
			else _spr = _e.imgFace;
			var _w = WW*.1
			var _scl = _w/sprite_get_width(_spr)
			draw_sprite_ext(_spr,0,(sprite_get_xoffset(_spr)*_scl)+((sprite_get_width(_spr)*_scl)*i),sprite_get_yoffset(_spr)*_scl,_scl,_scl,0,c.gry,2/3)
			
		}
		
	}
	
#endregion