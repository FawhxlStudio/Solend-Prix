/// @description Rescale
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

scl = (WW*D.zmn)/sprite_get_width(sprite_index)
xx = WW/2
yy = WH/2