#version 330

uniform sampler2D texture0;
uniform float time;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;

    // Random noise generation using a different method for better visibility
    vec2 noiseUV = uv * vec2(512.0, 512.0) + vec2(time); // Scaling UV for higher frequency noise
    float noise = fract(sin(dot(noiseUV.xy , vec2(12.9898, 78.233))) * 43758.5453);

    // Combine noise with the original color
    color += (noise - 0.5) * 0.5; // Adjust grain strength (centered around 0)

    // Clamp the final color to ensure it stays within [0, 1]
    color = clamp(color, 0.0, 1.0);

    fragColor = vec4(color, 1.0);
}
