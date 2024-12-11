/// @description Controls
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

#region Meta Updates
	
	#region Olds
		
		suitedo = suited
		
	#endregion
	
#endregion

if(D.scene_state == GAME.PLAY) {
	
	#region Zoom Toggle
		
		if(TRAN.delpct <= 0) {
			
			//if(MBRP and !D.ctrlOverride) D.zoomed = !D.zoomed;
			if(MBRP and !DBG.edit and !D.ctrlOverride) D.zoomed = !D.zoomed;
			
			if(D.zoomed) D.z = D.zmx-(D.zmx*lerp(D.diaZmn-1,D.diaZmx-1,D.diaDelPct));
			else D.z = D.zmn*lerp(D.diaZmn,D.diaZmx,D.diaDelPct);
			
			// Zoom Old (Used to return to zoom after transitions)
			D.zo = D.z
			
		}
		
	#endregion
	
}