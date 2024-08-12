#version 330 core

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    float blurSize = 0.005; // Size of the blur effect

    vec3 color = vec3(0.0);
    int samples = 12; // Number of blur samples
    float total = 0.0;

    // Apply blur by averaging surrounding pixels
    for (int i = 0; i < samples; ++i) {
        for (int j = 0; j < samples; ++j) {
            vec2 offset = vec2(float(i - samples / 2), float(j - samples / 2)) * blurSize;
            color += texture(texture0, uv + offset).rgb;
            total += 1.0;
        }
    }

    color /= total;

    // Add distortion by shifting the texture coordinates
    float distortionStrength = 0.03;
    vec2 distortedUV = uv + texture(texture0, uv * 10.0).rg * distortionStrength;

    // Combine blur and distortion for the frosted glass effect
    fragColor = vec4(mix(texture(texture0, uv).rgb, color, 0.7), 1.0);
}
