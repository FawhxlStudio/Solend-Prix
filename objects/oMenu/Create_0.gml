/// @description Init
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

expL = ds_list_create()
expCnt = 3
expDel = GSPD*random_range(1/3,3)
voxd = F
vox1 = F
vox2 = F
vox3 = F
voxFade = 1
voxi = 1/(GSPD*6)
ashGain = 0
ashid = N
preDel = GSPD*2
preDeli = 0//? That's what I usually do...
titDel = GSPD*3
titDel2 = GSPD*5
titDel3 = GSPD*8
titDel4 = GSPD*1
titDeli = 0//? That's what I usually do...
titAngl = N
titAngl2 = N