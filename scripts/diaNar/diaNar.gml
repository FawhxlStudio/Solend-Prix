function diaNar_focus_reset() {
	
	// Empty Focuses
	D.focus  = N
	D.focusL = N
	D.focusR = N
	D.focusM = N
	D.diaSpeaker = N
	D.diaTranDeli = 0
	D.diaTranPct = 0
	D.diaHold = F
	D.diaSoftDone = F
	
}

function diaNar_close(isDone) {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	
	#region Close Out Current...
		
		D.diaSoftDone = !isDone
		
		if(!ds_list_empty(D.diaNestLst)) {
			
			// Finish the current nest...
			var _t = ds_list_top(D.diaNestLst)
			_t[$ K.DN] = isDone
			ds_list_del_top(D.diaNestLst)
			
		} else if(!ds_list_empty(D.diaParLst)) {
			
			// Finish parent...
			var _t = diaNar_get_par()
			_t[$ K.DN] = isDone
			ds_list_delete(D.diaParLst,0)
			D.focus.dia[$ K.I] = 0
			diaNar_focus_reset()
			return isDone
			
		} else return N; // No Dialogue to close...
		
	#endregion
	
	#region Return to Previous...
		
		if(!ds_list_empty(D.diaNestLst)) {
			
			#region Back to Previous Nest Level... (Nest to Nest)
				
				// Returning to previous nest...
				var _t = ds_list_top(D.diaNestLst)
				var rcnt = diaNar_get_line_count(_t)
				
				if(_t[$ K.IO] < rcnt) {
					
					// Continue Past...
					D.focus.dia[$ K.I] = _t[$ K.IO]+1
					
				} else if(_t[$ K.IO] >= rcnt) {
					
					// Or previous nest is also done....
					D.focus.dia[$ K.I] = _t[$ K.IO] // Still set to old so we don't repeat...
					_t[$ K.DN] = T
					
				}
				
			#endregion
			
			return isDone
			
		} else if(!ds_list_empty(D.diaParLst)) {
			
			#region Back to Parent Dialogue... (Nest to Parent)
				
				// Returning to Parent/Not Nested Anymore...
				// Notes: D.focus.dia is where we store the iterator and the parent dialogue's old iterator
				// While nested structs have their own old iterator, the parent dialogue does not and stores it instead
				// the same way the global iterator is stored, at the D.focus.dia root level rather than the diaNar instance level...
				// WIP here to make this less confusing for others...
				var _t = diaNar_get_par() 
				var rcnt = diaNar_get_line_count(_t)
				
				if(D.focus.dia[$ K.IO] < rcnt) {
					
					// Continue Past...
					D.focus.dia[$ K.I] = D.focus.dia[$ K.IO]+1 // Iterate Old Iterator to Resume after the nest...
					
				} else if(D.focus.dia[$ K.IO] >= rcnt){
					
					// Or Parent Dialogue is done....
					D.focus.dia[$ K.I] = D.focus.dia[$ K.IO] // Still set to old so we don't repeat...
					_t[$ K.DN] = T // And remember, this done is normally where we'd find our old iterator for nested structs, but this is different for parent dialogue, WIP
					
				}
				
			#endregion
			
			return isDone
			
		}
		
	#endregion
	
	// Return Noone if Nothing Happened...
	return N
	
}

function diaNar_open_nest(actr,diaInst,lvl) {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	#region Start a Nest diaParLst here...
		
		// Init; We assume diaInst[$ D.focus.dia[$ K.I]] is a struct
		if(!is_struct(diaInst[$ D.focus.dia[$ K.I]])) return F; // If it isn't a struct, how? Return false.
		var rcnt = diaNar_get_line_count(diaInst)
		var rtn = diaNar_iterate_level(diaInst[$ D.focus.dia[$ K.I]],actr.uid,4)
		
		if(is_array(rtn)) {
			
			if(rtn[0] and is_struct(rtn[1])) {
				
				#region Pass; Check and Add to Nested Dialogue List to run...
					
					if(!ds_list_has(D.diaNestLst,rtn[1])) {
						
						// Store Parent/Pre-Nest Iterator if already nested...
						if(!ds_list_empty(D.diaNestLst)) diaInst[$ K.IO] = D.focus.dia[$ K.I]; // Prev Nest
						else D.focus.dia[$ K.IO] = D.focus.dia[$ K.I]; // Parent
						
						// Add nested to nest list...
						ds_list_add(D.diaNestLst,rtn[1]); // New Nest
						D.focus.dia[$ K.I] = 0 // Reset Iter for New Nest...
						
						return T
						
					}
					
				#endregion
				
			} else if(!rtn[0]) {
				
				#region Fail, Skip/Continue
					
					if(lvl == 0) {
						
						// WIP
						// From Parent Dialogue...
						if(D.focus.dia[$ K.I] < rcnt) D.focus.dia[$ K.I]+=1 // Continue Past...
						else if(D.focus.dia[$ K.I] >= rcnt) diaInst[$ K.DN] = T // Or Dialogue is done....
						// We do not need to use IO here because we haven't gone into a new nested layer...
						
					} else {
						
						// From Nested...
						if(D.focus.dia[$ K.I] < rcnt) D.focus.dia[$ K.I]+=1 // Continue Past...
						else if(D.focus.dia[$ K.I] >= rcnt) diaInst[$ K.DN] = T // Or Dialogue is done....
						// We do not need to use IO here because we haven't gone into a new nested layer...
						
					}
					
					return T // We still return true cause still performed as expected...
					
				#endregion
				
			}
			
		} else {
			
			#region Already Done or Total Fail, Iterate Past...
				
				if(lvl == 0) {
					
					// WIP
					// Parent Dialogue (diaInst might be the same as D.focus.dia but for sanity sake...
					if(D.focus.dia[$ K.I] < rcnt) D.focus.dia[$ K.I]+=1 // Continue Past...
					else if(D.focus.dia[$ K.I] >= rcnt) diaInst[$ K.DN] = T // Or Dialogue is done....
					// We do not need to use IO here because we haven't gone into a new nested layer...
					
				} else {
					
					// Nested...
					if(D.focus.dia[$ K.I] < rcnt) D.focus.dia[$ K.I]+=1 // Continue Past...
					else if(D.focus.dia[$ K.I] >= rcnt) diaInst[$ K.DN] = T // Or Dialogue is done....
					// We do not need to use IO here because we haven't gone into a new nested layer...
					
				}
				
				return T // We still return true cause still performed as expected...
				
			#endregion
			
		}
		
	#endregion
	
	return F // If we got here something got borked...
	
}

function diaNar_iterate_level(diaInst,uid,lvl) {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	if(is_struct(diaInst)) {
		
		if(uid != N) {
			
			switch(lvl) {
				
				#region Scene Level (Go to next level if exists...)
					
					case 0: {
						
						// Goto Actor Level... If Exists...
						if(variable_instance_exists(diaInst,string(D.scni)))
							return diaNar_iterate_level(diaInst[$ D.scni],uid,lvl+1);
						break
						
					}
					
				#endregion
				
				#region Actor Level (Go to next level if exists...)
					
					case 1: {
						
						// Goto Instance Level... If Exists...
						if(variable_instance_exists(diaInst,string(uid)))
							return diaNar_iterate_level(diaInst[$ uid],uid,lvl+1);
						break
						
					}
					
				#endregion
				
				#region Instance Level (Recursive)
					
					case 2: {
						
						// Init - Get Parts
						var sks = variable_instance_get_sorted_strKeys(diaInst,T)
						var rks = variable_instance_get_sorted_numKeys(diaInst,T)
						
						// Instance Should only be lines... Unless changed later to include sets...
						// Remember, Instance lines are structs of dialogue/narratives...
						for(var i = 0; i < array_length(rks); i++) {
							
							// Search Instance...
							var e = diaInst[$ rks[i]]
							var rtn = diaNar_iterate_level(e,uid,lvl+1)
							
							// Skip Nulls...
							if(rtn == N) continue;
							
							// Queue Dialogue
							if(is_array(rtn)) {
								
								if(rtn[0]) {
									
									// If is Proceed and is valid Dialogue, add it.
									if(is_struct(rtn[1]) and !ds_list_has(D.diaParLst,[uid,rtn[1]]))
										ds_list_add(D.diaParLst,[uid,rtn[1]]);
									
								}
								
							}
							
							
						}
						break
						
					}
					
				#endregion
				
				#region Dialogue/Narrative Level (Recursive)
					
					case 4:
					case 3: {
						
						#region Init/Done Check
							
							// Init - Get Parts
							var actr = actor_find(uid)
							var sks = variable_instance_get_sorted_strKeys(diaInst,T)
							var rks = variable_instance_get_sorted_numKeys(diaInst,T)
							
							// Done Already - Return Noone
							if(array_contains(sks,K.DN)) {
								
								if(diaInst[$ K.DN]) return N;
								
							}
							
						#endregion
						
						#region Process Dialogue/Narrative Sets... (sks; Triggers, Links, Actors, Ect...)
												
							// proc is whether or not we may (proc)eed with the loop...
							var proc = T
							var rtn = N // What we Return
							var _active = F
							if(!ds_list_empty(D.diaParLst)) {
								
								if(!ds_list_empty(D.diaNestLst)) _active = ds_list_top(D.diaNestLst) == diaInst
								else _active = diaNar_get_par() == diaInst
								
							}
							// If proc is T and rtn is something, that is a successful   , run return
							// If proc is T and rtn is nothing  , that is a continue     , run what we had if anything
							// If proc if F and rtn is something, that is a skip         , not ready to run return
							// If proc is F and rtn is nothing  , that is a total failure, mark as done and forget it
							// This is probably over-done, we probably either return [False and Nothing] or [True and Something] or just Noone...
							// WIP
							
							// Loop through (set)ting keys array (sks; (s)etting (k)ey(s))
							for(var i = 0; i < array_length(sks); i++) {
								
								#region Init/Continues/Skips/Prelims/Breaks
									
									// Proc already set to false? Then we're done, all conditions must be true... For Now... WIP
									var kDone = F
									if(proc == F) break;
									
									// Get Current Key to Check...
									var _k = sks[i]
									
									// Trigger Bypass
									// Level 4 is a nested instance, Triggers don't apply... (Exceptions? WIP)
									if(lvl == 4 and _k == K.TRG) continue;
									
								#endregion
								
								#region Make constants from multi-keys
									
									var _nflg = string(K.INV+K.FLG) // Inverted Flag Check
									var _actrL = string(K.ACT+K.LFT) // Actor Left (focusL)
									var _actrM = string(K.ACT+K.MID) // Actor Left (focusL)
									var _actrR = string(K.ACT+K.RHT) // Actor Right (focusR)
									
								#endregion
								
								switch(_k) {
									
									#region Trigger K.TRG (Parent Dialogue Instance Only (3))
										
										case K.TRG: {
											
											#region Trigger Cases...
												
												switch(diaInst[$ _k]) {
													
													case TRIGGER.START: {
														
														// Done? Should be this simple...
														// Not Done and is Start...
														rtn = diaInst
														break
														
													}
													
													case TRIGGER.SUIT: {
														
														if(actr) {
															
															if(actr.suited != actr.suitedo) {
																
																#region Suit SFX
																	
																	// Zipper SFX
																	if(!audio_is_playing(sfxZip))
																		audio_play_sound(sfxZip,0,F,1);
																	
																	// Prevent Audio Overlap...
																	if(audio_is_playing(sfxZip)) {
																		
																		if(audio_is_playing(sfxSwoosh))
																			audio_stop_sound(sfxSwoosh);
																		
																	}
																
																#endregion
																
																// Set Return
																rtn = diaInst;
																
															}
															
														}
														break
														
													}
													
													case TRIGGER.ANIM: {
														
														if(variable_instance_exists(diaInst,K.ANM)) {
															
															if(NS[$ diaInst[$ K.ANM]])
																rtn = diaNar_iterate_level(diaInst,uid,4); // Check sets for ability to do...
																// If we return N we know it is a no-go, otherwise it will return the dialogue...
															
														}
														break
														
													}
													
													case TRIGGER.CLICK: {
														
														if(actr != N) {
															
															if(MBLR and actr.mouseIn)
																rtn = diaInst;
															
														}
														break
														
													}
													
												}
												
											#endregion
											
											break
											
										}
										
									#endregion
									
									#region Flags K.FLG
										
										case K.FLG: {
											
											#region Normal Flags
												
												if(is_array(diaInst[$ _k])) {
													
													var flagArr = diaInst[$ _k]
													if(is_array(flagArr)) {
														
														if(is_array(flagArr[0])) {
															
															#region WIP When Needed: Multi (2d arr)
																
																/* We'd need this if we had multiple flags to check for a dialogue...
																	[ (2D Array Example of Contents)
																		0:[ 0:V.<Instance Type to Look Inside>, 1:<Instance Name/UID/ID/String>],
																		1:[ 0:V.<Instance Type to Look Inside>, 1:<Instance Name/UID/ID/String>],
																		...
																	]
																*/
																
															#endregion
															
														} else {
															
															#region Single Flag Pair
																
																// [ 0:V.<Instance Type to Look Inside>, 1:<Instance Name/UID/ID/String> ]
																switch(flagArr[0]) {
																	
																	#region Anim Check
																		
																		case V.ANIM: {
																			
																			// flagArr[1] == The Anim(name/str) to find in NS
																			if(variable_instance_exists(NS[$ flagArr[1]],K.DN))
																				proc = NS[$ flagArr[1]][$ K.DN];
																			else proc = F;
																			kDone = T
																			break
																			
																		}
																		
																	#endregion
																	
																}
																
															#endregion
															
														}
														
													}
													
												}
												
											#endregion
											
											// Successful
											if(kDone) break;
											// If we get here, we did not get what we were looking for
											proc = F
											break
											
										}
										
										case _nflg: {
											
											#region Inverse Flags
												
												if(is_array(diaInst[$ _k])) {
													
													var flagArr = diaInst[$ _k]
													if(is_array(flagArr)) {
														
														if(is_array(flagArr[0])) {
															
															#region TODO When Needed: Multi (2d arr)
															
																// See Normal for Example...
																
															#endregion
															
														} else {
															
															#region Single Flag Pair
																
																switch(flagArr[0]) {
																	
																	#region Anim Check
																		
																		case V.ANIM: {
																			
																			// Remember, Inverse, so we don't want the anim to be done in this case...
																			if(variable_instance_exists(NS[$ flagArr[1]],K.DN))
																				proc = !(NS[$ flagArr[1]][$ K.DN]);
																			else proc = T;
																			kDone = T
																			break
																			
																		}
																		
																	#endregion
																	
																}
																
															#endregion
															
														}
														
													}
													
												}
												
											#endregion
										
											// Successful
											if(kDone) break;
											// If we get here, we did not get what we were looking for
											proc = F
											break
											
										}
										
									#endregion
									
									#region Anim Check...
										
										// Rather Redundant, but a simpler flag check specifically for an anim's completion...
										case K.ANM: {
											
											#region Normal
												
												if(variable_instance_exists(diaInst,_k)) {
													
													if(variable_instance_exists(NS,diaInst[$ _k])) {
														
														if(variable_instance_exists(NS[$ diaInst[$ _k]],K.DN)) {
															
															// Is it Done?
															proc = NS[$ diaInst[$ _k]][$ K.DN]
															break
															
														}
														
													}
													
												}
												
											#endregion
											
											// If we get here, this is a total fail, not setup right
											proc = F
											rtn = N
											break
											
										}
										
									#endregion
									
									#region Actor Positions
										
										#region Left
											
											case _actrL: {
												
												if(_active) {
													
													var _actr = actor_find(diaInst[$ _k])
													if(_actr and _actr != D.focusL
														and _actr != D.focusR
														and _actr != D.focusM)
														D.focusL = _actr;
													
												}
												break
												
											}
											
										#endregion
										
										#region Middle
											
											case _actrM: {
												
												if(_active) {
													
													var _actr = actor_find(diaInst[$ _k])
													if(_actr and _actr != D.focusL
														and _actr != D.focusR
														and _actr != D.focusM)
														D.focusM = _actr;
													
												}
												break
												
											}
											
										#endregion
										
										#region Right
											
											case _actrR: {
												
												if(_active) {
													
													var _actr = actor_find(diaInst[$ _k])
													if(_actr and _actr != D.focusL
														and _actr != D.focusR
														and _actr != D.focusM)
														D.focusR = _actr;
													
												}
												break
												
											}
											
										#endregion
										
									#endregion
									
									#region Branch
										
										case K.BR: {
											
											var pass = F
											if(variable_instance_exists(diaInst,K.BR)) {
												
												if(is_array_ext(diaInst[$ K.BR],2,N)) {
													
													var _k = diaInst[$ K.BR][0]
													var _e = diaInst[$ K.BR][1]
													switch(_k) {
														
														#region Branch Type[0,_k]... (i.e. V.SUIT[0,_k] = is <char>[1,_e] suited?)
														
														case V.SUIT: {
															
															if(ds_list_has(D.actorLst,_e)) {
																
																rtn = diaInst[$ _e.suited]
																pass = T
																
															}
															
															break
															
														}
														
														#endregion
														
													}
													
												}
												
											}
											
											if(pass) proc = T; // Return proc to true since we got the T/F for the branch...
											else {
												
												proc = F
												rtn = N
												
											}
											
											
											break
											
										}
										
									#endregion
									
									#region Option
										
										case K.OPT: {
											
											// Set Options somehow to draw in diaNar_draw()?
											// Just Draw Here...
											var _e = diaInst[$ _k]
											if(is_array(_e)) {
												
												for(var i2 = 0; i2 < array_length(_e); i2++) {
													
													// Option already selected? Rtn is set...
													if(rtn != N) break;
													
													var _e2 = _e[i2]
													if(is_string(_e2)) {
														
														#region String Option (Normal; i2 -> diaInst key)
															
															var _xy = []
															_xy[0] = WW*.33
															_xy[2] = WW*.67
															_xy[3] = (WH*.3)+((i2+1)*200)
															_xy[1] = _xy[3]-200
															var rtn2 = draw_button_fxl(_xy,bgc_,fgc_,_e2,BUTTON.DIA_GOTO,T)
															if(rtn2 == N) D.diaHold = T;
															else D.diaHold = F;
															if(rtn2 == BUTTON.DIA_GOTO) rtn = diaInst[$ i2]; // Means this was picked
															continue
															
														#endregion
														
													} else {
														
														#region Value Option
															
															switch(_e2) {
																
																case BUTTON.DIA_LEAVE: {
																	
																	var _xy = []
																	_xy[0] = WW*.33
																	_xy[2] = WW*.67
																	_xy[3] = (WH*.3)+((i2+1)*200)
																	_xy[1] = _xy[3]-200
																	var rtn2 = draw_button_fxl(_xy,bgc_,fgc_,"Leave",BUTTON.DIA_LEAVE,T)
																	if(rtn2 == N) D.diaHold = T;
																	else D.diaHold = F;
																	if(rtn2 == BUTTON.DIA_LEAVE) diaNar_close(F);
																	continue
																	
																}
																
															}
															
														#endregion
														
													}
													
												}
												
											}
											break
											
										}
										
									#endregion
									
								}
								
								#region Finalize Nested...
									
									if(lvl >= 4 and !rtn) {
										
										// Made it through all checks with no fails?
										if(i == array_length(sks)-1 and proc)
											rtn = diaInst;
										
									}
									
								#endregion
								
							}
							
						#endregion
						
						#region Process diaNarr Lines... (rks; 0,1,2...)
							
							return [proc,rtn]
							
						#endregion
						break
						
					}
					
				#endregion
				
			}
			
		} else {
			
			// NO UID
			// TODO: Non-Actor?
			
		}
		
	}
	
	return N
	
}

function diaNar_get_par() {
	
	// Return Struct or None
	if(!ds_list_empty(D.diaParLst)) return D.diaParLst[|0][1];
	else return N;
	
}

function diaNar_get_lines(diaInst) {
	
	var rtn = []
	if(is_struct(diaInst)) {
		
		var ks = variable_instance_get_names(diaInst)
		for(var i = 0; i < array_length(ks); i++) {
			
			var k = ks[i]
			if(is_string_real(k)) rtn[array_length(rtn)] = k;
			
		}
		
	}
	
	if(rtn == []) return N;
	return rtn
	
}

function diaNar_get_sets(diaInst) {
	
	var rtn = []
	if(is_struct(diaInst)) {
		
		var ks = variable_instance_get_names(diaInst)
		for(var i = 0; i < array_length(ks); i++) {
			
			var k = ks[i]
			if(!is_string_real(k)) rtn[array_length(rtn)] = k;
			
		}
		
	}
	
	if(rtn == []) return N;
	return rtn
	
}

function diaNar_get_line_count(struct) {
	
	var tmp = variable_instance_get_sorted_numKeys(struct,T)
	if(is_array(tmp)) return (array_length(tmp)-1);
	else return N;
	
}

function diaNar_draw(actr,diaInst,diaLyr){
	
	//try { /* GMLive Call */ 
	if (live_call()) return live_result;// } catch(_ex) { /* GMLive not available? */ }
	
	// Init
	var _spr = sprNA
	if(actr.suited) _spr = actr.body;
	else _spr = actr.head;
	var _scl = (WH*.8)/sprite_get_height(_spr)
	
	#region Draw Head(s) (Full Close-Up Head) or Body(s) (Zoomed Bust) (Unnested)
		
		if(D.diaDelPct >= 1) {
			
			if(actr == D.focusL) {
				
				#region 1st focusL/Left Side
					
					if(D.diaSpeaker == actr) {
						
						// Is Speaking...
						if(actr.head == _spr) draw_sprite_ext(_spr,0,-WW*.1,WH*.9,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.headpol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
						else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.1,WH*.9,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.bodypol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
						
					} else {
						
						// isn't Speaking...
						if(actr.head == _spr) draw_sprite_ext(_spr,0,-WW*.1,WH*.9,(_scl-((_scl*.1)*D.diaTranPct))*actr.headpol,_scl-((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
						else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.1,WH*.9,(_scl-((_scl*.1)*D.diaTranPct))*actr.bodypol,_scl-((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
						
					}
					
				#endregion
				
			} else if(actr == D.focusM) {
				
				#region 3rd focusL/Middle Side (Flip x axis to face currently speaking focusL? Currently Treated like 2nd Focus only)
					
					if(D.diaSpeaker == actr) {
						
						// Is Speaking...
						if(actr.head == _spr) draw_sprite_ext(_spr,0,-WW*.5,WH*.9,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.headpol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
						else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.5,WH*.9,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.bodypol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
						
					} else {
						
						// isn't Speaking...
						if(actr.head == _spr) draw_sprite_ext(_spr,0,-WW*.5,WH*.9,(_scl-((_scl*.1)*D.diaTranPct))*actr.headpol,_scl-((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
						else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.5,WH*.9,(_scl-((_scl*.1)*D.diaTranPct))*actr.bodypol,_scl-((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
						
					}
					
				#endregion
				
			} else if(actr == D.focusR) {
				
				#region 2nd focusL/Right Side
					
					if(D.diaSpeaker == actr) {
						
						// Is Speaking...
						if(actr.head == _spr) draw_sprite_ext(_spr,0,-WW*.9,WH*.9,((_scl*.9)+((_scl*.1)*D.diaTranPct))*-actr.headpol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
						else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.9,WH*.9,((_scl*.9)+((_scl*.1)*D.diaTranPct))*-actr.bodypol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
						
					} else {
						
						// isn't Speaking...
						if(actr.head == _spr) draw_sprite_ext(_spr,0,-WW*.9,WH*.9,(_scl-((_scl*.1)*D.diaTranPct))*-actr.headpol,_scl-((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
						else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.9,WH*.9,(_scl-((_scl*.1)*D.diaTranPct))*-actr.bodypol,_scl-((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
						
					}
					
				#endregion
				
			}
			
			#region Iterate diaTran
				
				if(actr == D.diaSpeaker and D.diaDelPct2 >= 1) {
					
					if(D.diaTranDeli < D.diaTranDel) D.diaTranDeli = clamp(D.diaTranDeli+1,0,D.diaTranDel);
					D.diaTranPct = D.diaTranDeli/D.diaTranDel
					
				}
				
			#endregion
			
		}
		
	#endregion
	
	#region Draw Dialogue & Control
		
		if(D.diaDelPct2 >= 1) {
			
			#region Name Plate
				
				#region Init
					
					var _c = actr.col
					var nm = "Unknown"
					var	w = WW*.1  // Left X
					if(actr == D.focusM) w = WW*.5; // Middle X
					if(actr == D.focusR) w = WW*.9; // Right X
					var h = (WH*.9)-1
					draw_set_font(fNeuB)
					
				#endregion
				
				#region Player or Character?
					
					if(actr == P) {
						
						#region Player
							
							nm = "You"
							if(variable_instance_exists(actr.dia,K.KNW))
								if(actr.dia[$ K.KNW]) nm = actr.dia[$ K.NM]+" (You)";
							
						#endregion
						
					} else {
						
						#region Is Character
							
							if(variable_instance_exists(actr.dia,K.KNW)) {
								
								// Set Name...
								if(actr.dia[$ K.KNW]) nm = actr.dia[$ K.NM];
								
								// Set Sex Font...
								if(variable_instance_exists(actr.dia,K.SX)) {
									
									if(actr.dia[$ K.SX] == SEX.FEMALE) draw_set_font(fFemB);
									else draw_set_font(fMalB);
									
								}
								
							}
							
						#endregion
						
					}
					
				#endregion
				
				#region Init 2
					
					var fRht = (D.focusR == D.diaSpeaker)
					var _w = string_width(nm)
					draw_set_hvalign([fa_left,fa_middle])
					
				#endregion
				
				#region Name Box
					
					shader_set(shTranGradientBlk)
					var _xy = [w-(_w/4),(WH*.88)-STRH,w+(_w*1.25),h];
					if(fRht) _xy = [w,(WH*.88)-STRH,w+(_w*1.5),h];
					draw_rectangle_color(_xy[0],_xy[1],_xy[2],_xy[3],c.blk,c.blk,c.nr,c.nr,F) // Red cause shader works that way for gradient... lol
					shader_reset()
					if(DBG.edit) draw_rectangle_color(_xy[0],_xy[1],_xy[2],_xy[3],c.nr,c.nr,c.nr,c.nr,T);
					
				#endregion
				
				#region Draw Name
					
					if(fRht) draw_text_color(w,(WH*.89)-(STRH/2),nm,_c[0],_c[1],_c[2],_c[3],1);
					else draw_text_color(w,(WH*.89)-(STRH/2),nm,_c[0],_c[1],_c[2],_c[3],1);
					
				#endregion
				
			#endregion
			
			#region Is the Speaker? (Draw the actual Dialogue)
				
				if(actr == D.diaSpeaker) {
					
					#region Init
						
						var _scl = WW/1600
						if(D.focusR == D.diaSpeaker) _xy = [_xy[0],h,WW*.9,WH*.5];
						else _xy = [_xy[2],h,WW*.9,WH*.5];
						var _str = diaInst[$ string(D.focus.dia[$ K.I])]
						var _str = diaInst[$ string(D.focus.dia[$ K.I])]
						var _c = actr.col
						draw_set_font(actr.font)
						var _strsep = (STRH*1.5)*_scl
						var _pad = STRW*_scl
						var _strwmx = (WW/3)-(_pad*2)
						var _strw = string_width_ext(_str,_strsep,_strwmx)*_scl
						var _strh = string_height_ext(_str,_strsep,_strwmx)*_scl
						draw_set_valign(fa_bottom)
						draw_set_halign(fa_left)
						if(D.diaSpeaker == D.focusR) {
							
							_strw*=-1
							draw_set_halign(fa_right)
							
						}
						
					#endregion
					
					#region Line Effect & Narrative Draw Logix
						
						var rcnt = diaNar_get_line_count(diaInst)
						if(rcnt != N and !is_struct(diaInst[$ D.focus.dia[$ K.I]])) {
							
							#region Continue Dialogue...
								
								// Get Dialogue Level...
								var rtn = diaNar_iterate_level(diaInst,actr.uid,4)
								
								if(is_array(rtn)) {
									
									if(rtn[0]) {
										
										#region Auxiliary(Indirect) Operations or Primary(Direct) Operations
											
											if(rtn[1] and rtn[1] != diaInst) {
												
												#region Indirect Operations...
													
													#region New Nest
														
														if(is_struct(rtn[1]))
															diaNar_open_nest(actr,rtn[1],diaLyr); // Open Nest Attempt; Will move on if unable...
														
													#endregion
													
												#endregion
												
											} else {
												
												#region Direct Operations...
													
													// Get Content
													var _e = diaInst[$ D.focus.dia[$ K.I]]
													
													if(!is_string_real(_e) and D.diaTranPct >= 1) {
														
														#region Is Dialogue
															
															#region Text Box
																
																if(diaLyr == ds_list_size(D.diaNestLst)) {
																	
																	draw_set_alpha(.9)
																	if(fRht) {
																		
																		_xy[2] = clamp(_xy[0]-_strw,_xy[0]+1,_xy[2])+(_pad*2)
																		_xy[3] = clamp(_xy[1]-_strh,_xy[3],_xy[1])-(_pad*2)
																		
																	} else {
																		
																		_xy[2] = clamp(_xy[0]+_strw,_xy[0]+1,_xy[2])+(_pad*2)
																		_xy[3] = clamp(_xy[1]-_strh,_xy[3],_xy[1])-(_pad*2)
																		
																	}
																	draw_rectangle_color(_xy[0],_xy[1],_xy[2],_xy[3],c.blk,c.blk,c.blk,c.blk,F)
																	draw_set_alpha(1)
																	draw_rectangle_color(_xy[0],_xy[1],_xy[2],_xy[3],_c[1],_c[2],c.blk,c.blk,T)
																	
																}
																
															#endregion
															
															#region Draw Text
																
																// Draw Lines... If the line was a struct it would of got redirected anyway...
																draw_text_ext_transformed_color(_xy[0]+_pad,_xy[1]+_pad,_e,_strsep,_strwmx,_scl,_scl,0,_c[0],_c[1],_c[2],_c[3],1)
																if(keyboard_check_pressed(vk_enter) and D.focus.dia[$ K.I] < rcnt) D.focus.dia[$ K.I] += 1
																else if(keyboard_check_pressed(vk_enter) and D.focus.dia[$ K.I] >= rcnt) diaInst[$ K.DN] = T
																
															#endregion
															
														#endregion
														
													} else if(is_string_real(_e) and D.diaTranPct >= 1) {
														
														#region Is (V)alue
															
															#region Do Value Actions
																
																switch(_e) {
																	
																	#region Set Dialogue Speaker
																		
																		#region Actor Left...
																			
																			case V.LEFT: {
																				
																				if(D.focusL) D.diaSpeaker = D.focusL;
																				// Reset TranDel (Speaker Transition Delay)
																				D.diaTranDeli = 0
																				D.diaTranPct = 0
																				break
																				
																			}
																			
																		#endregion
																		
																		#region Actor Middle...
																			
																			case V.MIDDLE: {
																				
																				if(D.focusM) D.diaSpeaker = D.focusM;
																				// Reset TranDel (Speaker Transition Delay)
																				D.diaTranDeli = 0
																				D.diaTranPct = 0
																				break
																				
																			}
																			
																		#endregion
																		
																		#region Actor Right...
																			
																			case V.RIGHT: {
																				
																				if(D.focusR) D.diaSpeaker = D.focusR;
																				// Reset TranDel (Speaker Transition Delay)
																				D.diaTranDeli = 0
																				D.diaTranPct = 0
																				break
																				
																			}
																			
																		#endregion
																		
																	#endregion
																	
																}
																
															#endregion
															
															#region Iterate past value...
																
																if(D.focus.dia[$ K.I] < rcnt) D.focus.dia[$ K.I] += 1
																else if(D.focus.dia[$ K.I] >= rcnt) diaInst[$ K.DN] = T
																
															#endregion
															
														#endregion
														
													}
													
												#endregion
												
											}
											
										#endregion
										
										
									}
									
								} else {
									
									#region Return Was Noone... Anyting Else?
										
										if(rtn == N) {
											
											// How did this happen?
											diaInst[$ K.DN] = T; // This is Done?
											D.focus.dia[$ K.I] = rcnt
											
										}
										
									#endregion
									
								}
								
								#region Update Old...
									
									if(diaLyr == 0) D.focus.dia[$ K.IO] = D.focus.dia[$ K.I]; // Level 0; Parent
									else diaInst[$ K.IO] = D.focus.dia[$ K.I]; // Level 1+; Nest
									
								#endregion
								
							#endregion
							
						} else if(is_struct(diaInst[$ D.focus.dia[$ K.I]])) {
							
							if(!D.diaHold) diaNar_open_nest(actr,diaInst,diaLyr); // Open Nest Attempt; Will move on if unable...
							else diaNar_iterate_level(diaInst,actr.uid,4);
							
						}
						
					#endregion
					
					#region Iterate Dialogue (Done!)
						
						if(diaInst[$ K.DN]) {
							
							#region Trigger Actions
								
								if(variable_instance_exists(diaInst,K.ATN)) {
									
									switch(diaInst[$ K.ATN]) {
										
										case BUTTON.DIA_LEAVE: {
											
											if(in_party(actr)) leave_party(actr);
											break
											
										}
										
									}
									
								}
								
							#endregion
							
							// Do the Close
							diaNar_close(!D.diaSoftDone)
							
						}
						
					#endregion
					
				}
				
			#endregion
			
		}
		
	#endregion Draw Dialogue & Control
	
	#region Resets
		
		draw_set_font(fNeu)
		draw_set_alpha(1)
		
	#endregion
	
}