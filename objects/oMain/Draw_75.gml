/// @description Pause Menu

#region Game Paused?
	
	if(D.game_state == GAME.PAUSE) {
		
		#region Init Surface & Drawer Inst
			
			// Create Surface?
			var _created = F
			if(!is(pauseSurf) or !surface_exists(pauseSurf)) {
				
				pauseSurf = surface_create(WW,WH)
				_created = T
				
			}
			
			// Draw Object
			var _drawer = instance_create_layer(0,0,"GUI",oDrawer)
			
			// Set Surface Target + Reset
			surface_set_target(pauseSurf)
			if(_created) draw_clear_alpha(0,0);
			
		#endregion
		
		#region Draw Pause Menu
			
			
			
		#endregion
		
	}

#endregion
