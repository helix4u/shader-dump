#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec2 center = vec2(0.5, 0.5);
    vec3 color = vec3(0.0);

    // Sample along a radial line
    for (float i = 0.0; i < 1.0; i += 0.1) {
        vec2 offset = (uv - center) * i;
        color += texture(texture0, uv - offset).rgb;
    }

    color /= 10.0; // Average the samples
    fragColor = vec4(color, 1.0);
}
