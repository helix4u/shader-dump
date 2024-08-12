#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

void main() {
    float amount = 0.005; // amount of aberration
    vec2 redUV = uv + vec2(amount, amount);
    vec2 greenUV = uv;
    vec2 blueUV = uv - vec2(amount, amount);

    float red = texture(texture0, redUV).r;
    float green = texture(texture0, greenUV).g;
    float blue = texture(texture0, blueUV).b;

    fragColor = vec4(red, green, blue, 1.0);
}
