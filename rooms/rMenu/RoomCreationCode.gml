// Set Game State
D.game_state = GAME.MENU
if(!instance_exists(oMenu))
	global.menu_object = instance_create_layer(0,0,"Logic",oMenu);