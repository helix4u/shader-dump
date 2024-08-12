#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;
    vec3 bloom = vec3(0.0);

    // Sample surrounding pixels
    bloom += texture(texture0, uv + vec2(0.005, 0.0)).rgb;
    bloom += texture(texture0, uv + vec2(-0.005, 0.0)).rgb;
    bloom += texture(texture0, uv + vec2(0.0, 0.005)).rgb;
    bloom += texture(texture0, uv + vec2(0.0, -0.005)).rgb;

    // Combine with original color
    bloom = max(bloom - color, vec3(0.0));
    color += bloom * 0.3; // Adjust bloom intensity

    // Clamp color values to ensure they are within the 0.0 to 1.0 range
    color = clamp(color, 0.0, 1.0);

    fragColor = vec4(color, 1.0);
}
