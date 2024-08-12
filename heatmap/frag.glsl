#version 330

uniform sampler2D texture0;
in vec2 uv;
out vec4 fragColor;

vec3 heatmap(float value) {
    vec3 color = vec3(0.0);
    if (value < 0.2) {
        color = mix(vec3(0.0, 0.0, 1.0), vec3(0.0, 1.0, 1.0), value / 0.2);
    } else if (value < 0.4) {
        color = mix(vec3(0.0, 1.0, 1.0), vec3(0.0, 1.0, 0.0), (value - 0.2) / 0.2);
    } else if (value < 0.6) {
        color = mix(vec3(0.0, 1.0, 0.0), vec3(1.0, 1.0, 0.0), (value - 0.4) / 0.2);
    } else if (value < 0.8) {
        color = mix(vec3(1.0, 1.0, 0.0), vec3(1.0, 0.5, 0.0), (value - 0.6) / 0.2);
    } else {
        color = mix(vec3(1.0, 0.5, 0.0), vec3(1.0, 0.0, 0.0), (value - 0.8) / 0.2);
    }
    return color;
}

void main() {
    vec3 color = texture(texture0, uv).rgb;
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114));
    vec3 heatmapColor = heatmap(grayscale);
    fragColor = vec4(heatmapColor, 1.0);
}
