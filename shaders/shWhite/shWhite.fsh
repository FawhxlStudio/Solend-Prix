//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float alpha;

void main()
{
	
	if(texture2D(gm_BaseTexture,v_vTexcoord).a < (1.0/3.0)) discard;
	gl_FragColor = vec4(1.0,1.0,1.0,alpha);
	
}
