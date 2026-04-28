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


    float topFadePx;
    float bottomFadePx;

    float topFadePaddingPx;
    float bottomFadePaddingPx;

    float widthSource;
    float heightSource;
};
layout(binding = 1) uniform sampler2D source;

void main() {
    vec4 tex = texture(source, coord);

    float leftFade = max(0.0, min(1.0, (widthSource * coord.x - leftFadePaddingPx) / leftFadePx));

    float rightFade = max(0.0, min(1.0, (widthSource * (1 - coord.x) - rightFadePaddingPx) / rightFadePx));

    float topFade = max(0.0, min(1.0, (heightSource *  (coord.y)  - topFadePaddingPx) / topFadePx));

    float bottomFade = max(0.0, min(1.0, (heightSource * (1 - coord.y) - bottomFadePaddingPx) / bottomFadePx));

    float alpha = 1;

    if (widthSource > 0) {
        alpha *= leftFade * rightFade;
    }

    if (heightSource > 0) {
        alpha *= topFade * bottomFade;
    }

    fragColor = tex * alpha * qt_Opacity ;
}
