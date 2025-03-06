/// @description Init

// Vars
suited = F
suitedo = F
head = sprSylas4
headPol = -1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
body = sprSylasBod2
bodyPol = -1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
suitSpr = sprContainer
suitInst = N
diaSpr = N
diaSprPol = 1
sprFlipH = F
sprFlipV = F
flipDel = GSPD
flipHi = 0
flipVi = 0
font1 = fSylas
font2 = fEmoteMale
col = [1,c.nb,c.nb,c.lb,c.lb]
party = ds_list_create()
uid = ACTOR.SYLAS
spkr = F
spkro = F
sprPolo = N

#region Dialogue
	
	diai = 0
	dia = {}
	dia[$ K.NM] = "Sylas"
	dia[$ K.SX] = SEX.MALE
	dia[$ K.KNW] = F
	dia[$ K.I] = 0
	dia[$ K.CAR] = 0
	dia[$ K.CAR+K.DL] = GSPD*.2
	dia[$ K.CAR+K.DLI] = 0
	
#endregion