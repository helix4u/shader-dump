#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;
    float levels = 4.0; // Number of levels per channel
    color = floor(color * levels) / levels;

    // Apply color tints based on brightness
    vec3 tint = mix(vec3(1.0, 0.9, 0.8), vec3(0.5, 0.7, 1.0), dot(color, vec3(0.3, 0.3, 0.3)));
    color *= tint;

    fragColor = vec4(color, 1.0);
}
