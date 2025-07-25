/// @description Draw In Scene


if(D.scni == scni and !in_party(id) and !diaNar_in_focus(id)) {
	
	#region Init/Draw
		
		if(is(imgDia) and imgDia != sprNA) sprite_index = imgDia;
		else if(suited and is(imgSuit) and imgSuit != sprNA) sprite_index = imgSuit;
		else if(is(imgFace) and imgFace != sprNA) sprite_index = imgFace;
		else sprite_index = sprFlare;
		image_alpha = 1
		var scl = lerp(((D.href)/sprite_get_height(sprite_index))*.8,(D.href)/sprite_get_height(sprite_index),velSclPct)
		image_xscale = scl
		image_yscale = scl
		
		// FIX THIS, ADJUSTING CHAR'S IN SCENE POSITION FOR DEPTH EFFECT
		var _velSclo = velScl
		var _dltx = (D.bgImg.dltx*velScl)
		var _dlty = (D.bgImg.dlty*velScl)
		if(D.actorLeft == id) x = (WW*(1/5))+_dltx;
		else if(D.actorRight == id) x = (WW*(4/5))+_dltx;
		y = D.bgImg.bbox_bottom+((sprite_height*.2)*(1+(velScl-velSclMn)))
		velScl = _velSclo
		
		if(D.zo == D.z or (xpct == N and ypct == N)) {
			
			if(bbox_sanity(D.bgImg)) {
				
				xpct = (x-D.bgImg.bbox_left)/(D.bgImg.bbox_right-D.bgImg.bbox_left)
				ypct = (y-D.bgImg.bbox_top)/(D.bgImg.bbox_bottom-D.bgImg.bbox_top)
				
			}
			
		}
		
		if(D.zo != D.z) {
			
			if(bbox_sanity(D.bgImg)) {
				
				x = lerp(D.bgImg.bbox_left,D.bgImg.bbox_right,xpct)
				
			}
			
		}
		if(sprite_index != sprFlare) image_blend = D.scnBlend3;
		else image_blend = c.nr;
		if(y >= WH) depth = lerp(layer_get_depth("FG"),layer_get_depth("FGFade")+1,uid/(ds_list_size(D.actorL)-1));
		else depth = lerp(layer_get_depth("MG"),layer_get_depth("MGFade")+1,ruid/(ACTOR.LAST+(ds_list_size(D.actorL)-1)));
		
		if(!hide) draw_self();
		
	#endregion
	
	if(bbox_sanity(id)) {
		
		if(mouse_in_instance(id,F) and is_hover(id) and !hide) {
			
			#region Hovering...
				
				// Init
				if(D.isHvr != id and D.scnActSel != id) audio_play_sound_on(global.guiEmt,sfxUIHover,F,2,1);
				D.isHvr = id
				mouseIn = T
				if(D.scnActSel == id) {
					
					hvrPctO = 0
					hvrDeliO = hvrDelO
					
				} else {
					
					hvrPctO = D.hvrPct
					hvrDeliO = hvrDelO-(hvrDelO*hvrPctO)
					
				}
				
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
				
				#region Unselected Interaction
					
					if(D.scnActSel != id) {
						
						#region Select It
							
							var _xy4 = [max(0,bbox_left),max(1,bbox_top),min(WW-1,bbox_right),min(WH-1,bbox_bottom)]
							draw_rectangle_ext_color(_xy4,0,[.5,c.lgry,c.dgry,c.lgry,c.dgry],T)
							
							if(MBLR) {
								
								D.scnActSel = id // Select
								D.fd = 4
								
							}
							
						#endregion
						
					}
					
				#endregion
				
			#endregion
			
		} else if(!TRAN.override and !D.ctrlOverride and hvrPctO > 0) {
			
			#region Not Hovering: Fade out highlighting...
				
				if(D.isHvr == id) D.isHvr = N;
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
				
				if(D.isHvr == id) D.isHvr = N;
				mouseIn = F
				if(hvrDeliO < hvrDelO) hvrDeliO = clamp(hvrDeliO+1,0,hvrDelO);
				hvrPctO = 1-(hvrDeliO/hvrDelO)
				if(hvrPctO <= 0) surface_free(surf);
				
			#endregion
			
			#region Unselect
				
				if(MBLP and D.scnActSel == id) D.scnActSel = N;
				
			#endregion
			
		}
		
		if(D.scnActSel == id and !TRAN.override and !D.ctrlOverride and !hide) {
			
			#region Selected Interaction...
				
				var _xy4 = [max(0,bbox_left),max(1,bbox_top),min(WW-1,bbox_right),min(WH-1,bbox_bottom)]
				draw_rectangle_ext_color(_xy4,0,[.8,c.ng,c.g,c.ng,c.g],T)
				
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
						draw_button_fxl(_xy4Btn,[2/3,c.dgry,c.dgry,c.blk,c.blk],[1,c.ng,c.ng,c.g,c.g],"Approach",ACTION.DIA_APPROACH,diaAvailable)
						
					#endregion
					
					#region Move Past
						
						_xy4Btn[1] = _xy4Btn[3]+STRH
						_xy4Btn[3] = _xy4Btn[1]+(STRH*2)
						
						// Approach Button
						draw_button_fxl(_xy4Btn,[2/3,c.dgry,c.dgry,c.blk,c.blk],[1,c.ng,c.ng,c.g,c.g],"Move Past",ACTION.DIA_MOVEPAST,T)
						
					#endregion
					
					#region Cancel
						
						_xy4Btn[1] = _xy4Btn[3]+STRH
						_xy4Btn[3] = _xy4Btn[1]+(STRH*2)
						
						// Approach Button
						draw_button_fxl(_xy4Btn,[2/3,c.dgry,c.dgry,c.blk,c.blk],[1,c.ny,c.ny,c.ylw,c.ylw],"Cancel",ACTION.CANCEL,T)
						
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