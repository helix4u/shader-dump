#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;

    // Apply scanline effect
    float scanline = sin(uv.y * 800.0) * 0.1 + 0.9;
    color *= scanline;

    // Apply phosphor glow effect
    vec3 glowColor = vec3(0.0);
    for (float x = -0.002; x <= 0.002; x += 0.001) {
        for (float y = -0.002; y <= 0.002; y += 0.001) {
            glowColor += texture(texture0, uv + vec2(x, y)).rgb;
        }
    }
    color = mix(color, glowColor / 25.0, 0.5);

    fragColor = vec4(color, 1.0);
}
