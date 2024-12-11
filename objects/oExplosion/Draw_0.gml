/// @description No Draw; Logic
// Do Destroy Logic Externally for lists n such to keep track of count and to call draw_self()
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
if(initd) {
	
	al = clamp(al-ai,0,al)
	image_alpha = al/almx
	
}
if(drft and initd) {
	
	// X Drift
	if(xpct > .5) drftx += image_alpha/10;
	else drftx -= image_alpha/10;
	
	// Y Drift
	if(ypct > .5) drfty += image_alpha/10;
	else drfty -= image_alpha/10;
	
}
xx = (w*xpct)+(drftx/scl)
yy = (h*ypct)+(drfty/scl)
x = xx+panx
y = yy+pany