/// @description Surface Inits

#region Init/Draw Load Surface
	
	if(is_undefined(loadSurf)) {
		
		// Create Surface...
		loadSurf = surface_create(WW,WH)
		surface_set_target(loadSurf)
		
		#region Draw Loading Surface
			
			// Draw BG Fade
			draw_rectangle_ext_color([0,0,WW,WH],0,[.8,c.blk,c.blk,c.blk,c.blk],F)
			
			// Init Text
			draw_set_font(fTitle)
			draw_set_hvalign([fa_center,fa_middle])
			var _str = "LOADING"
			var _w = WW/2
			
			// Draw Text
			draw_text_transformed_color(WW/2,WH/2,_str,.5,.5,0,c.wht,c.wht,c.gry,c.gry,1)
			
		#endregion
		
		// Reset Surface Target
		surface_reset_target()
		
	}
	
#endregion