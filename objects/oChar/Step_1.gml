/// @description Controls & Updates
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

#region FX Updates
	
	#region Sprite Polarity Flip
		
		#region Horizontal
			
			if(sprFlipH) {
				
				// First? Set Old...
				if(flipHi == 0) {
					
					// Set Polairty Old
					if is(diaSpr) sprPolo = diaSprPol;
					else if(suited) sprPolo = bodyPol;
					else sprPolo = headPol;
					
				} else if(sprPolo != N) {
					
					// Apply Transistion
					if is(diaSpr) diaSprPol = lerp(sprPolo*-1,sprPolo,cos(degtorad(180*(flipHi/flipDel))/2));
					else if(suited) bodyPol = lerp(sprPolo*-1,sprPolo,cos(degtorad(180*(flipHi/flipDel))/2));
					else headPol = lerp(sprPolo*-1,sprPolo,cos(degtorad(180*(flipHi/flipDel))/2));
					
				}
				
				// Iterate
				flipHi++
				if(flipHi > flipDel) {
					
					// Done?
					flipHi = 0
					sprFlipH = F
					
					// CHECKLIST:
					// I think this is done?
					// Delay Dialogue From Continuing until sprFlipH or sprFlipV is no longer true?
					// Doesn't cos(0) == 2 or 1? We wan't sin right? 1 -> -1 in lerp???
					
				}
				
			}
			
		#endregion
		
	#endregion
	
#endregion

#region Meta Updates
	
	#region Olds
		
		suitedo = suited
		
	#endregion
	
#endregion

if(D.scene_state == GAME.PLAY) {
	
	if(in_party(id)) scni = D.scni
	
}