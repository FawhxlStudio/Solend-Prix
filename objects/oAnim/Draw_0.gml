/// @description Animation
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY
    and D.scene_state == GAME.PLAY
    and D.animPlay = id
    and is(animStr)) {
	
	if(is(NS[$ animStr][$ NS[$ K.I]])) {
		
		#region Apply Sprites...
			
			if(variable_instance_exists(NS[$ animStr],K.BD0+K.SPR)) {
				
				draw_sprite_ext(NS[$ animStr][$ K.BD0+K.SPR],0,xbd,ybd,image_xscale,image_yscale,0,c.wht,1)
				
			}
			if(variable_instance_exists(NS[$ animStr],K.SP0+K.SPR)) {
				
				draw_sprite_ext(NS[$ animStr][$ K.SP0+K.SPR],0,xship,yship,image_xscale/2,image_yscale/2,0,c.wht,1)
				
			}
			if(variable_instance_exists(NS[$ animStr],K.BG0+K.SPR)) {
				
				draw_sprite_ext(NS[$ animStr][$ K.BG0+K.SPR],0,xbg,ybg,image_xscale,image_yscale,0,c.wht,1)
				
			}
			
		#endregion
		
		draw_self()
		
		var rcnt = diaNar_get_line_count(NS[$ animStr])
		
		if(rcnt != N) {
			
			if(keyboard_check_pressed(vk_enter) and NS[$ K.I] < rcnt) NS[$ K.I] += 1
			else if(keyboard_check_pressed(vk_enter) and NS[$ K.I] >= rcnt) NS[$ animStr][$ K.DN] = T
			
		}
		
		if(NS[$ animStr][$ K.DN]) TRAN.from_anim = id;
		
	}
    
}