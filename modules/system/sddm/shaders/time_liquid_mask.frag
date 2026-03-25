#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
};

layout(binding = 1) uniform sampler2D sourceTex;
layout(binding = 2) uniform sampler2D maskTex;

void main() {
    vec4 sourceSample = texture(sourceTex, qt_TexCoord0);
    // sourceTex is already glyph-masked in liquid_glass.frag.
    // Reapplying mask alpha here causes dark edge artifacts on antialiased glyph boundaries.
    fragColor = sourceSample * qt_Opacity;
}
