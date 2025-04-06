/// @description Insert description here
// You can write your code in this editor

baseCnt = 500*max(.8,WW/1920)
cntSini+=cntSinv
if(cntSini < 0) cntSini += 360;
else if(cntSini >= 360) cntSini -= 360;
cntSin  = -sin(degtorad(cntSini))
cnt = round(baseCnt+(baseCnt*(cntSin/4)))