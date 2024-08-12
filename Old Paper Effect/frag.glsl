#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;

    // Sepia tone
    vec3 sepia = vec3(
        dot(color, vec3(0.393, 0.769, 0.189)),
        dot(color, vec3(0.349, 0.686, 0.168)),
        dot(color, vec3(0.272, 0.534, 0.131))
    );

    // Add noise for grainy effect
    float noise = fract(sin(dot(uv * textureSize(texture0, 0), vec2(12.9898, 78.233))) * 43758.5453);
    sepia += noise * 0.2;

    // Slight vignette
    float vignette = smoothstep(0.8, 0.2, length(uv - 0.5));
    sepia *= vignette;

    fragColor = vec4(clamp(sepia, 0.0, 1.0), 1.0);
}
