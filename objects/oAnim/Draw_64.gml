/// @description Text
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state == GAME.PLAY and D.scene_state == GAME.PLAY and D.animPlay = id and is(animStr)) {
	
	if(is(NS[$ animStr][$ NS[$ K.I]])) {
		
		if(!NS[$ animStr][$ K.DN]) {
			
			
			draw_set_font(font)
			draw_set_hvalign([fa_center,fa_top])
			var ao = draw_get_alpha()
			draw_set_alpha(.8)
			draw_rectangle_color(0,WH*.9,WW,WH,c.blk,c.blk,c.dgry,c.dgry,F)
			draw_set_alpha(ao)
			draw_text_color(WW/2,WH*.92,NS[$ animStr][$ NS[$ K.I]],c.r,c.r,c.wht,c.wht,1)
			draw_set_font(fNeu)
			
			if(variable_instance_exists(NS[$ animStr],K.NM)) {
				
				var w = WW/3
				var h = (WH*.9)-1
				var _w = string_width(NS[$ animStr][$ K.NM])
				draw_set_alpha(.8)
				draw_rectangle_color(w-(_w/4),WH*.88-STRH,w+(_w*1.25),h,c.dgry,c.dgry,c.blk,c.blk,F)
				draw_set_alpha(ao)
				draw_set_font(fNeuB)
				draw_set_hvalign([fa_left,fa_middle])
				draw_text_color(w,(WH*.89)-(STRH/2),NS[$ animStr][$ K.NM],c.wht,c.wht,c.lgry,c.lgry,1)
				draw_set_font(fNeu)
				
			}
			
		}
		
	}
	
}