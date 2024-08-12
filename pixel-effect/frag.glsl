#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec2 pixel_size = vec2(0.02, 0.02); // change the pixel size here
    vec2 coord = uv / pixel_size;
    coord = floor(coord) * pixel_size;
    vec3 color = texture(texture0, coord).rgb;
    fragColor = vec4(color, 1.0);
}
