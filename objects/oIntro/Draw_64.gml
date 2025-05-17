/// @description Draw and Logix


#region Init Draw Olds
	
	var ao = draw_get_alpha()
	var hvao = [draw_get_halign(),draw_get_valign()]
	var fo = draw_get_font()
	
#endregion

if(!load and loading_done()) {
	
	#region Fade In Iteration
		
		if(fadeIni < fadeIn) fadeIni = clamp(fadeIni+1,0,fadeIn);
		var _pctin = fadeIni/fadeIn
		
	#endregion
	
	#region Petrichor Planet Inits
		
		if(_pctin >= 1 and objTheia == N) {
			
			objGas = instance_create_layer(WW,WH/3,"FG",oStar)
			objGas.sprite_index = gas
			objGas.scl = (WH*(1+(1/2)))/sprite_get_height(gas)
			objGas.flick = F
			objGas.par = stars
			objGas.isChild = T
			objGas.pct = 1
			objGas.rot = 0
			objGas.x = WW+((sprite_get_width(gas)*objGas.scl)/1.8)
			objGas.sprHFlip = T
			objGas.isNova = F
			objGas.isGalaxy = F
			objGas.isStar = F
			objGas.depth += 2
			objGas.deptho = objGas.depth
			
			objTheia = instance_create_layer(WW,WH/2,"FG",oStar)
			objTheia.sprite_index = theia
			objTheia.scl = (WH*(2/3))/sprite_get_height(theia)
			objTheia.flick = F
			objTheia.par = stars
			objTheia.isChild = T
			objTheia.pct = 1
			objTheia.rot = 0
			objTheia.x = WW+((sprite_get_width(theia)*objTheia.scl)/1)
			objTheia.isNova = F
			objTheia.isGalaxy = F
			objTheia.isStar = F
			objTheia.depth += 1
			objTheia.deptho = objTheia.depth
			
			objsInit = T
			
			stars.velTgt = .2
			
		}
		
	#endregion
	
	#region Petrichor Velocity Changes
		
		if(instance_exists(objTheia) and objTheia.x < WW*2/3 and objsInit and stars.velTgt != .02) stars.velTgt = .02;
		if(instance_exists(objTheia) and objTheia.x < WW*1/2 and objsInit and stars.velTgt != .3 ) stars.velTgt = .3;
		if(!instance_exists(objTheia) and !instance_exists(objGas) and objsInit and stars.velTgt != 10) {
			
			stars.acc = .01
			stars.velTgt = 10
			theiaDone = T
			
		}
		
	#endregion
	
	#region Flight Triggers
		
		var _isFlight = (theiaDone and !instance_exists(objTheia) and !instance_exists(objGas))
		if(_isFlight and gothDel1i < gothDel1) {
			
			#region Stars Motion Direction Change... (Flying to the Right, to Flying Down)
				
				gothDel1i = clamp(gothDel1i+1,0,gothDel1)
				var _goth1 = gothDel1i/gothDel1
				stars.dir = lerp(180,100,_goth1)
				
			#endregion
		
		} else if(_isFlight and gothDel2i < gothDel2) {
			
			// Delay before Last Part Starts... (Fly Down for a lil...)
			gothDel2i = clamp(gothDel2i+1,0,gothDel2)
			
		} else if(_isFlight and gothDel2i >= gothDel2) {
			
			#region Last Part (Stop @ Gothica Planet; Solend System)
				
				stars.velOverride = T
				if(gothDel3i < gothDel3) gothDel3i = clamp(gothDel3i+1,0,gothDel3);
				var _goth3 = gothDel3i/gothDel3
				stars.vel = lerp(stars.velTgt,0,_goth3)
				
				if(objGoth == N) {
					
					objGoth = instance_create_layer(WW,WH,"FG",oStar)
					objGoth.sprite_index = goth
					objGoth.par = stars
					objGoth.isChild = T
					
					with(objGoth) {
						
						scl = WW/sprite_get_width(sprite_index)
						image_xscale = scl
						image_yscale = scl
						flick = F
						pct = 1
						rot = 0
						
					}
					
					objGoth.x = WW+((objGoth.sprite_width*(objGoth.par.vel)*cos(degtorad(stars.dir+180)))*cos(degtorad(stars.dir+180)))
					objGoth.y = WH+((objGoth.sprite_height*(objGoth.par.vel)*-sin(degtorad(stars.dir+180)))*-sin(degtorad(stars.dir+180)))
					objGoth.xo = objGoth.x
					objGoth.yo = objGoth.y
					objGoth.isNova = F
					objGoth.isGalaxy = F
					objGoth.isStar = F
					// No Depth Change Needed
					
				}
				
				if(objGoth != N) {
					
					var _gpct = 1-(stars.vel/stars.velTgt)
					_gpct = 1 - power(1-_gpct,3);
					
					with(objGoth) {
						
						x = lerp(xo,WW,_gpct)
						y = lerp(yo,WH,_gpct)
						
					}
					
				}
				
			#endregion
			
		}
	
	#endregion
	
	#region Delay Iteration
		
		if(_pctin >= 1 and deli < del) {
			
			if(keyboard_check(vk_shift)) {
				
				deli = clamp(deli+3,0,del)
				if(keyboard_check_pressed(vk_enter)) deli = del;
				
			} else deli = clamp(deli+1,0,del);
			
		}
		var _pctdel = deli/del
		
	#endregion
	
	#region Fade Out Iteration
		
		if(_pctdel >= 1 and fadeOuti < fadeOut) {
			
			if(!load2) {
				
				var _rdy = load_resort_area()
				_rdy = load_random_actors()
				load2 = _rdy
				
				if(load2) {
					
					set_scni(SCENE.RESORT_BED)
					room_goto(rGame)
					
				}
				
			}
			if(load2) fadeOuti = clamp(fadeOuti+1,0,fadeOut);
			
		}
		var _pctout = fadeOuti/fadeOut
		
	#endregion
	
	#region Apply/Draw Fade...
		
		if(_pctdel < 1) draw_set_alpha(_pctin);
		else draw_set_alpha(max(0,_pctin-_pctout));
		stars.pct = draw_get_alpha()
		draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
		
	#endregion
	
	#region Destroy after Fade Out...
		
		if(_pctout >= 1) {
			
			D.diaOverride = F
			M.introInst = N
			if(is(narSurf) and surface_exists(narSurf)) surface_free(narSurf);
			if(is(surfDrawer) and instance_exists(surfDrawer)) instance_destroy(surfDrawer);
			ds_list_destroy(stars.novL)
			ds_list_destroy(stars.galL)
			instance_destroy(stars)
			instance_destroy(id)
			
		}
		
	#endregion
	
	#region NIGHTMARE1 INIT LOGIC TO REPURPOSE FOR LATER NIGHTMARE SCENE
	
	/* Nightmare Intro Disabled: To use Nightmare for Sleep/Rest Event
	if(!is_undefined(nightmareInst) and instance_exists(nightmareInst)) {
		
		nightmare = nightmareInst.done
		if(nightmare) {
			
			instance_destroy(nightmareInst)
			nightmareInst = U
			
		}
		
	}
	if(nightmare and is_undefined(nightmareInst)) {
		
		draw_set_alpha(fade/(GSPD*2))
		draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
		draw_set_font(fTitle)
		draw_set_hvalign([fa_center,fa_middle])
		draw_text_transformed_color(WW/2,WH/2,"Weeks Earlier",(WW/string_width("Weeks Earlier"))*(2/3),(WW/string_width("Weeks Earlier"))*(2/3),0,c.wht,c.wht,c.lgry,c.lgry,fade/(GSPD*2))
		
		#region Iterate Intro Delay
			
			if(del > 0) del--;
			if(fade > 0 and del <= 0) fade--;
			if(fade <= 0) {
			    
			    D.fd = GSPD*2
			    D.diaOverride = F
			    instance_destroy(id)
			    
			}
			
		#endregion
		
	} else if(is_undefined(nightmareInst) and !nightmare) nightmareInst = instance_create_layer(0,0,layer,oNightmare1);
	*/
	
	#endregion
	
} else {
	
	#region Loading Screen
		
		// Draw Load Surface
		// if(is(D.loadSurf) and surface_exists(D.loadSurf)) draw_surface_ext(D.loadSurf,0,0,1,1,0,c.wht,1);
		
	#endregion
	
}

#region Reset Draw Olds
	
	draw_set_alpha(ao)
	draw_set_hvalign(hvao)
	draw_set_font(fo)
	
#endregion