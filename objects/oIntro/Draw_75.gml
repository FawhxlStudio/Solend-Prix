/// @description Narration Draw

#region Draw Narration
	
	if(is(narSurf) and surface_exists(narSurf) and fadeIni >= fadeIn) {
		
		// Init Drawer
		if(!is(surfDrawer)) surfDrawer = instance_create_layer(0,0,"GUI",oDrawer);
		
		// Update Scroll
		var _pct = deli/del
		narY2 = -surface_get_height(narSurf)
		narY1 = lerp(WH,narY2,_pct)
		
		if(is(surfDrawer)) {
			
			// Update Drawer
			surfDrawer.surf = narSurf
			surfDrawer.surfX = 0
			surfDrawer.surfY = narY1
			
		}
		
	}
	
#endregion