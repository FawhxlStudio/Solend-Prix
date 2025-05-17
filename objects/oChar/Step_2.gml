/// @description Resets

if(D.scene_state == GAME.PLAY) {
	
	if(in_party(id)) scni = D.scni
	
	#region Resets...
		
		if(D.scni != scni) hide = F;
		if(D.diaOpp == N and approach) D.diaOpp = id
		approach = F
		
	#endregion
	
}
