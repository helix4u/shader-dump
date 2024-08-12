#version 330

uniform sampler2D texture0;
uniform float time; // Pass the time variable for dynamic effects
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;

    // Generate film grain
    float grain = fract(sin(dot(uv.xy + time, vec2(12.9898, 78.233))) * 43758.5453);
    grain = grain * 2.0 - 1.0; // Normalize to [-1, 1]
    grain *= 0.1; // Control grain intensity

    // Add scratches (horizontal lines)
    float scratch = step(0.995, fract(uv.y * 100.0 + sin(time * 5.0) * 50.0)) * 0.3;

    // Combine grain and scratches with the original image
    color += vec3(grain) + vec3(scratch);

    // Slightly desaturate the image to enhance the old film look
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114));
    color = mix(color, vec3(grayscale), 0.2);

    fragColor = vec4(color, 1.0);
}
