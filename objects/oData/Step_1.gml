/// @description Factor Updates
try {
	
	// GMLive Call
	try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }
	
} catch(_ex) { /* GMLive not available? */ }
#region Other Updates
	
	#region Scene Blend
		
		// Init
		var rgb1 = color_get_rgb(scnBlend1)
		var rgb2 = color_get_rgb(scnBlend2)
		var rgb3 = rgb1
		
		// Do blend changing?
		if(scnBlend1 != scnBlend2 and scnBlendDeli < scnBlendDel) {
			
			// Color Calc...
			rgb3[0] = lerp(rgb1[0],rgb2[0],scnBlendPct)
			rgb3[1] = lerp(rgb1[1],rgb2[1],scnBlendPct)
			rgb3[2] = lerp(rgb1[2],rgb2[2],scnBlendPct)
			scnBlend3 = color_make_rgb(rgb3)
			
			// Iterate Scene Blend Change...
			scnBlendDeli = clamp(scnBlendDeli+1,0,scnBlendDel)
			scnBlendPct = scnBlendDeli/scnBlendDel
			
			
		} else {
			
			// Finalize/Reset
			scene_set_blend(scnBlend2)
			scnBlendDeli = 0
			scnBlendPct = 0
			
		}
		
	#endregion
	
	#region Global Relative Draw Vars
		
		wref = max(1,bgImg.sprite_height)
		href = max(1,bgImg.sprite_width)
		bgmxpct = MX/wref
		bgmypct = MY/href
		mwref = 1
		mhref = 1
		if(bbox_sanity(bgImg)) {
			
			mwref = max(1,bgImg.bbox_right)
			mhref = max(1,bgImg.bbox_bottom)
			bgdltx = bgImg.bbox_left
			bgdlty = bgImg.bbox_top
			
		}
		
	#endregion
	
#endregion