//#
//# Copyright (C) 2025-2026 QuasarApp.
//# Distributed under the GPLv3 software license, see the accompanying
//# Everyone is permitted to copy and distribute verbatim copies
//# of this license document, but changing it is not allowed.
//#


#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;

    float progress;
    float lineWidth;
    vec4 color;
    vec4 backgroundColor;
    float width;
    float height;
};

const float PI = 3.14159265359;

void main() {
    vec2 size = vec2(width, height);
    float minDim = min(size.x, size.y);

    vec2 p = (qt_TexCoord0 - vec2(0.5)) * size / minDim;

    float w = lineWidth / minDim;
    float rMid = 0.5 - w * 0.5;
    float hT = w * 0.5;

    float r = length(p);

    float dBg = abs(r - rMid) - hT;

    float theta = atan(p.x, -p.y);
    if (theta < 0.0) {
        theta += 2.0 * PI;
    }

    float alpha = clamp(progress, 0.0, 1.0) * 2.0 * PI;

    float dArc = 1e5;

    if (progress > 0.0) {
        if (progress >= 1.0) {
            dArc = abs(r - rMid) - hT;
        } else {
            if (theta >= 0.0 && theta <= alpha) {
                dArc = abs(r - rMid) - hT;
            }

            vec2 p0 = vec2(0.0, -rMid);
            vec2 p1 = vec2(rMid * sin(alpha), -rMid * cos(alpha));

            float dCap0 = length(p - p0) - hT;
            float dCap1 = length(p - p1) - hT;

            dArc = min(dArc, min(dCap0, dCap1));
        }
    }

    float aa = max(fwidth(r), 1.0 / minDim);

    float alphaBg = 1.0 - smoothstep(-aa, aa, dBg);
    float alphaFg = 1.0 - smoothstep(-aa, aa, dArc);

    vec4 cBg = backgroundColor * alphaBg;
    vec4 cFg = color * alphaFg;

    vec4 finalColor = cFg + cBg * (1.0 - cFg.a);

    fragColor = finalColor * qt_Opacity;
}