/// @description Weeks Earlier Fade-In

nightmare = F
nightmareInst = U
del = GSPD*(60*60)
deli = 0
fadeIn = GSPD/3
fadeIni = 0
fadeOut = GSPD*2
fadeOuti = 0
D.diaOverride = T
fetch = T
gothDel1 = GSPD*20
gothDel1i = 0
gothDel2 = GSPD*5
gothDel2i = 0

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