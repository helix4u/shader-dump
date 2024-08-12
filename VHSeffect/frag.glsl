#version 330

uniform sampler2D texture0;
uniform float time;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec2 uvOffset = uv;
    float noise = fract(sin(dot(uv * time, vec2(12.9898, 78.233))) * 43758.5453);
    uvOffset.y += noise * 0.02; // Simulate scanline distortion

    vec3 color = texture(texture0, uvOffset).rgb;

    // Color separation
    float offset = 0.005 * noise;
    float rChannel = texture(texture0, uvOffset + vec2(offset, 0.0)).r;
    float gChannel = texture(texture0, uvOffset).g;
    float bChannel = texture(texture0, uvOffset - vec2(offset, 0.0)).b;

    color = vec3(rChannel, gChannel, bChannel);

    // Add some horizontal noise lines
    if (mod(gl_FragCoord.y, 20.0) < 1.0) {
        color *= 0.7;
    }

    // Add random noise for a VHS-like grain
    float grain = fract(sin(dot(uv + time, vec2(12.9898, 78.233))) * 43758.5453);
    color += vec3(grain) * 0.05;

    fragColor = vec4(color, 1.0);
}
