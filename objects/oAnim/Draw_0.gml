/// @description Animation
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY
    and D.scene_state == GAME.PLAY
    and D.animPlay = id
    and is(animStr)) {
	
	if(is(diaInst[$ NS[$ K.I]])) {
		
		#region Blackout
			
			draw_set_alpha(1)
			draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
			
		#endregion
		
		#region Apply Sprites...
			
			if(variable_instance_exists(diaInst,K.BD0+K.SPR)) {
				
				draw_sprite_ext(diaInst[$ K.BD0+K.SPR],0,xbd,ybd,image_xscale,image_yscale,0,c.wht,1)
				
			}
			
			if(variable_instance_exists(diaInst,K.SP0+K.SPR)) {
				
				draw_sprite_ext(diaInst[$ K.SP0+K.SPR],0,xship,yship,image_xscale/2,image_yscale/2,0,c.wht,1)
				
			}
			
			if(variable_instance_exists(diaInst,K.BG0+K.SPR)) {
				
				draw_sprite_ext(diaInst[$ K.BG0+K.SPR],0,xbg,ybg,image_xscale,image_yscale,0,c.wht,1)
				
			}
			
		#endregion
		
		draw_self()
		
		#region SKS Actions (Beginning Only)
			
			if(diaInst[$ NS[$ K.I]] == 0) {
				
				var sks = variable_instance_get_sorted_strKeys(diaInst,F)
				for(var i = 0; i < array_length(sks); i++) {
					
					#region SKS Names
						
						var _sndsp = K.SND+K.STP
						var _sndpl = K.SND+K.PLY
						
					#endregion
					
					// Init
					var k = sks[i]
					var v = diaInst[$ k]
					switch(k) {
						
						#region Sound
							
							case _sndsp:
								
								if(!is_array(v) and audio_exists(v)) {
									
									#region Single Sound Entry
										
										if(audio_is_playing(v)) {
											
											if(audio_sound_get_gain(v) >= 2/3) audio_sound_gain(v,0,4000);
											if(audio_sound_get_gain(v) <= 0) audio_stop_sound(v);
											
										}
										
										
									#endregion
									
								} else {
									
									#region Array Process TODO
										//TODO
									#endregion
									
								}
								
							break
							
							case _sndpl:
								
								if(!is_array(v) and audio_exists(v)) {
									
									#region Single Sound Entry
										
										if(!audio_is_playing(v)) {
											
											audio_play_sound(v,3,T,0)
											audio_sound_gain(v,2/3,4000)
											
										}
										
									#endregion
									
								} else {
									
									#region Array Process TODO
										//TODO
									#endregion
									
								}
								
							break
							
						#endregion
						
					}
					
				}
				
			}
			
		#endregion
		
		#region Anim End...
			
			var _nxt = N
			if(variable_instance_exists(diaInst,K.ANM+K.NXT)) _nxt = diaInst[$ K.ANM+K.NXT];
			if(diaInst[$ K.DN] and !is_string(_nxt)) TRAN.from_anim = id; // No Next Anim; Normal Close
			else if(diaInst[$ K.DN] and is_string(_nxt)) {
				
				diaNar_anim_start(_nxt)
				instance_destroy(id)
				
			}
			
		#endregion
		
	}
    
}