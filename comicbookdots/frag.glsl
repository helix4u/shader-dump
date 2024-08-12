#version 330 core

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114)); // Convert to grayscale

    float dotSpacing = 20.0; // Controls the spacing of the dots
    float dotSize = 0.3; // Controls the size of the dots

    // Calculate the position of the dots
    vec2 dotPos = mod(uv * dotSpacing, 1.0);
    float distance = length(dotPos - vec2(0.5));

    // Create the dot pattern
    float pattern = smoothstep(dotSize, dotSize + 0.1, distance);
    pattern = 1.0 - pattern; // Invert the pattern

    // Apply the pattern to the grayscale image
    fragColor = vec4(vec3(grayscale) * pattern, 1.0);
}
