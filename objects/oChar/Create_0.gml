/// @description Init

#region Essential & Flags
	
	// Essentials
	uid = ACTOR.UNKNOWN
	col = [1,c.lgry,c.lgry,c.gry,c.gry]
	scni = N
	ruid = N // uid for randoms and unknowns
	deptho = depth
	
	// Suit Flags
	suited = T
	suitedo = suited
	
	// Interact Flag
	mouseIn = F
	hvrPctO = 0
	hvrDelO = GSPD
	hvrDeliO = 0
	
	// Dialogue Flags
	spkr = F
	spkro = F
	diaAvailable = F
	
#endregion

#region Stats
	
	// Relation to Player (-/+)
	relation = 0
	
#endregion

#region Char Fonts
	
	font1 = fNeu // Dialogue
	font2 = fNeu // Emote
	
#endregion

#region Assets
	
	// Face
	imgFace = sprNA
	imgFacePol = 1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
	
	// Suit
	imgSuit = sprNA
	imgSuitPol = 1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
	
	// Suit (Back)
	imgSuitBack = sprNA
	imgSuitBackPol = 1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
	
	// Suit (Crate)
	imgSuitCrate = sprSuitCrate
	suitCrateInst = N
	
	// Dialogue
	imgDia = N
	imgDiaPol = 1
	
#endregion

#region Image Flip Vars
	
	// Flags
	sprFlipH = F
	sprFlipV = F
	
	// Iterator
	flipDel = GSPD
	flipHi = 0
	flipVi = 0
	
	// Old Pol
	imgPolOld = N
	
#endregion

#region Dialogue
	
	diai = 0
	dia = {}
	dia[$ K.NM] = ACTORn[ACTOR.UNKNOWN]
	dia[$ K.FNM] = N
	dia[$ K.LNM] = N
	dia[$ K.SX] = N
	dia[$ K.KNW] = F
	dia[$ K.FNM+K.KNW] = F
	dia[$ K.LNM+K.KNW] = F
	dia[$ K.I] = 0
	dia[$ K.CAR] = 0
	dia[$ K.CAR+K.DL] = GSPD*.2
	dia[$ K.CAR+K.DLI] = 0
	
#endregion