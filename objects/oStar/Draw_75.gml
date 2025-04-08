/// @description Draw
if(draw) {
    
    if(isStar or isNova or isGalaxy) shader_set(shDiscardBlk);
    draw_self()
    shader_reset()
    
}