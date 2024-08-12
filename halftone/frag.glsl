#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    // Convert the texture color to grayscale
    vec3 color = texture(texture0, uv).rgb;
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114));

    // Halftone effect scale
    float scale = 10.0; // Adjust this for the density of the pattern
    vec2 pos = uv * scale;
    vec2 gridPos = floor(pos);
    vec2 coord = fract(pos) - 0.5; // Centering the grid

    // Create circular dots based on the grayscale value
    float radius = 0.5 * (1.0 - grayscale); // Dot size inversely proportional to brightness
    float dist = length(coord);
    float pattern = 1.0 - smoothstep(radius - 0.02, radius + 0.02, dist);

    // Apply the pattern to create the halftone effect
    fragColor = vec4(vec3(pattern), 1.0);
}
