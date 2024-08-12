#version 330

uniform sampler2D texture0; // The base texture
uniform vec3 lightDir; // The direction of the light
in vec2 uv;
out vec4 fragColor;

void main() {
    // Generate a pseudo-height map from the grayscale value of the base texture
    vec3 color = texture(texture0, uv).rgb;
    float height = dot(color, vec3(0.299, 0.587, 0.114)); // Convert color to grayscale

    // Enhance the contrast of the height map
    height = pow(height, 2.0); // Increase contrast by squaring the height value

    // Calculate the bump normal from the height map
    vec3 bumpNormal = normalize(vec3(dFdx(height), dFdy(height), 1.0));

    // Calculate the light intensity based on the bump normal and light direction
    float lightIntensity = max(dot(bumpNormal, normalize(lightDir)), 0.5); // Increased base light intensity

    // Modulate the original color with the light intensity
    color *= lightIntensity;

    fragColor = vec4(color, 1.0);
}
