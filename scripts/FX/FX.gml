function sfx_gunshot(vol) {
    
    if(is_array(vol)) audio_play_sound(sfxShot,0,F,random_range(vol[0],vol[1]),0,random_range(.9,1.1));
    else audio_play_sound(sfxShot,0,F,vol,0,random_range(.9,1.1));
    
}