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
							
							var _scn = S[$ _scni]
							var _ks = variable_instance_get_sorted_strKeys(_scn,T)
							var _locked = (array_contains(_ks,K.ACT+K.LCK) and _scn[$ K.ACT+K.LCK])
							scnActArr[_scni] = [N,N]
							
						#endregion
						
						#region Defined Actors
							
							#region Actor Left?
								
								if(array_contains(_ks,K.ACT+K.LFT) and !instance_of(_scn[$ K.ACT+K.LFT],oChar)) {
									
									// Get/Make Char Object...
									if(_scn[$ K.ACT+K.LFT] == ACTOR.RANDOM) scnActArr[_scni][0] = db_act_rnd(_scni,T);
									else scnActArr[_scni][0] = actor_find(_scn[$ K.ACT+K.LFT]);
									
									// Undefined if Fail
									if(!instance_of(scnActArr[_scni][0],oChar)) scnActArr[_scni][0] = U;
									
								} else if(instance_of(_scn[$ K.ACT+K.LFT],oChar)) scnActArr[_scni][0] = _scn[$ K.ACT+K.LFT];
								if(_locked and !instance_of(scnActArr[_scni][0],oChar)) scnActArr[_scni][0] = U;
								
							#endregion
							
							#region Actor Right?
								
								if(array_contains(_ks,K.ACT+K.RHT) and !instance_of(_scn[$ K.ACT+K.RHT],oChar)) {
									
									// Get/Make Char Object...
									if(_scn[$ K.ACT+K.RHT] == ACTOR.RANDOM) scnActArr[_scni][1] = db_act_rnd(_scni,T);
									else scnActArr[_scni][1] = actor_find(_scn[$ K.ACT+K.RHT]);
									
									// Undefined if Fail
									if(!instance_of(scnActArr[_scni][1],oChar)) scnActArr[_scni][1] = U;
									
								} else if(instance_of(_scn[$ K.ACT+K.RHT],oChar)) scnActArr[_scni][1] = _scn[$ K.ACT+K.RHT];
								if(_locked and !instance_of(scnActArr[_scni][1],oChar)) scnActArr[_scni][1] = U;
								
							#endregion
							
						#endregion
						
						#region Empty and Unlocked?
							
							if(!_locked) {
								
								#region Fill Empties 20% Each (N)
									
									#region Actor Left
										
										if(scnActArr[_scni][0] == N) {
											
											if(chance(33)) scnActArr[_scni][0] = db_act_rnd(_scni,T);
											else scnActArr[_scni][0] = U;
											
										}
										
									#endregion
									
									#region Actor Right
										
										if(scnActArr[_scni][1] == N) {
											
											if(chance(33)) scnActArr[_scni][1] = db_act_rnd(_scni,T);
											else scnActArr[_scni][1] = U;
											
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