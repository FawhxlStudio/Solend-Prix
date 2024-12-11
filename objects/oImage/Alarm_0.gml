/// @description Rescale
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(is_bg_img()) {
	
	scl = ((WW*D.zmn)/sprite_get_width(sprite_index))*sclMult
	xx = WW*xxpct
	yy = WH*yypct
	
} else {
	
	scl = (WW/sclBase)/sprite_get_width(sprite_index)
	
}