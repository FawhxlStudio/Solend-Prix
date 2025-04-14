/// @description Draw BG
try { /* GMLive Call */ if (live_call()) return live_result; } catch(_ex) { /* GMLive not available? */ }

if (room == rMenu and D.game_state == GAME.MENU) {
	
	#region Init Menu Screen
		
		// Basic
		var _xx = (WW/2)
		var _yy = (WH/2)
		
		// BD (Galaxy Backdrop)
		var _wd = sprite_get_width(bdspr)
		var _hd = sprite_get_height(bdspr)
		var _scld = (WW*1.01)/_wd
		var _w2d = _wd*_scld
		var _h2d = _hd*_scld
		var dltwd = _w2d-WW
		var dlthd = _h2d-WH
		var panxd = (dltwd/2)*MXPCT
		var panyd = (dlthd/2)*MYPCT
		
		// BG (City Skyline)
		var _w = sprite_get_width(bgspr)
		var _h = sprite_get_height(bgspr)
		var _scl = (WW*1.1)/_w
		var _w2 = _w*_scl
		var _h2 = _h*_scl
		var dltw = _w2-WW
		var dlth = _h2-WH
		var panx = (dltw/2)*MXPCT
		var pany = (dlth/2)*MYPCT
		
		// MG (Balcony)
		var _wm = sprite_get_width(mgspr)
		var _hm = sprite_get_height(mgspr)
		var _sclm = (WW*1.15)/_wm
		var _w2m = _wm*_sclm
		var _h2m = _hm*_sclm
		var dltwm = _w2m-WW
		var dlthm = _h2m-WH
		var panxm = (dltwm/2)*MXPCT
		var panym = (dlthm/2)*MYPCT
		
		// MG 2 (Sylas)
		var _wm2 = sprite_get_width(mg2spr)
		var _hm2 = sprite_get_height(mg2spr)
		var _sclm2 = (WW/4)/_wm2
		var _w2m2 = _wm2*_sclm2
		var _h2m2 = _hm2*_sclm2
		var dltwm2 = _w2m2-(WW/8)
		var dlthm2 = _h2m2-(WH*1.2)
		var panxm2 = (dltwm2/2)*MXPCT
		var panym2 = (dlthm2/2)*MYPCT
		
	#endregion
	
	#region Color Blend FX
		
		/* Disabled, Fire Flicker Effect
		var _r = random_range(216,255)
		var _t = 255-_r
		var _g = random_range(120,175-_t)
		var _blnd = make_color_rgb(_r,_g,0)
		var _blndd = make_color_rgb(216,120,0)
		*/
		var _blnd = make_color_rgb(160,160,255)
		
	#endregion
	
	#region Menu Sprite Draws
	    
	    // Backdrop
	    draw_sprite_ext(bdspr,0,_xx-(panxd),_yy-(panyd),_scld,_scld,0,_blnd,1)
	    
	    // Background
	    draw_sprite_ext(bgspr,0,_xx-panx,_yy-pany,_scl,_scl,0,_blnd,1)
	    
	    // Middle Ground
	    draw_sprite_ext(mgspr,0,_xx-(panxm),(WH*.75)-(panym),_sclm,_sclm,0,_blnd,1)
	    
	    // Middle Ground 2
	    draw_sprite_ext(mg2spr,0,(WW*(1/3))-(panxm*1.15),(WH*(1+(1/3)))-(panym*1.15),-_sclm2,_sclm2,0,_blnd,1)
	    
	#endregion
	
	#region Pre Menu Vox
		
		// Play Voxes
		if(!bgmPlayed and preDel <= 0) {
			
			// Play Intro BGM
			bgmID = audio_play_sound_on(bgmEmt,bgm,F,0,0)
			D.bgm = bgm
			D.bgmID = bgmID
			audio_sound_gain(bgmID,2/3,4000)
			bgmPlayed = T
			
		} else if(preDel > 0 ) preDel--;
		else if(bgmPlayed and !audio_is_playing(bgm) and !audio_is_playing(M.bgm)) {
			
			D.bgm = N
			D.bgmID = N
			M.bgmID = audio_play_sound_on(bgmEmt,M.bgm,T,0,0);
			audio_sound_gain(M.bgmID,1/3,4000)
			
		}
		
		if(preDel <= 0 and fade > 0) fade = clamp(fade-fadei,0,1);
		
		draw_set_alpha(fade)
		draw_rectangle_color(0,0,WW,WH,c.blk,c.blk,c.blk,c.blk,F)
		draw_set_alpha(1)
		var _tscl = (WH/sprite_get_height(sprLogo))*.8
		draw_sprite_ext(sprLogo,0,WW/2,WH/2,_tscl,_tscl,0,c.wht,fade)
		
	#endregion
	
	#region Title Prep
		
		if(titSurf == N or !surface_exists(titSurf) or surface_get_width(titSurf) != WW or surface_get_height(titSurf) != WH) {
			
			if(surface_exists(titSurf)) surface_free(titSurf);
			titSurf = surface_create(WW,WH)
			surface_set_target(titSurf)
			
			draw_set_hvalign([fa_center,fa_middle])
			draw_set_font(fTitle)
			var _str = "Solend Prix"
			var _strw = string_width(_str)
			if(titAngl == N) titAngl = random_range(-3,3);
			draw_text_transformed_color(WW/1.9,WH*.18,_str,(WW/2)/_strw,(WW/2)/_strw,titAngl,c.gry,c.gry,c.dgry,c.dgry,2/3)
			draw_text_transformed_color(WW/2,WH*.2,_str,(WW/2)/_strw,(WW/2)/_strw,titAngl,c.wht,c.wht,c.gry,c.gry,1)
			
			surface_reset_target()
			
		}
		
	#endregion
	
	#region Title Draw
		
		if(surface_exists(titSurf) and M.introInst == N) {
			
			// Draw Title
			if(audio_is_playing(sfxFlyBy)) tita = audio_sound_get_track_position(titsfx)/audio_sound_length(sfxFlyBy);
			draw_surface_ext(titSurf,0,0,1,1,0,c.wht,tita)
			
		}
		
	#endregion
	
	#region Buttons
		
		if(fade <= 0 and M.introInst == N) {
			
			if(titDel > 0) titDel--;
			if(btnDeli < btnDel and titDel == 0) btnDeli = clamp(btnDeli+1,0,btnDel);
			if(titDel > 0 and titDel < GSPD*2.9 and !audio_is_playing(sfxFlyBy)) titsfx = audio_play_sound_on(sfxEmt,sfxFlyBy,F,1,1);
			if(titDel > 0 and titDel < GSPD*2.8) titDel = 0;
			if(btnDel > 0 and btnDel < GSPD*(1/3)) btnDel = 0;
			
			// Init Play + Button Draws
			draw_set_hvalign([fa_center,fa_middle])
			draw_set_font(fHUD)
			var _bpct = btnDeli/btnDel
			var _bx1 = lerp(WW*.785,WW*.67,_bpct)
			var _bx2 = lerp(WW*.785,WW*.9,_bpct)
			var _pxy = [_bx1,WH*.75,_bx2,WH*.8]
			var _pbgc = [1/3,c.blk,c.blk,c.dgry,c.dgry]
			var _pfgc = [1,c.lgry,c.lgry,c.wht,c.wht]
			
			// Draw Play
			draw_button_fxl(_pxy,_pbgc,_pfgc,"Play",ACTION.PLAY,T)
			
			// Init Settings
			var _sxy = [_bx1,WH*.825,_bx2,WH*.875]
			var _sbgc = [1/3,c.blk,c.blk,c.dgry,c.dgry]
			var _sfgc = [1,c.lgry,c.lgry,c.wht,c.wht]
			
			// Draw Exit
			draw_button_fxl(_sxy,_sbgc,_sfgc,"Settings",ACTION.SETTINGS,T)
			
			// Init Exit
			var _exy = [_bx1,WH*.9,_bx2,WH*.95]
			var _ebgc = [1/3,c.blk,c.blk,c.dgry,c.dgry]
			var _efgc = [1,c.r,c.r,c.nr,c.nr]
			
			// Draw Exit
			draw_button_fxl(_exy,_ebgc,_efgc,"Exit",ACTION.EXIT,T)
			
		}
		
	#endregion
	
	#region Settings
		
		if(settings or setDeli > 0 and M.introInst == N) {
			
			if(settings and setDeli < setDel) setDeli = clamp(setDeli+1,0,setDel);
			var _delpct = setDeli/setDel
			
			// BG
			var _d = 0.005*_delpct
			draw_set_alpha((1/3)*_delpct)
			draw_rectangle_color(WW*(.025-_d),WH*(.45-_d),WW*(.575+_d),WH*(.975+_d),c.blk,c.blk,c.blk,c.blk,F)
			draw_set_alpha(1*_delpct)
			draw_rectangle_color(WW*(.025-_d),WH*(.45-_d),WW*(.575+_d),WH*(.975+_d),c.wht,c.wht,c.gry,c.gry,T)
			
			// Master Vol
			slider_draw([WW*(.1-_d),WH*(.5-_d),WW*(.5+_d),WH*(.55+_d)],[(1/3)*_delpct,c.dgry,c.dgry,c.blk,c.blk],[_delpct,c.wht,c.wht,c.gry,c.gry],"Total Volume",masterVol,0,1,2,"%",ACTION.VOL_MASTER,settings)
			
			// Environment Vol
			slider_draw([WW*(.1-_d),WH*(.6-_d),WW*(.5+_d),WH*(.65+_d)],[(1/3)*_delpct,c.dgry,c.dgry,c.blk,c.blk],[_delpct,c.wht,c.wht,c.gry,c.gry],"Environmental/Ambient Effects Volume",envVol,0,1,2,"%",ACTION.VOL_ENV,settings)
			
			// SFX Vol
			slider_draw([WW*(.1-_d),WH*(.7-_d),WW*(.5+_d),WH*(.75+_d)],[(1/3)*_delpct,c.dgry,c.dgry,c.blk,c.blk],[_delpct,c.wht,c.wht,c.gry,c.gry],"Sound Effects Volume",sfxVol,0,1,2,"%",ACTION.VOL_SFX,settings)
			
			// BGM Vol
			slider_draw([WW*(.1-_d),WH*(.8-_d),WW*(.5+_d),WH*(.85+_d)],[(1/3)*_delpct,c.dgry,c.dgry,c.blk,c.blk],[_delpct,c.wht,c.wht,c.gry,c.gry],"Background Music Volume",bgmVol,0,1,2,"%",ACTION.VOL_BGM,settings)
			
			// GUI Vol
			slider_draw([WW*(.1-_d),WH*(.9-_d),WW*(.5+_d),WH*(.95+_d)],[(1/3)*_delpct,c.dgry,c.dgry,c.blk,c.blk],[_delpct,c.wht,c.wht,c.gry,c.gry],"GUI Volume",guiVol,0,1,2,"%",ACTION.VOL_GUI,settings)
			
		}
		
		if(!settings and setDeli > 0) setDeli = clamp(setDeli-1,0,setDel);
		
	#endregion
	
}