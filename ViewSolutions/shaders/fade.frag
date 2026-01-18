#version 440
layout(location = 0) in vec2 coord;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    vec2 leftRightFadeStart;
    vec2 leftRightFadeEnd;
};
layout(binding = 1) uniform sampler2D src;

void main() {
    vec4 tex = texture(src, coord);

    float leftFade = smoothstep(leftRightFadeEnd.x, leftRightFadeStart.x, coord.x);

    float rightFade = smoothstep(leftRightFadeEnd.y, leftRightFadeStart.y, 1.0 - coord.x);

    float alpha = leftFade * rightFade;

    fragColor = tex * qt_Opacity * alpha;
}
