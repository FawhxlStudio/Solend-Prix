/// @description Position Updates

// Rotation
image_angle = rot

// Alpha/Flicker
if(flick) {
    
    if(par != N and instance_exists(par)) image_alpha = (lerp(.4,1,pct)*random(flickPct))*par.pct;
    else image_alpha = (lerp(.4,1,pct)*random(flickPct));
    
} else {
    
    if(par != N and instance_exists(par)) {
        
        image_alpha = (lerp(.4,1,pct))*par.pct;
        if(isGalaxy or isNova) image_alpha = nova*par.pct;
        
    } else {
        
        image_alpha = lerp(.4,1,pct);
        if(isGalaxy or isNova) image_alpha = nova;
        
    }
    
}

// Scale
if(scl == N) {
    
    // Track or Destroy Nova (Full?)
    if(isNova and is(par) and ds_list_size(par.novL) < 4) {
        
        ds_list_add(par.novL,id)
        isChild = T
        
    } else if(isNova and is(par)) instance_destroy(id,F);
    
    // Track or Destroy Galaxy (Full?)
    if(isGalaxy and is(par) and ds_list_size(par.galL) < 7) {
        
        ds_list_add(par.galL,id)
        isChild = T
        
    } 
    else if(isGalaxy and is(par)) instance_destroy(id,F);
    
    if(isStar) scl = random_range(((WH*.025)/sprite_get_height(sprite_index))*2/3,((WH*.025)/sprite_get_height(sprite_index))*(1+(1/3)));
    else if(isNova) scl = random_range(((WW)/sprite_get_width(sprite_index))*(2/3),((WW)/sprite_get_width(sprite_index))*2);
    else if(isGalaxy) scl = random_range(((WW*0.05)/sprite_get_width(sprite_index)),((WW*0.2)/sprite_get_width(sprite_index))*(1+(1/3)));
    else scl = max(1,4*pct);
    image_xscale = scl
    if(sprHFlip) image_xscale*=-1;
    image_yscale = scl
    var _pad = max(abs(sprite_width),abs(sprite_height))
    if(x > WW) x = WW+_pad;
    else if(x < 0) x = -_pad;
    if(y > WH) y = WH+_pad;
    else if(y < 0) y = -_pad;
    
} else {
    
    image_xscale = scl
    if(sprHFlip) image_xscale*=-1;
    image_yscale = scl
    
}

draw = T                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

// Velocity
if(par != N and instance_exists(par)) {
    
    // Set Child Flag
    isChild = T
    
    var _vel = par.vel
    if(isStar) _vel*=vmlt;
    if(sprite_index == sprPlanetTheiaGas) _vel*=6+vmlt;
    if(sprite_index == sprPlanetTheia) _vel*=10+vmlt;
    if(isGalaxy) _vel*=(scl*1.5);
    
    if(isStar) depth = lerp(layer_get_depth("MG"),layer_get_depth("FG")+10,pct);
    else if(sprite_index == sprPix) depth = lerp(layer_get_depth("BG"),layer_get_depth("MG")+1,pct);
    else if(isGalaxy) depth = lerp(layer_get_depth("Logic"),layer_get_depth("BG")+1,pct);
    
    // Position Iterate
    if(draw and sprite_index != sprPlanetGothicaBR) {
        
        x += ( cos(degtorad(par.dir))*_vel)*pct
        y += (-sin(degtorad(par.dir))*_vel)*pct
        
    }
    
    // Respawn?
    var _res = (par.cnt > instance_number(oStar) and sprite_index == sprPix)
    var _pad = max(abs(sprite_width),abs(sprite_height))
    if(x < -_pad and (par.dir >= 90 or par.dir <= 270)) instance_destroy(id,_res or isGalaxy or isNova);
    else if(x > WW+_pad and (par.dir <= 90 or par.dir >= 270)) instance_destroy(id,_res or isGalaxy or isNova);
    if(y < -_pad and (par.dir >= 0 and par.dir <= 180)) instance_destroy(id,_res or isGalaxy or isNova);
    else if(y > WH+_pad and (par.dir >= 180 and par.dir <= 360)) instance_destroy(id,_res or isGalaxy or isNova);
    
} else if(isChild) instance_destroy(id,F); // Destroy cause the parent is gone now