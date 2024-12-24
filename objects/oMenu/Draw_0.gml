/// @description Draw BG
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if(room == rMenu and D.game_state == GAME.MENU) {
	
	#region Init Menu Screen
	    
	    var _spr = sprMenuBG
	    var _spr2 = sprMenuMG1
	    var _spr3 = sprMenuMG2
	    var _spr4 = sprMenuBD
	    var _wd = sprite_get_width(_spr4)
	    var _hd = sprite_get_height(_spr4)
	    var _w = sprite_get_width(_spr)
	    var _h = sprite_get_height(_spr)
	    var _scl = (WW*1.67)/_w
	    var _scld = (WW*1.05)/_wd
	    var _sclMG1 = (WW/sprite_get_width(_spr2))*(1+(1/3))
	    var _sclMG2 = (WW/sprite_get_width(_spr3))/4
	    var _w2 = _w*_scl
	    var _h2 = _h*_scl
	    var _w2d = _wd*_scld
	    var _h2d = _hd*_scld
	    var _ox = sprite_get_xoffset(_spr)
	    var _ox = sprite_get_xoffset(_spr)
	    var _xx = (WW/2)
	    var _yy = (WH/2)
	    var _xxMG1 = (WW*1.67)*(1/3)
	    var _yyMG1 = (WH*1.67)
	    var _xxMG2 = (WW*1.67)*(2/3)
	    var _yyMG2 = (WH*1.67)*(3/4)
	    var dltw = _w2-WW
	    var dlth = _h2-WH
	    var dltwd = _w2d-WW
	    var dlthd = _h2d-WH
	    var panx = (dltw/2)*MXPCT
	    var pany = (dlth/2)*MYPCT
	    var panxd = (dltwd/2)*MXPCT
	    var panyd = (dlthd/2)*MYPCT
	    var zpct1 = 1.4
	    var zpct2 = 1.1
	    
	#endregion
	
	#region TODO Shake BigSlow/SmallQuick
	    
	    
	    
	#endregion
	
	#region TODO Lighting
	    
	    var _r = random_range(216,255)
	    var _t = 255-_r
	    var _g = random_range(120,175-_t)
	    var _blnd = make_color_rgb(_r,_g,0)
	    var _blndd = make_color_rgb(216,120,0)
	    
	#endregion
	
	#region TODO Explosions
	    
	    if(ds_list_size(expL) < expCnt and expDel <= 0) {
	        
	        var e = instance_create_layer(0,0,"Logic",oExplosion)
	        ds_list_add(expL,e)
	        e.alarm[0] = 1
	        expDel = GSPD*random_range(1/3,3)
	        
	    } else expDel = clamp(expDel-1,0,expDel);
	    
	    for(var i = 0; i < ds_list_size(expL); i++) {
	        
	        var e = expL[|i]
	        if(e.image_alpha <= 0) {
	            
	            instance_destroy(e)
	            ds_list_delete(expL,i)
	            if(ds_list_empty(expL)) break;
	            
	        } else {
	            
	            // Updates
	            if((e.w != _w or e.h != _h) and e.alarm[0] < 0) e.alarm[0] = 1;
	            e.w = _w2d
	            e.h = _h2d
	            e.panx = panxd
	            e.pany = panyd
	            e.image_blend = _blnd
		        e.image_alpha = e.al/e.almx
	            
	        }
	        
	    }
	    
	#endregion
	
	#region Menu BG Draws TODO: Particles
	    
	    draw_sprite_ext(_spr4,0,_xx-(panxd),_yy-(panyd),_scld,_scld,0,_blndd,1)
	    if(!ds_list_empty(expL)) {
	        
	        for(var i = 0; i < ds_list_size(expL); i++)
	            if(expL[|i].initd)
	                with(expL[|i]) draw_self();
	        
	    }
	    draw_sprite_ext( _spr,0,_xx-panx,_yy-pany,_scl,_scl,0,_blnd,1)
        /*
	    if(!ds_list_empty(expL)) {
	        for(var i = 0; i < ds_list_size(expL); i++)
	            if((expL[|i].scl > .5)  and expL[|i].initd)
	                with(expL[|i]) draw_self();
	    }
        */
	    draw_sprite_ext(_spr3,0,_xxMG2-(panx*zpct2),_yyMG2-(pany*zpct2),_sclMG2,_sclMG2,0,_blnd,1)
	    draw_sprite_ext(_spr2,0,_xxMG1-(panx*zpct1),_yyMG1-(pany*zpct1),_sclMG1,_sclMG1,0,_blndd,1)
	    
	#endregion
	
	#region Pre Menu Vox
	    
	    // Play Voxes
	    if(!vox1) {
	        
	        audio_play_sound(vaVox1,0,F,1/3);
	        vox1 = T
	        
	    } else if(vox1 and !vox2 and !audio_is_playing(vaVox1) and preDel <= 0) {
	        
	        audio_play_sound(vaVox2,0,F,2/3);
	        ashid = audio_play_sound(msxAsh,0,F,db_to_lin(0))
	        audio_sound_gain(ashid,0,0)
	        vox2 = T
	        
	    } else if(vox2 and !vox3 and !audio_is_playing(vaVox2) and voxFade <= .2) {
	        
	        audio_play_sound(vaVox3,0,F,1);
	        vox3 = T
	        
	    } else if(preDel > 0 ) preDel--;
	    
	    if(audio_is_playing(ashid) and audio_sound_get_gain(ashid) == 0)
	    	audio_sound_gain(ashid,1/3,pi*1000);
	    
	    if(vox2) voxFade -= voxi;
	    
	    if(vox3 and !audio_is_playing(vaVox3) and audio_is_playing(ashid))
	        audio_sound_gain(ashid,.8,pi*1000);
	    
	    draw_set_alpha(voxFade)
	    draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
	    draw_set_alpha(1)
	    var _tscl = (WH/sprite_get_height(sprLogo))*.8
	    draw_sprite_ext(sprLogo,0,WW/2,WH/2,_tscl,_tscl,0,c.wht,voxFade)
	    
	#endregion
	
	#region Buttons
		
		if(vox3 and !audio_is_playing(vaVox3)) {
			
			draw_set_hvalign([fa_center,fa_middle])
			draw_set_font(fTitle)
			if(titDel > 0) titDel--;
			if(titDel2 > 0 and titDel == 0) titDel2--;
			if(titDel3 > 0 and titDel == 0) titDel3--;
			if(titDel4 > 0 and titDel == 0) titDel4--;
			if(titDel > 0 and titDel < GSPD*2.9 and !audio_is_playing(sfxShot)) sfx_gunshot(1);
			if(titDel4 > 0 and titDel4 < GSPD*(1/2) and !audio_is_playing(sfxShot)) sfx_gunshot(2/3);
			if(titDel > 0 and titDel < GSPD*2.8) titDel = 0;
			if(titDel4 > 0 and titDel4 < GSPD*(1/3)) titDel4 = 0;
			
			// Init Play Button Vars (Subtitle uses the fgc alpha value, so we init here)
			// Sloppy but documented...
			var _pxy = [WW*.4,WH*.6,WW*.6,WH*.7]
			var _pbgc = [1-(titDel2/(GSPD*5)),c.blk,c.blk,c.dgry,c.dgry]
			var _pfgc = [1-(titDel2/(GSPD*5)),c.lgry,c.lgry,c.wht,c.wht]
			
			var _str = "Wild Comets"
			var _strw = string_width(_str)
			if(titAngl == N) titAngl = random_range(-10,10);
			draw_text_transformed_color(WW/2,WH*.25,_str,WW/_strw,WW/_strw,titAngl,c.wht,c.wht,c.lgry,c.lgry,1-(titDel/(GSPD*3)))
			draw_set_font(fHUD)
			
			// Draw Play
			draw_button_fxl(_pxy,_pbgc,_pfgc,"Play",ACTION.PLAY,T)
			
			// Init Play
			var _exy = [WW*.4,WH*.8,WW*.6,WH*.9]
			var _ebgc = [1-(titDel3/(GSPD*8)),c.blk,c.blk,c.dgry,c.dgry]
			var _efgc = [1-(titDel3/(GSPD*8)),c.r,c.r,c.nr,c.nr]
			
			// Draw Exit
			draw_button_fxl(_exy,_ebgc,_efgc,"Exit",ACTION.EXIT,T)
			
		}
		
	#endregion

}