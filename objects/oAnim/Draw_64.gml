/// @description Text
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY and D.scene_state == GAME.PLAY and D.animPlay = id and is(animStr)) {
	
	if(is(diaInst[$ NS[$ K.I]])) {
		
		if(!diaInst[$ K.DN]) {
			
			#region Draw Dialogue
				
				#region Init
					
					if(!variable_instance_exists(diaInst,K.I)) diaInst[$ K.I] = 0;
					var _act = struct_find(diaInst,K.ACT)
					D.diaEnter = F
					
				#endregion
				
				#region Get Font from Actor UID
					
					if(!is_undefined(_act)) {
						
						var _actr = actor_find(_act)
						diaNar_draw_dialogue(diaInst,_actr,diaInst[$ K.I],F)
						
					} else diaNar_draw_dialogue(diaInst,N,diaInst[$ K.I],F);
					
				#endregion
				
				#region Iterate Dialogue...
					
					// Init
					var rcnt = diaNar_get_real_keys_count(diaInst)
					
					// Override Dialogue Continuing
					if(D.diaInstArr != N) D.diaEnter = F;
					
					// Iterator
					if(rcnt != N and D.diaEnter) {
						
						if(diaInst[$ K.I] < rcnt) diaInst[$ K.I] += 1
						else if(diaInst[$ K.I] >= rcnt) {
							
							// Anim Done
							diaInst[$ K.DN] = T
							
							#region Anim K.END Actions
								
								var ends = diaNar_get_sks_ends(variable_instance_get_sorted_strKeys(diaInst,F))
								for(var i = 0; i < array_length(ends); i++) {
									
									#region SKS Names
										
										var _snden = K.SND+K.END
										var _sndspen = K.SND+K.STP+K.END
										
									#endregion
									
									var k = ends[i]
									var v = diaInst[$ k]
									switch(k) {
										
										case _snden: 
												
											if(is_array_ext(v,4,N)) {
												
												try {
													
													audio_play_sound(v[0],v[1],v[2],v[3])
													
												} catch (_ex) {
													
													show_debug_message("[WARN: Anim K.END Actions] Unable to play sound: "+string(_ar))
													show_debug_message(_ex)
													
												}
												
											} else if(audio_exists(v)) audio_play_sound(v,4,F,2/3);
											
											
										break
										
										case _sndspen:
											
											if(!is_array(v) and audio_exists(v)) {
												
												#region Single Sound Entry
													
													if(audio_is_playing(v)) {
														
														if(audio_sound_get_gain(v) >= 2/3) audio_sound_gain(v,0,1000);
														else if(audio_sound_get_gain(v) <= 0) audio_stop_sound(v);
														
													}
													
												#endregion
												
											} else {
												
												#region Array Process TODO
													
													//TODO
													
												#endregion
												
											}
											
										break
										
									}
									
								}
								
							#endregion
							
						}
						
					}
					
				#endregion
				
			#endregion
			
		}
		
	}
	
}