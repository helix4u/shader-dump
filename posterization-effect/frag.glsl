#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;
    float levels = 4.0; // number of levels per channel
    color = floor(color * levels) / levels;
    fragColor = vec4(color, 1.0);
}
