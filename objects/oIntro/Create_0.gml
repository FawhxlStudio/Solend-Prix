/// @description Weeks Earlier Fade-In

#region Old (Nightmare Related)
	
	nightmare = F
	nightmareInst = U
	
#endregion

#region Control Overrides + Fetch Init
	
	D.diaOverride = T
	load = T
	load2 = F
	alarm[0] = 4
	
#endregion

#region Intro Delays/Triggers
	
	// Early
	fadeIn = GSPD*2
	fadeIni = 0
	mns = 1.5
	del = (GSPD*60)*mns
	deli = 0
	
	// Late
	gothDel1 = del/4
	gothDel1i = 0
	gothDel2 = del/4
	gothDel2i = 0
	gothDel3 = del/4
	gothDel3i = 0
	
	// Final
	fadeOut = GSPD*2
	fadeOuti = 0
	
#endregion

#region Intro Assets
	
	// Surfaces
	narSurf = N
	narY1 = WH
	narY2 = U
	surfDrawer = N
	
	// Sprites
	theia = sprPlanetTheia
	gas   = sprPlanetTheiaGas
	goth  = sprPlanetGothicaBR
	stars = instance_create_layer(0,0,"Logic",oStarControl)
	stars.dir = 184 // A little tilt down?
	
	// Objects
	objTheia = N
	objGas = N
	objGoth = N
	objsInit = F
	theiaDone = F
	
	#region Intro String Array
		
		strArr = ["We were born under a distant sun,\n"
			+"on a world that never thawed.\n\n"
			+"Theia, a frozen tundra wrapped in eerie silence.\n"
			+"We orbited a gas giant that menaced us from above.\n\n"
			+"Our families sought a future there...\n"
			+"Instead, we had been abandoned.",
			
			"Our last chance... They had put in me.\n"
			+"I was the best pilot we had left...\n\n"
			+"I took the only capable ship,\n"
			+"unburdened by regulators or govenors-\n"
			+"its as dangerous as it is fast.\n"
			+"Praey, an old prototype fighter-scout.",
			
			"Everyone I knew froze themselves,\n"
			+"going into a stasis-sleep... while I chased a signal,\n"
			+"like whispers from the void.\n\n"
			+"It was a beacon, and it sent me to the Solend system.\n"
			+"And now Im here, Gothica, the busy hub of Solend.\n\n"
			+"A city of dark lights, loyalties and illusions...",
			
			"I had been chosen as a pilot in this... Solend Prix.\n"
			+"A race, a chance to save my home...\n\n"
			+"A fucking race...\n\n"
			+"A chance...\n\n"
			+"The longer Im here, the clearer things get...\n"
			+"This race isnt help- its a blood sport.",
			
			"Im not here to play in this twisted charity.\n"
			+"Im Sylas Praey- and Im here to break it."]
		
		// May change the way the narration is presented but for now we'll combine it all into one string...
		introStr = ""
		for(var i = 0; i < array_length(strArr); i++) {
			
			if(i == 0) introStr = strArr[i];
			else introStr += "\n\n-\n\n"+strArr[i];
			
		}
		
	#endregion
	
	#region Intro Asset Array
		
		assArr = [sprPlanetTheia,sprPlanetTheiaGas,
			sprPlanetGothicaBR,sprPix,sprGal1,sprGal2,
			sprGal3,sprGal4,sprGal5,sprGal6,sprGal7,
			sprGal8,sprGal9,sprNova1,sprNova2,sprNova3,
			sprNova4,sprNova5,sprNova6,sprNova7,sprNova8,
			sprNova9,sprStar1,sprStar2,sprStar3,sprStar4]
		
	#endregion
	
#endregion