function in_party(inst) {
	
	for(var i = 0; i < ds_list_size(P.party); i++) {
		
		if(P.party[|i] == inst) return T;
		
	}
	
	return F
	
}

function leave_party(actr) {
	
	for(var i = 0; i < ds_list_size(P.party); i++) {
		
		if(P.party[|i] == actr) {
			
			ds_list_delete(P.party,i)
			return T
			
		}
		
	}
	
	return F
	
}

function join_party(actr) {
	
	if(!in_party(actr)) {
		
		ds_list_add(P.party,actr)
		return T
		
	}
	
	return F
	
}