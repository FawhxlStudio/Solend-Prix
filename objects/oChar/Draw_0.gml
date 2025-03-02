/// @description Draw In Scene
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.scni == scni and !in_party(id) and !diaNar_in_focus(id)) {
	
	if(D.actorLeft == id) {
		
		#region Init/Draw
			
			if(diaSpr) sprite_index = diaSpr;
			else if(suited) sprite_index = body;
			else sprite_index = head;
			image_alpha = 1
			var scl = (D.href)/sprite_get_height(sprite_index)
			image_xscale = scl
			image_yscale = scl
			x = ((WW)*(1/5))+D.bgImg.dltx
			y = D.bgImg.bbox_bottom
			image_blend = D.scnBlend3;
			draw_self()
			
		#endregion
		
		if(bbox_sanity(id)) {
			
			if(mouse_in_rectangle([bbox_left,bbox_top,bbox_right,bbox_bottom])
				 and D.focusL == N and !TRAN.override and !D.ctrlOverride
				 and is_hover(id)) {
				
				// Init
				D.isHvr = id
				mouseIn = T
				
				if(diaAvailable) {
					
					#region Shader Draw
						
						// Open Surface
						var surf = surface_create(WW,WH)
						surface_set_target(surf)
							
							shader_set(shWhite)
								
								if(MBL) {
									
									var _a = shader_get_uniform(shWhite,"alpha")
									shader_set_uniform_f(_a,D.hvrPct/6)
									
								} else {
									
									var _a = shader_get_uniform(shWhite,"alpha")
									shader_set_uniform_f(_a,D.hvrPct/5)
									
								}
								
								draw_self()
								
							shader_reset()
							
						// Finalize Surface
						surface_reset_target()
						draw_surface_ext(surf,0,0,1,1,0,col[1],1)
						surface_free(surf)
						
					#endregion
					
				} else D.isHvr = N;
				
			} else if(D.focusL == N and !TRAN.override
				and !D.ctrlOverride and D.hvrPct > 0) {
				
				// Init
				mouseIn = F
				
				#region Shader Draw
					
					// Open Surface
					var surf = surface_create(WW,WH)
					surface_set_target(surf)
						
						shader_set(shWhite)
							
							if(MBL) {
								
								var _a = shader_get_uniform(shWhite,"alpha")
								shader_set_uniform_f(_a,D.hvrPct/6)
								
							} else {
								
								var _a = shader_get_uniform(shWhite,"alpha")
								shader_set_uniform_f(_a,D.hvrPct/5)
								
							}
							
							draw_self()
							
						shader_reset()
						
					// Finalize Surface
					surface_reset_target()
					draw_surface_ext(surf,0,0,1,1,0,col[3],D.hvrPct)
					surface_free(surf)
					
				#endregion
				
			} else mouseIn = F;
			
		}
		
		// Reset Dialogue Available
		diaAvailable = F
		
	}
	
}