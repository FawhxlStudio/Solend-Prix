/// @description Insert description here
// You can write your code in this editor

// Draw Updates
if(par != N and instance_exists(par)) image_alpha = (pct*random(flickPct))*par.pct;
else image_alpha = (pct*random(flickPct));
if(sprite_index == sprStar and scl == N) scl = random_range(2/3,1+(1/3));
else if(scl == N) scl = max(1,4*pct);
image_xscale = scl
image_yscale = scl