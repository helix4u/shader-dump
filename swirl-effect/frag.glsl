#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec2 center = vec2(0.5, 0.5);
    float angle = 0.5; // amount of swirl

    vec2 offset = uv - center;
    float dist = length(offset);
    float theta = atan(offset.y, offset.x) + angle * dist;
    vec2 newUV = center + dist * vec2(cos(theta), sin(theta));

    fragColor = texture(texture0, newUV);
}
