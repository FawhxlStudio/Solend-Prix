/// @description Insert description here

// Controls
vel = 5
dir = 180
acc = 0.02
pct = 0

// Count Modulation
baseCnt = 500*max(.8,WW/1920) // Based on 1920x1080/1200, Scales
cntSini = random(360)
cntSinv = 0.05
cntSin  = -sin(degtorad(cntSini))
cnt = round(baseCnt+(baseCnt*(cntSin/4)))

// Init Star List
for(var i = 0; i < cnt; i++) {
    
    var inst = instance_create_layer(random(WW),random(WH),"MG",oStar)
    inst.par = id
    
}