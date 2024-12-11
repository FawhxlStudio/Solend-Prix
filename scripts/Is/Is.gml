// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function is(inst) {
	
	try {
		
		if(!is_undefined(inst))
			if(inst != N and inst != U)
				return T
		
	} catch(_ex) {}
	
	return F
	
}

function is_string_real(str) {
	
	try {
		
		return is_real(real(str))
		
	} catch(_ex) {}
	
	return F
	
}

// Add new BG, BD and Sky Layers here so they update properly...
function is_bg_img() {
	
	return (D.bgImg == id
		or D.bgL1Img == id
		or D.bgL2Img == id
		or D.bdImg == id
		or D.skyImg == id)
	
}

function is_array_ext(arr,len,valTypes) {
	
	if(valTypes == N) {
		
		// Just Length...
		if(array_length(arr) != len) return F;
		
	} else if(!is_array(valTypes)) {
		
		// Fail if length mismatch...
		if(array_length(arr) != len) return F;
		
		// Loop Thorugh Array and Check all values are of type...
		for(var i = 0; i < len; i++) {
			
			// If any don't match, returns False...
			switch(valTypes) {
				
				case "real": {
					
					if(!is_real(arr[i])) return F;
					break
					
				}
				
				case "string": {
					
					if(!is_string(arr[i])) return F;
					break
					
				}
				
			}
			
		}
		
	} else if(is_array(valTypes)) {
		
		// WIP If needed... Check that each value in array is a type...
		return F
		
	}
	
	// Return True if nothing was wrong...
	return T
	
}