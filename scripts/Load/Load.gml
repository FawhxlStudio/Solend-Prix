// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region Loads
	
	#region Meta
		
		function area_check() {
			
			switch(string_split(global.SCENEn[D.scni],"_")[0]) {
				
				case "RESORT": {
					
					load_resort_area()
					load_random_actors()
					break
					
				}
				
				case "CITY": {
					
					load_city_area()
					load_random_actors()
					break
					
				}
				
				case "CLUB": {
					
					load_club_area()
					load_random_actors()
					break
					
				}
				
				case "BROTH": {
					
					load_brothel_area()
					load_random_actors()
					break
					
				}
				
				case "SPACEPORT": {
					
					load_port_area()
					load_random_actors()
					break
					
				}
				
				case "SLUM": {
					
					load_slums_area()
					load_random_actors()
					break
					
				}
				
				case "COCKPIT": {
					
					break
					
				}
				
			}
			
		}
		
		function loading_done() {
			
			return (tgs_are_loaded() and ags_are_loaded())
			
		}
		
		function load_common() {
			
			var done = T
			#region Audio
				
				if(!audio_group_is_loaded(audiogroup_default)) audio_group_load(audiogroup_default);
				for(var i = 0; i < array_length(AGA); i++) {
					
					if(!audio_group_is_loaded(AGA[i])) audio_group_load(AGA[i]);
					
				}
				
			#endregion
			
			#region Textures/Sprites
				
				if(texturegroup_get_status("tg_char_sylas") != texturegroup_status_fetched) {
					
					if(texturegroup_get_status("tg_char_sylas") == texturegroup_status_unloaded) texturegroup_load("tg_char_sylas",T);
					done = F
					
				}/* else if(texturegroup_get_status("tg_common") != texturegroup_status_fetched) {
					
					if(texturegroup_get_status("tg_common") == texturegroup_status_unloaded) texturegroup_load("tg_common",T);
					done = F
					
				}*/ else if(texturegroup_get_status("tg_goth_common") != texturegroup_status_fetched) {
					
					if(texturegroup_get_status("tg_goth_common") == texturegroup_status_unloaded) texturegroup_load("tg_goth_common",T);
					done = F
					
				}
				
			#endregion
			return done
			
		}
		
		function load_menu() {
			
			var done = T
			if(texturegroup_get_status("tg_menu") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_menu") == texturegroup_status_unloaded) texturegroup_load("tg_menu",T);
				done = F
				
			}
			load_club2_area()
			return done
			
		}
		
		function load_intro() {
			
			var done = T
			if(texturegroup_get_status("tg_intro") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_intro") == texturegroup_status_unloaded) texturegroup_load("tg_intro",T);
				done = F
				
			}
			load_starfield()
			return done
			
		}
		
		function load_starfield() {
			
			var done = T
			if(texturegroup_get_status("tg_starfield") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_starfield") == texturegroup_status_unloaded) texturegroup_load("tg_starfield",T);
				done = F
				
			}
			return done
			
		}
		
	#endregion
	
	#region Areas
		
		function load_resort_area() {
			
			var done = T
			if(!audio_group_is_loaded(ag_resort)) audio_group_load(ag_resort);
			if(texturegroup_get_status("tg_resort") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_resort") == texturegroup_status_unloaded) texturegroup_load("tg_resort",T);
				done = F
				
			}
			load_resort2_area()
			load_anim_news1()
			return done
			
		}
		
		function load_resort2_area() {
			
			var done = T
			if(texturegroup_get_status("tg_resort2") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_resort2") == texturegroup_status_unloaded) texturegroup_load("tg_resort2",T);
				done = F
				
			}
			return done
			
		}
		
		function load_city_area() {
			
			var done = T
			if(!audio_group_is_loaded(ag_city)) audio_group_load(ag_city);
			if(texturegroup_get_status("tg_city") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_city") == texturegroup_status_unloaded) texturegroup_load("tg_city",T);
				done = F
				
			}
			
		}
		
		function load_club_area() {
			
			var done = T
			if(!audio_group_is_loaded(ag_club)) audio_group_load(ag_club);
			if(texturegroup_get_status("tg_club1") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_club1") == texturegroup_status_unloaded) texturegroup_load("tg_club1",T);
				done = F
				
			} else if(texturegroup_get_status("tg_char_spitfire") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_char_spitfire") == texturegroup_status_unloaded) texturegroup_load("tg_char_spitfire",T);
				done = F
				
			}
			done = load_club2_area()
			return done
			
		}
		
		function load_club2_area() {
			
			var done = T
			if(texturegroup_get_status("tg_club2") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_club2") == texturegroup_status_unloaded) texturegroup_load("tg_club2",T);
				done = F
				
			}
			return done
			
		}
		
		function load_brothel_area() {
			
			var done = T
			if(!audio_group_is_loaded(ag_brothel)) audio_group_load(ag_brothel);
			if(texturegroup_get_status("tg_brothel") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_brothel") == texturegroup_status_unloaded) texturegroup_load("tg_brothel",T);
				done = F
				
			}
			return done
			
		}
		
		function load_slums_area() {
			
			var done = T
			if(!audio_group_is_loaded(ag_slums)) audio_group_load(ag_slums);
			if(texturegroup_get_status("tg_slums") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_slums") == texturegroup_status_unloaded) texturegroup_load("tg_slums",T);
				done = F
				
			}
			return done
			
		}
		
		function load_port_area() {
			
			var done = T
			if(!audio_group_is_loaded(ag_port)) audio_group_load(ag_port);
			if(texturegroup_get_status("tg_port") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_port") == texturegroup_status_unloaded) texturegroup_load("tg_port",T);
				done = F
				
			}
			done = load_resort2_area()
			return done
			
		}
		
	#endregion
	
	#region Anims
		
		function load_anim_news1() {
			
			var done = T
			if(texturegroup_get_status("tg_news1") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_news1") == texturegroup_status_unloaded) texturegroup_load("tg_news1",T);
				done = F
				
			}
			done = load_char_alexandria()
			return done
			
		}
		
		function load_anim_nightmare1() {
			
			var done = T
			if(!audio_group_is_loaded(ag_nightmare1)) audio_group_load(ag_nightmare1);
			if(texturegroup_get_status("tg_nightmare1") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_nightmare1") == texturegroup_status_unloaded) texturegroup_load("tg_nightmare1",T);
				done = F
				
			}
			return done
			
		}
		
	#endregion
	
	#region Actors
		
		function load_char_spitfire() {
			
			var done = T
			if(texturegroup_get_status("tg_char_spitfire") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_char_spitfire") == texturegroup_status_unloaded) texturegroup_load("tg_char_spitfire",T);
				done = F
				
			}/* else if(texturegroup_get_status("tg_common_female") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_common_female") == texturegroup_status_unloaded) texturegroup_load("tg_common_female",T);
				done = F
				
			}*/
			return done
			
		}
		
		function load_char_alexandria() {
			
			var done = T
			if(texturegroup_get_status("tg_char_alexandria") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_char_alexandria") == texturegroup_status_unloaded) texturegroup_load("tg_char_alexandria",T);
				done = F
				
			}/* else if(texturegroup_get_status("tg_common_female") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_common_female") == texturegroup_status_unloaded) texturegroup_load("tg_common_female",T);
				done = F
				
			}*/
			return done
			
		}
		
		function load_random_actors() {
			
			var done = T
			// Commons
			/*if(texturegroup_get_status("tg_common_male") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_common_male") == texturegroup_status_unloaded) texturegroup_load("tg_common_male",T);
				done = F
				
			} else if(texturegroup_get_status("tg_common_female") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_common_female") == texturegroup_status_unloaded) texturegroup_load("tg_common_female",T);
				done = F
				
			} else */if(texturegroup_get_status("tg_males") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_males") == texturegroup_status_unloaded) texturegroup_load("tg_males",T);
				done = F
				
			} else if(texturegroup_get_status("tg_females") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_females") == texturegroup_status_unloaded) texturegroup_load("tg_females",T);
				done = F
				
			} else if(!D.fLoaded) {
				
				sprite_prefetch_multi(D.fiArr)
				D.fLoaded = T
				
			} else if(!D.mLoaded) {
				
				sprite_prefetch_multi(D.miArr)
				D.mLoaded = T
				
			} else if(texturegroup_get_status("tg_males_close") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_males_close") == texturegroup_status_unloaded) texturegroup_load("tg_males_close",T);
				done = F
				
			} else if(texturegroup_get_status("tg_females_close") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_females_close") == texturegroup_status_unloaded) texturegroup_load("tg_females_close",T);
				done = F
				
			} else if(!D.cfLoaded) {
				
				sprite_prefetch_multi(D.cfiArr)
				D.cfLoaded = T
				
			} else if(!D.cmLoaded) {
				
				sprite_prefetch_multi(D.cmiArr)
				D.cmLoaded = T
				
			}
			return done
			
		}
		
		function load_combat(_sex) {
			
			var done = T
			if(_sex == SEX.MALE and texturegroup_get_status("tg_combat_male") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_combat_male") == texturegroup_status_unloaded) texturegroup_load("tg_combat_male",T);
				done = F
				
			} else if(_sex == SEX.FEMALE and texturegroup_get_status("tg_combat_female") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_combat_female") == texturegroup_status_unloaded) texturegroup_load("tg_combat_female",T);
				done = F
				
			} else if(texturegroup_get_status("tg_combat_actions") != texturegroup_status_fetched) {
				
				if(texturegroup_get_status("tg_combat_actions") == texturegroup_status_unloaded) texturegroup_load("tg_combat_actions",T);
				done = F
				
			}
			return done
			
		}
		
	#endregion
	
#endregion

#region Unloads
	
	#region Meta
		
		// Unload Everything Except Common Stuff and Characters/Actors
		function unload_all() {
			
			unload_menu()
			unload_intro()
			unload_starfield()
			
			unload_resort_area()
			unload_city_area()
			unload_club_area()
			unload_club2_area()
			unload_brothel_area()
			unload_slums_area()
			unload_port_area()
			
			unload_anim_news1()
			unload_anim_nightmare1()
			
		}
		
		function unload_menu() {
			
			if(texturegroup_get_status("tg_menu") != texturegroup_status_unloaded) texturegroup_unload("tg_menu")
			unload_club2_area()
			
		}
		
		function unload_intro() {
			
			if(texturegroup_get_status("tg_intro") != texturegroup_status_unloaded) texturegroup_unload("tg_intro");
			unload_starfield()
			
		}
		
		function unload_starfield() {
			
			if(texturegroup_get_status("tg_starfield") != texturegroup_status_unloaded) texturegroup_unload("tg_starfield");
			
		}
		
	#endregion
	
	#region Areas
		
		function unload_resort_area() {
			
			//if(audio_group_is_loaded(ag_resort)) audio_group_unload(ag_resort);
			if(texturegroup_get_status("tg_resort") != texturegroup_status_unloaded) texturegroup_unload("tg_resort");
			unload_anim_news1()
			unload_resort2_area()
			
		}
		
		function unload_resort2_area() {
			
			//if(audio_group_is_loaded(ag_resort)) audio_group_unload(ag_resort);
			if(texturegroup_get_status("tg_resort2") != texturegroup_status_unloaded) texturegroup_unload("tg_resort2");
			
		}
		
		function unload_city_area() {
			
			//if(audio_group_is_loaded(ag_city)) audio_group_unload(ag_city);
			if(texturegroup_get_status("tg_city") != texturegroup_status_unloaded) texturegroup_unload("tg_city");
			
		}
		
		function unload_club_area() {
			
			//if(audio_group_is_loaded(ag_club)) audio_group_unload(ag_club);
			if(texturegroup_get_status("tg_club1") != texturegroup_status_unloaded) texturegroup_unload("tg_club1");
			unload_club2_area()
			
		}
		
		function unload_club2_area() {
			
			if(texturegroup_get_status("tg_club2") != texturegroup_status_unloaded) texturegroup_unload("tg_club2");
			
		}
		
		function unload_brothel_area() {
			
			//if(audio_group_is_loaded(ag_brothel)) audio_group_unload(ag_brothel);
			if(texturegroup_get_status("tg_brothel") != texturegroup_status_unloaded) texturegroup_unload("tg_brothel");
			
		}
		
		function unload_slums_area() {
			
			//if(audio_group_is_loaded(ag_slums)) audio_group_unload(ag_slums);
			if(texturegroup_get_status("tg_slums") != texturegroup_status_unloaded) texturegroup_unload("tg_slums");
			
		}
		
		function unload_port_area() {
			
			//if(audio_group_is_loaded(ag_port)) audio_group_unload(ag_port);
			if(texturegroup_get_status("tg_port") != texturegroup_status_unloaded) texturegroup_unload("tg_port");
			
		}
		
	#endregion
	
	#region Anims
		
		function unload_anim_news1() {
			
			if(texturegroup_get_status("tg_news1") != texturegroup_status_unloaded) texturegroup_unload("tg_news1");
			unload_char_alexandria()
			
		}
		
		function unload_anim_nightmare1() {
			
			//if(audio_group_is_loaded(ag_nightmare1)) audio_group_unload(ag_nightmare1);
			if(texturegroup_get_status("tg_nightmare1") != texturegroup_status_unloaded) texturegroup_unload("tg_nightmare1");
			
		}
		
	#endregion
	
	#region Actors
		
		function unload_char_spitfire() {
			
			if(texturegroup_get_status("tg_char_spitfire") != texturegroup_status_unloaded) texturegroup_unload("tg_char_spitfire");
			//if(texturegroup_get_status("tg_common_female") != texturegroup_status_unloaded) texturegroup_unload("tg_common_female");
			
		}
		
		function unload_char_alexandria() {
			
			if(texturegroup_get_status("tg_char_alexandria") != texturegroup_status_unloaded) texturegroup_unload("tg_char_alexandria");
			//if(texturegroup_get_status("tg_common_female") != texturegroup_status_unloaded) texturegroup_unload("tg_common_female");
			
		}
		
		function unload_random_actors() {
			
			if(texturegroup_get_status("tg_males") != texturegroup_status_unloaded) texturegroup_unload("tg_males");
			if(texturegroup_get_status("tg_females") != texturegroup_status_unloaded) texturegroup_unload("tg_females");
			if(texturegroup_get_status("tg_males_close") != texturegroup_status_unloaded) texturegroup_unload("tg_males_close");
			if(texturegroup_get_status("tg_females_close") != texturegroup_status_unloaded) texturegroup_unload("tg_females_close");
			//if(texturegroup_get_status("tg_common_male") != texturegroup_status_unloaded) texturegroup_unload("tg_common_male");
			//if(texturegroup_get_status("tg_common_female") != texturegroup_status_unloaded) texturegroup_unload("tg_common_female");
			
		}
		
	#endregion
	
	#region Combat
		
		function unload_combat_male() {
			
			if(texturegroup_get_status("tg_combat_male") != texturegroup_status_unloaded) texturegroup_unload("tg_combat_male");
			
		}
		
		function unload_combat_female() {
			
			if(texturegroup_get_status("tg_combat_female") != texturegroup_status_unloaded) texturegroup_unload("tg_combat_female");
			
		}
		
	#endregion
	
#endregion

function tgs_are_loaded() {
	
	var rtn = T
	
	for(var i = 0; i < array_length(TGA); i++) {
		
		if(texturegroup_get_status(TGA[i]) == texturegroup_status_loading) rtn = F;
		
	}
	
	return rtn
	
}

function ags_are_loaded() {
	
	var rtn = T
	
	for(var i = 0; i < array_length(AGA); i++) {
		
		if(!audio_group_is_loaded(AGA[i])
			and audio_group_load_progress(AGA[i]) < 100) rtn = F;
		
	}
	
	return rtn
	
}