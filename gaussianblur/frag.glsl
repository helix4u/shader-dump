#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

const float offset = 1.0 / 300.0; // change depending on the image size

void main() {
    vec3 color = vec3(0.0);
    color += texture(texture0, uv + vec2(-offset, -offset)).rgb * 0.0625;
    color += texture(texture0, uv + vec2(0.0, -offset)).rgb * 0.125;
    color += texture(texture0, uv + vec2(offset, -offset)).rgb * 0.0625;
    color += texture(texture0, uv + vec2(-offset, 0.0)).rgb * 0.125;
    color += texture(texture0, uv).rgb * 0.25;
    color += texture(texture0, uv + vec2(offset, 0.0)).rgb * 0.125;
    color += texture(texture0, uv + vec2(-offset, offset)).rgb * 0.0625;
    color += texture(texture0, uv + vec2(0.0, offset)).rgb * 0.125;
    color += texture(texture0, uv + vec2(offset, offset)).rgb * 0.0625;
    fragColor = vec4(color, 1.0);
}
