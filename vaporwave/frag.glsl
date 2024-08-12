#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;

    // Apply a neon gradient (cyan, magenta, and purple tones)
    vec3 vaporwave = vec3(
        dot(color, vec3(0.5, 0.0, 1.0)),
        dot(color, vec3(1.0, 0.0, 0.5)),
        dot(color, vec3(0.7, 0.3, 1.0))
    );

    fragColor = vec4(clamp(vaporwave, 0.0, 1.0), 1.0);
}
