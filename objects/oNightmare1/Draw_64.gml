/// @description Draw and Logix
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(!diaNar_done(NS[$ global.visnm]) and is_undefined(inst)) {
	
	inst = diaNar_anim_start(global.visnm) // Tutorial; If not set to tutnm, is debugged
	audio_play_sound(sfxVoid,2,T,1)
	
}
// diaNar_done(NS[$ global.tutnm]) and diaNar_done(NS[$ global.radnm]) and diaNar_done(NS[$ global.beknm]) and 
done = (diaNar_done(NS[$ global.visnm]))