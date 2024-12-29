function diaNar_focus_reset() {
	
	// Empty Focuses
	D.focus  = N
	D.focusL = N
	D.focusR = N
	D.focusM = N
	D.diaSpeaker = N
	D.diaTranDeli = 0
	D.diaTranPct = 0
	D.diaSoftClose = F
	
}

function diaNar_close(isDone) {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	
	#region Close Out Current...
		
		D.diaSoftClose = !isDone
		
		if(!ds_list_empty(D.diaNestLst)) {
			
			// Finish the current nest...
			var _t = ds_list_top(D.diaNestLst)
			_t[$ K.DN] = isDone
			ds_list_del_top(D.diaNestLst)
			D.diaNestDir = F
			
		} else if(!ds_list_empty(D.diaParLst)) {
			
			// Finish parent...
			var _t = diaNar_get_par()
			_t[$ K.DN] = isDone
			ds_list_delete(D.diaParLst,0)
			D.focus.dia[$ K.I] = 0
			diaNar_focus_reset()
			D.diaNestDir = T // Since this is finishing the parent, we reset this...
			return isDone
			
		} else return N; // No Dialogue to close...
		
	#endregion
	
	#region Return to Previous...
		
		if(!ds_list_empty(D.diaNestLst)) {
			
			#region Back to Previous Nest Level... (Nest to Nest)
				
				// Returning to previous nest...
				var _t = ds_list_top(D.diaNestLst)
				var rcnt = diaNar_get_real_keys_count(_t)
				var _fork = diaNar_is_fork(_t)
				var _choice = diaNar_is_choice(_t)
				var _nxt = diaNar_next_dia(isDone)
				D.diaNestDir = _choice
				
				if(_fork and !_choice) {
					
					diaNar_close(isDone)
					
				} else if(_choice) {
					
					// Should iterate elsewhere
					_t[$ K.DN] = F
					D.diaNestDir = T
					
				} else {
					
					#region Resume Prev Nest
						
						if(_t[$ K.IO] < rcnt) {
							
							// Continue Past...
							D.focus.dia[$ K.I] = _t[$ K.IO]+1
							
						} else if(_t[$ K.IO] >= rcnt) {
							
							// Or previous nest is also done....
							D.focus.dia[$ K.I] = _t[$ K.IO] // Still set to old so we don't repeat...
							_t[$ K.DN] = isDone
							
						}
						
					#endregion
					
					
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
				var rcnt = diaNar_get_real_keys_count(_t)
				
				if(D.focus.dia[$ K.IO] < rcnt) {
					
					// Continue Past...
					D.focus.dia[$ K.I] = D.focus.dia[$ K.IO]+1 // Iterate Old Iterator to Resume after the nest...
					
				} else if(D.focus.dia[$ K.IO] >= rcnt){
					
					// Or Parent Dialogue is done....
					D.focus.dia[$ K.I] = D.focus.dia[$ K.IO] // Still set to old so we don't repeat...
					_t[$ K.DN] = isDone // And remember, this done is normally where we'd find our old iterator for nested structs, but this is different for parent dialogue, WIP
					
				}
				
			#endregion
			
			return isDone
			
		}
		
	#endregion
	
	// Return Noone if Nothing Happened...
	return N
	
}

function diaNar_open_nest(actr,diaInst,diaLyr) {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	#region Start a Nest diaParLst here...
		
		// Init; We assume diaInst[$ diaNarI()] is a struct
		var _dia = diaInst[$ diaNarI()]
		if(!is_struct(_dia)) return F; // If it isn't a struct, how? Return false.
		var rcnt = diaNar_get_real_keys_count(diaInst)
		var _rtn = diaNar_iterate_level(_dia,actr.uid,4)
		
		if(is_array(_rtn)) {
			
			if(_rtn[0] and is_struct(_rtn[1])) {
				
				if(diaNar_is_fork(_dia) and _rtn[1] != _dia) {
					
					#region Pass(Fork); Check and Add to Nested Dialogue List to run...
						
						if(!ds_list_has(D.diaNestLst,_rtn[1])) {
							
							// Add nested to nest list...
							ds_list_add(D.diaNestLst,_dia) // Add Fork to Nest List...
							ds_list_add(D.diaNestLst,_rtn[1]) // Add Results from Fork to Nest List...
							D.focus.dia[$ K.I] = 0 // Reset Iter for New Nest...
							D.diaNestDir = T
							return T
							
						}
						
					#endregion
					
				} else if(_rtn[1] == _dia) {
					
					#region Pass; Check and Add to Nested Dialogue List to run...
						
						if(!ds_list_has(D.diaNestLst,_rtn[1])) {
							
							// Add nested to nest list...
							ds_list_add(D.diaNestLst,_rtn[1]); // New Nest
							D.focus.dia[$ K.I] = 0 // Reset Iter for New Nest...
							D.diaNestDir = T
							
							return T
							
						}
						
					#endregion
					
				}
				
			} else if(!_rtn[0]) {
				
				#region Fail, Skip/Continue
					
					if(diaLyr == 0) {
						
						// WIP
						// From Parent Dialogue...
						if(diaNarI() < rcnt) D.focus.dia[$ K.I]+=1 // Continue Past...
						else if(diaNarI() >= rcnt) diaInst[$ K.DN] = T // Or Dialogue is done....
						// We do not need to use IO here because we haven't gone into a new nested layer...
						
					} else {
						
						// From Nested...
						if(diaNarI() < rcnt) D.focus.dia[$ K.I]+=1 // Continue Past...
						else if(diaNarI() >= rcnt) diaInst[$ K.DN] = T // Or Dialogue is done....
						// We do not need to use IO here because we haven't gone into a new nested layer...
						
					}
					
					return T // We still return true cause still performed as expected...
					
				#endregion
				
			}
			
		} else {
			
			#region Already Done or Total Fail, Iterate Past...
				
				if(diaLyr == 0) {
					
					// WIP
					// Parent Dialogue (diaInst might be the same as D.focus.dia but for sanity sake...
					if(diaNarI() < rcnt) D.focus.dia[$ K.I]+=1 // Continue Past...
					else if(diaNarI() >= rcnt) diaInst[$ K.DN] = T // Or Dialogue is done....
					// We do not need to use IO here because we haven't gone into a new nested layer...
					
				} else {
					
					// Nested...
					if(diaNarI() < rcnt) D.focus.dia[$ K.I]+=1 // Continue Past...
					else if(diaNarI() >= rcnt) diaInst[$ K.DN] = T // Or Dialogue is done....
					// We do not need to use IO here because we haven't gone into a new nested layer...
					
				}
				
				return T // We still return true cause still performed as expected...
				
			#endregion
			
		}
		
	#endregion
	
	return F // If we got here something got borked...
	
}

function diaNar_is_fork(diaInst) {
	
	// It's a fork if every line is a struct...
	var rks = diaNar_get_real_keys(diaInst)
	var rtn = T
	for(var i = 0; i < array_length(rks); i++) {
		
		if(!rtn) break;
		else if(!is_struct(diaInst[$ rks[i]])) rtn = F;
		
	}
	
	return rtn
	
}

function diaNar_is_dia(diaInst) {
	
	return (!diaNar_is_fork(diaInst) and !diaNar_is_choice(diaInst))
	
}

function diaNar_next_dia(close) {
	
	if(D.diaNestDir) {
		
		// Up/Open
		if(!ds_list_empty(D.diaNestLst)) return diaNar_get_top(); // Gonna be a lil weird iteration
		else return diaNar_get_par();
		
	} else {
		
		// Down/Close
		for(var i = ds_list_size(D.diaNestLst)-1; i >= 0; i--) {
			
			var _dia = D.diaNestLst[|i]
			if(!diaNar_is_fork(_dia) and !diaNar_is_choice(_dia) and _dia != diaNar_get_top()) return _dia; // Got one...
			
		}
		
		return diaNar_get_par() // If none else try to get par
		
	}
	
	return N
	
}

// Will get any key that starts with bypass
function diaNar_get_bypass(inst) {
	
	var rtn = N
	var rtnArr = []
	var _sks = variable_instance_get_sorted_strKeys(inst,T)
	for(var i = 0; i < array_length(_sks); i++) {
		
		if(string_starts_with(_sks[i],K.BYP) and rtn == N) rtn = _sks[i]; // Set Single Bypass Found...
		else if(string_starts_with(_sks[i],K.BYP)) {
			
			// Multiple Bypasses Found? Use Array.
			if(rtnArr == []) rtn[0] = rtn;
			rtnArr[array_length(rtnArr)] = _sks[i]
			
		}
		
	}
	
	// Return N if none found, Single if 1 found, Array if 1+
	if(rtnArr == []) return rtn;
	else return rtnArr;
	
}

// To expand with any new dialogue mechanics that act as a choice for the player... (ie option)
function diaNar_is_choice(diaInst) {
	
	// It's a fork if every line is a struct...
	var sks = diaNar_get_string_keys(diaInst)
	var rtn = F
	for(var i = 0; i < array_length(sks); i++) {
		
		if(rtn) break;
		else if(sks[i] == K.OPT) rtn = T; // Option, expand this else if to add different options...
		
	}
	
	return rtn
	
}

function diaNar_is_nest_open(diaInst) {
	
	return ds_list_has(D.diaNestLst,diaInst)
	
}

function diaNar_get_top() {
	
	if(!ds_list_empty(D.diaNestLst)) return ds_list_top(D.diaNestLst);
	else return diaNar_get_par();
	
}

function diaNar_done(inst) {
	
	var _rtn = struct_find(inst,K.DN)
	if(is_undefined(_rtn)) return F
	else return _rtn;
	
}

function diaNar_iterate_level(diaInst,uid,diaLyr) {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	if(is_struct(diaInst)) {
		
		if(uid != N) {
			
			switch(diaLyr) {
				
				#region 0 Scene Level (Go to next level if exists...)
					
					case 0: {
						
						// Goto Actor Level... If Exists...
						if(variable_instance_exists(diaInst,string(D.scni)))
							return diaNar_iterate_level(diaInst[$ D.scni],uid,diaLyr+1);
						break
						
					}
					
				#endregion
				
				#region 1 Actor Level (Go to next level if exists...)
					
					case 1: {
						
						// Goto Instance Level... If Exists...
						if(variable_instance_exists(diaInst,string(uid)))
							return diaNar_iterate_level(diaInst[$ uid],uid,diaLyr+1);
						break
						
					}
					
				#endregion
				
				#region 2 Instance Level (Recursive)
					
					case 2: {
						
						// Init - Get Parts
						var _sks = variable_instance_get_sorted_strKeys(diaInst,T)
						var _rks = variable_instance_get_sorted_numKeys(diaInst,T)
						
						// Instance Should only be lines... Unless changed later to include sets...
						// Remember, Instance lines are structs of dialogue/narratives...
						for(var i = 0; i < array_length(_rks); i++) {
							
							// Search Instance...
							var e = diaInst[$ _rks[i]]
							var _rtn = diaNar_iterate_level(e,uid,diaLyr+1)
							
							// Skip Nulls...
							if(_rtn == N) continue;
							
							// Queue Dialogue
							if(is_array(_rtn)) {
								
								if(_rtn[0]) {
									
									// If is Proceed and is valid Dialogue, add it.
									if(is_struct(_rtn[1]) and !ds_list_has(D.diaParLst,[uid,_rtn[1]]))
										ds_list_add(D.diaParLst,[uid,_rtn[1]]);
									
								}
								
							}
							
							
						}
						break
						
					}
					
				#endregion
				
				#region 3 & 4+ Dialogue/Narrative Level (Recursive)
					
					// 3 == Parent Dialogue
					// 4+ == Nested Dialogue
					default: {
						
						#region Init/Done Check
							
							// Erroneous Entry, Break out...
							if(!is_real(diaLyr)) break;
							else if(diaLyr < 3) break;
							
							// Init - Get Parts
							var actr = actor_find(uid)
							var _sks = variable_instance_get_sorted_strKeys(diaInst,T)
							var _rks = variable_instance_get_sorted_numKeys(diaInst,T)
							
						#endregion
						
						#region Process Dialogue/Narrative Sets... (_sks; Triggers, Links, Actors, Ect...)
							
							// If _proc is T and _rtn is something, that is a successful   , run return
							// If _proc is T and _rtn is nothing  , that is a continue     , run what we had if anything
							// If _proc if F and _rtn is something, that is a skip         , not ready to run return
							// If _proc is F and _rtn is nothing  , that is a total failure, mark as done and forget it
							// This is probably over-done, we probably either return [False and Nothing] or [True and Something] or just Noone...
							// WIP
							
							#region Make constants for multi-part keys /*#as needed...*/
								
								var _nflg = string(K.INV+K.FLG) // Inverted Flag Check
								var _nanm = string(K.INV+K.ANM) // Inverted Anim Check
								var _actrL = string(K.ACT+K.LFT) // Actor Left (focusL)
								var _actrM = string(K.ACT+K.MID) // Actor Left (focusL)
								var _actrR = string(K.ACT+K.RHT) // Actor Right (focusR)
								var _bypd  = string(K.BYP+K.DN)  // Bypass Done (to Struct)
								
							#endregion
							
							var _proc = T // Whether we may (proc)eed with our return or not...
							var _rtn = N // Dialogue we return if any
							var _isCurrent = F // Is what we're iterating the current dialogue? (Usually is...)
							#region Is Current Init
								
								if(!ds_list_empty(D.diaParLst)) {
									
									if(!ds_list_empty(D.diaNestLst)) _isCurrent = (ds_list_top(D.diaNestLst) == diaInst);
									else _isCurrent = (diaNar_get_par() == diaInst);
									
								}
								
							#endregion
							var _isFork = diaNar_is_fork(diaInst) // Is this dialogue just a fork? (All rks elements are structs)
							if(_isFork and !D.diaNestDir) {
								
								_proc = F
								_rtn = diaInst
								
							}
							var _byp = diaNar_get_bypass(diaInst)
							var _isBypassing = F
							var _isTrgd = F
							
							// Loop through (set)ting keys array (_sks; (s)etting (k)ey(s))
							for(var i = 0; i < array_length(_sks); i++) {
								
								#region Init
									
									// Get Current Key to Check...
									var _k = _sks[i]
									// This key is already done... (Some keys might have nested blocks so we need this to prevent defaults)
									var _kdone = F
									
									// Proc already set to false? Then we're done, all conditions must be true... For Now... WIP
									if(_proc == F) break;
									
								#endregion
								
								switch(_k) {
									
									#region Trigger K.TRG (Parent Dialogue Only [diaLyr == 3]) RTN
										
										// Triggers will set rtn to this dialogue upon success and will run it if still _proc
										case K.TRG: {
											
											if(diaLyr == 3) {
												
												#region Trigger Cases...
													
													switch(diaInst[$ _k]) {
														
														// Just starts!
														case TRIGGER.START: {
															
															// Done? Should be this simple...
															// Not Done and is Start...
															if(!diaNar_done(diaInst)) _rtn = diaInst;
															else if(_byp != N) {
																
																if(!is_array(_byp)) {
																	
																	#region Single Bypass Condition...
																		
																		// Currently the kind of bypass is not taken into consideration...
																		// Just if it is set and is a struct, use it...
																		if(is_struct(diaInst[$ _byp])) {
																			
																			_rtn = diaInst[$ _byp]
																			_isBypassing = T
																			
																		}
																		
																	#endregion
																	
																} // TODO else? Multi-Bypass?
																
															}
															break
															
														}
														
														// Triggers when suit status has changed (a single frame check...)
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
																	if(!diaNar_done(diaInst)) _rtn = diaInst;
																	else if(_byp != N) {
																		
																		if(!is_array(_byp)) {
																			
																			#region Single Bypass Condition...
																				
																				// Currently the kind of bypass is not taken into consideration...
																				// Just if it is set and is a struct, use it...
																				if(is_struct(diaInst[$ _byp])) {
																					
																					_rtn = diaInst[$ _byp]
																					_isBypassing = T
																					
																				}
																				
																			#endregion
																			
																		} // TODO else? Multi-Bypass?
																		
																	}
																	
																}
																
															}
															break
															
														}
														
														// Triggers like TRIGGER.START after an ANIM is completed
														case TRIGGER.ANIM: {
															
															if(variable_instance_exists(diaInst,K.ANM)) {
																
																if(NS[$ diaInst[$ K.ANM]]) {
																	
																	// Check sets for ability to do...
																	// If we return N we know it is a no-go, otherwise it will return the dialogue...
																	if(!diaNar_done(diaInst)) _rtn = diaNar_iterate_level(diaInst,uid,4);
																	else if(_byp != N) {
																		
																		if(!is_array(_byp)) {
																			
																			#region Single Bypass Condition...
																				
																				// Currently the kind of bypass is not taken into consideration...
																				// Just if it is set and is a struct, use it...
																				if(is_struct(diaInst[$ _byp])) {
																					
																					_rtn = diaInst[$ _byp]
																					_isBypassing = T
																					
																				}
																				
																			#endregion
																			
																		} // TODO else? Multi-Bypass?
																		
																	}
																	
																}
																
															}
															break
															
														}
														
														// Trigger Dialogue When Clicking a Character in the scene...
														case TRIGGER.CLICK: {
															
															// Actor Sanity...
															if(actr != N) {
																
																// Mouse In the Actor...
																if(actr.mouseIn) {
																	
																	// Debug Send...
																	if(instance_exists(DBG)) {
																		
																		if(DBG.active) DBG.diaPrev = diaInst;
																		
																	}
																	
																	if(!diaNar_done(diaInst)) {
																		
																		// Set to available in actor... If it is...
																		actr.diaAvailable = T;
																		
																		// Clicked & Activate...
																		if(MBLR) _rtn = diaInst;
																		
																	} else if(_byp != N) {
																		
																		if(!is_array(_byp)) {
																			
																			#region Single Bypass Condition...
																				
																				// Currently the kind of bypass is not taken into consideration...
																				// Just if it is set and is a struct, use it...
																				if(is_struct(diaInst[$ _byp])) {
																					
																					// Set to available in actor... If it is...
																					actr.diaAvailable = T;
																					
																					// Clicked & Activate...
																					if(MBLR)  {
																						
																						_rtn = diaInst[$ _byp]
																						_isBypassing = T
																						
																					}
																					
																				}
																				
																			#endregion
																			
																		} // TODO else? Multi-Bypass?
																		
																	}
																	
																}
																
															}
															break
															
														}
														
													}
													
												#endregion
												
												if(_rtn != N) _isTrgd = T;
												
											}
											
											break
											
										}
										
									#endregion
									
									#region Flags K.FLG PROC
										
										// Flags help determine if we _proc or not...
										case K.FLG: {
											
											#region Normal Flag
												
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
																				_proc = NS[$ flagArr[1]][$ K.DN];
																			_kdone = T
																			break
																			
																		}
																		
																	#endregion
																	
																}
																
															#endregion
															
														}
														
													}
													
												}
												
											#endregion
											
											// If we get here, we did not get what we were looking for
											if(!_kdone) _proc = F;
											break
											
										}
										
										case _nflg: {
											
											#region Inverse Flag
												
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
																				_proc = !(NS[$ flagArr[1]][$ K.DN]);
																			_kdone = T
																			break
																			
																		}
																		
																	#endregion
																	
																}
																
															#endregion
															
														}
														
													}
													
												}
												
											#endregion
											
											// If we get here, we did not get what we were looking for
											if(!_kdone) _proc = F;
											break
											
										}
										
									#endregion
									
									#region Simple Anim Checks... PROC
										
										// Simple anim checks is like a flag and determines whether or not we continue...
										case K.ANM: {
											
											#region Normal
												
												if(variable_instance_exists(diaInst,_k)) {
													
													if(variable_instance_exists(NS,diaInst[$ _k])) {
														
														if(variable_instance_exists(NS[$ diaInst[$ _k]],K.DN)) {
															
															// Is this anim Done?
															_proc = NS[$ diaInst[$ _k]][$ K.DN]
															_kdone = T
															
														}
														
													}
													
												}
												
											#endregion
											
											// If we get here, this is a total fail, not setup right
											if(!_kdone) _proc = F;
											break
											
										}
										
										// Rather Redundant, but a simpler flag check specifically for an anim's completion... (Inverted)
										case _nanm: {
											
											#region Inverted
												
												if(variable_instance_exists(diaInst,_k)) {
													
													if(variable_instance_exists(NS,diaInst[$ _k])) {
														
														if(variable_instance_exists(NS[$ diaInst[$ _k]],K.DN)) {
															
															// Is this anim Done?
															_proc = !(NS[$ diaInst[$ _k]][$ K.DN])
															_kdone = T
															
														}
														
													}
													
												}
												
											#endregion
											
											// If we get here, this is a total fail, not setup right
											if(!_kdone) _proc = F;
											break
											
										}
										
									#endregion
									
									#region Actor Positions STATIC
										
										// Does not affect end results; Positions Actors in Dialogue
										#region Left
											
											case _actrL: {
												
												if(_isCurrent) {
													
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
												
												if(_isCurrent) {
													
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
												
												if(_isCurrent) {
													
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
									
									#region Branch HYBRID
										
										// _proc as long as everything exists, will set _rtn to a new inst
										case K.BR: {
											
											if(variable_instance_exists(diaInst,K.BR)) {
												
												if(is_array_ext(diaInst[$ K.BR],2,N)) {
													
													// Init
													var _k = diaInst[$ K.BR][0]
													var _e = diaInst[$ K.BR][1]
													
													switch(_k) {
														
														#region Branch Type[0,_k]... (i.e. V.SUIT[0,_k] = is <char>[1,_e] suited?)
															
															case V.SUIT: {
																
																if(ds_list_has(D.actorLst,_e)) {
																	
																	if(variable_instance_exists(diaInst,string(_e.suited))) _rtn = diaInst[$ _e.suited];
																	else {
																		
																		// If we return false proc with inst we close that inst
																		_proc = F
																		_rtn = diaInst
																		
																	}
																	_kdone = T
																	
																}
																break
																
															}
															
														#endregion
														
													}
													
												}
												
											}
											
											if(!_kdone) _proc = F
											break
											
										}
										
									#endregion
									
									#region Option RTN
										
										// Will draw the buttons and sha'll return N if an option is not made yet
										case K.OPT: {
											
											// Get Options Array [Strings Entries first, Value Entries Last]
											// String entry index corresponds to the rks index to goto when picked (0: "Hi" -> Open Nest @ 0)
											// Value Entries are special actions (V.LEAVE -> Exit Dialogue)
											var _e = diaInst[$ _k]
											
											if(is_array(_e)) {
												
												#region Init
													
													var allDone = T
													// Actor Focus should be Player...
													if(D.diaSpeaker != P and !diaInst[$ K.DN]) diaNar_focus_switch(P);
													
												#endregion
												
												// If Player is Focus and Transition done... WIP
												if(D.diaSpeaker == P and D.diaTranPct >= 1) {
													
													for(var i2 = 0; i2 < array_length(_e); i2++) {
														
														if(D.diaTranPct >= 1 and D.diaSpeaker == P) {
															
															// Get option from array
															var _e2 = _e[i2]
															var _bgc = []
															var _fgc = []
															_bgc[0] = 2/3
															_bgc[1] = c.blk
															_bgc[2] = c.blk
															_bgc[3] = make_color_rgb(16,16,16)
															_bgc[4] = _bgc[3]
															array_copy(_fgc,0,fgc_,0,array_length(fgc_))
															_fgc[0] = 1
															
															if(is_string(_e2)) {
																
																#region String Option (Normal; i2 -> diaInst key)
																	
																	var _xy = [] // TMP; TODO: Standardized system of drawing [#] of buttons
																	_xy[0] = WW*.33
																	_xy[2] = WW*.67
																	_xy[3] = (WH*.3)+((i2+1)*200)
																	_xy[1] = _xy[3]-180
																	var _done = F
																	if(variable_instance_exists(diaInst[$ i2],K.DN)) _done = diaInst[$ i2][$ K.DN];
																	if(!_done) allDone = F;
																	var rtn2 = draw_button_fxl(_xy,_bgc,_fgc,_e2,ACTION.DIA_GOTO,!_done)
																	if(rtn2 == ACTION.DIA_GOTO) _rtn = diaInst[$ i2]; // Means this was picked
																	continue
																	
																#endregion
																
															} else {
																
																#region Value Option
																	
																	switch(_e2) {
																		
																		case ACTION.DIA_LEAVE: {
																			
																			var _xy = [] // TMP; TODO: Standardized system of drawing [#] of buttons
																			_xy[0] = WW*.33
																			_xy[2] = WW*.67
																			_xy[3] = (WH*.3)+((i2+1)*200)
																			_xy[1] = _xy[3]-180
																			_fgc[1] = c.r
																			_fgc[2] = c.r
																			_fgc[3] = c.dr
																			_fgc[4] = c.dr
																			var rtn2 = draw_button_fxl(_xy,_bgc,_fgc,"Leave",ACTION.DIA_LEAVE,T)
																			if(rtn2 == ACTION.DIA_LEAVE) diaNar_close(F);
																			continue
																			
																		}
																		
																	}
																	
																#endregion
																
															}
															
														}
														
													}
													
												}
												
											}
											break
											
										}
										
									#endregion
									
									#region Bypass HYBRID
										
										#region Bypass Set
											
											case K.BYP: {
												
												var _arr = diaInst[$ _k]
												if(is_array_ext(_arr,2,N)) {
													
													var _k2 = _arr[0] // Key
													var _v2 = _arr[1] // Key2
													
													switch(_k2) {
														
														#region Parent Bypasses
															
															// Will set the bypass at the parent of this dialogue
															// This is so we can return here even if the parent is done as an example
															// Could set it up to behave on things other than done...
															case V.PARENT_ALL: {
																
																if(!is_string_real(_v2) and is_string(_v2)) {
																	
																	var _par = diaNar_get_par()
																	_par[$ _k+_v2] = diaInst
																	
																}
																break
																
															}
															
														#endregion
														
													}
													
												}
												
												break
												
											}
											
										#endregion
										
									#endregion
									
								}
								
							}
							
						#endregion
						
						#region Cancel Return if Already Done
							// We let it process first for various external control/check purposes...
							// UNLESS a bypass is set.
							
							if(diaNar_done(diaInst) and !_isBypassing) return N;
							
						#endregion
						
						#region Finalize... //TPFinal
							
							// Is Not Parent Level? Return not set? Not Fork?
							if(diaLyr >= 4 and !_rtn and !_isFork) {
								
								// At end and still _proc then assume proc with self
								if(_proc) _rtn = diaInst;
								
							}
							
						#endregion
						
						#region Process diaNarr Lines... (_rks; 0,1,2...)
							
							// If proc true then continue with whatever return is (generally)
							return [_proc,_rtn]
							
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

function diaNar_get_real_keys(diaInst) {
	
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

function diaNar_get_string_keys(diaInst) {
	
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

function diaNar_get_real_keys_count(diaInst) {
	
	var tmp = variable_instance_get_sorted_numKeys(diaInst,T)
	if(is_array(tmp)) return (array_length(tmp)-1);
	else return N;
	
}

function diaNar_get_string_keys_count(diaInst) {
	
	var tmp = variable_instance_get_sorted_strKeys(diaInst,T)
	if(is_array(tmp)) return (array_length(tmp)-1);
	else return N;
	
}

function diaNar_in_focus(actr) {
	
	return (D.focusL == actr or D.focusR == actr or D.focusM == actr)
	
}

function diaNar_focus_switch(actr) {
	
	if(D.diaSpeaker != actr) {
		
		if(diaNar_in_focus(actr)) {
			
			D.diaSpeaker = actr
			actr.spkro = actr.spkr
			
		} else return F; // Actor not found in focus...
		
		// Reset TranDel (Speaker Transition Delay)
		D.diaTranDeli = 0
		D.diaTranPct = 0
		
		// Switched Successfully
		return T
		
	}
	
	// Speaker Already is Focus?
	return F
	
}

function diaNarI() {
	
	if(D.focus) return D.focus.dia[$ K.I];
	else return N;
	
}

function diaNar_draw(actr,diaInst,diaLyr){
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	
	// Init
	var _spr = sprNA
	if(actr.suited) _spr = actr.body;
	else _spr = actr.head;
	var _scl = (WH*.8)/sprite_get_height(_spr)
	
	#region Draw Head(s) (Full Close-Up Head) or Body(s) (Zoomed Bust) (Unnested)
		
		if(D.diaDelPct >= 1) {
			
			// WIP TODO CURRENTLY WHEN SWITCHING SPEAKERS ALL CHARACTERS ALWAYS ADJUST, NEED TO MAKE IT TO ONLY ADJUST WHEN NEEDED
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
				
				#region 3rd focusM/Middle Side (Flip x axis to face currently speaking focusL? Currently Treated like 2nd Focus only)
					
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
				
				#region 2nd focusR/Right Side
					
					if(D.diaSpeaker == actr) {
						
						// Is Speaking...
						if(actr.head == _spr) draw_sprite_ext(_spr,0,WW+(WW*.1),WH*.9,((_scl*.9)+((_scl*.1)*D.diaTranPct))*-actr.headpol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
						else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.9,WH*.9,((_scl*.9)+((_scl*.1)*D.diaTranPct))*-actr.bodypol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
						
					} else {
						
						// isn't Speaking...
						if(actr.head == _spr) draw_sprite_ext(_spr,0,WW+(WW*.1),WH*.9,(_scl-((_scl*.1)*D.diaTranPct))*-actr.headpol,_scl-((_scl*.1)*D.diaTranPct),0,color_darken(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
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
	
	#region Speaker Init (If not set, should be a new parent dialogue...)
		
		if(D.diaSpeaker == N and diaNarI() == 0 and diaLyr == 0) {
			
			// Maybe some redundant sanity checks here...
			if(is_struct(diaInst)) {
				
				switch(diaInst[$ diaNarI()]) {
					
					#region Set Dialogue Speaker
						
						#region Actor Left...
							
							case V.LEFT: {
								
								// Returns T/F on success...
								if(D.focusL) diaNar_focus_switch(D.focusL);
								break
								
							}
							
						#endregion
						
						#region Actor Middle...
							
							case V.MIDDLE: {
								
								// Returns T/F on success...
								if(D.focusM) diaNar_focus_switch(D.focusM);
								break
								
							}
							
						#endregion
						
						#region Actor Right...
							
							case V.RIGHT: {
								
								// Returns T/F on success...
								if(D.focusR) diaNar_focus_switch(D.focusR);
								break
								
							}
							
						#endregion
						
					#endregion
					
				}
				
				#region Iterate past value... If speaker was set
					
					if(D.diaSpeaker != N) {
						
						var rcnt = diaNar_get_real_keys_count(diaInst)
						if(diaNarI() < rcnt) D.focus.dia[$ K.I]+=1;
						else if(diaNarI() >= rcnt) diaInst[$ K.DN] = T;
						D.diaTranDeli = D.diaTranDel
						D.diaTranPct = 1
						
					} else if(D.diad <= 0) diaNar_focus_switch(D.focus); // Otherwise set speaker to primary focus (this is the default)
					
				#endregion
				
			}
			
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
					
					var fRht = (D.focusR == D.diaSpeaker and actr == D.focusR)
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
					
					if(fRht) draw_text_color(w+(_w*.25),(WH*.89)-(STRH/2),nm,_c[0],_c[1],_c[2],_c[3],1);
					else draw_text_color(w,(WH*.89)-(STRH/2),nm,_c[0],_c[1],_c[2],_c[3],1);
					
				#endregion
				
			#endregion
			
			#region Is the Speaker? (Draw the actual Dialogue)
				
				if(actr == D.diaSpeaker) {
					
					#region Init
						
						var _scl = WW/1600
						if(fRht) _xy = [WW*.1,h,_xy[0],WH*.5];
						else _xy = [_xy[2],h,WW*.9,WH*.5];
						var _str = diaInst[$ string(diaNarI())]
						var _c = actr.col
						draw_set_font(actr.font)
						var _strsep = (STRH*1.5)*_scl
						var _pad = STRW*_scl
						var _strwmx = (WW/3)-(_pad*2)
						var _strw = string_width_ext(_str,_strsep,_strwmx)*_scl
						var _strh = string_height_ext(_str,_strsep,_strwmx)*_scl
						draw_set_valign(fa_bottom)
						draw_set_halign(fa_left)
						if(fRht) draw_set_halign(fa_right);
						
					#endregion
					
					#region Finish Dialogue (Done!)
						
						if(diaInst[$ K.DN]) {
							
							#region Trigger Actions
								
								if(variable_instance_exists(diaInst,K.ATN)) {
									
									switch(diaInst[$ K.ATN]) {
										
										case ACTION.DIA_LEAVE: {
											
											if(in_party(actr)) leave_party(actr);
											break
											
										}
										
									}
									
								}
								
							#endregion
							
							// Do the Close; If we plan on having this be repeatable, D.diaSoftClose will be T
							// Normally when we're done with a dialogue we just use diaNar_close(T)
							// Otherwise when we use diaNar_close(F) it will trigger this to reset the done value for each level we close out of...
							diaNar_close(!D.diaSoftClose)
							
						}
						
					#endregion  
					
					#region Line Effect & Narrative Draw Logix //TPDraw
						
						// Iterate Dialogue Level...
						// If rtn[1] != diaInst that means whatever the next nest was already returned another nest; Likely a fork
						var _rtn = diaNar_iterate_level(diaInst,actr.uid,4)
						var rcnt = diaNar_get_real_keys_count(diaInst)
						
						if(is_array(_rtn)) {
							
							if(_rtn[0] and _rtn[1] == diaInst) {
								// Proceed with self...
								
								#region Continue with Self...
									
									#region Content Operation...
										
										// Get Content
										var _e = diaInst[$ diaNarI()]
										
										if(!is_struct(_e)) {
											
											#region Normal
												
												if(!is_string_real(_e) and D.diaTranPct >= 1) {
													
													#region Is Dialogue
														
														#region Text Box
															
															if(diaLyr == ds_list_size(D.diaNestLst)) {
																
																#region Init
																	
																	draw_set_alpha(.9)
																	if(fRht) _xy[0] = clamp(_xy[2]-_strw,_xy[0]+1,_xy[2])-(_pad*2);
																	else _xy[2] = clamp(_xy[0]+_strw,_xy[0]+1,_xy[2])+(_pad*2);
																	_xy[3] = clamp(_xy[1]-_strh,_xy[3],_xy[1])-(_pad*2)
																	
																#endregion
																
																#region What actor side?
																	
																	// Draw Text Box...
																	draw_rectangle_color(_xy[0],_xy[1],_xy[2],_xy[3],c.blk,c.blk,c.blk,c.blk,F)
																	draw_set_alpha(1)
																	draw_rectangle_color(_xy[0],_xy[1],_xy[2],_xy[3],_c[1],_c[2],c.blk,c.blk,T)
																	
																	if(fRht) {
																		
																		#region Draw Text
																			
																			// Draw Lines... If the line was a struct it would of got redirected anyway...
																			draw_text_ext_transformed_color(_xy[2]-_pad,_xy[1]+_pad,_e,_strsep,_strwmx,_scl,_scl,0,_c[0],_c[1],_c[2],_c[3],1)
																			if(keyboard_check_pressed(vk_enter) and diaNarI() < rcnt) D.focus.dia[$ K.I]+=1
																			else if(keyboard_check_pressed(vk_enter) and diaNarI() >= rcnt) diaInst[$ K.DN] = T
																			
																		#endregion
																		
																	} else {
																		
																		#region Draw Text
																			
																			// Draw Lines... If the line was a struct it would of got redirected anyway...
																			draw_text_ext_transformed_color(_xy[0]+_pad,_xy[1]+_pad,_e,_strsep,_strwmx,_scl,_scl,0,_c[0],_c[1],_c[2],_c[3],1)
																			if(keyboard_check_pressed(vk_enter) and diaNarI() < rcnt) D.focus.dia[$ K.I]+=1
																			else if(keyboard_check_pressed(vk_enter) and diaNarI() >= rcnt) diaInst[$ K.DN] = T
																			
																		#endregion
																	
																	}
																	
																#endregion
																
															}
															
														#endregion
														
													#endregion
													
												} else if(is_string_real(_e) and D.diaTranPct >= 1) {
													
													#region Is (V)alue
														
														#region Do Value Actions
															
															switch(_e) {
																
																#region Set Dialogue Speaker
																	
																	#region Actor Left...
																		
																		case V.LEFT: {
																			
																			// Returns T/F on success...
																			if(D.focusL) diaNar_focus_switch(D.focusL);
																			break
																			
																		}
																		
																	#endregion
																	
																	#region Actor Middle...
																		
																		case V.MIDDLE: {
																			
																			// Returns T/F on success...
																			if(D.focusM) diaNar_focus_switch(D.focusM);
																			break
																			
																		}
																		
																	#endregion
																	
																	#region Actor Right...
																		
																		case V.RIGHT: {
																			
																			// Returns T/F on success...
																			if(D.focusR) diaNar_focus_switch(D.focusR);
																			break
																			
																		}
																		
																	#endregion
																	
																#endregion
																
															}
															
														#endregion
														
														#region Iterate past value...
															
															if(diaNarI() < rcnt) D.focus.dia[$ K.I]+=1
															else if(diaNarI() >= rcnt) diaInst[$ K.DN] = T
															
														#endregion
														
													#endregion
													
												}
												
											#endregion
											
											#region Update Old...
												
												if(diaInst != diaNar_get_par()) diaInst[$ K.IO] = diaNarI();
												else D.focus.dia[$ K.IO] = diaNarI();
												
											#endregion
											
										} else {
											
											#region Open Struct Here... (Direct; Normal; This line is a struct goto it...)
												
												#region Iterate Fork Nest
													
													var _rtn2 = N
													if(diaNar_is_fork(diaInst[$ diaNarI()])) _rtn2 = diaNar_iterate_level(diaInst[$ diaNarI()],actr.uid,4);
													
												#endregion
												
												#region Do Open
													
													if(DBG.diaDebug) {
														
														if(keyboard_check(vk_shift) and keyboard_check_pressed(vk_enter))
															diaNar_open_nest(actr,diaInst,diaLyr);
														
													} else diaNar_open_nest(actr,diaInst,diaLyr); // Direct Dialogue Open
													
												#endregion
												
											#endregion
											
										}
										
									#endregion
									
								#endregion
								
							} else if(_rtn[0] and _rtn[1] != diaInst) {
								// Proceed with new Dialogue?
								// Indirect Dialogue Open (Bypasses a layer? Fork?)
								
								#region Open Nest (iteration returned a totally different layer; Fork Likely)
									
									if(is_struct(_rtn[1])) {
										
										#region Iterate Fork Nest
											
											var _rtn2 = N
											if(diaNar_is_fork(diaInst[$ diaNarI()])) _rtn2 = diaNar_iterate_level(diaInst[$ diaNarI()],actr.uid,4);
											
										#endregion
										
										#region Debug
											
											if(DBG.diaDebug) {
												
												if(keyboard_check(vk_shift) and keyboard_check_pressed(vk_enter))
													diaNar_open_nest(actr,diaInst,diaLyr);
												
											} else diaNar_open_nest(actr,diaInst,diaLyr); // Direct Dialogue Open
											
										#endregion
										
									}
									
								#endregion
								
							} else if(!_rtn[0]) {
								
								#region False Proc
									
									if(!_rtn[1]) {
										
										// Start Soft Close; We got False but also Nothing...
										D.diaSoftClose = T
										
									} else if(_rtn[1] == diaInst) {
										
										// False and self? This is Done...
										diaInst[$ K.DN] = T
										
									}
									
								#endregion
								
							}
							
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