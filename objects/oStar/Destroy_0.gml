/// @description Spawn/Respawn

if(par != N and instance_exists(par)) {
    
    var _rep = 0
    if(instance_number(object_index) < par.cnt) _rep = 1;
    
    if(x < -sprite_width and (par.dir > 90 or par.dir < 270)) {
        
        repeat(_rep) {
            
            var inst = instance_create_layer(WW+sprite_width,random(WH),layer,object_index)
            inst.par = par
            
        }
        
    } else if(x > WW+sprite_width and (par.dir < 90 or par.dir > 270)) {
        
        repeat(_rep) {
            
            var inst = instance_create_layer(-sprite_width,random(WH),layer,object_index)
            inst.par = par
            
        }
        
    } else if(y < -sprite_height and (par.dir > 0 and par.dir < 180)) {
        
        repeat(_rep) {
            
            var inst = instance_create_layer(random(WW),WH+sprite_height,layer,object_index)
            inst.par = par
            
        }
        
    } else if(y > WH+sprite_height and (par.dir > 180 and par.dir < 360)) {
        
        repeat(_rep) {
            
            var inst = instance_create_layer(random(WW),-sprite_height,layer,object_index)
            inst.par = par
            
        }
        
    }
    
}