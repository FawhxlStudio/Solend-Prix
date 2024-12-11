/// @description Init

// Polarity (-R2L/+L2R)
sprite_index = sprShipBig
w = D.bgImg.sprite_width
h = D.bgImg.sprite_height
zmn = 1/3
zmx = 2/3
z = random_range(zmn,zmx)
xy2 = [-w/2,(h/3)+(h*(z*.67))]
pol = irandom(1)
if(pol == 0) {
	
	xy2[0] = w/2
	pol = -1
	
}
dir = random_range(-10,10)
xy2[0]*=pol
scl = D.bgImg.image_xscale
vel = 2*z
