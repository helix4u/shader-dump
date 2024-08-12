#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    // Apply curvature distortion
    vec2 center = vec2(0.5, 0.5);
    vec2 offset = uv - center;
    float distortion = 0.15; // Adjust this value for more or less curvature
    vec2 curvedUV = center + offset * (1.0 + distortion * length(offset));

    vec3 color = texture(texture0, curvedUV).rgb;

    // Apply scanline effect
    float scanline = sin(uv.y * 800.0) * 0.1 + 0.9;
    color *= scanline;

    fragColor = vec4(color, 1.0);
}
