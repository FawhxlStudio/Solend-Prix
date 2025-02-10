precision mediump float; // Ensure compatibility

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;

void main() {
    
    // Init uv
    vec2 uv = v_vTexcoord;
    
    // Subtle screen warping
    uv.x += 0.001 * sin(uv.y * 25.0 + time * 2.0);
    
    // Chromatic aberration with minimal shift
    float r = texture2D(gm_BaseTexture, uv + vec2(0.0005, 0.0)).r;
    float g = texture2D(gm_BaseTexture, uv).g;
    float b = texture2D(gm_BaseTexture, uv - vec2(0.0005, 0.0)).b;
    
    vec3 col = vec3(r, g, b);
    
    // Soft scanlines (must be subtle or text becomes unreadable)
    float scanline = 0.02 * sin(uv.y * 800.0);
    col -= vec3(scanline);
    
    // Randomized glitch effect (tiny horizontal jumps)
    float glitchFactor = sin(time * 20.0 + uv.y * 100.0);
    float glitchThreshold = 0.995; // Adjust to control glitch frequency

    if (fract(glitchFactor) > glitchThreshold) {
        uv.x += 0.002; // Tiny shift, prevents major distortion
    }
    
    gl_FragColor = vec4(col, 1.0) * v_vColour;
}
