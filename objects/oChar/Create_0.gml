/// @description Init

// Vars
suited = T
suitedo = suited
head = sprSpitfire2
headpol = -1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
body = sprSpitfireBod
bodypol = 1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
suitSpr = sprContainer
suitInst = N
font = fFem
col = [c.nr,c.nr,c.ny,c.ny]
scni = N
uid = ACTOR.SPITFIRE
relation = 0
mouseIn = F

#region Dialogue
	
	diai = 0
	dia = {}
	dia[$ K.NM] = "Unknown"
	dia[$ K.SX] = N
	dia[$ K.KNW] = F
	dia[$ K.I] = 0
	dia[$ K.CAR] = 0
	dia[$ K.CAR+K.DL] = GSPD*.2
	dia[$ K.CAR+K.DLI] = 0
	/*
	dia[$ 0] = {}
	dia[$ 0][$ 0] = {}
	dia[$ 0][$ 0][$ K.TRG] = TRIGGER.START
	dia[$ 0][$ 0][$ K.DN] = F
	dia[$ 0][$ 0][$ 0] = "Euurghhh...."
	dia[$ 0][$ 0][$ 1] = "Is it time already?"
	dia[$ 0][$ 0][$ 2] = "Shit! I'm late!"
	*/
	
#endregion