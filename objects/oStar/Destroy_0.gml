/// @description Spawn/Respawn

if(par != N and instance_exists(par)) {
    
    // Remove Galaxy from Parent's List
    if(isGalaxy) {
        
        for(var i = 0; i < ds_list_size(par.galL); i++) {
            
            if(par.galL[|i] == id) ds_list_delete(par.galL,i);
            
        }
        
    }
    
    // Remove Nova from Parent's List
    if(isNova) {
        
        for(var i = 0; i < ds_list_size(par.novL); i++) {
            
            if(par.novL[|i] == id) ds_list_delete(par.novL,i);
            
        }
        
    }
    
    var _rep = 1
    var _aw = abs(sprite_width)
    var _ah = abs(sprite_height)
    if(instance_number(oStar) < par.cnt) _rep = 2;
    
    if(x < -_aw and (par.dir >= 90 or par.dir <= 270)) {
        
        repeat(_rep) {
            
            var inst = instance_create_layer(WW+_aw,random(WH),"MG",oStar)
            inst.par = par
            
        }
        
    } else if(x > WW+_aw and (par.dir <= 90 or par.dir >= 270)) {
        
        repeat(_rep) {
            
            var inst = instance_create_layer(-_aw,random(WH),"MG",oStar)
            inst.par = par
            
        }
        
    }
    
    if(y < -_ah and (par.dir >= 0 and par.dir <= 180)) {
        
        repeat(_rep) {
            
            var inst = instance_create_layer(random(WW),WH+_ah,"MG",oStar)
            inst.par = par
            
        }
        
    } else if(y > WH+_ah and (par.dir >= 180 and par.dir <= 360)) {
        
        repeat(_rep) {
            
            var inst = instance_create_layer(random(WW),-_ah,"MG",oStar)
            inst.par = par
            
        }
        
    }
    
}