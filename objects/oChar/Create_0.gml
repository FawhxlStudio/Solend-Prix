/// @description Init

#region Essential & Flags
	
	// Essentials
	uid = U
	ruid = N // uid for randoms and unknowns
	scni = N
	col = [1,c.lgry,c.lgry,c.gry,c.gry]
	deptho = depth
	hide = F
	approach = F
	
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
	surf =  N
	
	// Modifier
	velSclMn = 1.1
	velSclMx = 1.3
	velScl = random_range(velSclMn,velSclMx)
	velSclPct = (velScl-velSclMn)/(velSclMx-velSclMn)
	
	// Selection Delay
	selDel = ceil(GSPD*.1)
	selDeli = 0
	
	// Percent Based x/y set for zoom transitions
	xpct = N
	ypct = N
	
#endregion

#region Stats
	
	// Relation to Player (-/+)
	relation = 0
	bias = irandom_range(BIAS.POSITIVE,BIAS.NEGATIVE)
	align = irandom_range(ALIGN.FRIENDLY,ALIGN.HOSTILE)
	
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