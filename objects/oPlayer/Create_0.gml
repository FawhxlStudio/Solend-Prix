/// @description Init

#region Essential & Flags
	
	// Essential
	uid = ACTOR.SYLAS
	ruid = N
	col = [1,c.nb,c.nb,c.lb,c.lb]
	
	// Suit
	suited = F
	suitedo = F
	hudActive = T
	
	// Dialogue Speaker
	spkr = F
	spkro = F
	
#endregion

#region Asset Vars
	
	// Face
	imgFace = sprSylas
	imgFacePol = -1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
	
	// Suit
	imgSuit = sprSylasSuit
	imgSuitPol = -1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
	
	// Suit (Back)
	imgSuitBack = sprNA
	imgSuitBackPol = 1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
	
	// Suit (Crate)
	imgSuitCrate = sprSuitCrate
	suitCrateInst = N // Instance for Suit Crate
	
	// Dialogue
	imgDia = N
	imgDiaPol = 1
	
	// Voice Pitch
	vPitch = N
	
#endregion

#region Flip Vars
	
	// Flags
	sprFlipH = F
	sprFlipV = F
	
	// Iterator
	flipDel = GSPD
	flipHi = 0
	flipVi = 0
	
	// Old Polarity
	imgPolOld = N // Need to know the old polarity while flipping
	
#endregion

#region Char Fonts
	
	font1 = fSylas // Dialogue
	font2 = fEmoteMale // Emote
	
#endregion

#region Party List (List of Actors in Player's Party, Includes Player)
	
	party = ds_list_create()
	
#endregion

#region Dialogue Info
	
	diai = 0
	dia = {}
	dia[$ K.NM] = "Pilot"
	dia[$ K.FNM] = "Sylas"
	dia[$ K.LNM] = "Praey"
	dia[$ K.SX] = SEX.MALE
	dia[$ K.KNW] = T
	dia[$ K.FNM+K.KNW] = T
	dia[$ K.LNM+K.KNW] = T
	dia[$ K.I] = 0
	dia[$ K.CAR] = 0
	dia[$ K.CAR+K.DL] = GSPD*.2
	dia[$ K.CAR+K.DLI] = 0
	
#endregion