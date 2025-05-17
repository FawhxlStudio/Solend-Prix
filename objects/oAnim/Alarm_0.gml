/// @description Rescale


if(tightPan) scl = (WW*1.1)/sprite_get_width(sprite_index)
else scl = (WW*D.zmn)/sprite_get_width(sprite_index)
if(sprite_index == sprNA and is_string(animStr) and variable_instance_exists(NS[$ animStr],K.BG0+K.SPR)) {
	
	if(is_array(NS[$ animStr][$ K.BG0+K.SPR])) {
		
		if(arrSpri == N) arrSpri = 0;
		if(tightPan) scl = (WW*1.1)/sprite_get_width(NS[$ animStr][$ K.BG0+K.SPR][arrSpri])
		else scl = (WW*D.zmn)/sprite_get_width(NS[$ animStr][$ K.BG0+K.SPR][arrSpri])
		
	} else {
		
		if(tightPan) scl = (WW*1.1)/sprite_get_width(NS[$ animStr][$ K.BG0+K.SPR])
		else scl = (WW*D.zmn)/sprite_get_width(NS[$ animStr][$ K.BG0+K.SPR])
		
	}
	
}
xx = WW/2
yy = WH/2