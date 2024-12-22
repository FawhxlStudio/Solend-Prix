/// @description Init

// Basic/Meta
active = T
edit = F
editHelp = T
console = F
introSkip = F
resetControl = T
unstuck = T
muted = F
envInvert = T

// Dbg Strings, 1 Auto Clear; 2 Manual Clear
dbgStr = T
dbgStr1 = ""
dbgStr2 = ""
dbgStrScrl = 0
CON = U
CONi = 0
CONpre = "dia"
CONprei = CONSOLE.DIALOGUE
CONactor = ACTOR.SYLAS
CONarr = [""]
CONstri = 0
CONinit = T

// Edit Struct
ES = U
ESsel = N
ESi = 0
ESi2 = 0
ESedit = N

if(file_exists(game_save_id+"nodes.json")) {
	
	var _str = ""
	var _f = file_text_open_read(game_save_id+"nodes.json")
	while(!file_text_eof(_f)) _str += file_text_readln(_f)
	ES = json_parse(_str)
	ESi = variable_instance_names_count(ES)
	
} else ES = {}

if(file_exists(game_save_id+"console.json")) {
	
	var _str = ""
	var _f = file_text_open_read(game_save_id+"console.json")
	while(!file_text_eof(_f)) _str += file_text_readln(_f)
	CON = json_parse(_str)
	ESi = variable_instance_names_count(ES)
	
} else CON = {}