function db_diaNar() {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	
	#region Anims
		
		#region News 1
			
			NS[$ K.ANM+"News1"] = {}
			NS[$ K.ANM+"News1"][$ K.BD0+K.SPR] = animNews1BD
			NS[$ K.ANM+"News1"][$ K.SP0+K.SPR] = animNews1Ship
			NS[$ K.ANM+"News1"][$ K.BG0+K.SPR] = animNews1BG
			NS[$ K.ANM+"News1"][$ K.NM] = "Anchor Woman"
			NS[$ K.ANM+"News1"][$ 0] = "-colonys' tragedy serve as grim reminder to the dangers of settling distant systems..."
			NS[$ K.ANM+"News1"][$ 1] = "..."
			NS[$ K.ANM+"News1"][$ 2] = "Now onto the topic that has the known galaxy on the edge of their seat's tonight..."
			NS[$ K.ANM+"News1"][$ 3] = "Hosted by Saints Corp, An Interstellar league of competitors line up tonight for the launch of the exciting event known as \"The Grand Wing Prix\"..."
			NS[$ K.ANM+"News1"][$ 4] = "The course has now been finalized, and as the name suggests the course takes competitors from one end of the Galactic Wing to the other..."
			NS[$ K.ANM+"News1"][$ 5] = "The contestants will be starting in the Occulo system, racing through both known and unknown space to our own home system of Sol..."
			NS[$ K.ANM+"News1"][$ 6] = "It will be a long race with many challenges but all the competitors certainly have their eyes set on the 100,000,000 cr. prize pool at end..."
			NS[$ K.ANM+"News1"][$ 7] = "It's winner takes all and it's a once in a lifetime event, a lot can happen over the course of the race so trust \"Star Stream Network\" to keep you updated..."
			NS[$ K.ANM+"News1"][$ 8] = "This is Alexandria at SSN, Have a good night..."
			
		#endregion
		
		#region Dark Alley
			
			NS[$ K.ANM+"ClubAlley1"] = {}
			NS[$ K.ANM+"ClubAlley1"][$ K.BG0+K.SPR] = sprDarkAlley
			NS[$ K.ANM+"ClubAlley1"][$ K.ACT+K.RHT] = ACTOR.SPITFIRE
			NS[$ K.ANM+"ClubAlley1"][$ 0] = "You, with Spitfire reluctantly following, step outside the club's back door where the commotion was coming from..."
			NS[$ K.ANM+"ClubAlley1"][$ 1] = "The alleyway outside the club is dirty with used drugs, homeless encampents and seemingly sedated homeless people lining the alley..."
			NS[$ K.ANM+"ClubAlley1"][$ 2] = "Some of the homeless stare at you with desperate pleading eyes, some stare blankly and wander aimlessly..."
			NS[$ K.ANM+"ClubAlley1"][$ 3] = "A patrolling civil officer seems to be dismantling an encampment to the dismay of the few homeless lucid enough to understand what's going on..."
			NS[$ K.ANM+"ClubAlley1"][$ 4] = V.RIGHT
			NS[$ K.ANM+"ClubAlley1"][$ 5] = "They won't do anything to help these poor people except pacify them with sedatives that make them hallucinate more and more until they've turned their own minds into prisons..."
			NS[$ K.ANM+"ClubAlley1"][$ 6] = "I know with that kind of money from the race..."
			NS[$ K.ANM+"ClubAlley1"][$ 7] = {}
			NS[$ K.ANM+"ClubAlley1"][$ 7][$ K.REL+K.BR] = 1
			NS[$ K.ANM+"ClubAlley1"][$ 7][$ T] = {}
			NS[$ K.ANM+"ClubAlley1"][$ 7][$ T][$ 0] = "I could save him..."
			NS[$ K.ANM+"ClubAlley1"][$ 7][$ T][$ 1] = "Er- I'm sorry I'm thinking out loud, just-"
			NS[$ K.ANM+"ClubAlley1"][$ 8] = "Nevermind... We should get going..."
			NS[$ K.ANM+"ClubAlley1"][$ 9] = V.NARRATOR_NONE
			NS[$ K.ANM+"ClubAlley1"][$ 10] = "Acknowledging Spitfire's sudden discomfort you both leave towards the spaceport..."
			NS[$ K.ANM+"ClubAlley1"][$ 11] = V.RIGHT
			NS[$ K.ANM+"ClubAlley1"][$ 12] = V.DONE_AND_JOIN
			
		#endregion
		
		#region Fetch Anim Sprites
			
			// Init Anim Level Keys...
			var sks = variable_instance_get_sorted_strKeys(NS,T)
			
			if(is_array(sks)) {
				
				#region Iterate Anim Level...
					
					for(var i = 0; i < array_length(sks); i++) {
						
						// Init Instance Level Keys...
						var ks = variable_instance_get_names(NS[$ sks[i]])
						
						#region Iterate Instance Level...
							
							for(var i2 = 0; i2 < array_length(ks); i2++) {
								
								try {
									
									// Get Key...
									var k = ks[i2]
									
									// Is Sprite Key?
									if(string_ends_with(k,K.SPR)) {
										
										// Get Sprite Value
										var e = S[$ i][$ k]
										
										// Verify Sprite...
										if(sprite_exists(e)) {
											
											// Add Sprite to Fetch Array if missing...
											if(!array_contains(fetchArr,e)) 
												fetchArr[array_length(fetchArr)] = e;
											
										}
										
									}
									
								} catch(_ex) {}
								
							}
							
						#endregion
						
					}
					
				#endregion
				
			}
			
		#endregion
		
	#endregion
	
	#region Apartment
		
		//        $Scene ->      $Actor ->  $Instance -> $Dialogue/Narrative (Nestable)
		NS[$ SCENE.APARTMENT] = {}
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS] = {}
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 0] = {}
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 0][$ K.TRG] = TRIGGER.START
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 0][$ K.DN] = F
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 0][$ 0] = "Euurghhh...."
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 0][$ 1] = "Is it time already?"
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 0][$ 2] = "Shit! I'm late!"
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1] = {}
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1][$ K.TRG] = TRIGGER.SUIT
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1][$ K.DN] = F
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1][$ 0] = "You don your plated spacer suit."
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1][$ 1] = "Suit's still sharp..."
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1][$ 2] = {}
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1][$ 2][$ K.INV+K.FLG] = [V.ANIM,K.ANM+"News1"] // Must be false (this is a check whether it is done or not)
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 1][$ 2][$ 0] = "I wonder if the race is on the news..."
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 2] = {}
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 2][$ K.TRG] = TRIGGER.ANIM
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 2][$ K.DN] = F
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 2][$ K.ANM] = K.ANM+"News1"
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 2][$ 0] = "Alright I still got some time..."
		NS[$ SCENE.APARTMENT][$ ACTOR.SYLAS][$ 2][$ 1] = "I wonder if anyone else in the race is at the bar..."
		
	#endregion
	
	#region Street
		
		NS[$ SCENE.STREET] = {}
		NS[$ SCENE.STREET][$ ACTOR.SYLAS] = {}
		NS[$ SCENE.STREET][$ ACTOR.SYLAS][$ 0] = {}
		NS[$ SCENE.STREET][$ ACTOR.SYLAS][$ 0][$ K.TRG] = TRIGGER.START
		NS[$ SCENE.STREET][$ ACTOR.SYLAS][$ 0][$ K.DN] = F
		NS[$ SCENE.STREET][$ ACTOR.SYLAS][$ 0][$ 0] = "The club is across the street..."
		NS[$ SCENE.STREET][$ ACTOR.SYLAS][$ 0][$ 1] = "Someone'll be there..."
		
	#endregion
	
	#region Club 1
		
		// [$ 2]Scene -> [$ ACTOR.SPITFIRE]Actor -> [$ 0]Narrative Parent -> [$ 5]Narrative Branch -> [$ T|F]Narrative Dialogue -> [$ F:2]Narrative Selection -> [$ 0|1]Outcome
		NS[$ SCENE.CLUB] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ K.TRG] = TRIGGER.CLICK // Activate when spitfire character is clicked at scene 2
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ K.ACT+K.LFT] = ACTOR.SPITFIRE // Character to draw on left of screen
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ K.ACT+K.RHT] = ACTOR.SYLAS // Character to draw on right of screen
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 0] = V.RIGHT // Switch to Right Character as Speaker (Sylas)
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 1] = "Hey you in the Spacer suit..." // Dialogue
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 2] = V.LEFT // Switch to Left Character as Speaker (Spitfire)
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 3] = "Hmm? I guess you must be talking to me..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 4] = "[They look you up and down]" // Emote
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ K.BR] = [V.SUIT,P] // True or False: Player Suited?
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ T] = {} // Player is Suited:
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ T][$ 0] = "[They turn towards you promptly]"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ T][$ 1] = "Wait- You're the one that flies Praey!"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ T][$ 2] = "Your name's Sylas right?"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ T][$ 3] = V.DONE_AND_CONTINUE // Mark this Narrative Parent as Done (NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0])
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F] = {} // Player is NOT Suited:
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 0] = "[They wave their hand at you dismissively]"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 1] = "Not now I'm looking for someone..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ K.OPT] = ["\"Are you in the race too?\"",ACTION.LEAVE] // Option Array -> Buttons/Choices for Players to pick...
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0] = {} // Option 0 == Array[0] == "Are you in the race too?"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ K.REL+K.ADJ] = -1 // Actor's Relation change. (- bad, + good)
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 0] = "Aren't you a pilot in the race?"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 1] = V.LEFT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 2] = "Grghhh- I just said-"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 3] = V.RIGHT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 4] = "I'm in the race too, My name's Sylas."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 5] = V.LEFT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 6] = "Oh- I've been looking for you! You fly Praey right?"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 7] = "[Their head tilts to the side]... Where's your suit?"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 8] = V.RIGHT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 9] = "Oh- I uh-"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 10] = V.LEFT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 11] = "[They put their hand up towards you]"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 12] = "Stop- We don't have time, just go get it on and we'll talk more later."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 13] = "Come back here when you're suited..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 14] = "[They turn away from you impaitently]..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 0][$ 5][$ F][$ 2][$ 0][$ 15] = V.DONE // Also marks this narrative parent as done
		// Option 1 == Array[1] == ACTION.LEAVE; Just trigger action in this case, no additional dialogue set...
		
	#endregion
	
	#region Club 2
		
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ K.TRG] = TRIGGER.CLICK_OR_CONTINUE
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ K.ACT+K.LFT] = ACTOR.SPITFIRE
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ K.ACT+K.RHT] = ACTOR.SYLAS
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ K.FLG] = [V.SUIT,P] // Flags must be true
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ K.REL+K.BR] = 0 // True or False: Is Actor's Relation atleast this?
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T][$ 0] = V.LEFT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T][$ 1] = "Great! Oh- I'm Spitfire by the way..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T][$ 2] = V.ACTOR_MET // Actor known var to True
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T][$ 3] = "I saw your profile in the roster for the race."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T][$ 4] = "I wanted to talk to you because I figured we might be able to watch eachothers' backs out there..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T][$ 5] = "I overheard other pilots talking to eachother, seems like others are teaming up to split the prize..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T][$ 6] = "I don't think either of us can win this race alone... And your ship-"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ T][$ 7] = V.LINK_A
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ F] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ F][$ 0] = V.LEFT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ F][$ 1] = "Finally... I'm Spitfire by the way..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ F][$ 2] = V.ACTOR_MET // Actor known var to True
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ F][$ 3] = "I've seen your profile from the race roster."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ F][$ 4] = "I know other racers are forming teams to split the prize..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ F][$ 5] = "Just want to let you know I think we-"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 1][$ F][$ 6] = V.LINK_A
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ K.LNK] = V.LINK_A // Like a trigger, but specific to the end of another dialogue/narrative
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ K.ACT+K.LFT] = ACTOR.SPITFIRE
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ K.ACT+K.RHT] = ACTOR.SYLAS
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ 0] = V.NARRATOR_NONE // All Actors Inactive (For stuff like meta narrations...)
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ 1] = "[Distant Shouting] \"GET BACK!\""
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ 2] = V.RIGHT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ 3] = "Sounds like a fight outside..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ 4] = V.LEFT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ 5] = "We should get going..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ 6] = "A couple racers have already gotten targeted by local gangs already..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 2][$ 7] = V.LINK_B
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3] = {}
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ K.LNK] = V.LINK_B
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ K.ACT+K.LFT] = ACTOR.SPITFIRE
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ K.ACT+K.RHT] = ACTOR.SYLAS
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ K.OPT] = ["Investigate","Just Leave"]
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ K.ANM] = K.ANM+"ClubAlley1"
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 0] = {} // Investigate
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 0][$ K.REL+K.ADJ] = 1
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 0][$ 0] = "Hold on... I want to see what's going on..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 0][$ 1] = V.LEFT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 0][$ 2] = "..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 0][$ 3] = V.DONE_TO_ANIM
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 1] = {} // Just Leave
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 1][$ 0] = "Yeah, let's just go..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 1][$ 1] = V.LEFT
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 1][$ 2] = "Lead the way..."
		NS[$ SCENE.CLUB][$ ACTOR.SPITFIRE][$ 3][$ 1][$ 3] = V.DONE_AND_JOIN
		
	#endregion
    
}

function db_scn() {
	
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	
	#region Apartment
		
		S[$ SCENE.APARTMENT] = {}
		S[$ SCENE.APARTMENT][$ K.SK0+K.SPR] = sprCitySky
		S[$ SCENE.APARTMENT][$ K.SK0+K.PMT] = 1/40
		S[$ SCENE.APARTMENT][$ K.BD0+K.SPR] = sprApartBD
		S[$ SCENE.APARTMENT][$ K.BD0+K.PMT] = 1/30
		S[$ SCENE.APARTMENT][$ K.BG0+K.L2+K.SPR] = sprScrapersFar
		S[$ SCENE.APARTMENT][$ K.BG0+K.L2+K.PMT] = 1/20
		S[$ SCENE.APARTMENT][$ K.BG0+K.L2+K.WMT] = 1.3
		S[$ SCENE.APARTMENT][$ K.BG0+K.L1+K.SPR] = sprScrapersClose
		S[$ SCENE.APARTMENT][$ K.BG0+K.L1+K.PMT] = 1/10
		S[$ SCENE.APARTMENT][$ K.BG0+K.L1+K.WMT] = 1.5
		S[$ SCENE.APARTMENT][$ K.BG0+K.SPR] = sprApartment1
		S[$ SCENE.APARTMENT][$ K.BG0+K.PMT] = 1
		S[$ SCENE.APARTMENT][$ K.ENV] = F
		S[$ SCENE.APARTMENT][$ K.TRA+K.CNT] = 8
		S[$ SCENE.APARTMENT][$ K.TRA+K.XRG] = [-.2,1.2]
		S[$ SCENE.APARTMENT][$ K.TRA+K.YRG] = [1/3,2/3]
		S[$ SCENE.APARTMENT][$ K.TRA+K.ZRG] = [1/3,2/3]
		S[$ SCENE.APARTMENT][$ K.SCN+K.BLD+K.TR] = color_make_rgb([192,160,255])
		S[$ SCENE.APARTMENT][$ K.SCN+K.BLD+K.FL] = color_make_rgb([48,0,48])
		
	#endregion
	
	#region Street
		
		S[$ SCENE.STREET] = {}
		S[$ SCENE.STREET][$ K.SK0+K.PMT] = 1/3
		S[$ SCENE.STREET][$ K.BD0+K.SPR] = sprCityBD
		S[$ SCENE.STREET][$ K.BG0+K.L2+K.SPR] = sprNA
		S[$ SCENE.STREET][$ K.BG0+K.L1+K.SPR] = sprNA
		S[$ SCENE.STREET][$ K.BD0+K.PMT] = 2/3
		S[$ SCENE.STREET][$ K.BG0+K.SPR] = sprStreet1
		S[$ SCENE.STREET][$ K.BG0+K.PMT] = 1
		S[$ SCENE.STREET][$ K.ENV] = T
		S[$ SCENE.STREET][$ K.TRA+K.CNT] = 8
		S[$ SCENE.STREET][$ K.TRA+K.XRG] = [-.2,1.2]
		S[$ SCENE.STREET][$ K.TRA+K.YRG] = [1/3,2/3]
		S[$ SCENE.STREET][$ K.TRA+K.ZRG] = [1/3,2/3]
		S[$ SCENE.STREET][$ K.SCN+K.BLD] = color_make_rgb([192,255,255])
		
	#endregion
	
	#region Club
		
		S[$ SCENE.CLUB] = {}
		S[$ SCENE.CLUB][$ K.BD0+K.SPR] = sprBar1
		S[$ SCENE.CLUB][$ K.BD0+K.PMT] = .8
		S[$ SCENE.CLUB][$ K.BG0+K.SPR] = sprBarBooth
		S[$ SCENE.CLUB][$ K.BG0+K.PMT] = 1
		S[$ SCENE.CLUB][$ K.ACT+K.LFT] = ACTOR.SPITFIRE
		S[$ SCENE.CLUB][$ K.ENV] = T
		S[$ SCENE.CLUB][$ K.TRA+K.CNT] = 0
		S[$ SCENE.CLUB][$ K.SCN+K.BLD] = color_make_rgb([96,64,160])
		
	#endregion
	
	#region Plaza
		
		S[$ SCENE.PLAZA] = {}
		S[$ SCENE.PLAZA][$ K.BD0+K.SPR] = sprCityBD
		S[$ SCENE.PLAZA][$ K.BD0+K.PMT] = 1.1
		S[$ SCENE.PLAZA][$ K.BG0+K.SPR] = sprCity1
		S[$ SCENE.PLAZA][$ K.BG0+K.PMT] = 1
		S[$ SCENE.PLAZA][$ K.ENV] = T
		S[$ SCENE.PLAZA][$ K.TRA+K.CNT] = 8
		S[$ SCENE.PLAZA][$ K.TRA+K.XRG] = [-.2,1.2]
		S[$ SCENE.PLAZA][$ K.TRA+K.YRG] = [1/3,2/3]
		S[$ SCENE.PLAZA][$ K.TRA+K.ZRG] = [1/3,2/3]
		S[$ SCENE.PLAZA][$ K.SCN+K.BLD] = color_make_rgb([224,224,255])
		
	#endregion
	
	#region Spaceport
		
		S[$ SCENE.SPACEPORT] = {}
		S[$ SCENE.SPACEPORT][$ K.BD0+K.SPR] = sprNA
		S[$ SCENE.SPACEPORT][$ K.BD0+K.PMT] = 1
		S[$ SCENE.SPACEPORT][$ K.BG0+K.SPR] = sprSpaceport1
		S[$ SCENE.SPACEPORT][$ K.BG0+K.PMT] = 1
		S[$ SCENE.SPACEPORT][$ K.BG0+K.L2+K.SPR] = sprScrapersFar
		S[$ SCENE.SPACEPORT][$ K.BG0+K.L2+K.PMT] = 1/2
		S[$ SCENE.SPACEPORT][$ K.BG0+K.L2+K.WMT] = 1.1
		S[$ SCENE.SPACEPORT][$ K.BG0+K.L1+K.SPR] = sprScrapersClose
		S[$ SCENE.SPACEPORT][$ K.BG0+K.L1+K.PMT] = 2/3
		S[$ SCENE.SPACEPORT][$ K.BG0+K.L1+K.WMT] = 1.2
		S[$ SCENE.SPACEPORT][$ K.ENV] = T
		S[$ SCENE.SPACEPORT][$ K.TRA+K.CNT] = 2
		S[$ SCENE.SPACEPORT][$ K.TRA+K.XRG] = [-.2,1.2]
		S[$ SCENE.SPACEPORT][$ K.TRA+K.YRG] = [1/3,2/3]
		S[$ SCENE.SPACEPORT][$ K.TRA+K.ZRG] = [1/3,2/3]
		S[$ SCENE.SPACEPORT][$ K.SCN+K.BLD] = color_make_rgb([96,96,160])
		
	#endregion
	
	#region Praey Cockpit
		
		S[$ SCENE.PRAEY_COCKPIT] = {}
		S[$ SCENE.PRAEY_COCKPIT][$ K.BD0+K.SPR] = sprNA
		S[$ SCENE.PRAEY_COCKPIT][$ K.BD0+K.PMT] = 1
		S[$ SCENE.PRAEY_COCKPIT][$ K.BG0+K.SPR] = sprCockpit
		S[$ SCENE.PRAEY_COCKPIT][$ K.BG0+K.PMT] = 1
		S[$ SCENE.PRAEY_COCKPIT][$ K.BG0+K.L2+K.SPR] = sprScrapersFar
		S[$ SCENE.PRAEY_COCKPIT][$ K.BG0+K.L2+K.PMT] = 1/2
		S[$ SCENE.PRAEY_COCKPIT][$ K.BG0+K.L2+K.WMT] = 1.1
		S[$ SCENE.PRAEY_COCKPIT][$ K.BG0+K.L1+K.SPR] = sprScrapersClose
		S[$ SCENE.PRAEY_COCKPIT][$ K.BG0+K.L1+K.PMT] = 2/3
		S[$ SCENE.PRAEY_COCKPIT][$ K.BG0+K.L1+K.WMT] = 1.2
		S[$ SCENE.PRAEY_COCKPIT][$ K.ENV] = T
		S[$ SCENE.PRAEY_COCKPIT][$ K.TRA+K.CNT] = 0
		S[$ SCENE.PRAEY_COCKPIT][$ K.SCN+K.BLD+K.TR] = c.wht
		S[$ SCENE.PRAEY_COCKPIT][$ K.SCN+K.BLD+K.FL] = c.dgry
		
	#endregion
	
	#region Fetch Scene Sprites
		
		// Init Scene Level Keys...
		var rks = variable_instance_get_sorted_numKeys(S,T)
		
		if(is_array(rks)) {
			
			#region Iterate Scene Level...
				
				for(var i = 0; i < array_length(rks); i++) {
					
					// Init Instance Level Keys...
					var ks = variable_instance_get_names(S[$ rks[i]])
					
					#region Iterate Instance Level...
						
						for(var i2 = 0; i2 < array_length(ks); i2++) {
							
							try {
								
								// Get Key...
								var k = ks[i2]
								
								// Is Sprite Key?
								if(string_ends_with(k,K.SPR)) {
									
									// Get Sprite Value
									var e = S[$ i][$ k]
									
									// Verify Sprite...
									if(sprite_exists(e)) {
										
										// Add Sprite to Fetch Array if missing...
										if(!array_contains(fetchArr,e)) 
											fetchArr[array_length(fetchArr)] = e;
										
									}
									
								}
								
							} catch(_ex) {}
							
						}
						
					#endregion
					
				}
				
			#endregion
			
		}
		
	#endregion
    
}

function db_act() {
	
    try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
    
    #region Actor List Reset
        
        for(var i = 0; i < ds_list_size(actorL); i++) {
            
            var e = actorL[|i]
            if(e != P) instance_destroy(e);
            else ds_list_clear(P.party);
            
        }
        
        // Clear Actor List...
        ds_list_clear(actorL)
        
    #endregion
    
	#region Sylas (You)/Player
		
		ds_list_add(actorL,P)
		
	#endregion
	
	#region Spitfire
		
		ds_list_add(actorL,instance_create_layer(0,0,"MG",oChar))
		var _char = actorL[|ds_list_size(actorL)-1]
		_char.dia[$ K.NM] = "Spitfire"
		_char.dia[$ K.SX]  = SEX.FEMALE
		_char.body = sprSpitfireBod
		_char.bodypol = 1
		_char.head = sprSpitfire2
		_char.headpol = 1
		_char.uid = ACTOR.SPITFIRE
		
	#endregion
    
}

function db_context() {
	
    try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
    
	if(file_exists(game_save_id+"nodes.json")) {
		
		var _str = ""
		var _f = file_text_open_read(game_save_id+"nodes.json")
		while(!file_text_eof(_f)) _str += file_text_readln(_f)
		CM = json_parse(_str)
		
	}
    
}