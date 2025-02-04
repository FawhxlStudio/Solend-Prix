/// @description Rescale
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(tightPan) scl = (WW*1.1)/sprite_get_width(sprite_index)
else scl = (WW*D.zmn)/sprite_get_width(sprite_index)
if(sprite_index == sprNA and is_string(animStr) and variable_instance_exists(NS[$ animStr],K.BG0+K.SPR)) {

	if(tightPan) scl = (WW*1.1)/sprite_get_width(NS[$ animStr][$ K.BG0+K.SPR])
	else scl = (WW*D.zmn)/sprite_get_width(NS[$ animStr][$ K.BG0+K.SPR])
	
}
xx = WW/2
yy = WH/2