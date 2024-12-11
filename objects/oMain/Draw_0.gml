/// @description Game
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

#region Game
	
	if(D.game_state == GAME.PLAY) {
		
		if(D.scene_state == GAME.INIT) {
			
			#region Init
				
				// Play BGM
				if(!audio_is_playing(msx007) and is(introInst))
					msx = audio_play_sound(msx007,1,T,0);
				
			#endregion
			
			#region Init Scene
				
				#region Sky 0
					
					// Sprite
					if(variable_instance_exists(S[$ string(D.scni)],K.SK0+K.SPR))
						D.skyImg.sprite_index = S[$ string(D.scni)][$ K.SK0+K.SPR];
						
					// Pan Multiplier
					if(variable_instance_exists(S[$ string(D.scni)],K.SK0+K.PMT))
						D.skyImg.panMult = S[$ string(D.scni)][$ K.SK0+K.PMT];
						
					// Scale
					if(variable_instance_exists(S[$ string(D.scni)],K.SK0+K.WMT))
						D.skyImg.sclMult = S[$ string(D.scni)][$ K.SK0+K.WMT];
					D.skyImg.scl = ((WW*D.zmn)/sprite_get_width(D.skyImg.sprite_index))*D.skyImg.sclMult
					
				#endregion
				
				#region BD 0
					
					// Sprite
					if(variable_instance_exists(S[$ string(D.scni)],K.BD0+K.SPR))
						D.bdImg.sprite_index = S[$ string(D.scni)][$ K.BD0+K.SPR];
						
					// Pan Multiplier
					if(variable_instance_exists(S[$ string(D.scni)],K.BD0+K.PMT))
						D.bdImg.panMult = S[$ string(D.scni)][$ K.BD0+K.PMT];
						
					// Scale
					if(variable_instance_exists(S[$ string(D.scni)],K.BD0+K.WMT))
						D.bdImg.sclMult = S[$ string(D.scni)][$ K.BD0+K.WMT];
					D.bdImg.scl = ((WW*D.zmn)/sprite_get_width(D.bdImg.sprite_index))*D.bdImg.sclMult
					
				#endregion
				
				#region BG 0 Layer 2
					
					// Sprite
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.L2+K.SPR))
						D.bgL2Img.sprite_index = S[$ string(D.scni)][$ K.BG0+K.L2+K.SPR];
						
					// Pan Multiplier
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.L2+K.PMT))
						D.bgL2Img.panMult = S[$ string(D.scni)][$ K.BG0+K.L2+K.PMT];
						
					// Scale
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.L2+K.WMT))
						D.bgL2Img.sclMult = S[$ string(D.scni)][$ K.BG0+K.L2+K.WMT];
					D.bgL2Img.scl = ((WW*D.zmn)/sprite_get_width(D.bgL2Img.sprite_index))*D.bgL2Img.sclMult
					
				#endregion
				
				#region BG 0 Layer 1
					
					// Sprite
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.L1+K.SPR))
						D.bgL1Img.sprite_index = S[$ string(D.scni)][$ K.BG0+K.L1+K.SPR];
						
					// Pan Multiplier
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.L1+K.PMT))
						D.bgL1Img.panMult = S[$ string(D.scni)][$ K.BG0+K.L1+K.PMT];
						
					// Scale
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.L1+K.WMT))
						D.bgL1Img.sclMult = S[$ string(D.scni)][$ K.BG0+K.L1+K.WMT];
					D.bgL1Img.scl = ((WW*D.zmn)/sprite_get_width(D.bgL1Img.sprite_index))*D.bgL1Img.sclMult
					
				#endregion
				
				#region BG 0
					
					// Sprite
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.SPR))
						D.bgImg.sprite_index = S[$ string(D.scni)][$ K.BG0+K.SPR];
						
					// Pan Multiplier
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.PMT))
						D.bgImg.panMult = S[$ string(D.scni)][$ K.BG0+K.PMT];
						
					// Scale
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.WMT))
						D.bgImg.sclMult = S[$ string(D.scni)][$ K.BG0+K.WMT];
					D.bgImg.scl = ((WW*D.zmn)/sprite_get_width(D.bgImg.sprite_index))*D.bgImg.sclMult
					
				#endregion
				
			#endregion
			
			#region Scene Characters
				
				// Left
				if(variable_instance_exists(S[$ string(D.scni)],K.ACT+K.LFT)) {
					
					var _act = actor_find(S[$ string(D.scni)][$ K.ACT+K.LFT])
					if(!in_party(_act)) {
						
						_act.scni = D.scni
						D.actorLeft = _act
						
					}
					
				}
				// Right
				if(variable_instance_exists(S[$ string(D.scni)],K.ACT+K.RHT)) {
					
					var _act = actor_find(S[$ string(D.scni)][$ K.ACT+K.RHT])
					if(!in_party(_act)) {
						
						_act.scni = D.scni
						D.actorRight = _act
						
					}
					
				}
				
			#endregion
			
			#region Environmental
				
				if(variable_instance_exists(S[$ string(D.scni)],K.ENV)) {
					
					#region Blending...
						
						if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD)) {
							
							#region Single Blend
								
								if(variable_instance_exists(S[$ string(D.scni)],K.SCN+K.BLD+K.MT)) {
									
									// Single Blend... w/ Multiplier
									if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD]); // Brighter...
									else scene_set_blend(color_darken(S[$ string(D.scni)][$ K.SCN+K.BLD],S[$ string(D.scni)][$ K.SCN+K.BLD+K.MT])); // Darker...
									
								} else {
									
									// Single Blend... No Multiplier, Default 1/4
									if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(S[$ string(D.scni)][$ K.SCN+K.BLD]); // Brighter...
									else scene_set_blend(color_darken(S[$ string(D.scni)][$ K.SCN+K.BLD],1/4)); // Darker...
									
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
									else scene_set_blend(color_darken(c.wht,S[$ string(D.scni)][$ K.SCN+K.BLD+K.MT])); // Darker...
									
								} else {
									
									// No Blend... No Multiplier, Default 1/4
									if(S[$ string(D.scni)][$ K.ENV]) scene_set_blend(c.wht); // Brighter...
									else scene_set_blend(color_darken(c.wht,1/4)); // Darker...
									
								}
								
							#endregion
							
						}
						
					#endregion
					
				} else scene_set_blend(c.wht); // Default if no environment set... No Blend...
				
			#endregion
			
			#region Travellers
				
				if(variable_instance_exists(S[$ string(D.scni)],K.TRA+K.CNT )) {
					
					var cnt = S[$ string(D.scni)][$ K.TRA+K.CNT]
					for(var i = 0; i < cnt; i++) {
						// TODO TRAVELLERS SPAWNS
					}
					
				}
				if(variable_instance_exists(S[$ string(D.scni)],K.TRA+K.XRG)){}
				if(variable_instance_exists(S[$ string(D.scni)],K.TRA+K.YRG)){}
				if(variable_instance_exists(S[$ string(D.scni)],K.TRA+K.ZRG)){}
				
			#endregion
			
			// Set Play
			D.scene_state = GAME.PLAY
			
		}
		
		#region Fade-In BGM
			
			if(audio_is_playing(msx007) and is(msx) and is(introInst)) {
				
				if(audio_sound_get_gain(msx) == 0 and introInst.del <= 0)
					audio_sound_gain(msx,.1,10*1000);
				
			}
			
		#endregion
		
	}
	
#endregion