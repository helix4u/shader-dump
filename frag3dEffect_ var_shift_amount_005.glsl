#version 330

uniform sampler2D texture0;  // Main image
uniform float shift_amount;  // Amount to shift the image to create the 3D effect

in vec2 uv;
out vec4 fragColor;

void main() {
    // Shift amount for left and right images
    vec2 left_shift = vec2(-shift_amount, 0.0);
    vec2 right_shift = vec2(shift_amount, 0.0);
    
    // Sample the texture for left and right eye images
    vec3 left_color = texture(texture0, uv + left_shift).rgb;
    vec3 right_color = texture(texture0, uv + right_shift).rgb;
    
    // Create anaglyph effect by combining channels
    float red = left_color.r;
    float green = right_color.g;
    float blue = right_color.b;
    
    fragColor = vec4(red, green, blue, 1.0);
}
