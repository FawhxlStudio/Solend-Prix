/// @description Narration Pre-Draw

#region Prep Narration Surface
	
	if(!is(narSurf) or !surface_exists(narSurf)) {
		
		// Init Text
		var fo = draw_get_font()
		var hvo = draw_get_hvalign()
		var ao = draw_get_alpha()
		draw_set_font(fNarrator)
		draw_set_hvalign([fa_center,fa_top])
		draw_set_alpha(1)
		var _scl = WW/1920
		var _w = (WW*_scl)*(2/3)
		var _h = string_height_ext("|\n"+introStr+"\n|",STRH,_w)
		
		// Init Surface
		if(surface_exists(narSurf)) surface_free(narSurf);
		narSurf = surface_create(WW,_h)
		surface_set_target(narSurf)
		
		// Draw BG
		draw_rectangle_ext_color([WW*((1/3)/2),0,WW*((2/3)+((1/3)/2)),_h],0,[2/3,c.blk,c.blk,c.blk,c.blk],F)
		
		// Draw Narration
		draw_text_ext_transformed_color(WW/2,STRH,introStr,STRH,_w,_scl,_scl,0,c.wht,c.wht,c.gry,c.gry,1)
		
		// Reset Draw Stuff
		surface_reset_target()
		draw_set_font(fo)
		draw_set_hvalign(hvo)
		draw_set_alpha(ao)
		
	}
	
#endregion
