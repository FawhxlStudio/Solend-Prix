/// @description Logic Updates & Dialogue Triggers


#region Dialogue
	
	if(D.diaSpeaker == id) spkr = T
	
	/*
	
	if(variable_instance_exists(dia,string(D.scni)) and D.focusL == N and !TRAN.override) {
		
		var diaCnt = variable_instance_names_count(dia[$ D.scni])
		for(var i = 0; i < diaCnt; i++) {
			
			if(variable_instance_exists(dia[$ string(D.scni)],string(i))) {
				
				if(!dia[$ string(D.scni)][$ string(i)][$ K.DN]
					and dia[$ string(D.scni)][$ string(i)][$ K.TRG] == TRIGGER.START) {
					
					#region Start Trigger (Immediate/ASAP)
						
						var found = F
						for(var i2 = 0; i2 < ds_list_size(D.dialogue); i2++)
							found = (D.dialogue[|i2] == dia[$ string(D.scni)][$ string(i)]);
						if(!found) ds_list_add(D.dialogue,dia[$ D.scni][$ string(i)]);
						if(D.focusL == N) {
							
							D.focusL = id
							diai = i
							
						}
						
					#endregion
					
				} else if(!dia[$ string(D.scni)][$ string(i)][$ K.DN]
					and dia[$ string(D.scni)][$ string(i)][$ K.TRG] == TRIGGER.SUIT
					and suitedo != suited) {
					
					#region Suit Trigger
						
						var found = F
						for(var i2 = 0; i2 < ds_list_size(D.dialogue); i2++)
							found = (D.dialogue[|i2] == dia[$ string(D.scni)][$ string(i)]);
						if(!found) ds_list_add(D.dialogue,dia[$ D.scni][$ string(i)]);
						if(D.focusL == N) {
							
							D.focusL = id
							diai = i
							
						}
						
					#endregion
					
				} else if(!dia[$ string(D.scni)][$ string(i)][$ K.DN]
					and dia[$ string(D.scni)][$ string(i)][$ K.TRG] == TRIGGER.ANIM) {
					
					#region Check Anim Trigger for Done
						
						var _trig = F
						if(variable_instance_exists(dia[$ string(D.scni)][$ string(i)],K.ANM)) {
							
							// DEBUG HERE LIKELY IF ISSUES WITH TRIGGERING POST-ANIM DIALOGUE
							var _anim = dia[$ string(D.scni)][$ string(i)][$ K.ANM]
							if(variable_instance_exists(NS,_anim))
								if(variable_instance_exists(NS[$ _anim],K.DN))
									if(NS[$ _anim][$ K.DN])
										_trig = T;
							
						}
						
					#endregion
					
					#region If Anim Trigger is Good, Queue Dialogue if not already
						
						if(_trig) {
							
							var found = F
							for(var i2 = 0; i2 < ds_list_size(D.dialogue); i2++)
								found = (D.dialogue[|i2] == dia[$ string(D.scni)][$ string(i)]);
							if(!found) ds_list_add(D.dialogue,dia[$ D.scni][$ string(i)]);
							if(D.focusL == N) {
								
								D.focusL = id
								diai = i
								
							}
							
						}
						
					#endregion
					
				}
				
			}
			
		}
		
	}
	
	*/
	
#endregion Dialogue