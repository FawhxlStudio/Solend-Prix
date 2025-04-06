/// @description Updates

// Rotation Iterate
rot+=rotv
if(rot < 0) rot+=360;
else if(rot >= 360) rot-=360;

// Velocity
if(par != N and instance_exists(par)) {
    
    // Position Iterate
    x += ( cos(degtorad(par.dir))*par.vel)*pct
    y += (-sin(degtorad(par.dir))*par.vel)*pct
    
    // Respawn?
    var _res = (par.cnt < instance_number(object_index))
    if(x < -sprite_width and (par.dir > 90 or par.dir < 270)) instance_destroy(id,_res);
    else if(x > WW+sprite_width and (par.dir < 90 or par.dir > 270)) instance_destroy(id,_res);
    else if(y < -sprite_height and (par.dir > 0 and par.dir < 180)) instance_destroy(id,_res);
    else if(y > WH+sprite_height and (par.dir > 180 and par.dir < 360)) instance_destroy(id,_res);
    
}