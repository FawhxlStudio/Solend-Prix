/// @description Init

par = N
xx = WW/2
yy = WH/2
xbd = xx
xship = -xx
xxship = irandom_range(-xx*2,-xx)
velship = .001*D.z
shipDel = GSPD*10
shipDeli = 0
shipDel2i = 0
shipDelPct = 0
shipDel2Pct = 0
xbg = xx
ybd = yy
yship = yy
ybg = yy
xpct = U
ypct = U
dltx = 0
dlty = 0
scl = 1
panMult = 1
panMultBD = -.03
panMultShip = 1/3
panMultBG = 2/3

// IMAGE Blends
LIGHTS_OFF = c.dgry
LIGHTS_DIM = c.gry
LIGHTS_ON = c.wht

animStr = N
font = fNeu
bg = sprNA
bd = sprNA
ship = sprNA
strBld = ""
strDel = 1.5
strDeli = 0
diaInst = N

// Sound Stopped
sndStp = U
tightPan = F
actionPan = F
lightFX = F
fxInst = {
	
	col    : make_color_rgb(random_range(192,255),random_range(102,153),random_range(0,51)),
	blend  : F,
	blendc : c.r,
	dark   : F,
	cinematic: F
	
}

// Sprite Array Vars
arrSpri = N // The current step/sprite in the array used; Only the even elements are the sprites
arrSprDeli = N // Delay Iterator; 
arrSprDel = N // Next Odd Element; Delay Length
arrSprDone = F