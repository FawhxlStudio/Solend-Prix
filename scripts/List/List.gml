function ds_list_has(list,val) {
	
	for(var i = 0; i < ds_list_size(list); i++) {
		
		// Found?
		if(is_array(val)) {
			
			if(array_equals(list[|i],val)) return T;
			
		} else if(list[|i] == val) return T;
		
	}
	
	// Not Found...
	return F
	
}

function ds_list_top(list) {
    
	if(ds_list_empty(list)) return N;
	else return list[|ds_list_size(list)-1];
	
}

function ds_list_del_top(list) {
    
	if(ds_list_empty(list)) return F;
	else return ds_list_delete(D.diaNestLst,ds_list_size(list)-1);
	
}