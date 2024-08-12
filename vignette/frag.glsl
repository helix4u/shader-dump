#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;
    float dist = distance(uv, vec2(0.5)); // distance from the center
    float vignette = smoothstep(0.5, 0.9, dist); // smooth vignette effect
    fragColor = vec4(color * (1.0 - vignette), 1.0); // darken the edges
}
