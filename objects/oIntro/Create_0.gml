/// @description Weeks Earlier Fade-In

nightmare = F
nightmareInst = U
del = (GSPD*60)*60
deli = 0
fadeIn = GSPD/3
fadeIni = 0
fadeOut = GSPD*2
fadeOuti = 0
D.diaOverride = T
fetch = T
alarm[0] = 4
gothDel1 = GSPD*14
gothDel1i = 0
gothDel2 = GSPD*21
gothDel2i = 0
gothDel3 = GSPD*14
gothDel3i = 0

// Intro Assets
theia = sprPlanetTheia
gas   = sprPlanetTheiaGas
goth  = sprPlanetGothicaBR
stars = instance_create_layer(0,0,"Logic",oStarControl)
stars.dir = 182

// Scene Objects
objTheia = N
objGas = N
objGoth = N
objsInit = F
theiaDone = F

#region Intro Asset Array
	
	assArr = [sprPlanetTheia,sprPlanetTheiaGas,
		sprPlanetGothicaBR,sprPix,sprGal1,sprGal2,
		sprGal3,sprGal4,sprGal5,sprGal6,sprGal7,
		sprGal8,sprGal9,sprNova1,sprNova2,sprNova3,
		sprNova4,sprNova5,sprNova6,sprNova7,sprNova8,
		sprNova9,sprStar1,sprStar2,sprStar3,sprStar4]
	
#endregion