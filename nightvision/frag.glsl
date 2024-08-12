#version 330

uniform sampler2D texture0; // The base texture
uniform float time; // Time for animating the noise effect
in vec2 uv;
out vec4 fragColor;

void main() {
    // Sample the base texture and convert it to grayscale
    vec3 color = texture(texture0, uv).rgb;
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114));

    // Apply a green tint
    vec3 nightVisionColor = vec3(0.1, 1.0, 0.1) * grayscale;

    // Add some random noise for the night vision effect
    float noise = fract(sin(dot(uv.xy * time, vec2(12.9898, 78.233))) * 43758.5453);
    nightVisionColor += noise * 0.1;

    // Enhance contrast and brightness
    nightVisionColor = pow(nightVisionColor, vec3(1.5)); // Increase contrast
    nightVisionColor += 0.1; // Increase brightness

    fragColor = vec4(nightVisionColor, 1.0);
}
