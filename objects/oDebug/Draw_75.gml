/// @description Debug View
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(active and edit and !console) {
	
	#region Console Toggle
		
		if(keyboard_check_pressed(192)) {
			
			console = T
			edit = F
			
		}
		
	#endregion
	
	#region Base Debug Info
		
		#region Controls...
			
			#region Toggle Debug String
				
				if(keyboard_check_pressed(vk_insert)) {
					
					dbgStrScrl = 0
					dbgStr = !dbgStr
					
				}
				
			#endregion
			
			#region Toggle Edit Help
				
				if(keyboard_check_pressed(vk_end))
					editHelp = !editHelp;
				
			#endregion
			
			#region Toggle Nest Direction
				
				if(keyboard_check_pressed(vk_multiply))
					D.diaNestDir = !D.diaNestDir;
				
			#endregion
			
			#region Toggle Dia Prev 2
				
				if(keyboard_check_pressed(vk_divide) or ds_list_empty(D.diaParLst)) {
					
					if(!diaPrev2 and !ds_list_empty(D.diaParLst)) {
						
						// If diaPrev2 not set and we are in dialogue...
						diaPrev2 = diaNar_get_top()
						diaPrev2i = ds_list_size(D.diaNestLst)
						
					} else {
						
						// This will run if no dialogue or key was pressed and diaPrev2 was already set...
						diaPrev2 = N
						diaPrev2i = N
						diaPrev2Str = ""
						
					}
					
				}
				
			#endregion
			
			#region Dia Preview 2 Iterate Higher
				
				if(keyboard_check_pressed(vk_add) and diaPrev2) {
					
					if(diaPrev2i < ds_list_size(D.diaNestLst))
						diaPrev2i++;
					
				}
				
			#endregion
			
			#region Dia Preview 2 Iterate Lower
				
				if(keyboard_check_pressed(vk_subtract) and diaPrev2) {
					
					if(diaPrev2i > 0) diaPrev2i--;
					
				}
				
			#endregion
			
		#endregion
		
		#region Debug String Write & Draw
			
			if(dbgStr) {
				
				#region Debug String Scrolling
					
					if(mouse_wheel_up()) {
						
						if(keyboard_check(vk_shift)) dbgStrScrl -= 12;
						else dbgStrScrl -= 6;
						
					} else if(mouse_wheel_down()) {
						
						if(keyboard_check(vk_shift)) dbgStrScrl += 12;
						else dbgStrScrl += 6;
						
					}
					
				#endregion
				
				#region Add Editor Help...
					
					if(editHelp) {
						
						dbgStr1 += "M - Message/String\n"
							+"R - To Scene\n"
							+"F - Find Toggle\n"
							+"L - Highlight\n"
							+"H - Hover\n"
							+"X - Destroy\n"
							+"T - Timer\n"
							+"D - Delay\n"
							+"A - Anim\n"
							+"S - Sprite\n"
							+"O - Sound\n"
							+"E - Entity\n"
							+"C - Click\n"
							+"U - Surface\n"
						
					}
					
				#endregion
				
				#region Game Globals & Variables...
					
					dbgStr1 += "Game State: "
					switch(D.game_state) {
						
						case GAME.INIT: dbgStr1 += "INIT"; break;
						case GAME.MENU: dbgStr1 += "MENU"; break;
						case GAME.PLAY: dbgStr1 += "PLAY"; break;
						default: dbgStr1 += "Error"; break;
						
					}
					dbgStr1 += "\nMouse Win PCT X/Y: "+string(MXPCT)+"/"+string(MYPCT)
					if(is(S)) {
						
						if(variable_instance_exists(S,string(D.scni)))
							if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.SPR)) {
								
								// Add Scene Stuff
								dbgStr1 += "\nScene: "+sprite_get_name(S[$ string(D.scni)][$ K.BG0+K.SPR])
									+"\nScene I: "+string(D.scni)
									+"\nScene State: "
									
								switch(D.scene_state) {
									
									case GAME.INIT: dbgStr1 += "INIT"; break;
									case GAME.MENU: dbgStr1 += "MENU"; break;
									case GAME.PLAY: dbgStr1 += "PLAY"; break;
									default: dbgStr1 += "Error"; break;
									
								}
								
							}
						
					}
					dbgStr1 += "\nMouse BG X/Y pct: "+string(D.bgmxpct)+"/"+string(D.bgmypct)
					
				#endregion
				
				#region Player Variables...
					
					if(P.suited) dbgStr1 += "\nPlayer is Suited";
					else dbgStr1 += "\nPlayer is NOT Suited";
					
				#endregion
				
				#region Debug Marker Variables...
					
					if(markerStr != "") dbgStr1 += markerStr;
					
				#endregion
				
				#region Dialogue Pre-Vars
					
					dbgStr1 += "\nPar Dia List Count: "+string(ds_list_size(D.diaParLst))
					if(D.diaContinue) dbgStr1 += "\nDia Continue...";
					if(D.diaLnkA != N) dbgStr1 += "\nDia Link A:["+ACTORn[D.diaLnkA[0]]+","+string(is_struct(D.diaLnkA[1]))+"]";
					if(D.diaLnkB != N) dbgStr1 += "\nDia Link B:["+ACTORn[D.diaLnkB[0]]+","+string(is_struct(D.diaLnkB[1]))+"]";
					if(D.diaLnkC != N) dbgStr1 += "\nDia Link C:["+ACTORn[D.diaLnkC[0]]+","+string(is_struct(D.diaLnkC[1]))+"]";
					if(D.diaLnkD != N) dbgStr1 += "\nDia Link D:["+ACTORn[D.diaLnkD[0]]+","+string(is_struct(D.diaLnkD[1]))+"]";
					if(D.diaLnkE != N) dbgStr1 += "\nDia Link E:["+ACTORn[D.diaLnkE[0]]+","+string(is_struct(D.diaLnkE[1]))+"]";
					if(D.diaAnimTo != N) dbgStr1 += "\nDia Anim To: "+string(D.diaAnimTo);
					
				#endregion
				
				#region Selected Editor Struct...
					
					if(ESsel) dbgStr2 = "\n"+json_stringify(ES[$ string(ESsel)],T);
					
				#endregion
				
				#region Dialogue...
					
					try {
						
						// In Dialogue?
						if(diaPrev2) {
							
							#region Manual Open Dialogue Previewing... (Red)
								
								#region Dialogue Globals & Variables...
									 
									if(D.focus) diaPrev2Str = "\nFocus: "+string(D.focus)+"("+D.focus.dia[$ K.NM]+")";
									else diaPrev2Str = "\nFocus: None";
									if(D.focusL) diaPrev2Str += "\nFocus L: "+string(D.focusL)+"("+D.focusL.dia[$ K.NM]+")";
									else diaPrev2Str += "\nFocus L: None";
									if(D.focusR) diaPrev2Str += "\nFocus R: "+string(D.focusR)+"("+D.focusR.dia[$ K.NM]+")";
									else diaPrev2Str += "\nFocus R: None";
									if(D.focusM) diaPrev2Str += "\nFocus M: "+string(D.focusM)+"("+D.focusM.dia[$ K.NM]+")";
									else diaPrev2Str += "\nFocus M: None";
									if(D.diaSpeaker) diaPrev2Str += "\nSpeaker: "+string(D.diaSpeaker)+"("+D.diaSpeaker.dia[$ K.NM]+")";
									else diaPrev2Str += "\nSpeaker: None";
									diaPrev2Str += "\nPar Dia List Count: "+string(ds_list_size(D.diaParLst))
									diaPrev2Str += "\nNest Dia List Count: "+string(ds_list_size(D.diaNestLst))
									diaPrev2Str += "\nDia Delay sec/frame: "+string(D.diad/GSPD)+"/"+string(D.diad)
									diaPrev2Str += "\nLevel/Layer: "+string(ds_list_size(D.diaNestLst))
									if(D.diaSoftClose) diaPrev2Str += "\nSoft Close: True/Not Done";
									else diaPrev2Str += "\nSoft Close: False/Is Done";
									if(D.diaNestDir) diaPrev2Str += "\nNesting Direction: In/Open";
									else diaPrev2Str += "\nNesting Direction: Out/Close";
									if(D.focus) {
										diaPrev2Str += "\nIter: "+string(diaNarI())
										diaPrev2Str += "\nIter Old (Par): "+string(D.focus.dia[$ K.IO])
									}
									
								#endregion
								
								// Print Dialogue Preview in Red Somewhere... TODO
								#region Show Selected Nest/Parent...
									
									var _e = N
									if(diaPrev2i > ds_list_size(D.diaNestLst)) diaPrev2i = ds_list_size(D.diaNestLst);
									if(diaPrev2i > 0) _e = D.diaNestLst[|diaPrev2i-1];
									else _e = diaNar_get_par();
									var sks = diaNar_get_string_keys(_e)
									var rks = diaNar_get_real_keys(_e)
									for(var i = 0; i < array_length(rks); i++) rks[i] = real(rks[i]);
									array_sort(rks,T)
									diaPrev2Str += "\n[Layer = "+string(diaPrev2i)+ "]"
									for(var i = 0; i < array_length(sks); i++) diaPrev2Str += "\n[$ "+string(sks[i])+"]: "+string(_e[$ sks[i]]);
									for(var i = 0; i < array_length(rks); i++) {
										
										if(is_struct(_e[$ rks[i]])) {
											
											diaPrev2Str += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview Start]"
											var _e2 = _e[$ rks[i]]
											var sks2 = diaNar_get_string_keys(_e2)
											var rks2 = diaNar_get_real_keys(_e2)
											for(var i2 = 0; i2 < array_length(rks2); i2++) rks2[i2] = real(rks2[i2]);
											array_sort(rks2,T)
											for(var i2 = 0; i2 < array_length(sks2); i2++) diaPrev2Str += "\n--[$ "+string(sks2[i2])+"]: "+string(_e2[$ sks2[i2]]);
											for(var i2 = 0; i2 < array_length(rks2); i2++) {
												
												if(is_struct(_e2[$ rks2[i2]])) diaPrev2Str += "\n--[$ "+string(rks2[i2])+"]: [Nested Dialogue]+"
												else diaPrev2Str += "\n--[$ "+string(rks2[i2])+"]: "+string(_e2[$ rks2[i2]]);
												
											}
											diaPrev2Str += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview End]"
											
										} else diaPrev2Str += "\n[$ "+string(rks[i])+"]: "+string(_e[$ rks[i]]);
										
									}
									diaPrev2Str += "\n[Layer = "+string(diaPrev2i)+ "]"
									
								#endregion
								
							#endregion
							
						} else if(!ds_list_empty(D.diaParLst)) {
							
							#region Dialogue Globals & Variables...
								 
								if(D.focus) dbgStr2 = "\nFocus: "+string(D.focus)+"("+D.focus.dia[$ K.NM]+")";
								else dbgStr2 = "\nFocus: None";
								if(D.focusL) dbgStr2 += "\nFocus L: "+string(D.focusL)+"("+D.focusL.dia[$ K.NM]+")";
								else dbgStr2 += "\nFocus L: None";
								if(D.focusR) dbgStr2 += "\nFocus R: "+string(D.focusR)+"("+D.focusR.dia[$ K.NM]+")";
								else dbgStr2 += "\nFocus R: None";
								if(D.focusM) dbgStr2 += "\nFocus M: "+string(D.focusM)+"("+D.focusM.dia[$ K.NM]+")";
								else dbgStr2 += "\nFocus M: None";
								if(D.diaSpeaker) dbgStr2 += "\nSpeaker: "+string(D.diaSpeaker)+"("+D.diaSpeaker.dia[$ K.NM]+")";
								else dbgStr2 += "\nSpeaker: None";
								dbgStr2 += "\nNest Dia List Count: "+string(ds_list_size(D.diaNestLst))
								dbgStr2 += "\nDia Delay sec/frame: "+string(D.diad/GSPD)+"/"+string(D.diad)
								dbgStr2 += "\nLevel/Layer: "+string(ds_list_size(D.diaNestLst))
								if(D.diaSoftClose) dbgStr2 += "\nSoft Close: Don't Mark as Done (True)";
								else dbgStr2 += "\nSoft Close: Mark as Done (False)";
								if(D.diaNestDir) dbgStr2 += "\nNesting Direction: In/Open (True)";
								else dbgStr2 += "\nNesting Direction: Out/Close (False)";
								if(D.focus) {
									dbgStr2 += "\nIter: "+string(diaNarI())
									dbgStr2 += "\nIter Old (Par): "+string(D.focus.dia[$ K.IO])
								}
								
							#endregion
							
							#region Iteration Return Results
								
								if(D.diaSpeaker) {
									
									#region Current Return
										
										// Init
										var rtn = N
										var inst = N
										
										// Get Current Dialogue and Return...
										if(!ds_list_empty(D.diaNestLst)) {
											
											inst = ds_list_top(D.diaNestLst)
											rtn = diaNar_iterate_level(inst,D.diaSpeaker.uid,4)
											
										} else {
											
											inst = diaNar_get_par()
											rtn = diaNar_iterate_level(inst,D.diaSpeaker.uid,4)
											
										}
										
										// Show Results of Return from Iteration.....
										if(is_array(rtn)) {
											
											if(is_struct(rtn[1])) {
												
												if(rtn[1] == inst) dbgStr2 += "\nReturn: ["+string(rtn[0])+", Current Dialogue]";
												else dbgStr2 += "\nReturn: ["+string(rtn[0])+", Nested Dialogue]";
												
											} else dbgStr2 += "\nReturn: "+string(rtn);
											
										} else dbgStr2 += "\nReturn: "+string(rtn);
										
									#endregion
									
									#region Nest Return
										
										// Init
										var rtn = N
										var inst = N
										
										// Get Nested Dialogue and Return...
										if(!ds_list_empty(D.diaNestLst)) inst = ds_list_top(D.diaNestLst)[$ diaNarI()];
										else inst = diaNar_get_par()[$ diaNarI()];
										
										if(is_struct(inst)) {
											
											rtn = diaNar_iterate_level(inst,D.diaSpeaker.uid,4)
											
											// Show Results of Return from Iteration.....
											if(is_array(rtn)) {
												
												if(is_struct(rtn[1])) {
													
													if(rtn[1] == inst) dbgStr2 += "\nNest Return: ["+string(rtn[0])+", Nested Dialogue]";
													else dbgStr2 += "\nNest Return: ["+string(rtn[0])+", Nested+ Dialogue]";
													
												} else dbgStr2 += "\nNest Return: "+string(rtn);
												
											} else dbgStr2 += "\nNest Return: "+string(rtn);
											
										}
										
									#endregion
									
									
								}
								
							#endregion
							
							#region Current Dialogue Preview
								
								if(D.diaNestDir) {
									
									#region Up/Open
										
										if(!ds_list_empty(D.diaNestLst)) {
											
											#region Nested
												
												var _e = ds_list_top(D.diaNestLst)
												var sks = diaNar_get_string_keys(_e)
												var rks = diaNar_get_real_keys(_e)
												for(var i = 0; i < array_length(rks); i++) rks[i] = real(rks[i]);
												array_sort(rks,T)
												for(var i = 0; i < array_length(sks); i++) dbgStr2 += "\n[$ "+string(sks[i])+"]: "+string(_e[$ sks[i]]);
												for(var i = 0; i < array_length(rks); i++) {
													
													if(is_struct(_e[$ rks[i]])) {
														
														dbgStr2 += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview Start]"
														var _e2 = _e[$ rks[i]]
														var sks2 = diaNar_get_string_keys(_e2)
														var rks2 = diaNar_get_real_keys(_e2)
														for(var i2 = 0; i2 < array_length(rks2); i2++) rks2[i2] = real(rks2[i2]);
														array_sort(rks2,T)
														for(var i2 = 0; i2 < array_length(sks2); i2++) dbgStr2 += "\n--[$ "+string(sks2[i2])+"]: "+string(_e2[$ sks2[i2]]);
														for(var i2 = 0; i2 < array_length(rks2); i2++) {
															
															if(is_struct(_e2[$ rks2[i2]])) dbgStr2 += "\n--[$ "+string(rks2[i2])+"]: [Nested Dialogue]+"
															else dbgStr2 += "\n--[$ "+string(rks2[i2])+"]: "+string(_e2[$ rks2[i2]]);
															
														}
														dbgStr2 += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview End]"
														
													} else dbgStr2 += "\n[$ "+string(rks[i])+"]: "+string(_e[$ rks[i]]);
													
												}
												
											#endregion
											
										} else {
											
											#region Parent
												
												var _e = diaNar_get_par()
												var sks = diaNar_get_string_keys(_e)
												var rks = diaNar_get_real_keys(_e)
												for(var i = 0; i < array_length(rks); i++) rks[i] = real(rks[i]);
												array_sort(rks,T)
												for(var i = 0; i < array_length(sks); i++) dbgStr2 += "\n[$ "+string(sks[i])+"]: "+string(_e[$ sks[i]]);
												for(var i = 0; i < array_length(rks); i++) {
													
													if(is_struct(_e[$ rks[i]])) {
														
														dbgStr2 += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview Start]"
														var _e2 = _e[$ rks[i]]
														var sks2 = diaNar_get_string_keys(_e2)
														var rks2 = diaNar_get_real_keys(_e2)
														for(var i2 = 0; i2 < array_length(rks2); i2++) rks2[i2] = real(rks2[i2]);
														array_sort(rks2,T)
														for(var i2 = 0; i2 < array_length(sks2); i2++) dbgStr2 += "\n--[$ "+string(sks2[i2])+"]: "+string(_e2[$ sks2[i2]]);
														for(var i2 = 0; i2 < array_length(rks2); i2++) {
															
															if(is_struct(_e2[$ rks2[i2]])) dbgStr2 += "\n--[$ "+string(rks2[i2])+"]: [Nested Dialogue]+"
															else dbgStr2 += "\n--[$ "+string(rks2[i2])+"]: "+string(_e2[$ rks2[i2]]);
															
														}
														dbgStr2 += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview End]"
														
													} else dbgStr2 += "\n[$ "+string(rks[i])+"]: "+string(_e[$ rks[i]]);
													
												}
												
											#endregion
											
										}
										
									#endregion
									
								} else {
									
									#region Down/Close
										
										var _nxt = diaNar_next_dia(F)
										if(_nxt) {
											
											#region Show Next Dialogue...
												
												var _e = _nxt
												var sks = diaNar_get_string_keys(_e)
												var rks = diaNar_get_real_keys(_e)
												for(var i = 0; i < array_length(rks); i++) rks[i] = real(rks[i]);
												array_sort(rks,T)
												if(_nxt != diaNar_get_top()) dbgStr2 += "\n[Last Found Dialogue Start]";
												else dbgStr2 += "\n[Last Found dialogue Returned This... (Is Parent?) Start]";
												for(var i = 0; i < array_length(sks); i++) dbgStr2 += "\n[$ "+string(sks[i])+"]: "+string(_e[$ sks[i]]);
												for(var i = 0; i < array_length(rks); i++) {
													
													if(is_struct(_e[$ rks[i]])) {
														
														dbgStr2 += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview Start]"
														var _e2 = _e[$ rks[i]]
														var sks2 = diaNar_get_string_keys(_e2)
														var rks2 = diaNar_get_real_keys(_e2)
														for(var i2 = 0; i2 < array_length(rks2); i2++) rks2[i2] = real(rks2[i2]);
														array_sort(rks2,T)
														for(var i2 = 0; i2 < array_length(sks2); i2++) dbgStr2 += "\n--[$ "+string(sks2[i2])+"]: "+string(_e2[$ sks2[i2]]);
														for(var i2 = 0; i2 < array_length(rks2); i2++) {
															
															if(is_struct(_e2[$ rks2[i2]])) dbgStr2 += "\n--[$ "+string(rks2[i2])+"]: [Nested Dialogue]+"
															else dbgStr2 += "\n--[$ "+string(rks2[i2])+"]: "+string(_e2[$ rks2[i2]]);
															
														}
														dbgStr2 += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview End]"
														
													} else dbgStr2 += "\n[$ "+string(rks[i])+"]: "+string(_e[$ rks[i]]);
													
												}
												if(_nxt != diaNar_get_top()) dbgStr2 += "\n[Last Found Dialogue End]";
												else dbgStr2 += "\n[Last Found dialogue Returned This... (Is Parent?) End]";
												
											#endregion
											
										}
										
									#endregion
									
								}
								
							#endregion
							
						} else if(diaPrev) {
							
							#region Dialogue Globals & Variables...
								 
								if(D.focus) dbgStr2 = "\nFocus: "+string(D.focus)+"("+D.focus.dia[$ K.NM]+")";
								else dbgStr2 = "\nFocus: None";
								if(D.focusL) dbgStr2 += "\nFocus L: "+string(D.focusL)+"("+D.focusL.dia[$ K.NM]+")";
								else dbgStr2 += "\nFocus L: None";
								if(D.focusR) dbgStr2 += "\nFocus R: "+string(D.focusR)+"("+D.focusR.dia[$ K.NM]+")";
								else dbgStr2 += "\nFocus R: None";
								if(D.focusM) dbgStr2 += "\nFocus M: "+string(D.focusM)+"("+D.focusM.dia[$ K.NM]+")";
								else dbgStr2 += "\nFocus M: None";
								if(D.diaSpeaker) dbgStr2 += "\nSpeaker: "+string(D.diaSpeaker)+"("+D.diaSpeaker.dia[$ K.NM]+")";
								else dbgStr2 += "\nSpeaker: None";
								dbgStr2 += "\nPar Dia List Count: "+string(ds_list_size(D.diaParLst))
								dbgStr2 += "\nNest Dia List Count: "+string(ds_list_size(D.diaNestLst))
								dbgStr2 += "\nDia Delay sec/frame: "+string(D.diad/GSPD)+"/"+string(D.diad)
								dbgStr2 += "\nLevel/Layer: "+string(ds_list_size(D.diaNestLst))
								if(D.diaSoftClose) dbgStr2 += "\nSoft Close: True/Not Done";
								else dbgStr2 += "\nSoft Close: False/Is Done";
								if(D.diaNestDir) dbgStr2 += "\nNesting Direction: In/Open";
								else dbgStr2 += "\nNesting Direction: Out/Close";
								if(D.focus) dbgStr2 += "\nIter: "+string(diaNarI())
								
							#endregion
							
							#region Preview Dialogue that is available but not open... Preview set elsewhere...
								
								var _e = diaPrev
								var sks = diaNar_get_string_keys(_e)
								var rks = diaNar_get_real_keys(_e)
								for(var i = 0; i < array_length(rks); i++) rks[i] = real(rks[i]);
								array_sort(rks,T)
								for(var i = 0; i < array_length(sks); i++) dbgStr2 += "\n[$ "+string(sks[i])+"]: "+string(_e[$ sks[i]]);
								for(var i = 0; i < array_length(rks); i++) {
									
									if(is_struct(_e[$ rks[i]])) {
										
										dbgStr2 += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview Start]"
										var _e2 = _e[$ rks[i]]
										var sks2 = diaNar_get_string_keys(_e2)
										var rks2 = diaNar_get_real_keys(_e2)
										for(var i2 = 0; i2 < array_length(rks2); i2++) rks2[i2] = real(rks2[i2]);
										array_sort(rks2,T)
										for(var i2 = 0; i2 < array_length(sks2); i2++) dbgStr2 += "\n--[$ "+string(sks2[i2])+"]: "+string(_e2[$ sks2[i2]]);
										for(var i2 = 0; i2 < array_length(rks2); i2++) {
											
											if(is_struct(_e2[$ rks2[i2]])) dbgStr2 += "\n--[$ "+string(rks2[i2])+"]: [Nested Dialogue]+"
											else dbgStr2 += "\n--[$ "+string(rks2[i2])+"]: "+string(_e2[$ rks2[i2]]);
											
										}
										dbgStr2 += "\n[$ "+string(rks[i])+"]: [Nested Dialogue Preview End]"
										
									} else dbgStr2 += "\n[$ "+string(rks[i])+"]: "+string(_e[$ rks[i]]);
									
								}
								
							#endregion
							
							// Reset diaPrev, should be set again manually if it is still needed
							diaPrev = N
							
						} else {
							
							dbgStr2 = ""
							diaPrev2Str = ""
							
						}
						
					} catch(_ex) {}
					
				#endregion
				
				#region Draw Debug String(s)
					
					// Olds
					draw_olds_pull()
					
					// Init
					if(diaPrev2Str != "") {
						
						text_prep(string_trim(diaPrev2Str));
						fgc_[1] = c.nr
						fgc_[2] = c.nr
						fgc_[3] = c.r
						fgc_[4] = c.r
						
					} else if(is_string(dbgStr2)) text_prep(string_trim(dbgStr1+dbgStr2));
					else text_prep(string_trim(dbgStr1));
					draw_set_font(fDebug)
					
					// Make Debug STR BG more opaque for now...
					bgc_[0] = .9
					bgc_[1] = c.blk
					bgc_[2] = c.blk
					bgc_[3] = make_color_rgb(16,16,16)
					bgc_[4] = make_color_rgb(16,16,16)
					
					// Draw Debug Strings
					draw_set_alpha(bgc_[0])
					if(MXPCT > 1/3) {
						
						// Left Side
						draw_set_hvalign([fa_left,fa_top])
						draw_rectangle_color(0,0,strw_,strh_+dbgStrScrl,bgc_[1],bgc_[2],bgc_[3],bgc_[4],F)
						draw_text_color(0,dbgStrScrl,str_,fgc_[1],fgc_[2],fgc_[3],fgc_[4],fgc_[0])
						
					} else {
						
						// Move to Right to get out of way...
						draw_set_hvalign([fa_right,fa_top])
						draw_rectangle_color(WW,0,WW-strw_,strh_+dbgStrScrl,bgc_[1],bgc_[2],bgc_[3],bgc_[4],F)
						draw_text_color(WW,dbgStrScrl,str_,fgc_[1],fgc_[2],fgc_[3],fgc_[4],fgc_[0])
						
					}
					
					// Reset
					draw_olds_push()
					dbgStr1 = ""
					markerStr = ""
					
				#endregion
				
			}
			
		#endregion
		
	#endregion
	
	#region Edit Outline
		
		// Just to remind we're in edit mode
		draw_set_alpha(1/3)
		draw_rectangle_color(20,20,WW-20,WH-20,c.r,c.r,c.r,c.r,T)
		draw_reset()
		
	#endregion
	
} else if(active and console) {
	
	#region Console Toggle
		
		if(keyboard_check_pressed(192)) console = F;
		
	#endregion
	
	#region Console Editor
		
		#region Console Init
			
			// Console Input
			if(!variable_instance_exists(CON,string(D.scni))) {
				
				CON[$ string(D.scni)] = {}
				CONarr = [""]
				CONstri = 0
				
			} else if(CONarr != CON[$ string(D.scni)][$ "log"]) {
				
				CONarr = [""]
				if(variable_instance_exists(CON[$ string(D.scni)],"log"))
					CONarr = CON[$ string(D.scni)][$ "log"]
				CONstri = array_length(CONarr)-1
				
			}
			
			if(CONinit) {
				
				keyboard_string = CONarr[CONstri]
				CONinit = F
				
			}
			
		#endregion
		
		#region Hotkeys
			
			try {
				
				if(keyboard_check_pressed(vk_anykey)) {
					
					switch(keyboard_key) {
						
						#region Console Input Scroll
							
							case vk_up: {
								
								do {
									
									CONstri = clamp(CONstri-1,0,array_length(CONarr)-1)
									if(CONstri == 0 and CONarr[CONstri] == "") {
										
										CONstri = array_length(CONarr)-1
										break
										
									}
									
								} until(CONarr[CONstri] != "")
								keyboard_string = CONarr[CONstri]
								break
								
							}
							
							case vk_down: {
								
								do {
									
									CONstri = clamp(CONstri+1,0,array_length(CONarr)-1)
									if(CONstri == array_length(CONarr)-1) break;
									
								} until(CONarr[CONstri] != "")
								keyboard_string = CONarr[CONstri]
								break
								
							}
							
						#endregion
						
						#region Console Input Modifier (Prefix/Target)
							
							case vk_right: {
								
								switch(CONprei) {
									
									case CONSOLE.DIALOGUE: {
										
										if(CONactor < ACTOR.LAST) CONactor++; // Actor Iterate +
										else {
											
											// Loop + change From Dialogue...
											CONactor = ACTOR.LAST-1
											// Console Target Change +
											if(CONprei < CONSOLE.LAST) CONprei++; // Iterate
											else CONprei = CONSOLE.FIRST+1; // Loop
											
										}
										break
										
									}
									
									case CONSOLE.NARRATIVE: {
										
										if(CONactor < ACTOR.LAST) CONactor++; // Actor Iterate +
										else {
											
											// Loop + change From Dialogue...
											CONactor = ACTOR.LAST-1
											// Console Target Change +
											if(CONprei < CONSOLE.LAST) CONprei++; // Iterate
											else CONprei = CONSOLE.FIRST+1; // Loop
											
										}
										break
										
									}
									
									default: {
										
										// Console Target Change +
										if(CONprei < CONSOLE.LAST) CONprei++; // Iterate
										else CONprei = CONSOLE.FIRST+1; // Loop
										break
										
									}
									
								}
								break
								
							}
							
							case vk_left: {
								
								switch(CONprei) {
									
									case CONSOLE.DIALOGUE: {
										
										if(CONactor > ACTOR.FIRST) CONactor--; // Actor Iterate -
										else {
											
											// Loop + change From Dialogue...
											CONactor = ACTOR.FIRST+1
											// Console Target Change -
											if(CONprei > CONSOLE.FIRST) CONprei--; // Iterate
											else CONprei = CONSOLE.LAST-1; // Loop
											
										}
										break
										
									}
									
									case CONSOLE.NARRATIVE: {
										
										if(CONactor > ACTOR.FIRST) CONactor--; // Actor Iterate -
										else {
											
											// Loop + change From Dialogue...
											CONactor = ACTOR.FIRST+1
											// Console Target Change -
											if(CONprei > CONSOLE.FIRST) CONprei--; // Iterate
											else CONprei = CONSOLE.LAST-1; // Loop
											
										}
										break
										
									}
									
									default: {
										
										// Console Target Change -
										if(CONprei > CONSOLE.FIRST) CONprei--; // Iterate
										else CONprei = CONSOLE.LAST-1; // Loop
										break
										
									}
									
								}
								break
								
							}
							
						#endregion
						
						#region String Hotkeys
							
							case vk_f1: keyboard_string += "[$ \"0\"]";break;
							case vk_f2: keyboard_string += "[$ \"1\"]";break;
							case vk_f3: keyboard_string += "[$ \"2\"]";break;
							case vk_f4: keyboard_string += "[$ \"3\"]";break;
							case vk_f5: keyboard_string += "[$ \"4\"]";break;
							case vk_f6: keyboard_string += "[$ \"5\"]";break;
							case vk_f7: keyboard_string += "[$ \"6\"]";break;
							case vk_f8: keyboard_string += "[$ \"7\"]";break;
							case vk_f9: keyboard_string += "[$ \"8\"]";break;
							case vk_f10: keyboard_string += "[$ \"9\"]";break;
							case vk_f11: keyboard_string += "[$ \"10\"]";break;
							case vk_f12: keyboard_string += "[$ \""+string(D.scni)+"\"]";break;
							
						#endregion
						
					}
					
				}
				
			} catch(_ex) {}
			
		#endregion
		
		#region Input Update
			
			CONarr[CONstri] = string_copy(keyboard_string,0,string_length(keyboard_string))
			CON[$ string(D.scni)][$ "log"] = CONarr
			
		#endregion
		
		#region Console Confirm Input
			
			if(keyboard_check(vk_control) and keyboard_check_pressed(vk_enter)) {
				
				#region Set Output
					
					// Ensure Output Exists
					if(!variable_instance_exists(CON[$ string(D.scni)],"output"))
						CON[$ string(D.scni)][$ "output"] = ""
					
					var skip = 0
					for(var i = 0; i < array_length(CONarr); i++) {
						
						if(CONarr[i] == "") skip++;
						else CON[$ string(D.scni)][$ "output"] += CONpre+CONarr[i-skip]+"\n";
						
					}
					
				#endregion
				
				#region Write Scene File
					
					var _f = file_text_open_write(game_save_id+"console"+string(D.scni)+".json")
					var str = CON[$ string(D.scni)][$ "output"]
					file_text_write_string(_f,str)
					file_text_close(_f)
					
				#endregion
				
				#region Write Console File
					
					var _f = file_text_open_write(game_save_id+"console.json")
					var str = json_stringify(CON,T)
					file_text_write_string(_f,str)
					file_text_close(_f)
					
				#endregion
				
			} else if(keyboard_check_pressed(vk_enter)) {
				
				#region Confirm Input Edit/Entry
					
					if(CONstri == array_length(CONarr)-1) {
						
						// Append
						keyboard_string = ""
						CONstri++
						CONarr[CONstri] = ""
						
					} else {
						
						// Return to Latest after edit confirm
						CONstri = array_length(CONarr)-1
						keyboard_string = CONarr[CONstri]
						
					}
					
				#endregion
				
			}
			
		#endregion
		
		#region Draw
			
			var ex = "Example:\n"
				+"dia = {}\n"
				+"dia[$ \"name\"] = \"SYLAS\"\n"
				+"dia[$ \"sex\"] = SEX.MALE\n"
				+"dia[$ \"known\"] = F\n"
				+"dia[$ \"i\"] = 0\n"
				+"dia[$ \"cur\"] = 0\n"
				+"dia[$ \"curd\"] = GSPD*.2\n"
				+"dia[$ \"curi\"] = 0\n"
				+"dia[$ \"0\"] = {}\n"
				+"dia[$ \"0\"][$ \"0\"] = {}\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"trg\"] = TRIGGER.START\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"done\"] = F\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"lim\"] = 2\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"0\"] = \"Euurghhh....\"\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"1\"] = \"Is it time already?\"\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"2\"] = \"Shit! I'm late!\"\n"
				+"________________________________________________\n"
				+"Pending:\n"
			var pre = CONpre
			var str = "Prefix: "+pre+"\n"+ex+"\n"
			for(var i = 0; i < array_length(CONarr)-1; i++) {
				
				if(CONarr[i] == "") continue;
				if(i == CONstri) str += pre+CONarr[i]+" |>CURRENT EDIT<|\n";
				else str += pre+CONarr[i]+"\n";
				
			}
			draw_set_hvalign([fa_left,fa_bottom])
			draw_set_font(fDebug)
			var strw = max(string_width(str),string_width(pre+CONarr[CONstri]))
			draw_set_alpha(5/6)
			draw_rectangle_color(0,0,strw,WH,c.blk,c.blk,c.blk,c.blk,F)
			draw_set_alpha(1)
			draw_text_ext_color(0,WH-20,pre+CONarr[CONstri],20,WW,c.wht,c.wht,c.ng,c.ng,1)
			draw_text_ext_color(0,WH-(STRH+40),str,20,WW,c.lg,c.lg,c.g,c.g,1)
			
			
		#endregion
		
	#endregion
	
}

if(!console) CONinit = T