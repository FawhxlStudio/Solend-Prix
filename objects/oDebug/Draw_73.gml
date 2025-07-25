/// @description Editor


#region Editor Controls and Drawing
	
	#region Debug XY Struct Logic || Dev Tool || For plotting Interaction nodes throught scenes into a json file (much needed) || Available during debug
		
		if(!variable_instance_exists(ES,string(ESi)) or ES[$ string(ESi)] == N)
			ES[$ string(ESi)] = {} // Init Next Entry
		else {
			
			#region Debug XY Struct Editing Active || Entry Creation & Draw Logic
				
				// Toggle Debug XY Struct Editing...
				if(keyboard_check_pressed(vk_home)) edit = !edit
				
				if(edit) {
					
					#region Debug Scene Jump/TP Logic (+/- keys)
						
						if(scnJump) {
							
							if(keyboard_check_pressed(vk_subtract)) {
								
								if(keyboard_check(vk_shift)) {
									
									// Region Jump Down
									if(D.scni <= SCENE.CITY_PLAZA) set_scni(SCENE.RESORT_BED);
									else if(D.scni <= SCENE.CLUB_ENT) set_scni(SCENE.CITY_PLAZA);
									else if(D.scni <= SCENE.BROTH_ENT) set_scni(SCENE.CLUB_ENT);
									else if(D.scni <= SCENE.SPACEPORT_ENT) set_scni(SCENE.BROTH_ENT);
									else if(D.scni <= SCENE.SLUM_A1) set_scni(SCENE.SPACEPORT_ENT);
									else if(D.scni <= SCENE.COCKPIT_PRAEY) set_scni(SCENE.SLUM_A1);
									
								} else set_scni(D.scni-1); // Iterate 1 Scene Down
								
							} else if(keyboard_check_pressed(vk_add)) {
								
								if(keyboard_check(vk_shift)) {
									
									// Region Jump Up
									if(D.scni <= SCENE.RESORT_COURT1) set_scni(SCENE.RESORT_COURT2);
									else if(D.scni <= SCENE.CITY_ST4) set_scni(SCENE.CITY_STORE);
									else if(D.scni <= SCENE.BROTH_G2) set_scni(SCENE.BROTH_B);
									else if(D.scni <= SCENE.SPACEPORT_HANG1) set_scni(SCENE.SPACEPORT_HANG2);
									else if(D.scni <= SCENE.SLUM_A3) set_scni(SCENE.SLUM_BOD);
									else if(D.scni <= SCENE.COCKPIT_PRAEY) set_scni(SCENE.COCKPIT_PRAEY);
									
								} else set_scni(D.scni+1); // Iterate 1 Scene Up
								
							}
							
						}
						
					#endregion
					
					#region Debug XY Struct Editing Other Controls
						
						// If we MBMP outside all entries, this effectively acts as a deselect...
						if(MBMP) ESsel = N
						
						if(keyboard_check_pressed(vk_pageup)) {
							
							// Iterate to next entry/instance of ES(struct of structs) in debug viewer
							if(ESi2 >= variable_instance_names_count(ES)) ESi2 = 0
							else ESi2 += 1
							
						} else if(keyboard_check_pressed(vk_pagedown)) {
							
							// Iterate to previous entry/instance of ES(struct of structs) in debug viewer
							if(ESi2 <= 0) ESi2 = variable_instance_names_count(ES)
							else ESi2 -= 1
							
						} else if(keyboard_check_pressed(vk_delete)) {
							
							if(ESsel != N) ES[$ string(ESsel)] = N
							
						}
						
					#endregion
						
					#region XY Marker... (Idk why xy is mouse is drifted... FIXED but still used...)
						
						if(ds_list_empty(D.diaParL)) {
							
							var _dw2 = (D.bgImg.sprite_width-WW)/2
							var _dh2 = (D.bgImg.sprite_height-WH)/2
							
							// Init (First coordinate)
							var _xy4 = [MXPCT*D.bgImg.sprite_width+D.bgImg.dltx-_dw2,
								MYPCT*D.bgImg.sprite_height+D.bgImg.dlty-_dh2]
							
							draw_set_alpha(1)
							draw_circle_color(_xy4[0],_xy4[1],5,c.wht,c.blk,F)
							
						}
						
					#endregion
					
					#region Rectangle Entry (Left Click 2x for opposite corners to set)
						
						if(MBLP and ds_list_empty(D.diaParL)) {
							
							#region Init Rectangle Entry (If New)
								
								if(!variable_instance_exists(ES[$ string(ESi)],K.SCN+K.IN)) {
									
									ES[$ string(ESi)][$ K.SCN+K.IN] = D.scni
									ES[$ string(ESi)][$ K.SHP] = "rect"
									ES[$ string(ESi)][$ K.FND] = F
									ES[$ string(ESi)][$ K.HVR] = F
									ES[$ string(ESi)][$ K.HLT] = F
									
								}
								
							#endregion
							
							#region Set Coordinates
								
								// Ensure is Rectangle otherwise don'T do anything
								if(ES[$ string(ESi)][$ K.SHP] == "rect") {
									
									if(!variable_instance_exists(ES[$ string(ESi)],K.XY4)) {
										
										// Set First Coordinate if xy4 doesn'T even exist
										ES[$ string(ESi)][$ K.XY4] = [MXPCT,MYPCT]
										ES[$ string(ESi)][$ K.WH2]  = [D.bgImg.sprite_width,D.bgImg.sprite_height]
										
									} else if(array_length(ES[$ string(ESi)][$ K.XY4]) == 2) {
										
										// xy4 exists and is size 2, so we set the 2nd coordinate
										ES[$ string(ESi)][$ K.XY4][2] = MXPCT
										ES[$ string(ESi)][$ K.XY4][3] = MYPCT
										
										// With 2nd Coordinate set, this entry is done aside from str entry
										// We iterate ESi to go on to make the next entry
										ESi += 1
										
									}
									
								}
								
							#endregion
							
						}
						
					#endregion
					
					#region Circle Entry (Right Click + Drag to set w/ size) (Like a Node)
						
						if(MBR and ds_list_empty(D.diaParL)) {
							
							if(MBRP) {
								
								#region Init Circle Entry (Should be new /*#as this*/ is all done with one click+drag)
									
									if(!variable_instance_exists(ES[$ string(ESi)],K.SCN+K.IN)) {
										
										ES[$ string(ESi)][$ K.SCN+K.IN] = D.scni
										ES[$ string(ESi)][$ K.SHP] = "circ"
										ES[$ string(ESi)][$ K.FND] = F
										ES[$ string(ESi)][$ K.HVR] = F
										ES[$ string(ESi)][$ K.HLT] = F
										ES[$ string(ESi)][$ K.XY2] = [MXPCT,MYPCT]
										ES[$ string(ESi)][$ K.WH2]  = [D.bgImg.sprite_width,D.bgImg.sprite_height]
										ES[$ string(ESi)][$ K.RAD]  = 0
										
									}
									
								#endregion
								
							}
							
							#region Set circle size (RMB + Drag)
								
								// Ensure is Circle, otherwise don'T do anything
								if(ES[$ string(ESi)][$ K.SHP] == "circ") {
									
									var _dw2 = (D.bgImg.sprite_width-WW)/2
									var _dh2 = (D.bgImg.sprite_height-WH)/2
									
									// Init xy2
									var _xy2 = [ES[$ string(ESi)][$ K.XY2][0]*ES[$ string(ESi)][$ K.WH2][0]+D.bgImg.dltx-_dw2,
										ES[$ string(ESi)][$ K.XY2][1]*ES[$ string(ESi)][$ K.WH2][1]+D.bgImg.dlty-_dh2]
									
									// Adjust Radius/Size based on distance from initial click
									ES[$ string(ESi)][$ K.RAD] = point_distance(WMX,WMY,_xy2[0],_xy2[1])
									
								}
								
							#endregion
							
						} else if(MBRR) {
							
							#region Iterate/finish circle entry (RMB Release)
								
								if(variable_instance_exists(ES[$ string(ESi)],K.SCN+K.IN))
									if(ES[$ string(ESi)][$ K.SHP] == "circ")
										ESi += 1
								
							#endregion
							
						}
						
					#endregion
					
					#region Draw Each Debug XY Entry per room & Edit/Control Logic
						
						// Init Font
						var fo = draw_get_font()
						draw_set_font(fDebug)
						
						// Loop through all the entries in ES
						// (a struct of structs, each struct an entry with relevant data)
						for(var i = 0; i < variable_instance_names_count(ES); i++) {
							
							// Skip deleted entries
							if(!is(ES[$ string(i)])) continue
							
							// Is it an actual entry yet? If K.SCN+K.IN ain'T set then it ain'T defined at all yet
							if(variable_instance_exists(ES[$ string(i)],K.SCN+K.IN)) {
								
								#region Ensure Toggle Variable Instances Exist in all entries
									
									if(!variable_instance_exists(ES[$ string(i)],K.FND))
										ES[$ string(i)][$ K.FND] = F
									if(!variable_instance_exists(ES[$ string(i)],K.HVR))
										ES[$ string(i)][$ K.HVR] = F
									if(!variable_instance_exists(ES[$ string(i)],K.HLT))
										ES[$ string(i)][$ K.HLT] = F
									if(!variable_instance_exists(ES[$ string(i)],K.DTR))
										ES[$ string(i)][$ K.DTR] = F
									
								#endregion
								
								#region Scene WH Sanity
									
									if(variable_instance_exists(ES[$ string(i)],K.WH2))
										ES[$ string(i)][$ K.WH2] = [D.bgImg.sprite_width,D.bgImg.sprite_height]
									
								#endregion
								
								#region Are we in the room?
									
									if(ES[$ string(i)][$ K.SCN+K.IN] == D.scni) {
										
										#region What shape? Circle or Rectangle?
											
											if(variable_instance_exists(ES[$ string(i)],K.SHP)) {
												
												if(ES[$ string(i)][$ K.SHP] == "rect") {
													
													#region Draw Debug XY Rectangles
														
														if(variable_instance_exists(ES[$ string(i)],K.XY4)) {
															
															#region Init
																
																var _dw2 = (D.bgImg.sprite_width-WW)/2
																var _dh2 = (D.bgImg.sprite_height-WH)/2
																
																// Init (First coordinate)
																var _xy4 = [ES[$ string(i)][$ K.XY4][0]*ES[$ string(i)][$ K.WH2][0]+D.bgImg.dltx-_dw2,
																	ES[$ string(i)][$ K.XY4][1]*ES[$ string(i)][$ K.WH2][1]+D.bgImg.dlty-_dh2]
																
																// Draw First Coordinate
																draw_circle_color(_xy4[0],_xy4[1],5,c_white,c_white,F)
																
															#endregion
															
															#region 2nd Coordinate?
																
																if(array_length(ES[$ string(i)][$ K.XY4]) == 4) {
																	
																	#region Do have 2nd Coordinate, Full Draw
																		
																		// Init 2nd Coordinate
																		_xy4[2] = ES[$ string(i)][$ K.XY4][2]*ES[$ string(i)][$ K.WH2][0]+D.bgImg.dltx-_dw2
																		_xy4[3] = ES[$ string(i)][$ K.XY4][3]*ES[$ string(i)][$ K.WH2][1]+D.bgImg.dlty-_dh2
																		
																		// Draw 2nd Coor
																		draw_circle_color(_xy4[2],_xy4[3],5,c_white,c_white,F)
																		
																		// If inside rectangle, select w/ middle mouse button
																		if(mouse_in_rectangle(_xy4) and MBMP) {
																			
																			keyboard_string = ""
																			ESsel = i
																			ESi2 = i
																			
																		}
																		
																		// set rect alpha 20%
																		var ao = draw_get_alpha()
																		draw_set_alpha(1/5)
																		
																		// Selected or not?
																		if(ESsel == i) {
																			
																			// Selected (yellow)
																			draw_rectangle_color(_xy4[0],_xy4[1],_xy4[2],_xy4[3],
																				c.ylw,c.ylw,c.ylw,c.ylw,F)
																			
																		} else if(i == ESi2) {
																			
																			// Debug Display (red)
																			draw_rectangle_color(_xy4[0],_xy4[1],_xy4[2],_xy4[3],
																				c.r,c.r,c.r,c.r,F)
																			
																		} else {
																			
																			// Unselected (white)
																			draw_rectangle_color(_xy4[0],_xy4[1],_xy4[2],_xy4[3],
																				c.wht,c.wht,c.wht,c.wht,F)
																			
																		}
																		
																		#region Draw Additional Vars
																			
																			// Init
																			var hvo = [draw_get_halign(),draw_get_valign()]
																			draw_set_hvalign([fa_center,fa_middle])
																			var _str = ""
																			var _str2 = ""
																			
																			#region Basics
																				
																				#region String Draw
																					
																					if(variable_instance_exists(ES[$ string(i)],K.STR)) {
																						
																						if(_str != "") _str += "\n"
																						_str += "str: \""+ES[$ string(i)][$ K.STR]+"\""
																						
																					}
																					
																				#endregion
																				
																				#region To_Room
																					
																					if(variable_instance_exists(ES[$ string(i)],K.SCN+K.TO)) {
																						
																						if(_str != "") _str += "\n"
																						if(!is_string_real(ES[$ string(i)][$ K.SCN+K.TO])) _str += "scene_to: "+string(ES[$ string(i)][$ K.SCN+K.TO]);
																						else _str += "scene_to: "+string(ES[$ string(i)][$ K.SCN+K.TO])+"("+global.SCENEn[real(ES[$ string(i)][$ K.SCN+K.TO])]+")";
																						
																					}
																					
																				#endregion
																				
																			#endregion
																			
																			#region Toggles
																				
																				#region Find?
																					
																					if(variable_instance_exists(ES[$ string(i)],K.FND)) {
																						
																						if(ES[$ string(i)][$ K.FND]) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Must Find"
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Hilight?
																					
																					if(variable_instance_exists(ES[$ string(i)],K.HLT)) {
																						
																						if(ES[$ string(i)][$ K.HLT]) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Highlights"
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Hover?
																					
																					if(variable_instance_exists(ES[$ string(i)],K.HVR)) {
																						
																						if(ES[$ string(i)][$ K.HVR]) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Hover"
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Destroy?
																					
																					if(variable_instance_exists(ES[$ string(i)],K.DTR)) {
																						
																						if(ES[$ string(i)][$ K.DTR]) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Destroy"
																							
																						}
																						
																					}
																					
																				#endregion
																				
																			#endregion
																			
																			// Add to _str
																			if(_str2 != "") _str += "\n"+_str2
																			_str2 = "" // Reset
																			
																			#region Timer/Delay
																				
																				#region Timer
																					
																					if(variable_instance_exists(ES[$ string(i)],K.TMR)) {
																						
																						if(ES[$ string(i)][$ K.TMR] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Timer: "+string(ES[$ string(i)][$ K.TMR])
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Delay
																					
																					if(variable_instance_exists(ES[$ string(i)],K.DL)) {
																						
																						if(ES[$ string(i)][$ K.DL] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Delay: "+string(ES[$ string(i)][$ K.DL])
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region X Offset
																					
																					if(variable_instance_exists(ES[$ string(i)],K.XOF)) {
																						
																						if(ES[$ string(i)][$ K.XOF] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "X Offset: "+string(ES[$ string(i)][$ K.XOF])
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Y Offset
																					
																					if(variable_instance_exists(ES[$ string(i)],K.YOF)) {
																						
																						if(ES[$ string(i)][$ K.YOF] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Y Offset: "+string(ES[$ string(i)][$ K.YOF])
																							
																						}
																						
																					}
																					
																				#endregion
																				
																			#endregion
																			
																			// Add to _str
																			if(_str2 != "") _str += "\n"+_str2
																			_str2 = "" // Reset
																			
																			#region Assets
																			
																				#region Animation (A sprite w/ frames)
																					
																					if(variable_instance_exists(ES[$ string(i)],K.ANM)) {
																						
																						if(ES[$ string(i)][$ K.ANM] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Anim: \""+string(ES[$ string(i)][$ K.ANM])+"\""
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Sprite
																					
																					if(variable_instance_exists(ES[$ string(i)],K.SPR)) {
																						
																						if(ES[$ string(i)][$ K.SPR] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "Sprite: \""+string(ES[$ string(i)][$ K.SPR])+"\""
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Sound
																					
																					if(variable_instance_exists(ES[$ string(i)],K.SND)) {
																						
																						if(ES[$ string(i)][$ K.SND] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							_str2 += "SFX: \""+string(ES[$ string(i)][$ K.SND])+"\""
																							
																						}
																						
																					}
																					
																				#endregion
																				
																			#endregion
																			
																			// Add to _str
																			if(_str2 != "") _str += "\n"+_str2
																			_str2 = "" // Reset
																			
																			#region Assets 2
																				
																				#region Entity
																					
																					if(variable_instance_exists(ES[$ string(i)],K.ENT)) {
																						
																						if(ES[$ string(i)][$ K.ENT] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							if(!is_string_real(ES[$ string(i)][$ K.ENT])) _str2 += "Entity: \""+string(ES[$ string(i)][$ K.ENT])+"\"";
																							else _str2 += "Entity: "+string(ES[$ string(i)][$ K.ENT])+"("+global.ACTORn[real(ES[$ string(i)][$ K.ENT])]+")";
																							// If real, points to an actor, otherwise string could be anything else...
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Click
																					
																					if(variable_instance_exists(ES[$ string(i)],K.CLK)) {
																						
																						if(ES[$ string(i)][$ K.CLK] != N) {
																							
																							if(_str2 != "") _str2 += ", ";
																							if(!is_string_real(ES[$ string(i)][$ K.CLK])) _str2 += "Click: "+string(ES[$ string(i)][$ K.CLK]);
																							else _str2 += "Click: "+string(ES[$ string(i)][$ K.CLK])+"("+global.Vn[real(ES[$ string(i)][$ K.CLK])]+")";
																							
																						}
																						
																					}
																					
																				#endregion
																				
																				#region Surface
																					
																					if(variable_instance_exists(ES[$ string(i)],K.SRF)) {
																						
																						if(ES[$ string(i)][$ K.SRF] != N) {
																							
																							if(_str2 != "") _str2 += ", "
																							if(!is_string_real(ES[$ string(i)][$ K.SRF])) _str2 += "Surface: \""+string(ES[$ string(i)][$ K.SRF])+"\"";
																							else _str2 += "Surface: "+string(ES[$ string(i)][$ K.SRF]);
																							// If real, just show number...
																							
																						}
																						
																					}
																					
																				#endregion
																				
																			#endregion
																			
																			// Add to _str
																			if(_str2 != "") _str += "\n"+_str2
																			_str2 = "" // Reset
																			
																			// Draw and Reset
																			var _xx = lerp(_xy4[0],_xy4[2],1/2)
																			var _yy = lerp(_xy4[1],_xy4[3],1/2)
																			draw_text_color(_xx,_yy,_str,c.wht,c.wht,c.wht,c.wht,1)
																			draw_set_hvalign(hvo)
																			
																		#endregion
																		
																		// Reset alpha
																		draw_set_alpha(ao)
																		
																	#endregion
																	
																} else {
																	
																	#region No 2nd Entry yet... Maybe we want to cancel?
																		
																		// Don'T have 2nd Coordinate?
																		if(keyboard_check_pressed(vk_backspace)) {
																			
																			// Delete/Cancel this Entry
																			ES[$ string(i)] = N
																			
																		}
																		
																	#endregion
																	
																}
																
															#endregion
															
														}
														
													#endregion
													
												} else if(ES[$ string(i)][$ K.SHP] == "circ") {
													
													#region Draw Debug XY Circles
														
														#region Inits
															
															var _dw2 = (D.bgImg.sprite_width-WW)/2
															var _dh2 = (D.bgImg.sprite_height-WH)/2
															
															var _xy2 = [ES[$ string(i)][$ K.XY2][0]*ES[$ string(i)][$ K.WH2][0]+D.bgImg.dltx-_dw2,
																ES[$ string(i)][$ K.XY2][1]*ES[$ string(i)][$ K.WH2][1]+D.bgImg.dlty-_dh2]
															var _rad = real(ES[$ string(i)][$ K.RAD])
															
															// Draw Coordinate
															draw_circle_color(_xy2[0],_xy2[1],3,c.r,c.r,F)
															
															// Selected?
															if(mouse_in_circle(_xy2,_rad) and MBMP) {
																
																keyboard_string = ""
																ESsel = i
																ESi2 = i
																
															}
															
															// set rect alpha 20%
															var ao = draw_get_alpha()
															draw_set_alpha(1/5)
															
														#endregion
														
														#region Draw Radius
															
															if(i == ESsel) {
																
																// Selected, Draw Yellow
																// Draw Radius (Hilight)
																draw_circle_color(_xy2[0],_xy2[1],_rad,c.ylw,c.ylw,F)
																
															} else if(i == ESi2) {
																
																// Displayed in Debug, Draw Red
																// Draw Radius (Hilight)
																draw_circle_color(_xy2[0],_xy2[1],_rad,c.r,c.r,F)
																
															} else {
																
																// Unselected, Draw White
																// Draw Radius (Hilight)
																draw_circle_color(_xy2[0],_xy2[1],_rad,c.wht,c.wht,F)
																
															}
															
														#endregion
														
														#region Draw Additional Vars
															
															// Init
															var hvo = [draw_get_halign(),draw_get_valign()]
															draw_set_hvalign([fa_center,fa_middle])
															var _str = ""
															var _str2 = ""
															
															#region Basics
																
																// String Draw
																if(variable_instance_exists(ES[$ string(i)],K.STR)) {
																	
																	if(_str != "") _str += "\n"
																	_str += "str: \""+ES[$ string(i)][$ K.STR]+"\""
																	
																}
																
																// To_Room
																if(variable_instance_exists(ES[$ string(i)],K.SCN+K.TO)) {
																	
																	if(_str != "") _str += "\n"
																	if(!is_string_real(ES[$ string(i)][$ K.SCN+K.TO])) _str += "scene_to: "+string(ES[$ string(i)][$ K.SCN+K.TO]);
																	else _str += "scene_to: "+string(ES[$ string(i)][$ K.SCN+K.TO])+"("+global.SCENEn[real(ES[$ string(i)][$ K.SCN+K.TO])]+")";
																	
																}
																
															#endregion
															
															#region Toggles
																
																// Find?
																if(variable_instance_exists(ES[$ string(i)],K.FND)) {
																	
																	if(ES[$ string(i)][$ K.FND]) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "Must Find"
																		
																	}
																	
																}
																
																// Hilight?
																if(variable_instance_exists(ES[$ string(i)],K.HLT)) {
																	
																	if(ES[$ string(i)][$ K.HLT]) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "Highlights"
																		
																	}
																	
																}
																
																// Hover?
																if(variable_instance_exists(ES[$ string(i)],K.HVR)) {
																	
																	if(ES[$ string(i)][$ K.HVR]) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "Hover"
																		
																	}
																	
																}
																
																// Destroy?
																if(variable_instance_exists(ES[$ string(i)],K.DTR)) {
																	
																	if(ES[$ string(i)][$ K.DTR]) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "Destroy"
																		
																	}
																	
																}
																
															#endregion
															
															// Add to _str
															if(_str2 != "") _str += "\n"+_str2
															_str2 = "" // Reset
															
															#region Timer/Delay
																
																// Timer
																if(variable_instance_exists(ES[$ string(i)],K.TMR)) {
																	
																	if(ES[$ string(i)][$ K.TMR] != N) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "Timer: "+string(ES[$ string(i)][$ K.TMR])
																		
																	}
																	
																}
																
																// Delay
																if(variable_instance_exists(ES[$ string(i)],K.DL)) {
																	
																	if(ES[$ string(i)][$ K.DL] != N) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "Delay: " + string(ES[$ string(i)][$ K.DL])
																		
																	}
																	
																}
																
																#region X Offset
																	
																	if(variable_instance_exists(ES[$ string(i)],K.XOF)) {
																		
																		if(ES[$ string(i)][$ K.XOF] != N) {
																			
																			if(_str2 != "") _str2 += ", "
																			_str2 += "X Offset: "+string(ES[$ string(i)][$ K.XOF])
																			
																		}
																		
																	}
																	
																#endregion
																
																#region Y Offset
																	
																	if(variable_instance_exists(ES[$ string(i)],K.YOF)) {
																		
																		if(ES[$ string(i)][$ K.YOF] != N) {
																			
																			if(_str2 != "") _str2 += ", "
																			_str2 += "Y Offset: "+string(ES[$ string(i)][$ K.YOF])
																			
																		}
																		
																	}
																	
																#endregion
																
															#endregion
															
															// Add to _str
															if(_str2 != "") _str += "\n"+_str2
															_str2 = "" // Reset
															
															#region Assets
															
																// Animation (A sprite w/ frames)
																if(variable_instance_exists(ES[$ string(i)],K.ANM)) {
																	
																	if(ES[$ string(i)][$ K.ANM] != N) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "Anim: " + string(ES[$ string(i)][$ K.ANM])
																		
																	}
																	
																}
																
																// Sprite
																if(variable_instance_exists(ES[$ string(i)],K.SPR)) {
																	
																	if(ES[$ string(i)][$ K.SPR] != N) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "Sprite: " + string(ES[$ string(i)][$ K.SPR])
																		
																	}
																	
																}
																
																// Sound
																if(variable_instance_exists(ES[$ string(i)],K.SND)) {
																	
																	if(ES[$ string(i)][$ K.SND] != N) {
																		
																		if(_str2 != "") _str2 += ", "
																		_str2 += "SFX: " + string(ES[$ string(i)][$ K.SND])
																		
																	}
																	
																}
																
															#endregion
															
															// Add to _str
															if(_str2 != "") _str += "\n"+_str2
															_str2 = "" // Reset
															
															#region Assets 2
																
																// Entity
																if(variable_instance_exists(ES[$ string(i)],K.ENT)) {
																	
																	if(ES[$ string(i)][$ K.ENT] != N) {
																		
																		if(_str2 != "") _str2 += ", "
																		if(!is_string_real(ES[$ string(i)][$ K.ENT])) _str2 += "Entity: \""+string(ES[$ string(i)][$ K.ENT])+"\"";
																		else _str2 += "Entity: "+string(ES[$ string(i)][$ K.ENT])+"("+global.ACTORn[real(ES[$ string(i)][$ K.ENT])]+")";
																		// If real, points to an actor, otherwise string could be anything else...
																		
																	}
																	
																}
																
																// Click
																if(variable_instance_exists(ES[$ string(i)],K.CLK)) {
																	
																	if(ES[$ string(i)][$ K.CLK] != N) {
																		
																		if(_str2 != "") _str2 += ", ";
																		if(!is_string_real(ES[$ string(i)][$ K.CLK])) _str2 += "Click: "+string(ES[$ string(i)][$ K.CLK]);
																		else _str2 += "Click: "+string(ES[$ string(i)][$ K.CLK])+"("+global.Vn[real(ES[$ string(i)][$ K.CLK])]+")";
																		
																	}
																	
																}
																
															#endregion
															
															// Add to _str
															if(_str2 != "") _str += "\n"+_str2
															_str2 = "" // Reset
															
															// Draw and Reset
															draw_text_color(_xy2[0],_xy2[1],_str,c.wht,c.wht,c.wht,c.wht,1)
															draw_set_hvalign(hvo)
															
														#endregion
														
														// Reset Alpha
														draw_set_alpha(ao)
														
													#endregion
													
												}
												
											}
											
										#endregion
										
									}
									
								#endregion
								
							}
							
						}
						
						// Reset Font
						draw_set_font(fo)
						
					#endregion
					
					#region Entry Edits (Selected and using hotkeys to set additional variables to an entry)
						
						if(is(ES[$ string(ESsel)])) {
							
							if(ESedit == N) {
								
								#region Entry Edit Controls
									
									if(keyboard_check_pressed(ord("M"))) {
										
										#region Init Message(string) Edit
											
											ESedit = EDIT.TEXT
											if(variable_instance_exists(ES[$ string(ESsel)],K.STR))
												keyboard_string = ES[$ string(ESsel)][$ K.STR]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.STR] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("R"))) {
										
										#region Init To_Room Edit
											
											ESedit = EDIT.TO_SCENE
											if(variable_instance_exists(ES[$ string(ESsel)],K.SCN+K.TO))
												keyboard_string = ES[$ string(ESsel)][$ K.SCN+K.TO]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.SCN+K.TO] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("F"))) {
										
										#region Init Findable Toggle
											
											keyboard_string = ""
											ESedit = N
											if(!variable_instance_exists(ES[$ string(ESsel)],K.FND)) ES[$ string(ESsel)][$ K.FND] = T
											else ES[$ string(ESsel)][$ K.FND] = !ES[$ string(ESsel)][$ K.FND]
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("L"))) {
										
										#region Init Hilite Toggle
											
											keyboard_string = ""
											ESedit = N
											if(!variable_instance_exists(ES[$ string(ESsel)],K.HLT)) ES[$ string(ESsel)][$ K.HLT] = T
											else ES[$ string(ESsel)][$ K.HLT] = !ES[$ string(ESsel)][$ K.HLT]
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("H"))) {
										
										#region Init Hover Toggle
											
											keyboard_string = ""
											ESedit = N
											if(!variable_instance_exists(ES[$ string(ESsel)],K.HVR)) ES[$ string(ESsel)][$ K.HVR] = T
											else ES[$ string(ESsel)][$ K.HVR] = !ES[$ string(ESsel)][$ K.HVR]
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("K"))) {
										
										#region Init Destroy Toggle
											
											keyboard_string = ""
											ESedit = N
											if(!variable_instance_exists(ES[$ string(ESsel)],K.DTR)) ES[$ string(ESsel)][$ K.DTR] = T
											else ES[$ string(ESsel)][$ K.DTR] = !ES[$ string(ESsel)][$ K.DTR]
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("T"))) {
										
										#region Timer
											
											ESedit = EDIT.TIMER
											if(variable_instance_exists(ES[$ string(ESsel)],K.TMR))
												keyboard_string = ES[$ string(ESsel)][$ K.TMR]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.TMR] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("D"))) {
										
										#region Delay
											
											ESedit = EDIT.DELAY
											if(variable_instance_exists(ES[$ string(ESsel)],K.DL))
												keyboard_string = ES[$ string(ESsel)][$ K.DL]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.DL] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("X"))) {
										
										#region X Offset
											
											ESedit = EDIT.XOFFSET
											if(variable_instance_exists(ES[$ string(ESsel)],K.XOF))
												keyboard_string = ES[$ string(ESsel)][$ K.XOF]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.XOF] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("Y"))) {
										
										#region Y Offset
											
											ESedit = EDIT.YOFFSET
											if(variable_instance_exists(ES[$ string(ESsel)],K.YOF))
												keyboard_string = ES[$ string(ESsel)][$ K.YOF]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.YOF] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("A"))) {
										
										#region Animation
											
											ESedit = EDIT.ANIMATION
											if(variable_instance_exists(ES[$ string(ESsel)],K.ANM))
												keyboard_string = ES[$ string(ESsel)][$ K.ANM]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.ANM] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("S"))) {
										
										#region Sprite
											
											ESedit = EDIT.SPRITE
											if(variable_instance_exists(ES[$ string(ESsel)],K.SPR))
												keyboard_string = ES[$ string(ESsel)][$ K.SPR]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.SPR] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("O"))) {
										
										#region Sound
											
											ESedit = EDIT.SOUND
											if(variable_instance_exists(ES[$ string(ESsel)],K.SND))
												keyboard_string = ES[$ string(ESsel)][$ K.SND]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.SND] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("E"))) {
										
										#region Entity
											
											ESedit = EDIT.ENTITY
											if(variable_instance_exists(ES[$ string(ESsel)],K.ENT))
												keyboard_string = ES[$ string(ESsel)][$ K.ENT]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.ENT] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("C"))) {
										
										#region Click
											
											ESedit = EDIT.CLICK
											if(variable_instance_exists(ES[$ string(ESsel)],K.CLK))
												keyboard_string = ES[$ string(ESsel)][$ K.CLK]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.CLK] = ""
												
											}
											
										#endregion
										
									} else if(keyboard_check_pressed(ord("U"))) {
										
										#region Surface
											
											ESedit = EDIT.SURFACE
											if(variable_instance_exists(ES[$ string(ESsel)],K.SRF))
												keyboard_string = ES[$ string(ESsel)][$ K.SRF]
											else {
												
												keyboard_string = ""
												ES[$ string(ESsel)][$ K.SRF] = ""
												
											}
											
										#endregion
										
									}
									
								#endregion
								
							} else {
								
								#region Confirm Input
									
									if(ESedit == EDIT.TEXT) { // String/Text Edit STR
										
										#region Message
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.STR] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.STR)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.STR] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.TO_SCENE) { // To_Room Edit SCENE
										
										#region To Room
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.SCN+K.TO] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.SCN+K.TO)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.SCN+K.TO] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.TIMER) { // Timer Edit #
										
										#region Timer
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.TMR] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.TMR)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.TMR] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.DELAY) { // Delay Edit #
										
										#region Delay
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.DL] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.DL)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.DL] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.XOFFSET) { // Delay Edit #
										
										#region X Offset
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.XOF] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.XOF)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.XOF] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.YOFFSET) { // Delay Edit #
										
										#region Y Offset
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.YOF] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.YOF)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.YOF] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.ANIMATION) { // Animation Edit STR
										
										#region Animation
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.ANM] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.ANM)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.ANM] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.SPRITE) { // Sprite Edit STR
										
										#region Sprite
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.SPR] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.SPR)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.SPR] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.SOUND) { // Sound Edit STR
										
										#region Sound
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.SND] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.SND)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.SND] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.ENTITY) { // Entity Edit HYBRID
										
										#region Entity
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.ENT] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.ENT)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.ENT] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.CLICK) { // Entity Edit V
										
										#region Click
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.CLK] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.CLK)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.CLK] = keyboard_string
											
										#endregion
										
									} else if(ESedit == EDIT.SURFACE) { // Entity Edit HYBRID
										
										#region Surface
											
											if(keyboard_check_pressed(vk_backspace)
												and ES[$ string(ESsel)][$ K.SRF] == "") {
												variable_struct_remove(ES[$ string(ESsel)],K.SRF)
												ESedit = N
											} else ES[$ string(ESsel)][$ K.SRF] = keyboard_string
											
										#endregion
										
									}
									
									#region Finish Edit (String -> Real etc. Conversions)
										
										if(keyboard_check_pressed(vk_enter)) {
											
											if(ESedit == EDIT.TIMER) {
												
												#region Timer
													
													if(is_string_real(ES[$ string(ESsel)][$ K.TMR]))
														ES[$ string(ESsel)][$ K.TMR] = real(ES[$ string(ESsel)][$ K.TMR]);
													else variable_struct_remove(ES[$ string(ESsel)],K.TMR);
													
												#endregion
												
											} else if(ESedit == EDIT.DELAY) {
												
												#region Delay
													
													if(is_string_real(ES[$ string(ESsel)][$ K.DL]))
														ES[$ string(ESsel)][$ K.DL] = real(ES[$ string(ESsel)][$ K.DL]);
													else variable_struct_remove(ES[$ string(ESsel)],K.DL);
													
												#endregion
												
											} else if(ESedit == EDIT.XOFFSET) {
												
												#region Delay
													
													if(is_string_real(ES[$ string(ESsel)][$ K.XOF]))
														ES[$ string(ESsel)][$ K.DL] = real(ES[$ string(ESsel)][$ K.XOF]);
													else variable_struct_remove(ES[$ string(ESsel)],K.XOF);
													
												#endregion
												
											} else if(ESedit == EDIT.YOFFSET) {
												
												#region Delay
													
													if(is_string_real(ES[$ string(ESsel)][$ K.YOF]))
														ES[$ string(ESsel)][$ K.DL] = real(ES[$ string(ESsel)][$ K.YOF]);
													else variable_struct_remove(ES[$ string(ESsel)],K.YOF);
													
												#endregion
												
											} else if(ESedit == EDIT.CLICK) {
												
												#region Click
													
													if(is_string_real(ES[$ string(ESsel)][$ K.CLK]))
														ES[$ string(ESsel)][$ K.CLK] = real(ES[$ string(ESsel)][$ K.CLK]);
													else variable_struct_remove(ES[$ string(ESsel)],K.CLK);
													
												#endregion
												
											} else if(ESedit == EDIT.ENTITY) {
												
												#region Entity
													
													if(is_string_real(ES[$ string(ESsel)][$ K.ENT])) // is Actor Value?
														ES[$ string(ESsel)][$ K.ENT] = real(ES[$ string(ESsel)][$ K.ENT]);
													// HYBRID Can also be a STR for a name to something else... So we don't remove if not real(ACTOR)...
													
												#endregion
												
											} else if(ESedit == EDIT.TO_SCENE) {
												
												#region To Scene
													
													if(is_string_real(ES[$ string(ESsel)][$ K.SCN+K.TO]))
														ES[$ string(ESsel)][$ K.SCN+K.TO] = real(ES[$ string(ESsel)][$ K.SCN+K.TO]);
													else variable_struct_remove(ES[$ string(ESsel)],K.SCN+K.TO);
													
												#endregion
												
											} else if(ESedit == EDIT.SURFACE) {
												
												#region Surface
													
													if(is_string_real(ES[$ string(ESsel)][$ K.SRF])) // is Actor Value?
														ES[$ string(ESsel)][$ K.SRF] = real(ES[$ string(ESsel)][$ K.SRF]);
													// HYBRID Can also be a STR for a name to something else... So we don't remove if not real(ACTOR)...
													
												#endregion
												
											}
											
											ESedit = N
											
										}
										
									#endregion
									
								#endregion
								
							}
							
						}
						
					#endregion
					
					#region Write everything to file
						
						if(keyboard_check(vk_control) and keyboard_check_pressed(vk_enter)) {
							
							struct_trim_and_backfill(ES)
							var _f = file_text_open_write(game_save_id+"nodes.json")
							file_text_write_string(_f,json_stringify(ES,T))
							file_text_close(_f)
							
						}
						
					#endregion
					
				}
				
			#endregion
			
		}
		
	#endregion
	
#endregion