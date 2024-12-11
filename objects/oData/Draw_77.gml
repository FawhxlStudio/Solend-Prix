/// @description Global Logic Updates Updates
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
#region Control Override
	
	if(!ds_list_empty(dialogue) or animPlay != N or focusL != N) ctrlOverride = T;
	else ctrlOverride = F;
	
#endregion

#region Frame Delay
	
	if(fd > 0) fd = clamp(fd-1,0,GSPD);
	
#endregion

#region Hover Iteration
	
	if(isHvr) {
		
		// Iterate
		if(hvrDeli < hvrDel) hvrDeli = clamp(hvrDeli+1,0,hvrDel);
		hvrPct = hvrDeli/hvrDel
		
	} else {
		
		// Reset
		hvrDeli = 0
		hvrPct = 0
		
	}
	isHvr = F
	
#endregion