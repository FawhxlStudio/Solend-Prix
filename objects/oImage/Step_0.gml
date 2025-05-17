/// @description MG+ Look

if(D.game_state == GAME.PLAY
	and is(sprite_index)) {
	
	if(!is_bg_img()) { 
		
		x = lerp(D.bgdltx,D.mwref,xxpct)
		y = lerp(D.bgdlty,D.mhref,yypct)
		
	}
	
}