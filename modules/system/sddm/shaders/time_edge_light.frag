#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float edgePx;
    float intensity;
    float sharpness;
    float softnessPx;
    vec2 invSize;
    vec2 lightDir;
} ubuf;

layout(binding = 1) uniform sampler2D maskSource;

float a(vec2 uv) {
    vec2 clampedUv = clamp(uv, vec2(0.001), vec2(0.999));
    return texture(maskSource, clampedUv).a;
}

float softenedAlpha(vec2 uv, vec2 blurStep) {
    if (blurStep.x <= 0.0 && blurStep.y <= 0.0) {
        return a(uv);
    }

    float sum = a(uv) * 4.0;
    sum += a(uv + vec2( blurStep.x,  0.0)) * 2.0;
    sum += a(uv + vec2(-blurStep.x,  0.0)) * 2.0;
    sum += a(uv + vec2(0.0,  blurStep.y)) * 2.0;
    sum += a(uv + vec2(0.0, -blurStep.y)) * 2.0;
    sum += a(uv + vec2( blurStep.x,  blurStep.y));
    sum += a(uv + vec2(-blurStep.x,  blurStep.y));
    sum += a(uv + vec2( blurStep.x, -blurStep.y));
    sum += a(uv + vec2(-blurStep.x, -blurStep.y));

    return sum / 16.0;
}

void main() {
    vec2 uv = qt_TexCoord0;
    float s = clamp(ubuf.sharpness, 0.0, 1.0);
    vec2 blurStep = ubuf.invSize * max(0.0, ubuf.softnessPx);

    vec2 d = ubuf.invSize * (ubuf.edgePx * mix(1.75, 1.0, s));

    float c  = softenedAlpha(uv, blurStep);
    float l  = softenedAlpha(uv + vec2(-d.x,  0.0), blurStep);
    float r  = softenedAlpha(uv + vec2( d.x,  0.0), blurStep);
    float t  = softenedAlpha(uv + vec2( 0.0, -d.y), blurStep);
    float b  = softenedAlpha(uv + vec2( 0.0,  d.y), blurStep);
    float tl = softenedAlpha(uv + vec2(-d.x, -d.y), blurStep);
    float tr = softenedAlpha(uv + vec2( d.x, -d.y), blurStep);
    float bl = softenedAlpha(uv + vec2(-d.x,  d.y), blurStep);
    float br = softenedAlpha(uv + vec2( d.x,  d.y), blurStep);

    vec2 grad = vec2(
        (tr + (2.0 * r) + br) - (tl + (2.0 * l) + bl),
        (bl + (2.0 * b) + br) - (tl + (2.0 * t) + tr)
    );
    float g = length(grad);

    float inside = smoothstep(0.02, 0.15, c);
    float edge = smoothstep(0.12, 1.05, g) * inside;

    vec2 n = normalize(grad + vec2(1e-6));
    vec2 L = normalize(ubuf.lightDir);

    float ndotl = clamp(dot(n, -L), 0.0, 1.0);

    float broad = pow(ndotl, mix(1.8, 5.5, s));
    float spec = pow(ndotl, mix(4.0, 12.0, s));
    float alpha = edge * ((0.58 * broad) + (0.42 * spec)) * ubuf.intensity;

    vec3 col = vec3(0.95, 0.98, 1.00);
    fragColor = vec4(col * alpha, alpha) * ubuf.qt_Opacity;
}
