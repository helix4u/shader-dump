#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;

    // Flattened Bayer matrix for dithering
    float bayer[16] = float[](
         0.0,  8.0,  2.0, 10.0,
        12.0,  4.0, 14.0,  6.0,
         3.0, 11.0,  1.0,  9.0,
        15.0,  7.0, 13.0,  5.0
    );

    // Get the pixel coordinates
    vec2 pixelCoord = uv * vec2(512.0, 512.0); // Adjust according to image size
    int x = int(mod(pixelCoord.x, 4.0));
    int y = int(mod(pixelCoord.y, 4.0));
    
    // Calculate the index for the flattened Bayer matrix
    int index = y * 4 + x;
    float threshold = bayer[index] / 16.0;

    // Apply dithering effect
    color = step(vec3(threshold), color);
    fragColor = vec4(color, 1.0);
}
