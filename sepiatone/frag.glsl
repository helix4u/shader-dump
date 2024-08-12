#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;
    vec3 sepia = vec3(
        dot(color, vec3(0.393, 0.769, 0.189)),
        dot(color, vec3(0.349, 0.686, 0.168)),
        dot(color, vec3(0.272, 0.534, 0.131))
    );
    // Clamp the sepia values to the range [0.0, 1.0]
    sepia = clamp(sepia, 0.0, 1.0);
    fragColor = vec4(sepia, 1.0);
}
