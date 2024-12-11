/// @description MG+ Look
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
if(D.game_state == GAME.PLAY
	and is(sprite_index)) {
	
	if(!is_bg_img()) { 
		
		x = lerp(D.bgdltx,D.mwref,xxpct)
		y = lerp(D.bgdlty,D.mhref,yypct)
		
	}
	
}