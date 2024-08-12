#version 330

uniform sampler2D texture0;
uniform vec2 texture_size;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec2 sortedUV = uv;

    // Displace pixels based on their brightness
    vec3 color = texture(texture0, uv).rgb;
    float brightness = dot(color, vec3(0.2126, 0.7152, 0.0722)); // Grayscale brightness

    // Calculate the displacement, ensuring it stays within bounds
    sortedUV.x = clamp(sortedUV.x + brightness * 0.1, 0.0, 1.0);

    fragColor = texture(texture0, sortedUV);
}
