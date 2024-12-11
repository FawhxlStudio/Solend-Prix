function in_party(inst) {
	
	for(var i = 0; i < ds_list_size(P.party); i++) {
		
		if(P.party[|i] == inst) return T;
		
	}
	
	return F
	
}

function leave_party(inst) {
	
	for(var i = 0; i < ds_list_size(P.party); i++) {
		
		if(P.party[|i] == inst) {
			
			ds_list_delete(P.party,i)
			return T
			
		}
		
	}
	
	return F
	
}

function join_party(inst) {
	
	if(!in_party(inst)) {
		
		ds_list_add(P.party,inst)
		return T
		
	}
	
	return F
	
}