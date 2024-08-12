#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    float frequency = 10.0;
    float amplitude = 0.02;
    vec2 wave = uv + vec2(sin(uv.y * frequency) * amplitude, sin(uv.x * frequency) * amplitude);
    fragColor = texture(texture0, wave);
}
