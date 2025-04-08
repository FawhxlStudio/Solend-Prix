precision mediump float;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec4 texColor = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
    
    // Compute brightness
    float brightness = dot(texColor.rgb, vec3(0.299, 0.587, 0.114));

    // Only draw pixels above a threshold (e.g., ~5% brightness)
    if (brightness < 0.05) {
        discard;
    }

    gl_FragColor = texColor;
}
