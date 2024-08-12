#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

vec3 rainbow(float value) {
    float x = fract(value * 6.0); // Fractional part for interpolation
    vec3 color;

    if (value < 1.0 / 6.0) {
        color = mix(vec3(1.0, 0.0, 0.0), vec3(1.0, 1.0, 0.0), x); // Red to Yellow
    } else if (value < 2.0 / 6.0) {
        color = mix(vec3(1.0, 1.0, 0.0), vec3(0.0, 1.0, 0.0), x); // Yellow to Green
    } else if (value < 3.0 / 6.0) {
        color = mix(vec3(0.0, 1.0, 0.0), vec3(0.0, 1.0, 1.0), x); // Green to Cyan
    } else if (value < 4.0 / 6.0) {
        color = mix(vec3(0.0, 1.0, 1.0), vec3(0.0, 0.0, 1.0), x); // Cyan to Blue
    } else if (value < 5.0 / 6.0) {
        color = mix(vec3(0.0, 0.0, 1.0), vec3(1.0, 0.0, 1.0), x); // Blue to Magenta
    } else {
        color = mix(vec3(1.0, 0.0, 1.0), vec3(1.0, 0.0, 0.0), x); // Magenta to Red
    }

    return color;
}

void main() {
    vec3 baseColor = texture(texture0, uv).rgb;

    // Apply a rainbow gradient effect based on the vertical position
    vec3 gradient = rainbow(uv.y);

    // Blend the base image with the rainbow gradient
    fragColor = vec4(mix(baseColor, gradient, 0.5), 1.0); // Adjust the mix value for more or less gradient effect
}
