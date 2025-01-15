/// @description Draw In Scene
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.scni == scni and !in_party(id)) {
	
	if(D.actorLeft == id) {
		
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
		
		if(bbox_sanity(id)) {
			
			if(mouse_in_rectangle([bbox_left,bbox_top,bbox_right,bbox_bottom])
				 and D.focusL == N and !TRAN.override and !D.ctrlOverride
				 and is_hover(id)) {
				
				// Init
				D.isHvr = id
				mouseIn = T
				
				if(diaAvailable) {
					
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
					
				} else D.isHvr = N;
				
			} else mouseIn = F;
			
		}
		
		// Reset Dialogue Available
		diaAvailable = F
		
	}
	
}