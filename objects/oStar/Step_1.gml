/// @description Position Updates

// Rotation
image_angle = rot

// Alpha/Flicker
if(flick) {
    
    if(par != N and instance_exists(par)) image_alpha = (lerp(.8,1,pct)*random(flickPct))*par.pct;
    else image_alpha = (lerp(.8,1,pct)*random(flickPct));
    
} else {
    
    if(par != N and instance_exists(par)) image_alpha = (lerp(.8,1,pct))*par.pct;
    else image_alpha = lerp(.8,1,pct);
    if(isGalaxy or isNova) image_alpha = nova;
    
}

// Scale
if(scl == N) {
    
    if(isStar) scl = random_range(((WH*.01)/sprite_get_height(sprite_index))*2/3,((WH*.01)/sprite_get_height(sprite_index))*(1+(1/3)));
    else if(isNova) scl = random_range(((WW)/sprite_get_width(sprite_index))*(1+(1/3)),((WW)/sprite_get_width(sprite_index))*(1+(2/3)));
    else if(isGalaxy) scl = random_range(((WW*0.05)/sprite_get_width(sprite_index))*2/3,((WW*0.2)/sprite_get_width(sprite_index))*(1+(1/3)));
    else scl = max(1,4*pct);
    if(isStar or isNova or isGalaxy) depth*=2-scl;
    image_xscale = scl
    if(sprHFlip) image_xscale*=-1;
    image_yscale = scl
    var _pad = max(sprite_width,sprite_height)
    if(x > WW) x = WW+_pad;
    else if(x < 0) x = -_pad;
    if(y > WH) y = WH+_pad;
    else if(y < 0) y = -_pad;
    
    // Track or Destroy Nova (Full?)
    if(isNova and is(par) and ds_list_size(par.novL) < 2) ds_list_add(par.novL,id);
    else if(isNova and is(par)) instance_destroy(id,F);
    
    // Track or Destroy Galaxy (Full?)
    if(isGalaxy and is(par) and ds_list_size(par.galL) < 7) ds_list_add(par.galL,id);
    else if(isGalaxy and is(par)) instance_destroy(id,F);
    
} else {
    
    image_xscale = scl
    if(sprHFlip) image_xscale*=-1;
    image_yscale = scl
    
}

// Velocity
if(par != N and instance_exists(par)) {
    
    // Set Child Flag
    isChild = T
    
    var _vel = par.vel
    if(isStar) _vel*=vmlt;
    if(sprite_index == sprPlanetTheiaGas) _vel*=6+vmlt
    if(sprite_index == sprPlanetTheia) _vel*=10+vmlt
    if(isGalaxy) _vel*=scl;
    
    // Position Iterate
    if(draw) {
        
        x += ( cos(degtorad(par.dir))*_vel)*pct
        y += (-sin(degtorad(par.dir))*_vel)*pct
        
    }
    
    // Respawn?
    var _res = (par.cnt > instance_number(oStar) and sprite_index == sprPix)
    var _aw = abs(sprite_width)
    var _ah = abs(sprite_height)
    if(x < -_aw and (par.dir >= 90 or par.dir <= 270)) instance_destroy(id,_res or isGalaxy or isNova);
    else if(x > WW+_aw and (par.dir <= 90 or par.dir >= 270)) instance_destroy(id,_res or isGalaxy or isNova);
    if(y < -_ah and (par.dir >= 0 and par.dir <= 180)) instance_destroy(id,_res or isGalaxy or isNova);
    else if(y > WH+_ah and (par.dir >= 180 and par.dir <= 360)) instance_destroy(id,_res or isGalaxy or isNova);
    
} else if(isChild) instance_destroy(id,F); // Destroy cause the parent is gone now

draw = T