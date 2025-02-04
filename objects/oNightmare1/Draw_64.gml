/// @description Draw and Logix
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(!diaNar_done(NS[$ global.radnm]) and is_undefined(inst)) {
	
	NS[$ global.tutnm][$ K.DN] = T
	inst = diaNar_anim_start(global.radnm) // Tutorial; If not set to tutnm, is debugged
	audio_play_sound(sfxVoid,2,T,1)
	
}
done = (diaNar_done(NS[$ global.tutnm]) and diaNar_done(NS[$ global.radnm]) and diaNar_done(NS[$ global.beknm]) and diaNar_done(NS[$ global.visnm]))