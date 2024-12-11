/// @description Draw In Scene
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.scni == scni) {
	
	if(D.actorLeft == id) {
		
		sprite_index = body
		image_alpha = 1
		var scl = ((WW*D.z)*(2/3))/sprite_get_width(body)
		image_xscale = scl
		image_yscale = scl
		x = ((WW*D.z)*(1/3))+D.bgdltx
		y = ((WH*D.z))+D.bgdlty
		image_blend = D.scnBlend3;
		draw_self()
		
		if(bbox_sanity(id)) {
			
			if(mouse_in_rectangle([bbox_left,bbox_top,bbox_right,bbox_bottom])
				 and D.focusL == N and !TRAN.override and !D.ctrlOverride) {
				
				D.isHvr = T
				mouseIn = T
				
				#region Shader Draw
					
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
					
				#endregion
				
			} else mouseIn = F;
			
		}
		
	}
	
}