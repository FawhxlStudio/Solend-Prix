varying vec2 v_vTexcoord;
uniform sampler2D originalTexture; // Original scene
uniform sampler2D bloomTexture;    // Blurred bright areas
uniform float bloomIntensity;      // Intensity of the bloom

void main() {
	
    vec4 original = texture2D(originalTexture, v_vTexcoord);
    vec4 bloom = texture2D(bloomTexture, v_vTexcoord) * bloomIntensity;
    gl_FragColor = original + bloom;
	
}
