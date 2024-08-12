#version 330

uniform sampler2D texture0; // The base texture
in vec2 uv;
out vec4 fragColor;

void main() {
    // Sample the base texture and convert it to grayscale
    vec3 color = texture(texture0, uv).rgb;
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114));

    // Map grayscale value to infrared color gradient
    vec3 infraredColor;
    if (grayscale < 0.25) {
        infraredColor = mix(vec3(0.0, 0.0, 0.5), vec3(0.0, 0.5, 1.0), grayscale / 0.25); // Blue to cyan
    } else if (grayscale < 0.5) {
        infraredColor = mix(vec3(0.0, 0.5, 1.0), vec3(0.0, 1.0, 0.0), (grayscale - 0.25) / 0.25); // Cyan to green
    } else if (grayscale < 0.75) {
        infraredColor = mix(vec3(0.0, 1.0, 0.0), vec3(1.0, 1.0, 0.0), (grayscale - 0.5) / 0.25); // Green to yellow
    } else {
        infraredColor = mix(vec3(1.0, 1.0, 0.0), vec3(1.0, 0.0, 0.0), (grayscale - 0.75) / 0.25); // Yellow to red
    }

    // Output the final infrared color
    fragColor = vec4(infraredColor, 1.0);
}
