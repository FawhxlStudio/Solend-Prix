varying vec2 v_vTexcoord;
uniform float threshold;          // Brightness threshold (e.g., 0.8)

void main() {
	
    // Sample the texture at the current coordinate
    vec4 color = texture2D(gm_BaseTexture, v_vTexcoord);
    
    // Calculate perceived brightness
    float brightness = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    // Ensure alpha > 0 and brightness > threshold
    if (color.a > 0.0 && brightness > threshold) {
    	
        gl_FragColor = color;
        
    } else {
    	
        gl_FragColor = vec4(0.0); // Fully transparent
        
    }
    
}