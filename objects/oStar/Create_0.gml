/// @description Init

// Basics
draw = F
par = N
flick = F
flickPct = random_range(0.9,1.1)
pct = random(1)
rot = random(360)
scl = N
nova = random_range(1/3,2/3)
isChild = F
isNova = N
isGalaxy = N
isStar = N
if(chance(1)) flick = T;
sprHFlip = F
if(pct >= .99 and chance(50)) pick_star_asset();
else if(pct >= 1/3 and pct <= 2/3 and chance(1)) pick_nova_asset();
else if(pct <= .1 and chance(.1)) pick_galaxy_asset();
vmlt = random_range(2,4)