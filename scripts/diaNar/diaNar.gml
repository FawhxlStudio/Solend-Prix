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
	D.diaDone = F
	
}

function diaNar_is_link(diaInst,clear) {
	
	if(D.diaLnkA != N) {
		
		if(is_array_ext(D.diaLnkA,2,N)) {
			
			if(is_struct(D.diaLnkA[1])) {
				
				if(D.diaLnkA[1] == diaInst) {
					
					if(clear) D.diaLnkA = N;
					return T
					
				}
				
			}
			
		}
		
	}
	
	if(D.diaLnkB != N) {
		
		if(is_array_ext(D.diaLnkB,2,N)) {
			
			if(is_struct(D.diaLnkB[1])) {
				
				if(D.diaLnkB[1] == diaInst) {
					
					if(clear) D.diaLnkB = N;
					return T
					
				}
				
			}
			
		}
		
	}
	
	if(D.diaLnkC != N) {
		
		if(is_array_ext(D.diaLnkC,2,N)) {
			
			if(is_struct(D.diaLnkC[1])) {
				
				if(D.diaLnkC[1] == diaInst) {
					
					if(clear) D.diaLnkC = N;
					return T
					
				}
				
			}
			
		}
		
	}
	
	if(D.diaLnkD != N) {
		
		if(is_array_ext(D.diaLnkD,2,N)) {
			
			if(is_struct(D.diaLnkD[1])) {
				
				if(D.diaLnkD[1] == diaInst) {
					
					if(clear) D.diaLnkD = N;
					return T
					
				}
				
			}
			
		}
		
	}
	
	if(D.diaLnkE != N) {
		
		if(is_array_ext(D.diaLnkE,2,N)) {
			
			if(is_struct(D.diaLnkE[1])) {
				
				if(D.diaLnkE[1] == diaInst) {
					
					if(clear) D.diaLnkE = N;
					return T
					
				}
				
			}
			
		}
		
	}
	
	return F
	
}

function diaNar_get_link(diaInst) {
	
	if(D.diaLnkA != N) {
		
		if(is_array_ext(D.diaLnkA,2,N)) {
			
			if(is_struct(D.diaLnkA[1])) {
				
				if(D.diaLnkA[1] == diaInst) return V.LINK_A;
				
			}
			
		}
		
	}
	
	if(D.diaLnkB != N) {
		
		if(is_array_ext(D.diaLnkB,2,N)) {
			
			if(is_struct(D.diaLnkB[1])) {
				
				if(D.diaLnkB[1] == diaInst) return V.LINK_B;
				
			}
			
		}
		
	}
	
	if(D.diaLnkC != N) {
		
		if(is_array_ext(D.diaLnkC,2,N)) {
			
			if(is_struct(D.diaLnkC[1])) {
				
				if(D.diaLnkC[1] == diaInst) return V.LINK_C;
				
			}
			
		}
		
	}
	
	if(D.diaLnkD != N) {
		
		if(is_array_ext(D.diaLnkD,2,N)) {
			
			if(is_struct(D.diaLnkD[1])) {
				
				if(D.diaLnkD[1] == diaInst) return V.LINK_D;
				
			}
			
		}
		
	}
	
	if(D.diaLnkE != N) {
		
		if(is_array_ext(D.diaLnkE,2,N)) {
			
			if(is_struct(D.diaLnkE[1])) {
				
				if(D.diaLnkE[1] == diaInst) return V.LINK_E;
				
			}
			
		}
		
	}
	
	return N
	
}

function diaNar_at_choice() {
	
	if(diaNar_is_choice(diaNar_get_top())) return T
	else return diaNar_is_choice(diaNar_get_top()[$ diaNarI()])
	
}

function diaNar_close(isDone) {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	
	#region Close Out Current...
		
		D.diaSoftClose = !isDone
		
		if(!ds_list_empty(D.diaNestLst)) {
			
			#region Finish the current nest...
				
				if(!diaNar_at_choice()) diaNar_focus_switch(D.focus);
				var _t = ds_list_top(D.diaNestLst)
				if(_t == D.diaInstRpt) _t[$ K.DN] = F;
				else if(diaNar_is_choice(_t)) _t[$ K.DN] = F;
				else _t[$ K.DN] = isDone;
				diaNar_is_link(_t,T)
				ds_list_del_top(D.diaNestLst)
				D.diaNestDir = F
				
			#endregion
			
		} else if(!ds_list_empty(D.diaParLst)) {
			
			#region Finish parent...
				
				var _t = diaNar_get_par()
				_t[$ K.DN] = isDone
				diaNar_is_link(_t,T)
				ds_list_delete(D.diaParLst,0)
				D.focus.dia[$ K.I] = 0
				diaNar_focus_reset()
				D.diaNestDir = T // Since this is finishing the parent, we reset this...
				return isDone
				
			#endregion
			
		} else return N; // No Dialogue to close...
		
	#endregion
	
	#region Return to Previous...
		
		if(!ds_list_empty(D.diaNestLst)) {
			
			#region Back to Previous Nest Level... (Nest to Nest)
				
				#region Init  Returning to previous nest...
					
					var _t = ds_list_top(D.diaNestLst)
					var rcnt = diaNar_get_real_keys_count(_t)
					var _fork = diaNar_is_fork(_t)
					var _choice = diaNar_is_choice(_t)
					var _nxt = diaNar_next_dia(isDone)
					D.diaNestDir = _choice
					
				#endregion
				
				if(_fork and !_choice) {
					
					return diaNar_close(isDone)
					
				} else if(_choice) {
					
					#region Choice Stay?
						
						if(D.diaDone) {
							
							// Unless Bypass this is done too...
							_t[$ K.DN] = F
							D.diaNestDir = F
							D.diaSoftClose = F
							
						} else {
							
							// Choices don't finish? WIP
							_t[$ K.DN] = F
							D.diaNestDir = T
							D.diaSoftClose = F
							return T
							
						}
						
					#endregion
					
				}
				
			#endregion
			
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
		
		// Init; If it diaNarI() isn't a struct then we assume it is a link and we want to open itself...
		var _dia = N
		if(!diaNar_is_open(diaInst) or (diaNar_is_fork(diaInst) and !diaNar_is_choice(diaInst))) _dia = diaInst;
		else if(is_struct(diaInst[$ diaNarI()])) _dia = diaInst[$ diaNarI()];
		if(!is_struct(_dia)) return F; // If it isn't a struct, how? Return false.
		var rcnt = diaNar_get_real_keys_count(_dia)
		if(DBG and DBG.active and DBG.edit) DBG.markerStr += "\nDia Open Iter...";
		var _rtn = diaNar_iterate_level(_dia,actr.uid,4)
		
		if(is_array(_rtn)) {
			
			if(_rtn[0] and is_struct(_rtn[1])) {
				
				if(diaNar_is_fork(_dia) and _rtn[1] != _dia) {
					
					#region Pass(Fork); Check and Add to Nested Dialogue List to run...
						
						if(!ds_list_has(D.diaNestLst,_rtn[1])) {
							
							// Add nested to nest list...
							if(!diaNar_at_choice()) diaNar_focus_switch(D.focus);
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

function diaNar_is_open(diaInst) {
	
	#region Search Parent List for Instance...
		
		var found = F
		for(var i = 0; i < ds_list_size(D.diaParLst); i++) {
			
			if(D.diaParLst[|i][1] == diaInst) {
				
				found = T
				break
				
			}
			
		}
		
	#endregion
	
	// Search Nest list and return whether or not was found in parent...
	return (ds_list_has(D.diaNestLst,diaInst) or found)
	
}

function diaNar_get_top() {
	
	if(!ds_list_empty(D.diaNestLst)) return ds_list_top(D.diaNestLst);
	else return diaNar_get_par();
	
}

function diaNar_reset() {
	
	D.diaDel = GSPD
	D.diaDeli = 0
	D.diaDelPct = 0
	D.diaDeli2 = 0
	D.diaDelPct2 = 0
	D.diaSpeaker = N
	D.diaTranDel = GSPD*(2/3)
	D.diaTranDeli = 0
	D.diaTranPct = 0
	D.diaSoftClose = F
	D.diad = 0
	D.diaNestDir = T // T == Into Nest, F == Out of Nest
	D.diaContinue = F
	D.diaLnkA = N
	D.diaLnkB = N
	D.diaLnkC = N
	D.diaLnkD = N
	D.diaLnkE = N
	D.diaAnimTo = N
	D.diaTrigi = 0
	D.diaEnter = F
	D.diaDone = F
	D.diaDly = GSPD*2
	D.diaI = 0
	D.diaPct = 0
	D.diaInstArr = N // Array to hold instance vars (i.e. [actor id, image] to transition to) ([Inst]ance [Arr]ay)
	D.diaImn = 0
	D.diaImx = D.diaDly
	D.diaInstRpt = N
	D.diaLBDrawn = F
	
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
								var _rlbr = string(K.REL+K.BR)  // Relationship Branch
								var _anto = string(K.ANM+K.TO) // Anim To...
								var _rlad = string(K.REL+K.ADJ) // Relation Adjust... (double _)?
								
							#endregion
							
							#region Iteration Inits
								
								var _proc = T // Whether we may (proc)eed with our return or not...
								var _rtn = N // Dialogue we return if any
								var _isCurrent = (diaInst == diaNar_get_top()) // Is what we're iterating the current dialogue? (Usually is...)
								var _awaiting = (diaNar_get_top()[$ diaNarI()] == diaInst)
								var _exiting = (!D.diaNestDir or D.diaSoftClose)
								var _linked = diaNar_get_link(diaInst)
								if( _linked != N) _awaiting = (diaNar_get_top()[$ diaNarI()] == _linked);
								var _isFork = diaNar_is_fork(diaInst) // Is this dialogue just a fork? (All rks elements are structs)
								if( _isFork and !D.diaNestDir) {
									
									_proc = F
									_rtn = diaInst
									
								}
								var _byp = diaNar_get_bypass(diaInst)
								var _isBypassing = F
								var _isTrgd = F
								var _isBranch = (_isFork and is_array_ext(_rks,2,"real"))
								var _break = ((!_isCurrent and !_awaiting) or _exiting)
								var _currentlyWaitingOn = (_isCurrent or _awaiting)
								
							#endregion
							
							#region Letterbox for Branch/Forks Input Waits...
								
								if(_awaiting and !D.diaLBDrawn) {
									
									#region Scene Darken (If no diaParLst)
										
										if(ds_list_empty(D.diaParLst)) {
											
											var ao = draw_get_alpha()
											draw_set_alpha((1/3)*(D.diaDelPct))
											draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
											draw_set_alpha(ao)
											
										}
										
									#endregion
									
									#region Letterboxing
										
										draw_set_alpha(1)
										draw_rectangle_color(0,0,WW,(WH*.1)*D.diaDelPct,c.blk,c.blk,c.blk,c.blk,F)
										draw_rectangle_color(0,WH-((WH*.1)*D.diaDelPct),WW,WH,c.blk,c.blk,c.blk,c.blk,F)
										
									#endregion
									
									D.diaLBDrawn = T
									
								}
								
							#endregion
							
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
															
															// Debug diaShortcut skips start triggers
															if(!is_debug(DBG.diaShortcut)) {
																
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
																
																if(diaNar_done(NS[$ diaInst[$ K.ANM]])) {
																	
																	// Check sets for ability to do...
																	// If we return N we know it is a no-go, otherwise it will return the dialogue...
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
																		
																		// Set to available in actor... If it is...
																		actr.diaAvailable = T
																		if(diaNar_done(diaInst[$ _byp])) diaInst[$ _byp][$ K.DN] = F;
																		if(is_struct(diaInst[$ _byp]) and diaNar_is_choice(diaInst[$ _byp]))
																			diaNar_iterate_level(diaInst[$ _byp],actr.uid,4);
																		
																		
																		if(!is_array(_byp)) {
																			
																			#region Single Bypass Condition...
																				
																				// Currently the kind of bypass is not taken into consideration...
																				// Just if it is set and is a struct, use it...
																				if(is_struct(diaInst[$ _byp])) {
																					
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
														
														case TRIGGER.CONTINUE: {
															
															if(D.diaContinue) {
																
																// Done? Should be this simple...
																// Not Done and is Start...
																if(!diaNar_done(diaInst) and !_rtn) _rtn = diaInst;
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
																
																// Reset
																D.diaContinue = F
																
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
												
												var _v = diaInst[$ _k]
												
												if(is_array(_v)) {
													
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
													
												} else if(is_string_real(_v) or is_real(_v)) {
													
													#region Value
														
														_v = real(_v)
														switch(_v) {
															
															case V.SUIT: {
																
																// Just V.SUIT? Check Player Suit.
																_proc = P.suited;
																_kdone = T
																break
																
															}
															
														}
														
													#endregion
													
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
											
											// Only do when current...
											if(_break) {
												
												if(_awaiting) _proc = F;
												break
												
											}
											
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
											
											// Only do when current...
											if(!_currentlyWaitingOn) break;
											
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
															
															#region Get option from array; Init Draw
																
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
																
															#endregion
															
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
																			if(rtn2 == ACTION.DIA_LEAVE) diaNar_close((D.diaInstRpt == diaInst and allDone));
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
									
									#region Relation Branch RTN
										
										case _rlbr: {
											
											// Only do when current...
											if(_break or actr != D.focus) {
												
												if(_awaiting and actr == D.focus) _proc = F;
												break
												
											}
											
											if(diaLyr >= 4) {
												
												// Check that is like a branch... (2)
												var _v = diaInst[$ _k]
												if(actr and is_string_real(_v)) {
													
													_v = real(_v)
													if(variable_instance_exists(diaInst,string(real(actr.relation) >= _v)))
														_rtn = diaInst[$ (real(actr.relation) >= _v)];
													
												}
												
											}
											
											break
											
										}
										
									#endregion
									
									#region Link
										
										case K.LNK: {
											
											if(!diaNar_done(diaInst)) {
												
												var _v = diaInst[$ _k]
												switch(_v) {
													
													case V.LINK_A: D.diaLnkA = [uid,diaInst]; break;
													case V.LINK_B: D.diaLnkB = [uid,diaInst]; break;
													case V.LINK_C: D.diaLnkC = [uid,diaInst]; break;
													case V.LINK_D: D.diaLnkD = [uid,diaInst]; break;
													case V.LINK_E: D.diaLnkE = [uid,diaInst]; break;
													
												}
												
											}
											break
											
										}
										
									#endregion
									
									#region Anim To
										
										case _anto: {
											
											// Only do when current...
											if(!_currentlyWaitingOn) break;
											
											if(!diaNar_done(NS[$ diaInst[$ _k]]))
												D.diaAnimTo = NS[$ diaInst[$ _k]];
											break
											
										}
										
									#endregion
									
									#region Adjustments...
										
										#region Relation
											
											case _rlad: {
												
												// Only do when current...
												if(_break or actr != D.focus or D.focus == P) {
													
													if(_awaiting and actr == D.focus and actr != P) _proc = F;
													break
													
												}
												
												if(diaLyr >= 4) {
													
													// Check that is like a branch... (2)
													var _v = diaInst[$ _k]
													if(actr and is_string_real(_v)) {
														
														_v = real(_v)
														D.focus.relation += _v
														diaInst[$ _k] = 0 // Zeroize to prevent additional adjustments
														
													}
													
												}
												
											}
											
										#endregion
										
									#endregion
									
									#region Repeat
										
										case K.RPT: {
											
											if(diaInst[$ _k]) D.diaInstRpt = diaInst;
											
										}
										
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
							if(diaLyr >= 4 and !_rtn and !_isFork and !_exiting) {
								
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

function diaNar_get_scene() {
	
	try {
		
		if(variable_instance_exists(NS,string(D.scni)))
			return NS[$ D.scni];
		
	} catch (_ex) {}
	
	return N
	
}

// Converts NS to Strings for editing like: NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1][$ K.TRG] = TRIGGER.SUIT
function diaNar_to_editor(inst,lyr,k) {
	
	var arr = [k+" = {}"]
	// Where do we append to k?
	
	try {
		
		var sz = variable_instance_names_count(inst)
		if(sz > 0) {
			
			var rks = variable_instance_get_sorted_numKeys(inst,T)
			var rksz = array_length(rks)
			var sks = variable_instance_get_sorted_strKeys(inst,T)
			var sksz = array_length(sks)
			
			#region Proc Strings First (To do)
				
				for(var i = 0; i < sksz; i++) {
					
					var e = sks[i]
					
				}
				
			#endregion
			
			#region Proc Numbered
				
				for(var i = 0; i < rksz; i++) {
					
					var e = inst[$ rks[i]]
					if(is_struct(e)) {
						
						var rtn = diaNar_to_editor(e,lyr+1,k)
						if(is_array(rtn)) array_copy(arr,array_length(arr),rtn,0,array_length(rtn))
						
					} else {
						
						if(is_string(e) and !is_string_real(e)) arr[array_length(arr)] = k+" = \""+e+"\"";
						else if(is_string_real(e) or is_real(e)) arr[array_length(arr)] = k+" = V."+Vn[real(e)];
						
					}
					
				}
				
			#endregion
			
			
		}
		
	} catch(_ex) {}
	
	return N
	
}

function diaNar_draw(actr,diaInst,diaLyr){
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	
	// Init
	var _spr = sprNA
	if(actr.suited) _spr = actr.body;
	else _spr = actr.head;
	var _scl = WH/sprite_get_height(_spr)
	var _scl2 = WH/sprite_get_height(actr.head)
	
	#region Instarr Logic
		
		var instSpr = _spr
		if(D.diaInstArr != N) {
			
			if(D.diaInstArr[0] == actr and sprite_exists(D.diaInstArr[1])) {
				
				#region Transition
					
					// Iterate for Transition
					D.diaPct = D.diaI/D.diaDly
					if(D.diaI < D.diaDly) D.diaI++;
					
					if(D.diaPct == 1) {
						
						// Dialogue Sprite Set
						actr.diaSpr = D.diaInstArr[1];
						D.diaInstArr = N
						
						#region Reset Inst Arr Iterator (This way it doesn't interfere with others using it so its only reset right after we're done with it)
							
							D.diaI = clamp(D.diaImn,D.diaImn,D.diaImx)
							D.diaPct = D.diaI/D.diaDly
							
						#endregion
						
					} else {
						
						instSpr = D.diaInstArr[1];
						
						#region Scale Calc
							
							n_scl = lerp(_scl*.8,_scl,D.diaPct)
							_scl  = lerp(_scl,_scl*.8,D.diaPct)
							
						#endregion
						
					}
					
				#endregion
				
			}
			
		}
		
	#endregion
	
	#region Draw Head(s) (Full Close-Up Head) or Body(s) (Zoomed Bust) (Unnested)
		
		if(D.diaDelPct >= 1) {
			
			// WIP TODO CURRENTLY WHEN SWITCHING SPEAKERS ALL CHARACTERS ALWAYS ADJUST, NEED TO MAKE IT TO ONLY ADJUST WHEN NEEDED
			if(actr == D.focusL) {
				
				#region 1st focusL/Left Side (Sihlouette)
					
					if(actr.suited) {
						
						var _sprw = sprite_get_width(actr.head)
						if(_sprw <= sprite_get_height(actr.head)) draw_sprite_ext(actr.head,0,-_sprw*.2,WH,_scl2*actr.headPol,_scl2,0,color_brightness(D.scnBlend3,lerp(1,1/5,1)),D.diaDelPct2/2);
						else draw_sprite_ext(actr.head,0,0,WH,_scl2*actr.headPol,_scl2,0,color_brightness(D.scnBlend3,lerp(1,1/5,1)),D.diaDelPct2/2);
						
					}
					
				#endregion
				
				#region 1st focusL/Left Side
					
					if(actr.diaSpr == N) {
						
						#region Default (Suited/Unsuited)
							
							if(D.diaSpeaker == actr) {
								
								// Is Speaking...
								if(actr.head == _spr) draw_sprite_ext(_spr,0,-WW*.1,WH,clamp((_scl*.9)+((_scl*.1)*D.diaTranPct),0,1)*actr.headPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
								else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.1,WH,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.bodyPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
								
							} else {
								
								// isn't Speaking...
								if(actr.head == _spr) draw_sprite_ext(_spr,0,-WW*.1,WH,(_scl-((_scl*.1)*D.diaTranPct))*actr.headPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
								else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.1,WH,(_scl-((_scl*.1)*D.diaTranPct))*actr.bodyPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
								
							}
							
						#endregion
						
					} else {
						
						#region Dia Spr Set...
							
							if(D.diaSpeaker == actr) draw_sprite_ext(actr.diaSpr,0,WW*.1,WH,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.diaSprPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),1-D.diaPct);
							else draw_sprite_ext(actr.diaSpr,0,WW*.1,WH,(_scl-((_scl*.1)*D.diaTranPct))*actr.diaSprPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),1-D.diaPct);
							
						#endregion
						
					}
					
				#endregion
				
			} else if(actr == D.focusM) {
				
				#region 3rd focusM/Middle (Sihlouette)
					
					if(actr.suited) {
						
						var _sprw = sprite_get_width(actr.head)
						draw_sprite_ext(actr.head,0,WW*.5-(_sprw/2),WH,_scl2*actr.headPol,_scl2,0,color_brightness(D.scnBlend3,lerp(1,1/5,1)),D.diaDelPct2/2);
						
						
					}
					
				#endregion
				
				#region 3rd focusM/Middle (Flip x axis to face currently speaking focusL? Currently Treated like 2nd Focus only)
					
					if(actr.diaSpr == N) {
						
						#region Default (Suited/Unsuited)
							
							if(D.diaSpeaker == actr) {
								
								// Is Speaking...
								if(actr.head == _spr) draw_sprite_ext(_spr,0,WW*.5,WH,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.headPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
								else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.5,WH,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.bodyPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
								
							} else {
								
								// isn't Speaking...
								if(actr.head == _spr) draw_sprite_ext(_spr,0,WW*.5,WH,(_scl-((_scl*.1)*D.diaTranPct))*actr.headPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
								else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.5,WH,(_scl-((_scl*.1)*D.diaTranPct))*actr.bodyPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
								
							}
							
						#endregion
						
					} else {
						
						#region Dia Spr Set...
							
							if(D.diaSpeaker == actr) draw_sprite_ext(actr.diaSpr,0,WW*.5,WH,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.diaSprPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),1-D.diaPct);
							else draw_sprite_ext(actr.diaSpr,0,-WW*.5,WH,(_scl-((_scl*.1)*D.diaTranPct))*actr.diaSprPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),1-D.diaPct);
							
						#endregion
						
					}
					
				#endregion
				
			} else if(actr == D.focusR) {
				
				#region 2nd focusR/Right Side (Sihlouette)
					
					if(actr.suited) {
						
						var _sprw = sprite_get_width(actr.head)
						if(_sprw <= sprite_get_height(actr.head)) draw_sprite_ext(actr.head,0,WW+(_sprw*.2),WH,_scl2*-actr.headPol,_scl2,0,color_brightness(D.scnBlend3,lerp(1,1/5,1)),D.diaDelPct2/2);
						else draw_sprite_ext(actr.head,0,WW,WH,_scl2*-actr.headPol,_scl2,0,color_brightness(D.scnBlend3,lerp(1,1/5,1)),D.diaDelPct2/2);
						
					}
					
				#endregion
				
				#region 2nd focusR/Right Side
					
					if(actr.diaSpr == N) {
						
						#region Default (Suited/Unsuited)
							
							var _sprw = sprite_get_width(_spr)
							if(D.diaSpeaker == actr) {
								
								// Is Speaking...
								if(actr.head == _spr) draw_sprite_ext(_spr,0,WW+(WW*.1),WH,((_scl*.9)+((_scl*.1)*D.diaTranPct))*-actr.headPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
								else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.9,WH,((_scl*.9)+((_scl*.1)*D.diaTranPct))*-actr.bodyPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaDelPct2);
								
							} else {
								
								// isn't Speaking...
								if(actr.head == _spr) draw_sprite_ext(_spr,0,WW+(WW*.1),WH,(_scl-((_scl*.1)*D.diaTranPct))*-actr.headPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
								else if(actr.body == _spr) draw_sprite_ext(_spr,0,WW*.9,WH,(_scl-((_scl*.1)*D.diaTranPct))*-actr.bodyPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),D.diaDelPct2);
								
							}
							
						#endregion
						
					} else {
						
						#region Dia Spr Set...
							
							if(D.diaSpeaker == actr) draw_sprite_ext(actr.diaSpr,0,WW*.9,WH,((_scl*.9)+((_scl*.1)*D.diaTranPct))*actr.diaSprPol,(_scl*.9)+((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),1-D.diaPct);
							else draw_sprite_ext(actr.diaSpr,0,-WW*.9,WH,(_scl-((_scl*.1)*D.diaTranPct))*actr.diaSprPol,_scl-((_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1,1/3,D.diaTranPct)),1-D.diaPct);
							
						#endregion
						
					}
					
				#endregion
				
			}
			
			#region Transitionary Draw
				
				if(D.diaInstArr != N) {
					
					if(D.diaInstArr[0] == actr and sprite_exists(D.diaInstArr[1]))
						draw_sprite_ext(D.diaInstArr[1],0,WW*.1,WH,((n_scl*.9)+((n_scl*.1)*D.diaTranPct))*actr.diaSprPol,(n_scl*.9)+((n_scl*.1)*D.diaTranPct),0,color_brightness(D.scnBlend3,lerp(1/3,1,D.diaTranPct)),D.diaPct);
					
				}
				
			#endregion
			
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
			
			/* OLD
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
			*/
			
			#region Finish Dialogue (Done!)
				
				if(diaInst[$ K.DN] or D.diaDone) {
					
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
			
			#region Is the Speaker? (Draw the actual Dialogue)
				 
				if(actr == D.diaSpeaker) {
					
					/* OLD?
					#region Init
						
						var fRht = (D.focusR == D.diaSpeaker and actr == D.focusR)
						var _scl = WW/1600
						if(fRht) _xy = [WW*.1,h,_xy[0],WH*.5];
						else _xy = [_xy[2],h,WW*.9,WH*.5];
						var _str = diaInst[$ string(diaNarI())]
						var _c = actr.col
						draw_set_font(actr.font1)
						var _strsep = (STRH*1.5)*_scl
						var _pad = STRW*_scl
						var _strwmx = (WW/3)-(_pad*2)
						var _strw = string_width_ext(_str,_strsep,_strwmx)*_scl
						var _strh = string_height_ext(_str,_strsep,_strwmx)*_scl
						draw_set_valign(fa_bottom)
						draw_set_halign(fa_left)
						if(fRht) draw_set_halign(fa_right);
						
					#endregion
					*/
					
					#region Line Effect & Narrative Draw Logix //TPDraw
						
						if(DBG and DBG.active and DBG.edit) DBG.markerStr += "\nDia Draw Iter...";
						#region Iterate Dialogue Level...
							
							// If rtn[1] != diaInst that means whatever the next nest was already returned another nest; Likely a fork
							var _rtn = diaNar_iterate_level(diaInst,actr.uid,4)
							var rcnt = diaNar_get_real_keys_count(diaInst)
							
						#endregion
						
						if(is_array(_rtn)) {
							
							if(_rtn[0] and _rtn[1] == diaInst) {
								
								if(DBG and DBG.active and DBG.edit) DBG.markerStr += "\nDia Continue Self... [1,self]";
								// Proceed with self...
								#region Continue with Self...
									
									#region Content Operation...
										
										// Get Content
										var _e = diaInst[$ diaNarI()]
										
										if(!is_struct(_e)) {
											
											#region Normal
												
												if(!is_string_real(_e) and D.diaTranPct >= 1) {
													
													#region Is Dialogue
														
														/* OLD
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
														*/
														
														#region Init & Send to Draw Function
															
															D.diaEnter = F
															diaNar_draw_dialogue(diaInst,actr,diaNarI(),T)
															
														#endregion
														
														#region Enter Action (Iterate)
															
															// Override Dialogue Continuing
															if(D.diaInstArr != N) D.diaEnter = F;
															
															if(D.diaEnter) {
																
																if(diaNarI() < rcnt) D.focus.dia[$ K.I]+=1
																else if(diaNarI() >= rcnt) diaInst[$ K.DN] = T
																
																D.diaEnter = F
																
															}
															
														#endregion
														
													#endregion
													
												} else if(is_string_real(_e) and D.diaTranPct >= 1) {
													
													#region Is (V)alue
														
														// To bypass iterating incase i.e. we open a linked nest, we don't want to mess up the old iter value...
														var noIter = F
														
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
																
																#region Done
																	
																	case V.DONE: {
																		
																		D.diaSoftClose = F
																		diaInst[$ K.DN] = T
																		D.diaDone = T
																		break
																		
																	}
																	
																	case V.DONE_AND_CONTINUE: {
																		
																		D.diaSoftClose = F
																		D.diaContinue = T
																		diaInst[$ K.DN] = T
																		D.diaDone = T
																		break
																		
																	}
																	
																	case V.DONE_AND_JOIN: {
																		
																		join_party(D.focus)
																		D.diaSoftClose = F
																		diaInst[$ K.DN] = T
																		D.diaDone = T
																		break
																		
																	}
																	
																	case V.DONE_TO_ANIM: {
																		
																		D.diaSoftClose = F
																		diaInst[$ K.DN] = T
																		D.diaDone = T
																		break
																		
																	}
																	
																#endregion
																
																#region Links
																	
																	case V.LINK_A: {
																		
																		if(is_array_ext(D.diaLnkA,2,N)) {
																			
																			var _actr = actor_find(D.diaLnkA[0])
																			if(_actr != N) diaNar_open_nest(_actr,D.diaLnkA[1],diaLyr);
																			noIter = T
																			
																		}
																		break
																		
																	}
																	
																	case V.LINK_B: {
																		
																		if(is_array_ext(D.diaLnkB,2,N)) {
																			
																			var _actr = actor_find(D.diaLnkB[0])
																			if(_actr != N) diaNar_open_nest(_actr,D.diaLnkB[1],diaLyr);
																			noIter = T
																			
																		}
																		break
																		
																	}
																	
																	case V.LINK_C: {
																		
																		if(is_array_ext(D.diaLnkC,2,N)) {
																			
																			var _actr = actor_find(D.diaLnkC[0])
																			if(_actr != N) diaNar_open_nest(_actr,D.diaLnkC[1],diaLyr);
																			noIter = T
																			
																		}
																		break
																		
																	}
																	
																	case V.LINK_D: {
																		
																		if(is_array_ext(D.diaLnkD,2,N)) {
																			
																			var _actr = actor_find(D.diaLnkD[0])
																			if(_actr != N) diaNar_open_nest(_actr,D.diaLnkD[1],diaLyr);
																			noIter = T
																			
																		}
																		break
																		
																	}
																	
																	case V.LINK_E: {
																		
																		if(is_array_ext(D.diaLnkE,2,N)) {
																			
																			var _actr = actor_find(D.diaLnkE[0])
																			if(_actr != N) diaNar_open_nest(_actr,D.diaLnkE[1],diaLyr);
																			noIter = T
																			
																		}
																		break
																		
																	}
																	
																#endregion
																
																#region Actor Sprite Change
																	
																	case V.BODY: {
																		
																		if(D.diaSpeaker.diaSpr != D.diaSpeaker.body)
																			D.diaInstArr = [D.diaSpeaker,D.diaSpeaker.body];
																		break
																		
																	}
																	
																	case V.BODY_BACK: {
																		
																		if(D.diaSpeaker.diaSpr != D.diaSpeaker.bodyBack)
																			D.diaInstArr = [D.diaSpeaker,D.diaSpeaker.bodyBack];
																		break
																		
																	}
																	
																#endregion
																
															}
															
														#endregion
														
														#region Iterate past value...
															
															if(!noIter) {
																
																if(diaNarI() < rcnt) D.focus.dia[$ K.I]+=1
																else if(diaNarI() >= rcnt) diaInst[$ K.DN] = T
																
															}
															
														#endregion
														
													#endregion
													
												}
												
												#region Update Old...
													
													if(diaInst == diaNar_get_top()) {
														
														if(diaInst != diaNar_get_par()) diaInst[$ K.IO] = diaNarI();
														else D.focus.dia[$ K.IO] = diaNarI();
														
													}
													
												#endregion
												
											#endregion
											
										} else {
											
											#region Open Struct Here... (Direct; Normal; This line is a struct goto it...)
												
												#region Iterate Fork Nest
													
													var _rtn2 = N
													if(diaNar_is_fork(diaInst[$ diaNarI()])) _rtn2 = diaNar_iterate_level(diaInst[$ diaNarI()],actr.uid,4);
													else diaNar_open_nest(actr,diaInst,diaLyr); // Direct Dialogue Open
													
												#endregion
												
												#region Open/Close Descision...
													
													if(is_array_ext(_rtn2,2,N)) {
														
														if(_rtn2[0]) {
															
															#region Open w/ Optional Debug Mode...
																
																if(DBG.diaDebug) {
																	
																	if(keyboard_check(vk_shift) and keyboard_check_pressed(vk_enter))
																		diaNar_open_nest(actr,diaInst,diaLyr);
																	
																} else diaNar_open_nest(actr,diaInst,diaLyr); // Direct Dialogue Open
																
															#endregion
															
														} else {
															
															#region False Proc
																
																if(_rtn2[1] != diaInst) {
																	
																	#region Start Soft Close; We got False but also Nothing...
																	
																		D.diaSoftClose = T
																		diaInst[$ K.DN] = T
																		
																	#endregion
																	
																} else if(_rtn2[1] == diaInst) {
																	
																	#region False and self? This is Done...
																		
																		D.diaSoftClose = F
																		diaInst[$ K.DN] = T
																		
																	#endregion
																	
																}
																
															#endregion
															
														}
														
													}
													
												#endregion
												
											#endregion
											
										}
										
									#endregion
									
								#endregion
								
							} else if(_rtn[0] and _rtn[1] != diaInst) {
								
								if(DBG and DBG.active and DBG.edit) DBG.markerStr += "\nDia Nest Attempt... [1,NOT Self]";
								#region Continue with/Open new diaInst
									
									// Proceed with new Dialogue?
									// Indirect Dialogue Open (Maybe Bypasses a layer?)
									// This might only happen when:
									// 1. Next Layer is a Fork or Choice and is either waiting for input or returning a selection/branch
									//    [1,N] == Waiting; [1,inst] == Open This;
									#region Iterate Fork Nest
										
										var _rtn2 = N
										if(diaNar_is_fork(diaInst[$ diaNarI()])) {
											
											if(DBG and DBG.active and DBG.edit) DBG.markerStr += "\nDia Fork Nest Attempt Iter...";
											_rtn2 = diaNar_iterate_level(diaInst[$ diaNarI()],actr.uid,4);
											
										} else diaNar_open_nest(actr,diaInst,diaLyr);
										
									#endregion
									
									#region Open/Close Descision...
										
										if(is_array_ext(_rtn2,2,N)) {
											
											if(_rtn2[0]) {
												
												#region Open w/ Optional Debug Mode...
													
													if(DBG.diaDebug) {
														
														if(keyboard_check(vk_shift) and keyboard_check_pressed(vk_enter))
															diaNar_open_nest(actr,diaInst,diaLyr);
														
													} else diaNar_open_nest(actr,diaInst,diaLyr); // Direct Dialogue Open
													
												#endregion
												
											} else {
												
												#region False Proc
													
													if(_rtn2[1] != diaInst) {
														
														#region Start Soft Close; We got False but also Nothing...
															
															D.diaSoftClose = T
															diaInst[$ K.DN] = T
															
														#endregion
														
													} else if(_rtn2[1] == diaInst) {
														
														#region False and self? This is Done...
															
															D.diaSoftClose = F
															diaInst[$ K.DN] = T
															
														#endregion
														
													}
													
												#endregion
												
											}
											
										}
										
									#endregion
									
								#endregion
								
							} else if(!_rtn[0]) {
								
								if(DBG and DBG.active and DBG.edit) DBG.markerStr += "\nDia False Proc... [0,N or Self]";
								#region False Proc
									
									if(!_rtn[1]) {
										
										#region Start Soft Close; We got False but also Nothing...
											
											D.diaSoftClose = T
											diaInst[$ K.DN] = T
											
										#endregion
										
									} else if(_rtn[1] == diaInst) {
										
										#region False and self? This is Done...
											
											D.diaSoftClose = F
											diaInst[$ K.DN] = T
											
										#endregion
										
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

function diaNar_draw_dialogue(inst,actr,i,letterbox) {
	
	if(letterbox and !D.diaLBDrawn) {
		
		#region Scene Darken (If no diaParLst)
			
			if(ds_list_empty(D.diaParLst)) {
				
				var ao = draw_get_alpha()
				draw_set_alpha((1/3)*(D.diaDelPct))
				draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
				draw_set_alpha(ao)
				
			}
			
		#endregion
		
		#region Letterboxing
			
			draw_set_alpha(1)
			draw_rectangle_color(0,0,WW,(WH*.1)*D.diaDelPct,c.blk,c.blk,c.blk,c.blk,F)
			draw_rectangle_color(0,WH-((WH*.1)*D.diaDelPct),WW,WH,c.blk,c.blk,c.blk,c.blk,F)
			
		#endregion
		
		D.diaLBDrawn = T
		
	}
	
	#region Text Pre
		
		// Set Font...
		if(actr != N) draw_set_font(actr.font1);
		else draw_set_font(fNeu);
		
		var strFull = (strBld_ == inst[$ i])
		text_prep_cc(inst[$ i])
		var xx = WW/2
		var yy = WH*(7/8)
		var xy = []
		xy[0] = 0
		xy[1] = WH*.75
		xy[2] = WW
		xy[3] = WH
		draw_set_hvalign([fa_center,fa_middle])
		var ao = draw_get_alpha()
		
	#endregion
	
	#region Draw Message Box
		
		draw_set_alpha(bgc_[0])
		draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],bgc_[1],bgc_[2],bgc_[3],bgc_[4],F)
		
	#endregion
	
	#region Hilight/Glow
		
		if(mouse_in_rectangle(xy) and strFull) {
			
			#region Do Highlight
				
				if(MBL) draw_set_alpha(fgc_[0]/8)
				else draw_set_alpha(fgc_[0]/4)
				draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],c.blk,c.blk,c.dgry,c.dgry,F)
				
			#endregion
			
		} else if(strFull) {
			
			#region Do Glow
				
				#region Init
					
					var _sin = -sin(degtorad(D.diaTrigi))/2
					draw_set_alpha(abs(_sin)/3)
					
				#endregion
				
				#region Char/Default Glow
					
					if(actr != N) {
						
						var _c = actr.col
						draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],c.blk,c.blk,_c[1],_c[3],F)
						
					} else draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],c.wht,c.wht,c.ltgry,c.ltgry,F);
					
				#endregion
				
				#region Iterate and Loop Trigonometry Variable
					
					D.diaTrigi++
					if(D.diaTrigi >= 360) D.diaTrigi -= 360
					else if(D.diaTrigi < 0) D.diaTrigi += 360
					
				#endregion
				
			#endregion
			
		} else D.diaTrigi = 0;
		
	#endregion
	
	#region Draw Message
		
		draw_set_alpha(fgc_[0])
		// Colors
		if(actr != N) {
			
			// Draw Text...
			var _c = actr.col
			draw_text_ext_color(xx,lerp(xy[1],xy[3],0.5),strBld_,STRH,strw_,_c[1],_c[2],_c[3],_c[4],_c[0])
			
		} else draw_text_ext_color(xx,lerp(xy[1],xy[3],0.5),strBld_,STRH,strw_,fgc_[1],fgc_[2],fgc_[3],fgc_[4],fgc_[0]);
		
	#endregion
	
	#region Iterate String Build (Output)
		
		if(strDeli_ >= strDel_ and strBld_ != inst[$ i]) {
			
			#region Add to Build (Next Char)
				
				strBld_ += string_char_at(inst[$ i],string_length(strBld_)+1)
				strDeli_ = 0
				
			#endregion
			
		} else strDeli_++; // Iterate Delay (Time it takes between each char to add to build)...
		
		#region Reset Str Bld when next started... UPDATE w/ more
			
			if((keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or (mouse_in_rectangle(xy) and MBLR))
				and D.diaInstArr == N) {
				
				#region Dialogue Next
					
					if(strFull) {
						
						D.diaEnter = T
						strBld_ = ""
						strDeli_ = 0
						D.diaTrigi = 0
						
					} else strBld_ = inst[$ i];
					
				#endregion
				
			}
			
		#endregion
		
	#endregion
	
	#region Draw Name
		
		// Reset Font
		draw_set_font(fNeu)
		
		#region Anim Name Variable
			
			if(actr != N) {
				
				// Init;
				var _nm = actr.dia[$ K.NM]
				
				#region Text Pre
					
					draw_set_font(fNeuB)
					var w = WW/3
					var h = (WH*.9)-1
					var _w = string_width(_nm)
					var _h = string_height(_nm)
					xy[0] = WW*.25
					xy[2] = xy[0]+_w+10
					xy[3] = xy[1]-_h-10
					
				#endregion
				
				#region Name BG
					
					draw_set_alpha(bgc_[0])
					draw_rectangle_color(xy[0],xy[1],xy[2],xy[3],bgc_[1],bgc_[2],bgc_[3],bgc_[4],F)
					
				#endregion
				
				#region Draw Name
					
					draw_set_alpha(ao)
					draw_set_hvalign([fa_left,fa_bottom])
					var _c = actr.col
					draw_text_color(xy[0]+5,xy[1]-5,_nm,_c[1],_c[2],_c[3],_c[4],1)
					
					// Reset Font
					draw_set_font(fNeu)
					
				#endregion
				
			}
			
		#endregion
		
	#endregion
	
}