//
// Simple passthrough fragment shader
//
precision mediump float;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	float _a = max(v_vColour.r,v_vColour.g);
	_a = max(_a,v_vColour.b);
    gl_FragColor = vec4(v_vColour.r,v_vColour.g,v_vColour.b,_a);
}
