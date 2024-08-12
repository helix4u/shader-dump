#version 330

uniform sampler2D texture0;
uniform float time; // Pass the time variable for dynamic ripple movement
in vec2 uv;
out vec4 fragColor;

void main() {
    vec2 rippleCenter = vec2(0.5, 0.5); // Center of the ripple
    float frequency = 30.0; // Ripple frequency
    float amplitude = 0.02; // Ripple amplitude
    float speed = 3.0; // Ripple speed

    // Calculate distance from the center
    float distance = length(uv - rippleCenter);

    // Calculate the ripple effect
    float ripple = sin(distance * frequency - time * speed) * amplitude;

    // Displace the UV coordinates with the ripple effect
    vec2 rippleUV = uv + normalize(uv - rippleCenter) * ripple;

    // Sample the texture with the displaced UV coordinates
    vec3 color = texture(texture0, rippleUV).rgb;

    fragColor = vec4(color, 1.0);
}
