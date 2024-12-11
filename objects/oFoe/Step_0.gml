/// @description Updates
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(D.game_state = GAME.PLAY) {
	
	x += (vel*pol)*degtorad(dir)
	
}