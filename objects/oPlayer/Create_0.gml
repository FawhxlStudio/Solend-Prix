/// @description Init

// Vars
suited = F
suitedo = F
head = sprSylas2
headpol = -1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
body = sprSylasBod2
bodypol = 1 // Based on being in 1st/Left Focus Position in Dialogue; see Main GUI Draw
suitSpr = sprContainer
suitInst = N
font1 = fNeu
font2 = fNeuB
col = [c.nb,c.nb,c.lb,c.lb]
party = ds_list_create()
uid = ACTOR.SYLAS
spkr = F
spkro = F

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