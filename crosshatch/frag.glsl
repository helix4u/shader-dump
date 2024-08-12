#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114));

    // Further increase scale for even finer hatch densities
    float scale = 1200.0; // Increase this value to make the lines finer and denser

    // First set of lines (45-degree angle)
    float line1 = step(0.5, fract((uv.x + uv.y) * scale));

    // Second set of lines (-45-degree angle)
    float line2 = step(0.5, fract((uv.x - uv.y) * scale));

    // Combine the lines to simulate different hatching densities
    float hatchPattern = mix(1.0, line1, smoothstep(0.6, 0.8, grayscale));
    hatchPattern = min(hatchPattern, mix(hatchPattern, line2, smoothstep(0.4, 0.6, grayscale)));

    // Blend the pattern with the grayscale value to create the final effect
    fragColor = vec4(vec3(hatchPattern * grayscale), 1.0);
}
