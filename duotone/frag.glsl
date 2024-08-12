#version 330

uniform sampler2D texture0; // The input image
in vec2 uv;                 // The UV coordinates
out vec4 fragColor;         // The output color

// Define the two colors for the duotone effect
uniform vec3 darkColor = vec3(0.1, 0.1, 0.4); // Dark tones (e.g., dark blue)
uniform vec3 lightColor = vec3(1.0, 0.8, 0.6); // Light tones (e.g., light peach)

void main() {
    // Sample the color from the texture
    vec3 color = texture(texture0, uv).rgb;
    
    // Convert the color to grayscale using luminance
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114));
    
    // Interpolate between darkColor and lightColor based on the grayscale value
    vec3 duotone = mix(darkColor, lightColor, grayscale);
    
    // Set the output color
    fragColor = vec4(duotone, 1.0);
}
