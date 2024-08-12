#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

const float offset = 1.0 / 300.0;

void main() {
    vec3 color = vec3(0.0);

    // Sharpening kernel
    color -= texture(texture0, uv + vec2(-offset, -offset)).rgb * 1.0;
    color -= texture(texture0, uv + vec2(0.0, -offset)).rgb * 1.0;
    color -= texture(texture0, uv + vec2(offset, -offset)).rgb * 1.0;
    color -= texture(texture0, uv + vec2(-offset, 0.0)).rgb * 1.0;
    color += texture(texture0, uv).rgb * 9.0;
    color -= texture(texture0, uv + vec2(offset, 0.0)).rgb * 1.0;
    color -= texture(texture0, uv + vec2(-offset, offset)).rgb * 1.0;
    color -= texture(texture0, uv + vec2(0.0, offset)).rgb * 1.0;
    color -= texture(texture0, uv + vec2(offset, offset)).rgb * 1.0;

    fragColor = vec4(color, 1.0);
}
