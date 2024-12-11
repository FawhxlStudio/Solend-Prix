function near_mouse(inst,dist) {
	
	return (point_distance(WMX,WMY,inst.x,inst.y) <= dist)
	
}

function mouse_in_rectangle(xy4) {
	
	var rtn = T
	if(xy4[0] < xy4[2]) rtn = WMX >= xy4[0] and WMX <= xy4[2]
	if(xy4[1] < xy4[3] and rtn) rtn = WMY >= xy4[1] and WMY <= xy4[3]
	if(xy4[0] > xy4[2] and rtn) rtn = WMX <= xy4[0] and WMX >= xy4[2]
	if(xy4[1] > xy4[3] and rtn) rtn = WMY <= xy4[1] and WMY >= xy4[3]
	return rtn
	
}

function mouse_in_circle(xy2,rad) {
	
	return (point_distance(xy2[0],xy2[1],WMX,WMY) <= rad)
	
}