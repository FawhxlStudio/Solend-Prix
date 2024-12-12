/// @description Debug
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(active and edit and !console) {
	
	#region Console Toggle
		
		if(keyboard_check_pressed(192)) {
			
			console = T
			edit = F
			
		}
		
	#endregion
	
	#region Base Debug Info
		
		// Toggle Debug String
		if(keyboard_check_pressed(vk_insert)) {
			
			dbgStrScrl = 0
			dbgStr = !dbgStr;
			
		}
		
		if(dbgStr) {
			
			// Debug String Scroll
			if(mouse_wheel_up()) {
				
				if(keyboard_check(vk_shift)) dbgStrScrl -= 12;
				else dbgStrScrl -= 6;
				
			} else if(mouse_wheel_down()) {
				
				if(keyboard_check(vk_shift)) dbgStrScrl += 12;
				else dbgStrScrl += 6;
				
			}
			
			dbgStr1 += "Game State: "
			switch(D.game_state) {
				
				case GAME.INIT: dbgStr1 += "INIT"; break;
				case GAME.MENU: dbgStr1 += "MENU"; break;
				case GAME.PLAY: dbgStr1 += "PLAY"; break;
				default: dbgStr1 += "Error"; break;
				
			}
			dbgStr1 += "\nMouse Win PCT X/Y: "+string(MXPCT)+"/"+string(MYPCT)
			if(is(S)) {
				
				if(variable_instance_exists(S,string(D.scni)))
					if(variable_instance_exists(S[$ string(D.scni)],K.BG0+K.SPR)) {
						
						// Add Scene Stuff
						dbgStr1 += "\nScene: "+sprite_get_name(S[$ string(D.scni)][$ K.BG0+K.SPR])
							+"\nScene I: "+string(D.scni)
							+"\nScene State: "
							
						switch(D.scene_state) {
							
							case GAME.INIT: dbgStr1 += "INIT"; break;
							case GAME.MENU: dbgStr1 += "MENU"; break;
							case GAME.PLAY: dbgStr1 += "PLAY"; break;
							default: dbgStr1 += "Error"; break;
							
						}
						
					}
				
			}
			dbgStr1 += "\nMouse BG X/Y pct: "+string(D.bgmxpct)+"/"+string(D.bgmypct)
			if(P.suited) dbgStr1 += "\nSuited"
			if(is(ES)) dbgStr2 = "\n"+json_stringify(ES[$ string(ESsel)],T)
			
			// Olds
			draw_olds_pull()
			
			// Init
			text_prep(string_trim(dbgStr1+dbgStr2))
			draw_set_font(fDebug)
			
			// Draw Debug Strings
			draw_set_alpha(bgc_[0])
			if(MXPCT > 1/3) {
				
				// Left Side
				draw_set_hvalign([fa_left,fa_top])
				draw_rectangle_color(0,0,strw_,strh_+dbgStrScrl,bgc_[1],bgc_[2],bgc_[3],bgc_[4],F)
				draw_text_color(0,dbgStrScrl,str_,fgc_[1],fgc_[2],fgc_[3],fgc_[4],fgc_[0])
				
			} else {
				
				// Move to Right to get out of way...
				draw_set_hvalign([fa_right,fa_top])
				draw_rectangle_color(WW,0,WW-strw_,strh_+dbgStrScrl,bgc_[1],bgc_[2],bgc_[3],bgc_[4],F)
				draw_text_color(WW,dbgStrScrl,str_,fgc_[1],fgc_[2],fgc_[3],fgc_[4],fgc_[0])
				
			}
			
			// Reset
			draw_olds_push()
			dbgStr1 = ""
			
		}
		
	#endregion
	
} else if(active and console) {
	
	#region Console Toggle
		
		if(keyboard_check_pressed(192)) console = F;
		
	#endregion
	
	#region Console Editor
		
		#region Console Init
			
			// Console Input
			if(!variable_instance_exists(CON,string(D.scni))) {
				
				CON[$ string(D.scni)] = {}
				CONarr = [""]
				CONstri = 0
				
			} else if(CONarr != CON[$ string(D.scni)][$ "log"]) {
				
				CONarr = [""]
				if(variable_instance_exists(CON[$ string(D.scni)],"log"))
					CONarr = CON[$ string(D.scni)][$ "log"]
				CONstri = array_length(CONarr)-1
				
			}
			
			if(CONinit) {
				
				keyboard_string = CONarr[CONstri]
				CONinit = F
				
			}
			
		#endregion
		
		#region Hotkeys
			
			try {
				
				if(keyboard_check_pressed(vk_anykey)) {
					
					switch(keyboard_key) {
						
						#region Console Input Scroll
							
							case vk_up: {
								
								do {
									
									CONstri = clamp(CONstri-1,0,array_length(CONarr)-1)
									if(CONstri == 0 and CONarr[CONstri] == "") {
										
										CONstri = array_length(CONarr)-1
										break
										
									}
									
								} until(CONarr[CONstri] != "")
								keyboard_string = CONarr[CONstri]
								break
								
							}
							
							case vk_down: {
								
								do {
									
									CONstri = clamp(CONstri+1,0,array_length(CONarr)-1)
									if(CONstri == array_length(CONarr)-1) break;
									
								} until(CONarr[CONstri] != "")
								keyboard_string = CONarr[CONstri]
								break
								
							}
							
						#endregion
						
						#region Console Input Modifier (Prefix/Target)
							
							case vk_right: {
								
								switch(CONprei) {
									
									case CONSOLE.DIALOGUE: {
										
										if(CONactor < ACTOR.LAST) CONactor++; // Actor Iterate +
										else {
											
											// Loop + change From Dialogue...
											CONactor = ACTOR.LAST-1
											// Console Target Change +
											if(CONprei < CONSOLE.LAST) CONprei++; // Iterate
											else CONprei = CONSOLE.FIRST+1; // Loop
											
										}
										break
										
									}
									
									case CONSOLE.NARRATIVE: {
										
										if(CONactor < ACTOR.LAST) CONactor++; // Actor Iterate +
										else {
											
											// Loop + change From Dialogue...
											CONactor = ACTOR.LAST-1
											// Console Target Change +
											if(CONprei < CONSOLE.LAST) CONprei++; // Iterate
											else CONprei = CONSOLE.FIRST+1; // Loop
											
										}
										break
										
									}
									
									default: {
										
										// Console Target Change +
										if(CONprei < CONSOLE.LAST) CONprei++; // Iterate
										else CONprei = CONSOLE.FIRST+1; // Loop
										break
										
									}
									
								}
								break
								
							}
							
							case vk_left: {
								
								switch(CONprei) {
									
									case CONSOLE.DIALOGUE: {
										
										if(CONactor > ACTOR.FIRST) CONactor--; // Actor Iterate -
										else {
											
											// Loop + change From Dialogue...
											CONactor = ACTOR.FIRST+1
											// Console Target Change -
											if(CONprei > CONSOLE.FIRST) CONprei--; // Iterate
											else CONprei = CONSOLE.LAST-1; // Loop
											
										}
										break
										
									}
									
									case CONSOLE.NARRATIVE: {
										
										if(CONactor > ACTOR.FIRST) CONactor--; // Actor Iterate -
										else {
											
											// Loop + change From Dialogue...
											CONactor = ACTOR.FIRST+1
											// Console Target Change -
											if(CONprei > CONSOLE.FIRST) CONprei--; // Iterate
											else CONprei = CONSOLE.LAST-1; // Loop
											
										}
										break
										
									}
									
									default: {
										
										// Console Target Change -
										if(CONprei > CONSOLE.FIRST) CONprei--; // Iterate
										else CONprei = CONSOLE.LAST-1; // Loop
										break
										
									}
									
								}
								break
								
							}
							
						#endregion
						
						#region String Hotkeys
							
							case vk_f1: keyboard_string += "[$ \"0\"]";break;
							case vk_f2: keyboard_string += "[$ \"1\"]";break;
							case vk_f3: keyboard_string += "[$ \"2\"]";break;
							case vk_f4: keyboard_string += "[$ \"3\"]";break;
							case vk_f5: keyboard_string += "[$ \"4\"]";break;
							case vk_f6: keyboard_string += "[$ \"5\"]";break;
							case vk_f7: keyboard_string += "[$ \"6\"]";break;
							case vk_f8: keyboard_string += "[$ \"7\"]";break;
							case vk_f9: keyboard_string += "[$ \"8\"]";break;
							case vk_f10: keyboard_string += "[$ \"9\"]";break;
							case vk_f11: keyboard_string += "[$ \"10\"]";break;
							case vk_f12: keyboard_string += "[$ \""+string(D.scni)+"\"]";break;
							
						#endregion
						
					}
					
				}
				
			} catch(_ex) {}
			
		#endregion
		
		#region Input Update
			
			CONarr[CONstri] = string_copy(keyboard_string,0,string_length(keyboard_string))
			CON[$ string(D.scni)][$ "log"] = CONarr
			
		#endregion
		
		#region Console Confirm Input
			
			if(keyboard_check(vk_control) and keyboard_check_pressed(vk_enter)) {
				
				#region Set Output
					
					// Ensure Output Exists
					if(!variable_instance_exists(CON[$ string(D.scni)],"output"))
						CON[$ string(D.scni)][$ "output"] = ""
					
					var skip = 0
					for(var i = 0; i < array_length(CONarr); i++) {
						
						if(CONarr[i] == "") skip++;
						else CON[$ string(D.scni)][$ "output"] += CONpre+CONarr[i-skip]+"\n";
						
					}
					
				#endregion
				
				#region Write Scene File
					
					var _f = file_text_open_write(game_save_id+"console"+string(D.scni)+".json")
					var str = CON[$ string(D.scni)][$ "output"]
					file_text_write_string(_f,str)
					file_text_close(_f)
					
				#endregion
				
				#region Write Console File
					
					var _f = file_text_open_write(game_save_id+"console.json")
					var str = json_stringify(CON,T)
					file_text_write_string(_f,str)
					file_text_close(_f)
					
				#endregion
				
			} else if(keyboard_check_pressed(vk_enter)) {
				
				#region Confirm Input Edit/Entry
					
					if(CONstri == array_length(CONarr)-1) {
						
						// Append
						keyboard_string = ""
						CONstri++
						CONarr[CONstri] = ""
						
					} else {
						
						// Return to Latest after edit confirm
						CONstri = array_length(CONarr)-1
						keyboard_string = CONarr[CONstri]
						
					}
					
				#endregion
				
			}
			
		#endregion
		
		#region Draw
			
			var ex = "Example:\n"
				+"dia = {}\n"
				+"dia[$ \"name\"] = \"SYLAS\"\n"
				+"dia[$ \"sex\"] = SEX.MALE\n"
				+"dia[$ \"known\"] = F\n"
				+"dia[$ \"i\"] = 0\n"
				+"dia[$ \"cur\"] = 0\n"
				+"dia[$ \"curd\"] = GSPD*.2\n"
				+"dia[$ \"curi\"] = 0\n"
				+"dia[$ \"0\"] = {}\n"
				+"dia[$ \"0\"][$ \"0\"] = {}\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"trg\"] = TRIGGER.START\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"done\"] = F\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"lim\"] = 2\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"0\"] = \"Euurghhh....\"\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"1\"] = \"Is it time already?\"\n"
				+"dia[$ \"0\"][$ \"0\"][$ \"2\"] = \"Shit! I'm late!\"\n"
				+"________________________________________________\n"
				+"Pending:\n"
			var pre = CONpre
			var str = "Prefix: "+pre+"\n"+ex+"\n"
			for(var i = 0; i < array_length(CONarr)-1; i++) {
				
				if(CONarr[i] == "") continue;
				if(i == CONstri) str += pre+CONarr[i]+" |>CURRENT EDIT<|\n";
				else str += pre+CONarr[i]+"\n";
				
			}
			draw_set_hvalign([fa_left,fa_bottom])
			draw_set_font(fDebug)
			var strw = max(string_width(str),string_width(pre+CONarr[CONstri]))
			draw_set_alpha(5/6)
			draw_rectangle_color(0,0,strw,WH,c.blk,c.blk,c.blk,c.blk,F)
			draw_set_alpha(1)
			draw_text_ext_color(0,WH-20,pre+CONarr[CONstri],20,WW,c.wht,c.wht,c.ng,c.ng,1)
			draw_text_ext_color(0,WH-(STRH+40),str,20,WW,c.lg,c.lg,c.g,c.g,1)
			
			
		#endregion
		
	#endregion
	
}

if(!console) CONinit = T