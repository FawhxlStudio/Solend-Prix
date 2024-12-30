/// @description Text
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY and D.scene_state == GAME.PLAY and D.animPlay = id and is(animStr)) {
	
	if(is(NS[$ animStr][$ NS[$ K.I]])) {
		
		if(!NS[$ animStr][$ K.DN]) {
			
			var _ani = NS[$ animStr]
			var _act = struct_find(_ani,K.ACT)
			
			if(!is_undefined(_act)) {
				
				var _actr = actor_find(_act)
				
				if(_actr != N) draw_set_font(_actr.font1);
				
			} else {
				
				draw_set_font(font)
				
			}
			
			text_prep_cc(NS[$ animStr][$ NS[$ K.I]])
			var xx = WW/2
			var yy = WH*(7/8)
			var xy = []
			xy[0] = xx-(strw_/2)-15
			xy[1] = yy-(strh_/2)-10
			xy[2] = xx+(strw_/2)+15
			xy[3] = yy+(strh_/2)+10
			draw_set_hvalign([fa_left,fa_top])
			var ao = draw_get_alpha()
			draw_set_alpha(bgc_[0])
			draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],bgc_[1],bgc_[2],bgc_[3],bgc_[4],F)
			draw_set_alpha(fgc_[0])
			var c1 = make_color_rgb(192,0,192)
			var c2 = make_color_rgb(128,0,128)
			draw_text_ext_color(xy[0],xy[1],strBld,STRH,strw_,c1,c1,c2,c2,1)
			draw_set_font(fNeu)
			if(strDeli >= strDel and strBld != NS[$ animStr][$ NS[$ K.I]]) {
				
				strBld += string_char_at(NS[$ animStr][$ NS[$ K.I]],string_length(strBld)+1)
				strDeli = 0
				
			} else strDeli++;
			if(keyboard_check_pressed(vk_enter)) {
				
				strBld = ""
				strDeli = 0
				
			}
			
			if(variable_instance_exists(NS[$ animStr],K.NM)) {
				
				var w = WW/3
				var h = (WH*.9)-1
				draw_set_font(fNeuB)
				var _w = string_width(NS[$ animStr][$ K.NM])
				var _h = string_height(NS[$ animStr][$ K.NM])
				xy[2] = xy[0]+_w+10
				xy[3] = xy[1]-_h-10
				draw_set_alpha(bgc_[0])
				draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],bgc_[1],bgc_[2],bgc_[3],bgc_[4],F)
				draw_set_alpha(ao)
				draw_set_hvalign([fa_left,fa_bottom])
				draw_text_color(xy[0]+5,xy[1]-5,NS[$ animStr][$ K.NM],c1,c1,c2,c2,1)
				draw_set_font(fNeu)
				
			}
			
		}
		
	}
	
}