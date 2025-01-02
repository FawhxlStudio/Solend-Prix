/// @description Text
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY and D.scene_state == GAME.PLAY and D.animPlay = id and is(animStr)) {
	
	if(is(NS[$ animStr][$ NS[$ K.I]])) {
		
		if(!NS[$ animStr][$ K.DN]) {
			
			#region Draw Dialogue
				
				#region Init
					
					var _ani = NS[$ animStr]
					if(!variable_instance_exists(_ani,K.I)) _ani[$ K.I] = 0;
					var _act = struct_find(_ani,K.ACT)
					D.diaEnter = F
					
				#endregion
				
				#region Get Font from Actor UID
					
					if(!is_undefined(_act)) {
						
						var _actr = actor_find(_act)
						diaNar_draw_dialogue(_ani,_actr,_ani[$ K.I])
						
					} else diaNar_draw_dialogue(_ani,N,_ani[$ K.I]);
					
				#endregion
				
				#region Iterate Dialogue...
					
					var rcnt = diaNar_get_real_keys_count(NS[$ animStr])
					if(rcnt != N and D.diaEnter) {
						
						if(keyboard_check_pressed(vk_enter) and NS[$ K.I] < rcnt) NS[$ K.I] += 1
						else if(keyboard_check_pressed(vk_enter) and NS[$ K.I] >= rcnt) NS[$ animStr][$ K.DN] = T
						
					}
					
				#endregion
				
			#endregion
			
		}
		
	}
	
}