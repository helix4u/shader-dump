#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;

    // Apply scanline effect
    float scanline = sin(uv.y * 800.0) * 0.1 + 0.9; // Adjust frequency for your resolution
    color *= scanline;

    fragColor = vec4(color, 1.0);
}
