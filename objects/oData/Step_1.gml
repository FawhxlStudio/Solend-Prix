/// @description Factor Updates
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
#region Other Updates
	
	#region Scene Actor Array & List
		
		if(array_equals(scnActArr,[])) {
			
			#region Loop Through Scenes...
				
				var _scnKs = variable_instance_get_sorted_numKeys(S,T)
				scnActArr[array_length(_scnKs)-1] = [N,N] // Init Array to Final Size
				for(var i = 0; i < array_length(_scnKs); i++) {
					
					// Get Scene I
					var _scni = _scnKs[i]
					
					#region Close Actors
						
						#region Init
							
							var _ks = variable_instance_get_sorted_strKeys(S[$ _scni],T)
							var _locked = (array_contains(_ks,K.ACT+K.LCK) and S[$ _scni][$ K.ACT+K.LCK])
							scnActArr[_scni] = [N,N]
							
						#endregion
						
						#region Defined Actors
							
							#region Actor Left?
								
								if(variable_instance_exists(S[$ _scni],K.ACT+K.LFT) and !instance_of(S[$ _scni][$ K.ACT+K.LFT],oChar)) {
									
									// Get/Make Char Object...
									if(S[$ _scni][$ K.ACT+K.LFT] == ACTOR.RANDOM) {
										
										
										if(scn_area(_scni) == AREA.SLUM and chance(80))
											scnActArr[_scni][0] = db_act_rnd_slum(_scni,T);
										else if(scn_area(_scni) == AREA.BROTHEL and chance(80))
											scnActArr[_scni][0] = db_act_rnd_broth(_scni,T);
										else scnActArr[_scni][0] = db_act_rnd(_scni,T);
										if(instance_of(scnActArr[_scni][0],oChar)) S[$ _scni][$ K.ACT+K.LFT] = scnActArr[_scni][0].ruid;
										
									} else scnActArr[_scni][0] = actor_find(S[$ _scni][$ K.ACT+K.LFT]);
									
									// Undefined if Fail
									if(!instance_of(scnActArr[_scni][0],oChar)) scnActArr[_scni][0] = U;
									
								} else if(instance_of(S[$ _scni][$ K.ACT+K.LFT],oChar)) scnActArr[_scni][0] = S[$ _scni][$ K.ACT+K.LFT];
								if(_locked and !instance_of(scnActArr[_scni][0],oChar)) scnActArr[_scni][0] = U;
								
							#endregion
							
							#region Actor Right?
								
								if(variable_instance_exists(S[$ _scni],K.ACT+K.RHT) and !instance_of(S[$ _scni][$ K.ACT+K.RHT],oChar)) {
									
									// Get/Make Char Object...
									if(S[$ _scni][$ K.ACT+K.RHT] == ACTOR.RANDOM) {
										
										if(scn_area(_scni) == AREA.SLUM and chance(80))
											scnActArr[_scni][1] = db_act_rnd_slum(_scni,T);
										else if(scn_area(_scni) == AREA.BROTHEL and chance(80))
											scnActArr[_scni][1] = db_act_rnd_broth(_scni,T);
										else scnActArr[_scni][1] = db_act_rnd(_scni,T);
										if(instance_of(scnActArr[_scni][1],oChar)) S[$ _scni][$ K.ACT+K.RHT] = scnActArr[_scni][1].ruid;
										
									} else scnActArr[_scni][1] = actor_find(S[$ _scni][$ K.ACT+K.RHT]);
									
									// Undefined if Fail
									if(!instance_of(scnActArr[_scni][1],oChar)) scnActArr[_scni][1] = U;
									
								} else if(instance_of(S[$ _scni][$ K.ACT+K.RHT],oChar)) scnActArr[_scni][1] = S[$ _scni][$ K.ACT+K.RHT];
								if(_locked and !instance_of(scnActArr[_scni][1],oChar)) scnActArr[_scni][1] = U;
								
							#endregion
							
						#endregion
						
						#region Empty and Unlocked?
							
							if(!_locked) {
								
								#region Fill Empties 67% Each (N)
									
									#region Actor Left
										
										if(scnActArr[_scni][0] == N) {
											
											if(chance(100*(2/3))) {
												
												if(scn_area(_scni) == AREA.SLUM and chance(80))
													scnActArr[_scni][0] = db_act_rnd_slum(_scni,T);
												else if(scn_area(_scni) == AREA.BROTHEL and chance(80))
													scnActArr[_scni][0] = db_act_rnd_broth(_scni,T);
												else scnActArr[_scni][0] = db_act_rnd(_scni,T);
												if(instance_of(scnActArr[_scni][0],oChar)) S[$ _scni][$ K.ACT+K.LFT] = scnActArr[_scni][0].ruid;
												
											} else scnActArr[_scni][0] = U;
											
										}
										
									#endregion
									
									#region Actor Right
										
										if(scnActArr[_scni][1] == N) {
											
											if(chance(100*(2/3))) {
												
												if(scn_area(_scni) == AREA.SLUM and chance(80))
													scnActArr[_scni][1] = db_act_rnd_slum(_scni,T);
												else if(scn_area(_scni) == AREA.BROTHEL and chance(80))
													scnActArr[_scni][1] = db_act_rnd_broth(_scni,T);
												else scnActArr[_scni][1] = db_act_rnd(_scni,T);
												if(instance_of(scnActArr[_scni][1],oChar)) S[$ _scni][$ K.ACT+K.RHT] = scnActArr[_scni][1].ruid;
												
											} else scnActArr[_scni][1] = U;
											
										}
										
									#endregion
									
								#endregion
								
							}
							
						#endregion
						
					#endregion
					
					#region Scene Actors (CM Circles: Entity: Random (9))
						
						// TODO NEXT
						
					#endregion
					
				}
				
			#endregion
			
		}
		
	#endregion
	
	#region Scene Blend
		
		// Init
		var rgb1 = color_get_rgb(scnBlend1)
		var rgb2 = color_get_rgb(scnBlend2)
		var rgb3 = rgb1
		
		// Do blend changing?
		if(scnBlend1 != scnBlend2 and scnBlendDeli < scnBlendDel) {
			
			// Color Calc...
			rgb3[0] = lerp(rgb1[0],rgb2[0],scnBlendPct)
			rgb3[1] = lerp(rgb1[1],rgb2[1],scnBlendPct)
			rgb3[2] = lerp(rgb1[2],rgb2[2],scnBlendPct)
			scnBlend3 = color_make_rgb(rgb3)
			
			// Iterate Scene Blend Change...
			scnBlendDeli = clamp(scnBlendDeli+1,0,scnBlendDel)
			scnBlendPct = scnBlendDeli/scnBlendDel
			
			
		} else {
			
			// Finalize/Reset
			scene_set_blend(scnBlend2)
			scnBlendDeli = 0
			scnBlendPct = 0
			
		}
		
	#endregion
	
	#region Global Relative Draw Vars
		
		wref = max(1,bgImg.sprite_width)
		href = max(1,bgImg.sprite_height)
		mwref = 1
		mhref = 1
		if(bbox_sanity(bgImg)) {
			
			mwref = max(1,bgImg.bbox_right)
			mhref = max(1,bgImg.bbox_bottom)
			bgmxpct = MX/mwref
			bgmypct = MY/mhref
			bgdltx = bgImg.bbox_left
			bgdlty = bgImg.bbox_top
			
		}
		
	#endregion
	
#endregion