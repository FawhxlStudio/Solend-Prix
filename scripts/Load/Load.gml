// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#region Loads
	
	#region Meta
		
		function area_check() {
			
			switch(string_split(SCENEn[D.scni],"_")[0]) {
				
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
			
			#region Audio
				
				if(!audio_group_is_loaded(audiogroup_default)) audio_group_load(audiogroup_default);
				for(var i = 0; i < array_length(AGA); i++) {
					
					if(!audio_group_is_loaded(AGA[i])) audio_group_load(AGA[i]);
					
				}
				
			#endregion
			
			#region Textures/Sprites
				
				if(texturegroup_get_status("tg_char_sylas") == texturegroup_status_unloaded) texturegroup_load("tg_char_sylas",T);
				if(texturegroup_get_status("tg_common") == texturegroup_status_unloaded) texturegroup_load("tg_common",T);
				if(texturegroup_get_status("tg_goth_common") == texturegroup_status_unloaded) texturegroup_load("tg_goth_common",T);
				
			#endregion
			
		}
		
		function common_ready() {
			
			// Init
			var rtn = T
			
			#region Audio
				
				if(!audio_group_is_loaded(audiogroup_default)) rtn = F;
				if(!audio_group_is_loaded(ag_sfx)) rtn = F;
				if(!audio_group_is_loaded(ag_ui)) rtn = F;
				
			#endregion
			
			#region Textures/Sprites
				
				if(texturegroup_get_status("Default") != texturegroup_status_fetched) rtn = F;
				if(texturegroup_get_status("tg_char_sylas") != texturegroup_status_fetched) rtn = F;
				if(texturegroup_get_status("tg_common") != texturegroup_status_fetched) rtn = F;
				if(texturegroup_get_status("tg_goth_common") != texturegroup_status_fetched) rtn = F;
				
			#endregion
			
			return rtn
			
		}
		
		function load_menu() {
			
			if(texturegroup_get_status("tg_menu") == texturegroup_status_unloaded) texturegroup_load("tg_menu",T);
			load_club2_area()
			
		}
		
		function menu_ready() {
			
			return (texturegroup_get_status("tg_menu") == texturegroup_status_fetched
				and texturegroup_get_status("tg_club2") == texturegroup_status_fetched)
			
		}
		
		function load_intro() {
			
			if(texturegroup_get_status("tg_intro") == texturegroup_status_unloaded) texturegroup_load("tg_intro",T);
			load_starfield()
			
		}
		
		function intro_ready() {
			
			// Init
			var rtn = T
			
			if(texturegroup_get_status("tg_intro") != texturegroup_status_fetched) rtn = F;
			if(!starfield_ready()) rtn = F;
			
			return rtn
			
		}
		
		function load_starfield() {
			
			if(texturegroup_get_status("tg_starfield") == texturegroup_status_unloaded) texturegroup_load("tg_starfield",T);
			
		}
		
		function starfield_ready() {
			
			return texturegroup_get_status("tg_starfield") == texturegroup_status_fetched
			
		}
		
	#endregion
	
	#region Areas
		
		function load_resort_area() {
			
			if(!audio_group_is_loaded(ag_resort)) audio_group_load(ag_resort);
			if(texturegroup_get_status("tg_resort") == texturegroup_status_unloaded) texturegroup_load("tg_resort",T);
			load_resort2_area()
			load_anim_news1()
			
		}
		
		function load_resort2_area() {
			
			if(texturegroup_get_status("tg_resort2") == texturegroup_status_unloaded) texturegroup_load("tg_resort2",T);
			
		}
		
		function resort_area_ready() {
			
			var rtn = T
			
			if(!audio_group_is_loaded(ag_resort)) rtn = F;
			if(texturegroup_get_status("tg_resort") != texturegroup_status_fetched) rtn = F;
			//load_anim_news1()
			
			return rtn
			
		}
		
		function load_city_area() {
			
			if(!audio_group_is_loaded(ag_city)) audio_group_load(ag_city);
			if(texturegroup_get_status("tg_city") == texturegroup_status_unloaded) texturegroup_load("tg_city",T);
			
		}
		
		function load_club_area() {
			
			if(!audio_group_is_loaded(ag_club)) audio_group_load(ag_club);
			if(texturegroup_get_status("tg_club1") == texturegroup_status_unloaded) texturegroup_load("tg_club1",T);
			if(texturegroup_get_status("tg_char_spitfire") == texturegroup_status_unloaded) texturegroup_load("tg_char_spitfire",T);
			load_club2_area()
			
		}
		
		function load_club2_area() {
			
			if(texturegroup_get_status("tg_club2") == texturegroup_status_unloaded) texturegroup_load("tg_club2",T);
			
		}
		
		function load_brothel_area() {
			
			if(!audio_group_is_loaded(ag_brothel)) audio_group_load(ag_brothel);
			if(texturegroup_get_status("tg_brothel") == texturegroup_status_unloaded) texturegroup_load("tg_brothel",T);
			
		}
		
		function load_slums_area() {
			
			if(!audio_group_is_loaded(ag_slums)) audio_group_load(ag_slums);
			if(texturegroup_get_status("tg_slums") == texturegroup_status_unloaded) texturegroup_load("tg_slums",T);
			
		}
		
		function load_port_area() {
			
			if(!audio_group_is_loaded(ag_port)) audio_group_load(ag_port);
			if(texturegroup_get_status("tg_port") == texturegroup_status_unloaded) texturegroup_load("tg_port",T);
			load_resort2_area()
			
		}
		
	#endregion
	
	#region Anims
		
		function load_anim_news1() {
			
			if(texturegroup_get_status("tg_news1") == texturegroup_status_unloaded) texturegroup_load("tg_news1",T);
			load_char_alexandria()
			
		}
		
		function anim_news1_ready() {
			
			var rtn = T
			
			if(texturegroup_get_status("tg_news1") != texturegroup_status_fetched) rtn = F;
			//load_char_alexandria()
			
			return rtn
			
		}
		
		function load_anim_nightmare1() {
			
			if(!audio_group_is_loaded(ag_nightmare1)) audio_group_load(ag_nightmare1);
			if(texturegroup_get_status("tg_nightmare1") == texturegroup_status_unloaded) texturegroup_load("tg_nightmare1",T);
			
		}
		
		function anim_nightmare1_ready() {
			
			var rtn = T
			
			if(!audio_group_is_loaded(ag_nightmare1)) rtn = F;
			if(texturegroup_get_status("tg_nightmare1") != texturegroup_status_fetched) rtn = F;
			
			return rtn
			
		}
		
	#endregion
	
	#region Actors
		
		function load_char_spitfire() {
			
			if(texturegroup_get_status("tg_char_spitfire") == texturegroup_status_unloaded) texturegroup_load("tg_char_spitfire",T);
			if(texturegroup_get_status("tg_common_female") == texturegroup_status_unloaded) texturegroup_load("tg_common_female",T);
			
		}
		
		function load_char_alexandria() {
			
			if(texturegroup_get_status("tg_char_alexandria") == texturegroup_status_unloaded) texturegroup_load("tg_char_alexandria",T);
			if(texturegroup_get_status("tg_common_female") == texturegroup_status_unloaded) texturegroup_load("tg_common_female",T);
			
		}
		
		function char_alexandria_ready() {
			
			if(texturegroup_get_status("tg_char_alexandria") != texturegroup_status_fetched) rtn = F;
			if(texturegroup_get_status("tg_common_female") != texturegroup_status_fetched) rtn = F;
			
		}
		
		function load_random_actors() {
			
			// Commons
			if(texturegroup_get_status("tg_common_male") == texturegroup_status_unloaded) texturegroup_load("tg_common_male",T);
			if(texturegroup_get_status("tg_common_female") == texturegroup_status_unloaded) texturegroup_load("tg_common_female",T);
			
			// Distant
			if(texturegroup_get_status("tg_males") == texturegroup_status_unloaded) texturegroup_load("tg_males");
			if(texturegroup_get_status("tg_females") == texturegroup_status_unloaded) texturegroup_load("tg_females");
			if(!array_equals(D.fiArr,[])) sprite_prefetch_multi(D.fiArr);
			if(!array_equals(D.miArr,[])) sprite_prefetch_multi(D.miArr);
			
			// Close
			if(texturegroup_get_status("tg_males_close") == texturegroup_status_unloaded) texturegroup_load("tg_males_close");
			if(texturegroup_get_status("tg_females_close") == texturegroup_status_unloaded) texturegroup_load("tg_females_close");
			if(!array_equals(D.cfiArr,[])) sprite_prefetch_multi(D.cfiArr);
			if(!array_equals(D.cmiArr,[])) sprite_prefetch_multi(D.cmiArr);
			
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
			
			if(texturegroup_get_status("tg_menu") > texturegroup_status_unloaded) texturegroup_unload("tg_menu")
			unload_club2_area()
			
		}
		
		function unload_intro() {
			
			if(texturegroup_get_status("tg_intro") > texturegroup_status_unloaded) texturegroup_unload("tg_intro");
			unload_starfield()
			
		}
		
		function unload_starfield() {
			
			if(texturegroup_get_status("tg_starfield") > texturegroup_status_unloaded) texturegroup_unload("tg_starfield");
			
		}
		
	#endregion
	
	#region Areas
		
		function unload_resort_area() {
			
			//if(audio_group_is_loaded(ag_resort)) audio_group_unload(ag_resort);
			if(texturegroup_get_status("tg_resort") > texturegroup_status_unloaded) texturegroup_unload("tg_resort");
			unload_anim_news1()
			unload_resort2_area()
			
		}
		
		function unload_resort2_area() {
			
			//if(audio_group_is_loaded(ag_resort)) audio_group_unload(ag_resort);
			if(texturegroup_get_status("tg_resort2") > texturegroup_status_unloaded) texturegroup_unload("tg_resort2");
			
		}
		
		function unload_city_area() {
			
			//if(audio_group_is_loaded(ag_city)) audio_group_unload(ag_city);
			if(texturegroup_get_status("tg_city") > texturegroup_status_unloaded) texturegroup_unload("tg_city");
			
		}
		
		function unload_club_area() {
			
			//if(audio_group_is_loaded(ag_club)) audio_group_unload(ag_club);
			if(texturegroup_get_status("tg_club1") > texturegroup_status_unloaded) texturegroup_unload("tg_club1");
			unload_club2_area()
			
		}
		
		function unload_club2_area() {
			
			if(texturegroup_get_status("tg_club2") > texturegroup_status_unloaded) texturegroup_unload("tg_club2");
			
		}
		
		function unload_brothel_area() {
			
			//if(audio_group_is_loaded(ag_brothel)) audio_group_unload(ag_brothel);
			if(texturegroup_get_status("tg_brothel") > texturegroup_status_unloaded) texturegroup_unload("tg_brothel");
			
		}
		
		function unload_slums_area() {
			
			//if(audio_group_is_loaded(ag_slums)) audio_group_unload(ag_slums);
			if(texturegroup_get_status("tg_slums") > texturegroup_status_unloaded) texturegroup_unload("tg_slums");
			
		}
		
		function unload_port_area() {
			
			//if(audio_group_is_loaded(ag_port)) audio_group_unload(ag_port);
			if(texturegroup_get_status("tg_port") > texturegroup_status_unloaded) texturegroup_unload("tg_port");
			
		}
		
	#endregion
	
	#region Anims
		
		function unload_anim_news1() {
			
			if(texturegroup_get_status("tg_news1") > texturegroup_status_unloaded) texturegroup_unload("tg_news1");
			unload_char_alexandria()
			
		}
		
		function unload_anim_nightmare1() {
			
			//if(audio_group_is_loaded(ag_nightmare1)) audio_group_unload(ag_nightmare1);
			if(texturegroup_get_status("tg_nightmare1") > texturegroup_status_unloaded) texturegroup_unload("tg_nightmare1");
			
		}
		
	#endregion
	
	#region Actors
		
		function unload_char_spitfire() {
			
			if(texturegroup_get_status("tg_char_spitfire") > texturegroup_status_unloaded) texturegroup_unload("tg_char_spitfire");
			if(texturegroup_get_status("tg_common_female") > texturegroup_status_unloaded) texturegroup_unload("tg_common_female");
			
		}
		
		function unload_char_alexandria() {
			
			if(texturegroup_get_status("tg_char_alexandria") > texturegroup_status_unloaded) texturegroup_unload("tg_char_alexandria");
			if(texturegroup_get_status("tg_common_female") > texturegroup_status_unloaded) texturegroup_unload("tg_common_female");
			
		}
		
		function unload_random_actors() {
			
			if(texturegroup_get_status("tg_males") > texturegroup_status_unloaded) texturegroup_unload("tg_males");
			if(texturegroup_get_status("tg_females") > texturegroup_status_unloaded) texturegroup_unload("tg_females");
			if(texturegroup_get_status("tg_males_close") > texturegroup_status_unloaded) texturegroup_unload("tg_males_close");
			if(texturegroup_get_status("tg_females_close") > texturegroup_status_unloaded) texturegroup_unload("tg_females_close");
			if(texturegroup_get_status("tg_common_male") > texturegroup_status_unloaded) texturegroup_unload("tg_common_male");
			if(texturegroup_get_status("tg_common_female") > texturegroup_status_unloaded) texturegroup_unload("tg_common_female");
			
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