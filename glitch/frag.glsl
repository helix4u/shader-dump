#version 330

uniform sampler2D texture0;
uniform float time;
in vec2 uv;
out vec4 fragColor;

void main() {
    vec2 glitchUV = uv;

    // Introduce a stronger and more noticeable glitch offset
    if (mod(gl_FragCoord.y + time * 10.0, 20.0) < 2.0) {
        glitchUV.x += sin(time * 50.0 + gl_FragCoord.y) * 0.1; // Increase frequency and amplitude
    }
    
    // Add a second layer of glitch to make it more pronounced
    if (mod(gl_FragCoord.x + time * 20.0, 30.0) < 2.0) {
        glitchUV.y += cos(time * 50.0 + gl_FragCoord.x) * 0.1; // Horizontal glitch effect
    }

    vec3 color = texture(texture0, glitchUV).rgb;

    fragColor = vec4(color, 1.0);
}
