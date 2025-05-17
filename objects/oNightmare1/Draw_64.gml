/// @description Draw and Logix


if(!DBG.active or !DBG.nightSkip) {
	
	if(!diaNar_done(NS[$ global.tutnm]) and is_undefined(inst)) {
		
		inst = diaNar_anim_start(global.tutnm) // Tutorial; If not set to tutnm, is debugged
		audio_play_sound(sfxVoid,2,T,1)
		
	}
	// diaNar_done(NS[$ global.tutnm]) and diaNar_done(NS[$ global.radnm]) and diaNar_done(NS[$ global.beknm]) and 
	done = (diaNar_done(NS[$ global.tutnm]) and diaNar_done(NS[$ global.radnm]) and diaNar_done(NS[$ global.visnm]))

} else done = T;