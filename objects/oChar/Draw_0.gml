/// @description Draw In Scene
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.scni == scni and !in_party(id) and !diaNar_in_focus(id)) {
	
	#region Init/Draw
		
		if(is(imgDia) and imgDia != sprNA) sprite_index = imgDia;
		else if(suited and is(imgSuit) and imgSuit != sprNA) sprite_index = imgSuit;
		else if(is(imgFace) and imgFace != sprNA) sprite_index = imgFace;
		else sprite_index = sprFlare;
		image_alpha = 1
		var scl = (D.href)/sprite_get_height(sprite_index)
		image_xscale = scl
		image_yscale = scl
		if(D.actorLeft == id) x = (WW*(1/5))+D.bgImg.dltx;
		else if(D.actorRight == id) x = (WW*(4/5))+D.bgImg.dltx;
		y = D.bgImg.bbox_bottom+min(sprite_height*.2,sprite_yoffset)
		if(sprite_index != sprFlare) image_blend = D.scnBlend3;
		else image_blend = c.nr;
		if(uid != ACTOR.RANDOM) {
			
			depth = lerp(layer_get_depth("MG"),layer_get_depth("FG"),uid/(ds_list_size(D.actorL)-1))
			
		} else {
			
			depth = lerp(layer_get_depth("MG"),layer_get_depth("FG"),ruid/(ds_list_size(D.actorL)-1))+1
			
		}
		
		draw_self()
		
	#endregion
	
	if(bbox_sanity(id)) {
		
		if(mouse_in_instance(id,F) and is_hover(id)) {
			
			// Init
			D.isHvr = id
			mouseIn = T
			hvrPctO = D.hvrPct
			hvrDeliO = hvrDelO-(hvrDelO*hvrPctO)
			
			if(diaAvailable) {
				
				#region Shader Draw
					
					// Open Surface
					var created = F
					if(!surface_exists(surf)) {
						
						surf = surface_create(WW,WH);
						created = T
						
					}
					surface_set_target(surf)
						
						if(created) draw_clear_alpha(0,0);
						
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
					
				#endregion
				
			}
			
		} else if(D.focusL == N and !TRAN.override
			and !D.ctrlOverride and hvrPctO > 0) {
			
			if(hvrDeliO < hvrDelO) hvrDeliO = clamp(hvrDeliO+1,0,hvrDelO)
			hvrPctO = 1-(hvrDeliO/hvrDelO)
			
			// Init
			mouseIn = F
			
			#region Shader Draw
				
				// Open Surface
				var created = F
				if(!surface_exists(surf)) {
					
					surf = surface_create(WW,WH);
					created = T
					
				}
				surface_set_target(surf)
					
					if(created) draw_clear_alpha(0,0);
					
					shader_set(shWhite)
						
						if(MBL) {
							
							var _a = shader_get_uniform(shWhite,"alpha")
							shader_set_uniform_f(_a,hvrPctO/6)
							
						} else {
							
							var _a = shader_get_uniform(shWhite,"alpha")
							shader_set_uniform_f(_a,hvrPctO/5)
							
						}
						
						draw_self()
						
					shader_reset()
					
				// Finalize Surface
				surface_reset_target()
				draw_surface_ext(surf,0,0,1,1,0,col[3],hvrPctO)
				
			#endregion
			
		} else {
			
			mouseIn = F
			if(hvrDeliO < hvrDelO) hvrDeliO = clamp(hvrDeliO+1,0,hvrDelO);
			hvrPctO = 1-(hvrDeliO/hvrDelO)
			if(hvrPctO <= 0) surface_free(surf);
			
		}
		
	}
	
	// Reset Dialogue Available
	diaAvailable = (F or uid == ACTOR.RANDOM)
	
}