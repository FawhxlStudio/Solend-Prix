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
								
								if(variable_instance_exists(diaInst,K.SND+K.END)) {
									
									var _ar = diaInst[$ K.SND+K.END]
									if(is_array_ext(_ar,4,N)) {
										
										try {
											
											audio_play_sound(_ar[0],_ar[1],_ar[2],_ar[3])
											
										} catch (_ex) {
											
											show_debug_message("[WARN: Anim K.END Actions] Unable to play sound: "+string(_ar))
											show_debug_message(_ex)
											
										}
										
									} else if(audio_exists(_ar)) audio_play_sound(_ar,4,F,2/3);
									
								}
								
							#endregion
							
						}
						
					}
					
				#endregion
				
			#endregion
			
		}
		
	}
	
}