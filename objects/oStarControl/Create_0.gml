/// @description Insert description here

// Controls
velTgt = 0
vel = 0
dir = 0
acc = 0.001
pct = 0

// Count Modulation
baseCnt = 500*max(.8,WW/1920) // Based on 1920x1080/1200, Scales
cntSini = random(360)
cntSinv = 0.05
cntSin  = cos(degtorad(cntSini))
cnt = round(baseCnt+(baseCnt*(cntSin/4)))

// Asset Lists
novL = ds_list_create()
novCnt = irandom(2)
galL = ds_list_create()
galCnt = irandom_range(1,7)

// Init Star List
for(var i = 0; i < cnt; i++) {
    
    // Create Inst
    var inst = instance_create_layer(random(WW),random(WH),"MG",oStar)
    inst.par = id
    
    if(ds_list_size(galL) < galCnt) {
        
        // Galaxy Asset
        ds_list_add(galL,inst)
        with(inst) pick_galaxy_asset();
        
    } else if(ds_list_size(novL) < novCnt) {
        
        // Nova Asset
        ds_list_add(novL,inst)
        with(inst) pick_nova_asset();
        
    }
}