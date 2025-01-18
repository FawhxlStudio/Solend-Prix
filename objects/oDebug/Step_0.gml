/// @description Live Update
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
#region Other Debug Controls...
	
	if(D.game_state == GAME.PLAY and D.scene_state == GAME.PLAY) {
		
		#region DB Resets
			
			if(resetControl) {
				
				#region All
					
					if(keyboard_check_pressed(vk_f12) and !console and edit) {
						
						with(D) {
							
							// Reset Structs...
							db_scn()
							db_diaNar()
							db_act()
							db_context()
							
						}
						
						// Return Suit...
						P.suited = F
						P.suitedo = P.suited
						
						#region Environmental
							
							if(variable_instance_exists(S[$ string(D.scni)],K.ENV)) {
								
								#region Blending...
									
									if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD)) {
										
										#region Single Blend
											
											if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.MT)) {
												
												// Single Blend... w/ Multiplier
												if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD]); // Brighter...
												else scene_set_blend(color_brightness(S[$ string(D.scni)][$ K.SCN+K.BLD],S[$ string(D.scni)][$ K.SCN+K.BLD+K.MT])); // Darker...
												
											} else {
												
												// Single Blend... No Multiplier, Default 1/4
												if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD]); // Brighter...
												else scene_set_blend(color_brightness(S[$ string(D.scni)][$ K.SCN+K.BLD],1/4)); // Darker...
												
											}
											
										#endregion
										
									} else if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.TR)
										and variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.FL)) {
										
										// True & False Blend...
										if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD+K.TR]); // Brighter...
										else scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD+K.FL]); // Darker...
										
									} else if(!variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.TR)
										and variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.FL)) {
										
										// False Only Blend...
										if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(c.wht); // Brighter...
										else scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD+K.FL]); // Darker?
										
									} else if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.TR)
										and !variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.FL)) {
										
										// True Only Blend...
										if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD+K.TR]); // Brighter?
										else scene_set_blend(c.dgry); // Darker...
										
									} else {
										
										#region No Blend
											
											if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.MT)) {
												
												// No Blend... w/ Multiplier
												if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(c.wht); // Brighter...
												else scene_set_blend(color_brightness(c.wht,S[$ string(D.scni)][$ K.SCN+K.BLD+K.MT])); // Darker...
												
											} else {
												
												// No Blend... No Multiplier, Default 1/4
												if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(c.wht); // Brighter...
												else scene_set_blend(color_brightness(c.wht,1/4)); // Darker...
												
											}
											
										#endregion
										
									}
									
								#endregion
								
							} else scene_set_blend(c.wht); // Default if no environment set... No Blend...
							
						#endregion
						
						// Exit Edit Mode
						edit = F
						
					}
					
				#endregion
				
			}
			
		#endregion
		
		#region Environment Invert/Toggle (For Testing Blend Switching)
			
			if(keyboard_check_pressed(vk_f3) and !console and edit and envInvert) {
				
				#region Environmental
					
					if(variable_instance_exists(S[$ string(D.scni)],K.ENV)) {
						
						// Invert Env
						S[$ string(D.scni)][$ K.ENV] = !S[$ string(D.scni)][$ K.ENV]
						
						#region Blending...
							
							if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD)) {
								
								#region Single Blend
									
									if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.MT)) {
										
										// Single Blend... w/ Multiplier
										if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD]); // Brighter...
										else scene_set_blend(color_brightness(S[$ string(D.scni)][$ K.SCN+K.BLD],S[$ string(D.scni)][$ K.SCN+K.BLD+K.MT])); // Darker...
										
									} else {
										
										// Single Blend... No Multiplier, Default 1/4
										if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD]); // Brighter...
										else scene_set_blend(color_brightness(S[$ string(D.scni)][$ K.SCN+K.BLD],1/4)); // Darker...
										
									}
									
								#endregion
								
							} else if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.TR)
								and variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.FL)) {
								
								// True & False Blend...
								if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD+K.TR]); // Brighter...
								else scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD+K.FL]); // Darker...
								
							} else if(!variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.TR)
								and variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.FL)) {
								
								// False Only Blend...
								if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(c.wht); // Brighter...
								else scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD+K.FL]); // Darker?
								
							} else if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.TR)
								and !variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.FL)) {
								
								// True Only Blend...
								if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD+K.TR]); // Brighter?
								else scene_set_blend(c.dgry); // Darker...
								
							} else {
								
								#region No Blend
									
									if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.MT)) {
										
										// No Blend... w/ Multiplier
										if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(c.wht); // Brighter...
										else scene_set_blend(color_brightness(c.wht,S[$ string(D.scni)][$ K.SCN+K.BLD+K.MT])); // Darker...
										
									} else {
										
										// No Blend... No Multiplier, Default 1/4
										if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(c.wht); // Brighter...
										else scene_set_blend(color_brightness(c.wht,1/4)); // Darker...
										
									}
									
								#endregion
								
							}
							
						#endregion
						
					} else scene_set_blend(c.wht); // Default if no environment set... No Blend...
					
				#endregion
				
				// Exit Edit Mode
				edit = F
				
			}
			
		#endregion
		
		#region Mute Toggle
			
			if(keyboard_check_pressed(vk_f2) and !console and edit) {
				
				muted = !muted
				if(muted) audio_pause_all();
				else audio_resume_all()
				
				// Exit Edit Mode
				edit = F
				
			}
			
		#endregion
		
		#region Unstuck
			
			if(unstuck) {
				
				if(keyboard_check_pressed(vk_f1) and !console and edit) {
					
					diaNar_close(F)
					
					// Exit Edit Mode
					edit = F
					
				}
				
			}
			
		#endregion
		
	}
	
#endregion