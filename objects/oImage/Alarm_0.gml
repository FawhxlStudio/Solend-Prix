/// @description Rescale
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(is_bg_img()) {
	
	scl = ((WW*D.zmn)/sprite_get_width(sprite_index))*sclMult
	if(!is_undefined(sclMultW)) sclW = ((WW*D.zmn)/sprite_get_width(sprite_index))*sclMultW;
	else sclW = U;
	if(!is_undefined(sclMultH)) sclH = ((WW*D.zmn)/sprite_get_width(sprite_index))*sclMultH;
	else sclH = U;
	xx = WW*xxpct
	yy = WH*yypct
	
} else {
	
	scl = (WW/sclBase)/sprite_get_width(sprite_index)
	
}