#version 440
layout(location = 0) in vec2 coord;
layout(location = 0) out vec4 fragColor;
layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    float leftFadePx;
    float rightFadePx;

    float leftFadePaddingPx;
    float rightFadePaddingPx;

    float widthSource;
};
layout(binding = 1) uniform sampler2D source;

void main() {
    vec4 tex = texture(source, coord);

    float leftFade = max(0.0, min(1.0, (widthSource * coord.x - leftFadePaddingPx) / leftFadePx));

    float rightFade = max(0.0, min(1.0, (widthSource * (1 - coord.x) - rightFadePaddingPx) / rightFadePx));

    float alpha = leftFade * rightFade;

    fragColor = tex * alpha * qt_Opacity ;
}
