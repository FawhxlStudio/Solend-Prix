/// @description Flush & Fetch...
if(fetch) {
	
	draw_texture_flush()
	sprite_prefetch_multi(assArr)
	fetch = F
	if(surface_exists(narSurf)) surface_free(narSurf);
	narSurf = N
	
}