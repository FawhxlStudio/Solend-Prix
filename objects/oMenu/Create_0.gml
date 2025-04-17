/// @description Init
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

// Fade in
fade = 1
fadei = 1/(GSPD*6)

// BGM
bgm = msxPixelCycle // Nightcrawl?
bgmID = N
bgmPlayed = F

// Delays + Title Stuff
preDel = GSPD*2 // These are Simple Delays, they deiterate themselves
titDel = GSPD*3
titsfx = N
titAngl = N
titAngl2 = N
titSurf = N
tita = 0
btnDel = GSPD*2
btnDeli = 0

// Menu Sprites
bdspr = sprNewMenuBD
bgspr = sprNewMenuBG
mgspr = sprClubBoothBG
mg2spr = sprSylasSuit

// Settings
settings = F
setDel = GSPD/2
setDeli = 0

// Load
load_menu()
loaded = T