/// @description Draw Loading & Pause Menu

// Loading Screen
if(!loading_done() and is(loadSurf) and surface_exists(loadSurf)
	and game_state != GAME.INIT and (game_state == GAME.MENU and instance_of(M.introInst,oIntro)))
	draw_surface_ext(loadSurf,0,0,1,1,0,c.wht,1);