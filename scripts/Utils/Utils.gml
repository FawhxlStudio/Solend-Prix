function chance(pct) {
	
	var r = random_range(0,100)
	if(pct > r or pct == 100) return T
	else if(pct < r) return F
	else return chance(pct)
	
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
	
	for(var i = 0; i < ds_list_size(D.actorLst); i++) {
		
		if(_uid == D.actorLst[|i].uid)
			return D.actorLst[|i];
		
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

function color_brightness(col,mlt) {
	
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

function struct_find(inst,k) {
	
	try {
		
		if(variable_instance_exists(inst,k)) return inst[$ k];
		
	} catch(_ex) {}
	
	return U
	
}

function is_hover(inst) {
	
	// Return True if No Hover set or Hover is instance
	return ((!D.isHvr or D.isHvr == inst) and (!D.isHvro or D.isHvro == inst))
	
}

function is_debug(val) {
	
	try {
		
		if(DBG) {
			
			if(DBG.active) {
				
				return val;
				
			}
			
		}
		
	} catch(_ex) {}
	
	return F
	
}

function trig_iter(struct) {
	
	if(is_struct(struct)) {
		
		#region Ensure Variables...
			
			if(!variable_instance_exists(struct,"i")) struct[$  "i"] = 0;
			if(!variable_instance_exists(struct,"d")) struct[$  "d"] = GSPD;
			if(!variable_instance_exists(struct,"pct")) struct[$  "pct"] = 0;
			if(!variable_instance_exists(struct,"deg")) struct[$  "deg"] = 0;
			if(!variable_instance_exists(struct,"sn")) struct[$  "sn"] = sin(degtorad(0));
			if(!variable_instance_exists(struct,"snMlt")) struct[$  "snMlt"] = 0;
			if(!variable_instance_exists(struct,"snM")) struct[$  "snM"] = struct[$ "sn"]*(struct[$ "snMlt"]+1);
			if(!variable_instance_exists(struct,"sn2")) struct[$  "sn2"] = struct[$ "sn"]/2;
			if(!variable_instance_exists(struct,"csn")) struct[$  "csn"] = cos(degtorad(0));
			if(!variable_instance_exists(struct,"csnMlt")) struct[$  "csnMlt"] = 0;
			if(!variable_instance_exists(struct,"csnM")) struct[$  "csnM"] = struct[$ "csn"]*(struct[$ "csnMlt"]+1);
			if(!variable_instance_exists(struct,"csn2")) struct[$  "csn2"] = struct[$ "csn"]/2;
			
		#endregion
		
		#region Iterate + Updates
			
			with(struct) {
				
				// Iterate i -> d -> i = 0
				if(i >= d) i = 0;
				else i++;
				
				// Calc Updates
				pct = i/d
				deg = 360*pct
				sn = sin(degtorad(deg))
				sn2 = sn/2
				csn = cos(degtorad(deg))
				csn2 = csn/2
				
				
			}
			
		#endregion
		
	}
	
}

function noise1D(seed, x) {
	
    var xi = floor(x); // Get the integer position
    var xf = x - xi;   // Get the fractional part for interpolation

    // Get noise values at integer positions
    var n0 = hash(xi + seed * 10000);
    var n1 = hash(xi + 1 + seed * 10000);

    // Interpolate between the two noise values
    return mix(n0, n1, smoothstep(xf));
    
}

// Hash function to generate pseudo-random gradients
function hash(n) {
	
    n = (n << 13) ^ n;
    return (1.0 - ((n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0);
    
}

// Smooth interpolation function
function smoothstep(t) {
	
    return t * t * (3.0 - 2.0 * t);
    
}

// Linear interpolation function
function mix(a, b, t) {
	
    return a + (b - a) * t;
    
}

