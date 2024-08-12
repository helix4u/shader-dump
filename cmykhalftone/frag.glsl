#version 330

uniform sampler2D texture0;
uniform vec2 texture_size;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec3 color = texture(texture0, uv).rgb;

    // Convert RGB to CMYK
    float K = 1.0 - max(max(color.r, color.g), color.b);
    float C = (1.0 - color.r - K) / (1.0 - K);
    float M = (1.0 - color.g - K) / (1.0 - K);
    float Y = (1.0 - color.b - K) / (1.0 - K);

    // Halftone dot sizes for CMYK
    float dotSizeC = mod(gl_FragCoord.x + gl_FragCoord.y, 10.0) / 10.0;
    float dotSizeM = mod(gl_FragCoord.x - gl_FragCoord.y, 10.0) / 10.0;
    float dotSizeY = mod(gl_FragCoord.x + gl_FragCoord.y * 2.0, 10.0) / 10.0;
    float dotSizeK = mod(gl_FragCoord.x * 2.0 - gl_FragCoord.y, 10.0) / 10.0;

    // Apply halftoning by comparing with the dot size
    float finalC = (C > dotSizeC) ? 1.0 : 0.0;
    float finalM = (M > dotSizeM) ? 1.0 : 0.0;
    float finalY = (Y > dotSizeY) ? 1.0 : 0.0;
    float finalK = (K > dotSizeK) ? 1.0 : 0.0;

    // Combine CMYK channels back to RGB
    vec3 finalColor = vec3(1.0 - finalC, 1.0 - finalM, 1.0 - finalY) * (1.0 - finalK);

    fragColor = vec4(finalColor, 1.0);
}
