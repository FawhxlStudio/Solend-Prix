/// @description Init

// Vars
suited = T
suitedo = suited
head = sprSpitfire2
headPol = -1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
body = sprSpitfireBod
bodyPol = 1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
bodyBack = sprSpitfireBack
bodyBackPol = 1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
suitSpr = sprContainer
diaSpr = N
diaSprPol = 1
sprFlipH = F
sprFlipV = F
flipDel = GSPD
flipHi = 0
flipVi = 0
suitInst = N
font1 = fFem
font2 = fFem
col = [1,c.nr,c.nr,c.ny,c.ny]
scni = N
uid = ACTOR.SPITFIRE
relation = 0
mouseIn = F
spkr = F
spkro = F
diaAvailable = F
sprPolo = N

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
	
#endregion