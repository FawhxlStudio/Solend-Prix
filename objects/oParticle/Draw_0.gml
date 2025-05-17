/// @description No Draw; Logic
// Do Destroy Logic Externally for lists n such to keep track of count and to call draw_self()


#region TODO Lighting
    
    var _r = random_range(216,255)
    var _t = 255-_r
    var _g = random_range(120,175-_t)
    image_blend = make_color_rgb(_r,_g,0)
    
#endregion

if(initd) {
	
	al = clamp(al-ai,0,al)
	image_alpha = al/almx
    image_angle = rot
    rot += roti
    if(rot >= 360) rot -= 360;
    else if(rot < 0) rot += 360;
	
}
if(drft and initd) {
	
	// X Drift
	drftx += (vel*xcos)
	
	// Y Drift
	drfty += (vel*ysin)
	
}
xx = (w*xpct)+(drftx/scl)
yy = (h*ypct)+(drfty/scl)
x = xx+panx
y = yy+pany