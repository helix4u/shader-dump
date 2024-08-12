#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    // Apply curvature distortion
    vec2 center = vec2(0.5, 0.5);
    vec2 offset = uv - center;
    float distortion = 0.15; // Adjust for curvature
    vec2 curvedUV = center + offset * (1.0 + distortion * length(offset));

    // Clamp UV coordinates to prevent wraparound
    curvedUV = clamp(curvedUV, vec2(0.0), vec2(1.0));

    vec3 color = texture(texture0, curvedUV).rgb;

    // Apply scanline effect
    float scanline = sin(uv.y * 800.0) * 0.1 + 0.9;
    color *= scanline;

    // Apply phosphor glow effect
    vec3 glowColor = vec3(0.0);
    for (float x = -0.002; x <= 0.002; x += 0.001) {
        for (float y = -0.002; y <= 0.002; y += 0.001) {
            vec2 glowUV = curvedUV + vec2(x, y);
            glowUV = clamp(glowUV, vec2(0.0), vec2(1.0)); // Clamp again for glow effect
            glowColor += texture(texture0, glowUV).rgb;
        }
    }
    color = mix(color, glowColor / 25.0, 0.5);

    fragColor = vec4(color, 1.0);
}
