#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

const float offset = 1.0 / 300.0; // change depending on the image size

void main() {
    vec3 color = vec3(0.0);
    float gx = 0.0;
    float gy = 0.0;

    float sobel_x[9] = float[](-1, 0, 1, -2, 0, 2, -1, 0, 1);
    float sobel_y[9] = float[](1, 2, 1, 0, 0, 0, -1, -2, -1);

    vec2 offsetArr[9] = vec2[](
        vec2(-offset, offset), vec2(0.0, offset), vec2(offset, offset),
        vec2(-offset, 0.0), vec2(0.0, 0.0), vec2(offset, 0.0),
        vec2(-offset, -offset), vec2(0.0, -offset), vec2(offset, -offset)
    );

    for(int i = 0; i < 9; i++) {
        color = texture(texture0, uv + offsetArr[i]).rgb;
        gx += color.r * sobel_x[i];
        gy += color.r * sobel_y[i];
    }

    float g = sqrt(gx * gx + gy * gy);
    fragColor = vec4(vec3(g), 1.0);
}
