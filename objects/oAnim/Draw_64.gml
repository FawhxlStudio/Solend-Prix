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
						diaNar_draw_dialogue(_ani,_actr,_ani[$ K.I],F)
						
					} else diaNar_draw_dialogue(_ani,N,_ani[$ K.I],F);
					
				#endregion
				
				#region Iterate Dialogue...
					
					var rcnt = diaNar_get_real_keys_count(_ani)
					if(rcnt != N and D.diaEnter) {
						
						if(_ani[$ K.I] < rcnt) _ani[$ K.I] += 1
						else if(_ani[$ K.I] >= rcnt) _ani[$ K.DN] = T
						
					}
					
				#endregion
				
			#endregion
			
		}
		
	}
	
}