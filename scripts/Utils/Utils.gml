function chance(pct) {
	
	return (random_range(0,100) <= pct)
	
}

function flip() {
	
	if(chance(50)) return 1
	else return -1
	
}

function flipr() {
	
	if(chance(50)) return random_range(.01,1)
	else return -random_range(.01,1)
	
}

function actor_find(_uid) {
	
	for(var i = 0; i < ds_list_size(D.actorL); i++) {
		
		if(_uid == D.actorL[|i].uid)
			return D.actorL[|i];
		
	}
	
	return N
	
}

function bbox_sanity(inst) {
	
	try {
		
		with(inst) {
			
			if(!is_nan(bbox_left) and !is_nan(bbox_top) and !is_nan(bbox_right) and !is_nan(bbox_bottom)) return T;
			
		}
		
	} catch(_ex) {}
	
	return F
	
}

function variable_instance_get_sorted_numKeys(struct,ascending) {
	
	// Init Keys Array
	var ks = variable_instance_get_names(struct)
	var rtn = []
	
	// Convert Numbers from Strings
	for(var i = 0; i < array_length(ks); i++) {
		
		// Convert and Add to return array
		if(is_string_real(ks[i]))
			rtn[array_length(rtn)] = real(ks[i]);
		
	}
	
	// Returns
	if(rtn == []) return N; // Nothing to return...
	else {
		
		// Sort & Return
		array_sort(rtn,ascending)
		return rtn
		
	}
	
}

function variable_instance_get_sorted_strKeys(struct,ascending) {
	
	// Init Keys Array
	var ks = variable_instance_get_names(struct)
	var rtn = []
	
	// Convert Numbers from Strings
	for(var i = 0; i < array_length(ks); i++) {
		
		// If not a number, add to return array...
		if(!is_string_real(ks[i])) rtn[array_length(rtn)] = ks[i];
		
	}
	
	// Returns
	if(rtn == []) return N; // Nothing to return...
	else {
		
		// Sort & Return
		array_sort(rtn,ascending)
		return rtn
		
	}
	 
}

function color_get_rgb(col) {
	
	return [color_get_red(col),color_get_green(col),color_get_blue(col)]
	
}

function color_make_rgb(colArr) {
	
	return make_color_rgb(colArr[0],colArr[1],colArr[2])
	
}

function color_darken(col,mlt) {
	
	var _c = color_get_rgb(col)
	return make_color_rgb(_c[0]*mlt,_c[1]*mlt,_c[2]*mlt)
	
}

function scene_set_blend(col) {
	
	D.scnBlend1 = col
	D.scnBlend2 = col
	D.scnBlend3 = col
	
}

function mouse_in_window() {
	
	// Init Vars for Calc...
	var dmx = display_mouse_get_x()
	var dmy = display_mouse_get_y()
	var wx = window_get_x()
	var wy = window_get_y()
	
	// Return T/F if we are in window...
	return (dmx >= wx and dmx <= wx+WW and dmy >= wy and dmy <= wy+WH)
	
}

// This has a very specific use case (i.e. nodes.json)
// Cleans iterate-able struct of structs to fill in empty entries
function struct_trim_and_backfill(inst) {
	
	if(is_struct(inst)) {
		
		// Init Loop; Length of Struct
		var len = variable_instance_names_count(inst)
		var last = F // To set to true if nothing to fill with
		for(var ix = 0; ix < len; ix++) {
			
			// Sanitize Empty Structs
			if(is_struct(inst[$ ix]) and variable_instance_names_count(inst[$ ix]) <= 0)
				inst[$ ix] = N;
			
			// This Spot is Empty? Fill it with next if able...
			if(inst[$ ix] == N and ix < len-1 and !last) {
				
				for(var iy = ix+1; iy < len; iy++) {
					
					// Sanitize Empty Structs
					if(is_struct(inst[$ iy]) and variable_instance_names_count(inst[$ iy]) <= 0)
						inst[$ iy] = N;
					
					// Is Sanitized; Is Done or Continue | Is Struct; Backfill it and Break...
					if(inst[$ iy] == N) {
						
						// Is Last; Done and Break | Not Last; Try Next
						if(iy == len-1) {
							
							// We will now go back to ix loop and delete all the sanitized entries...
							last = T
							break
							
						} else continue; // More to check; Keep going...
						
					} else if(is_struct(inst[$ iy])) {
						
						// Do Backfill...
						inst[$ ix] = variable_clone(inst[$ iy])
						inst[$ iy] = N // Then Sanitize Old Index
						break
						
					} else inst[$ iy] = N; // Sanitize by default
					
				}
				
			}
			
			// No more to backfill... Remove sanitized entries...
			if(last) variable_struct_remove(inst,string(ix));
			
		}
		
	}
	
}