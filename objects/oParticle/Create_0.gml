/// @description Init

sprite_index = sprEmbers
image_index = irandom(image_number)
almn = (GSPD/2)
almx = (GSPD*3)
al = random_range(almn,almx)
scl = random_range(1-(2/3),1+(2/3))
ai = (1/scl)
image_xscale = scl
image_yscale = scl
w = WW
h = WH
if(flip()) xpct = random_range(0,1);
else xpct = 1;
if(xpct >= 1) ypct = random_range(0,1);
else ypct = 1;
xx = w*xpct
yy = h*ypct
panx = 0
pany = 0
drft = T
drftx = 0
drfty = 0
initd = F

vel = 20
dir = random_range(100,135)
rot = random_range(0,359)
roti = flipr()/scl
dirDltmn = 0
dirDltmx = 20
dirDlt = random_range(dirDltmn+scl,dirDltmx-scl)
dirDlti = flip()
dirSin = sin(rot)
xcos = cos(dir)
ysin = sin(dir)