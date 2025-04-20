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
		
		if(!hide) draw_self();
		
	#endregion
	
	if(bbox_sanity(id)) {
		
		if(mouse_in_instance(id,F) and is_hover(id) and !hide) {
			
			#region Hovering...
				
				// Init
				if(D.isHvr != id) audio_play_sound_on(guiEmt,sfxUIHover,F,2,1);
				D.isHvr = id
				mouseIn = T
				hvrPctO = D.hvrPct
				hvrDeliO = hvrDelO-(hvrDelO*hvrPctO)
				
				if(diaAvailable and D.scnActSel != id and !hide) {
					
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
				
				#region Select Interaction
					
					if(D.scnActSel != id) {
						
						#region Not selected...
							
							var _xy4 = [max(0,bbox_left),max(1,bbox_top),min(WW-1,bbox_right),min(WH-1,bbox_bottom)]
							draw_rectangle_ext_color(_xy4,0,[.5,c.lgry,c.dgry,c.lgry,c.dgry],T)
							
							if(MBLR) D.scnActSel = id; // Select
							
						#endregion
						
					}
					
				#endregion
				
			#endregion
			
		} else if(!TRAN.override and !D.ctrlOverride and hvrPctO > 0 and !hide) {
			
			#region Not Hovering: Fade out highlighting...
				
				if(hvrDeliO < hvrDelO) hvrDeliO = clamp(hvrDeliO+1,0,hvrDelO)
				if(D.scnActSel == id) hvrDeliO = hvrDelO; // If selected get rid of shader
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
				
			#endregion
			
		} else {
			
			#region Not Hovering: Faded Out...
				
				mouseIn = F
				if(hvrDeliO < hvrDelO) hvrDeliO = clamp(hvrDeliO+1,0,hvrDelO);
				hvrPctO = 1-(hvrDeliO/hvrDelO)
				if(hvrPctO <= 0) surface_free(surf);
				
			#endregion
			
		}
		
		if(D.scnActSel == id and !TRAN.override and !D.ctrlOverride and !hide) {
			
			#region Selected...
				
				var _xy4 = [max(0,bbox_left),max(1,bbox_top),min(WW-1,bbox_right),min(WH-1,bbox_bottom)]
				draw_rectangle_ext_color(_xy4,0,[.8,c.ng,c.g,c.ng,c.g],T)
				
				if(MBRR) D.scnActSel = N; // Unselect
				
				#region Draw Selection Choices
					
					// Draw Init
					var fo = draw_get_font()
					var hvo = draw_get_hvalign()
					draw_set_font(fHUD)
					draw_set_hvalign([fa_center,fa_middle])
					
					#region Approach
						
						var _xy4Btn = _xy4
						_xy4Btn[0] = lerp(bbox_left,bbox_right,1/3)
						_xy4Btn[1] = lerp(bbox_top,bbox_bottom,1/3)
						_xy4Btn[2] = lerp(bbox_left,bbox_right,2/3)
						_xy4Btn[3] = _xy4Btn[1]+(STRH*2)
						
						// Approach Button
						draw_button_fxl(_xy4Btn,[.8,c.dgry,c.dgry,c.blk,c.blk],[1,c.ng,c.g,c.ng,c.g],"Approach",ACTION.DIA_APPROACH,diaAvailable)
						
					#endregion
					
					#region Move Past
						
						_xy4Btn[1] = _xy4Btn[3]+STRH
						_xy4Btn[3] = _xy4Btn[1]+(STRH*2)
						
						// Approach Button
						draw_button_fxl(_xy4Btn,[.8,c.dgry,c.dgry,c.blk,c.blk],[1,c.ng,c.g,c.ng,c.g],"Move Past",ACTION.DIA_MOVEPAST,T)
						
					#endregion
					
					// Draw Reset
					draw_set_font(fo)
					draw_set_hvalign(hvo)
					
				#endregion
				
			#endregion
			
		}
		
	}
	
	// Reset Dialogue Available
	diaAvailable = (F or uid == ACTOR.RANDOM)
	
}