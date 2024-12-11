// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function _init() {
	
	// Randomize
	randomize()
	
	#region Macros
		
		#region Basic/Bool
			
			#macro T true
			#macro F false
			#macro N noone
			#macro U undefined
			#macro GSPD game_get_speed(gamespeed_fps)
			#macro STRH string_height("|")
			#macro STRW string_width("_")
			
		#endregion Basic/Bool
		
		#region Mouse
			
			// Basics
			#macro MX mouse_x
			#macro MY mouse_y
			#macro WMX window_mouse_get_x()
			#macro WMY window_mouse_get_y()
			#macro MXPCT window_mouse_get_x()/window_get_width()
			#macro MYPCT window_mouse_get_y()/window_get_height()
			
			// Mouse Left
			#macro MBLP mouse_check_button_pressed(mb_left)
			#macro MBL  mouse_check_button(mb_left)
			#macro MBLR mouse_check_button_released(mb_left)
			
			// Mouse Middle
			#macro MBMP mouse_check_button_pressed(mb_middle)
			#macro MBM  mouse_check_button(mb_middle)
			#macro MBMR mouse_check_button_released(mb_middle)
			
			// Mouse Right
			#macro MBRP mouse_check_button_pressed(mb_right)
			#macro MBR  mouse_check_button(mb_right)
			#macro MBRR mouse_check_button_released(mb_right)
			
		#endregion Mouse
		
		#region Display
			
			#macro DW display_get_width()
			#macro DH display_get_height()
			
		#endregion Display
		
		#region Window
			
			#macro WW window_get_width()
			#macro WH window_get_height()
			
		#endregion Window
		
		#region Chances (Rolls)
			
			#macro R50 (irandom(1) == 1)   // 50%; !R50 == 50%
			#macro R33 (irandom(2) == 2)   // 33%; !R33 == 67%
			#macro R25 (irandom(3) == 3)   // 25%; !R25 == 75%
			#macro R20 (irandom(4) == 4)   // 20%; !R20 == 80%
			#macro R10 (irandom(9) == 9)   // 10%; !R10 == 10%
			#macro R1  (irandom(99) == 99) //  1%; !R1  == 99%
			
		#endregion Chances
		
		#region Color Struct
			
			#macro c global.color_struct
			c = {
				
				#region Grayscale
					
					wht		:	make_color_rgb(255,255,255),
					lgry	:	make_color_rgb(192,192,192),
					gry		:	make_color_rgb(128,128,128),
					dgry	:	make_color_rgb(64,64,64),
					blk		:	make_color_rgb(0,0,0),
					
				#endregion
				
				#region Redscale
					
					nr	:	make_color_rgb(255,0,0),
					lr	:	make_color_rgb(192,0,0),
					r	:	make_color_rgb(128,0,0),
					dr	:	make_color_rgb(64,0,0),
					
				#endregion
				
				#region Greenscale
					
					ng	:	make_color_rgb(0,255,0),
					lg	:	make_color_rgb(0,192,0),
					g	:	make_color_rgb(0,128,0),
					dg	:	make_color_rgb(0,64,0),
					
				#endregion
				
				#region Bluescale
					
					nb	:	make_color_rgb(128,128,255),
					lb	:	make_color_rgb(128,128,255),
					b	:	make_color_rgb(32,32,128),
					db	:	make_color_rgb(0,0,64),
					
				#endregion
				
				#region Yellowscale
					
					ny	:	make_color_rgb(255,255,0),
					ly	:	make_color_rgb(192,192,0),
					ylw	:	make_color_rgb(128,128,0),
					dy	:	make_color_rgb(64,64,0),
					
				#endregion
				
				#region Orangescale
					
					nrng	:	make_color_rgb(255,128,0),
					lrng	:	make_color_rgb(192,96,0),
					rng		:	make_color_rgb(128,64,0),
					drng	:	make_color_rgb(64,32,0)
					
				#endregion
				
			}
			
		#endregion
		
		
	#endregion Macros
	
	#region Enums
		
		enum GAME {
			
			FIRST,
			INIT,
			PLAY,
			MENU,
			LAST
			
		}
		
		enum TRIGGER {
			
			FIRST,
			START,
			SUIT,
			ANIM,
			CLICK,
			CLICK_OR_CONTINUE,
			CONTINUE,
			LAST
			
		}
		
		enum EDIT {
			
			FIRST,
			TEXT,
			TO_SCENE,
			TIMER,
			DELAY,
			ANIMATION,
			SPRITE,
			SOUND,
			ENTITY,
			CLICK,
			LAST
			
		}
		
		enum SEX {
			
			FIRST,
			MALE,
			FEMALE,
			LAST
			
		}
		
		enum ACTOR {
			
			FIRST,
			SYLAS,
			SPITFIRE,
			LAST
			
		}
		
		enum ACTION {
			
			FIRST,
			LEAVE,
			LAST
			
		}
		
		enum CONSOLE {
			
			FIRST,
			DIALOGUE,
			NARRATIVE,
			SCENE,
			LAST
			
		}
		
		enum V {
			
			FIRST,
			STATIC,
			DONE,
			DONE_AND_CONTINUE,
			DONE_TO_ANIM,
			DONE_AND_JOIN,
			CONTINUE,
			SUIT,
			NARRATOR_ALL,
			NARRATOR_NONE,
			LEFT,
			MIDDLE,
			RIGHT,
			ACTOR_MET,
			ANIM,
			LINK_A,
			LINK_B,
			LINK_C,
			LINK_D,
			LINK_E,
			MB_LP,
			LAST
			
		}
		
		enum BUTTON {
			
			FIRST,
			PLAY,
			EXIT,
			LAST
			
		}
		
		enum SCENE {
			
			FIRST,
			APARTMENT,
			STREET,
			CLUB,
			PLAZA,
			SPACEPORT,
			PRAEY_COCKPIT,
			LAST
			
		}
		
		// Pretend this is a enum for strings
		#macro K global.key_struct
		K = N
		K = {
			
			// RULE 0: THESE WILL BE BETWEEN 2 AND 3 FOR ACCESSOR BREVITY - FOR HIGHLY SPECIALIZED SIMULATION ENGINEERS OF EXCESSIVE OR ADVANCED LOGISTICAL PROWESS QUALIFIED IN FVKJADSNCJK DJKFDSAN KVNSDKJAF SNSFJHSVJHSAJHJVL MN XMVMNZX CV, ZXM B M,XCMBX MNXCZMXMNHJFA L JHSAD VJHSDA CJ XLMNVC SAJJLSDF SDLK FCNVCJZX J V VASK JLVSAJKDB VNJKSNVKJCZXVXC VJZSVKJSCKJXZBZGNKJFS VLHKSF BVKCZBNXJBNLZX BVXK CVBNJKCLKZ XBXVZNBXZKBJLZN LBZJBK ZXCJV CXBNVLKNKSA NVC V,MZNBZXVNBKJ LZKJSVJFKLVBZXZZNCM,VLBXVJZBJKXVZLKJV  VB XZVJKB XVJZKB XZJB NNXB.BZX JVK CXBLJBKZX BJBKZX NVKM BXC.NMBVZX B LJKHZB .KX B.NM CZX.JV XZJHKVBKZ VH.XZBN.ZXNV.JKCZXNVJKX NBXZ. BNCXZ NBJKVZ XB.XZBVHKZB RHJLKFVDVJNCMV,Z.XN KJSFGBKJLDSVA BKC VKXJLCZ  XZB. ZXB.JCVZX NB VXBXC.Z BV.XZCV B.XZ .BXC. NKVNCXMZ VB.MXZCNB V.NMCX
			// Rule 1: End user will recieve human-readable format
			// Prefix
			INV:"!",
			// Parent
			NM:"name",
			SX:"sex",
			ACT:"actor",
			KNW:"know",
			BR:"branch",
			OPT:"option",
			FLG:"flag",
			CLK:"click",
			SHP:"shape",
			FND:"find",
			FOD:"found",
			HVR:"hover",
			HLT:"highlight",
			RAD:"radius",
			XY4:"coordinateArray4",
			XY2:"coordinateArray2",
			WH2:"widthHeightArray2",
			DTR:"destroy",
			DTD:"destroyed",
			STR:"string",
			LNK:"link",
			ENT:"entity",
			ANM:"anim",
			DN:"done",
			TRG:"trigger",
			CAR:"carot",
			ENV:"environment",
			SCN:"scene",
			SND:"sound",
			TRA:"traveller",
			SK0:"skylayerO",
			BD0:"backdropO",
			BG0:"background0",
			MG0:"middleground0",
			FG0:"foreground0",
			SP0:"special0", 
			TMR:"timer",
			// Hybrid
			REL:"relation_",
			// Hybrid Child
			I:"_iterator",
			IO:"_iteratorOld",
			// Child
			L1:"_layer1",
			L2:"_layer2",
			LFT:"_left",
			MID:"_middle",
			RHT:"_right",
			SPR:"_sprite",
			PMT:"_panMultiplier",
			WMT:"_widthMultiplier",
			MT:"_multiplier",
			XRG:"_xRange",
			YRG:"_yRange",
			ZRG:"_zRange",
			CNT:"_count",
			TO:"_to",
			IN:"_in",
			BLD:"_blend",
			DL:"_delay",
			DLI:"_delayIterator",
			TR:"_true",
			FL:"_false",
			ADJ:"_adjust"
			
		}
		
	#endregion Enums
	
	#region Debug
		
		try {
			
			#macro GMLV global.gmlive
			GMLV = instance_create_layer(0,0,"Logic",obj_gmlive)
			
		} catch(_ex) { /* GMLive not available? */ }
		
		if(T) { // @TOGGLE: Debug Mode
			
			#macro DBG global.debug
			DBG = instance_create_layer(0,0,"Logic",oDebug)
			DBG.persistent = T
			
			//show_message("Debug Active")
			
		}
		
	#endregion
	
	#region Global Objects
		
		#region Essentials
			
			// Main Object; Processes Non-Player Interactions
			#macro M global.main
			M = instance_create_layer(0,0,"Logic",oMain)
			M.persistent = T
			
			// Player Object; Processes Player Interactions
			#macro P global.player
			P = instance_create_layer(0,0,"Logic",oPlayer)
			P.persistent = T
			
			// Data Object; Holder of Global Variables
			#macro TRAN global.transition
			TRAN = instance_create_layer(0,0,"Logic",oTransition)
			TRAN.persistent = T
			
			// Data Object; Holder of Global Variables
			#macro D global.data
			D = instance_create_layer(0,0,"Logic",oData)
			D.persistent = T
			
		#endregion Essentials
		
	#endregion Global Objects
	
}