varying vec2 v_vTexcoord;
uniform vec2 texelSize; // 1.0 / resolution
uniform float blurStrength; // Blur radius, e.g., 4.0

void main() {
	
    vec4 result = vec4(0.0);
    float total = 0.0;

    // Apply a simple Gaussian blur
    for (float x = -4.0; x <= 4.0; x+=1.0) {
		
        for (float y = -4.0; y <= 4.0; y+=1.0) {
			
            float weight = exp(-0.5 * (x*x + y*y) / (blurStrength * blurStrength));
            vec2 offset = vec2(x, y) * texelSize;
            result += texture2D(gm_BaseTexture, v_vTexcoord + offset) * weight;
            total += weight;
			
        }
		
    }
	
    gl_FragColor = result / total;
	
}
