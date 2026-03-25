#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec4 uUvRect;
};

layout(binding = 1) uniform sampler2D source;

void main() {
    vec2 uv = uUvRect.xy + (qt_TexCoord0 * uUvRect.zw);
    vec2 clampedUv = clamp(uv, vec2(0.0), vec2(1.0));
    fragColor = texture(source, clampedUv) * qt_Opacity;
}
