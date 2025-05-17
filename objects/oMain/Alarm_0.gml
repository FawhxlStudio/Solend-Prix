/// @description Resize Surface

// Ensure Minimum WH of 1
var _ww = max(1,WW)
var _wh = max(1,WH)
surface_resize(application_surface,_ww,_wh)
room_width = _ww
room_height = _wh
//window_mouse_set(_ww/2,_wh/2)