#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 uSize;
    float radiusPx;
    float edgePx;
    float intensity;
    float sharpness;
    vec2 lightDir;
} ubuf;

float roundedRectSdf(vec2 p, vec2 size, float r) {
    vec2 halfSize = size * 0.5;
    vec2 q = abs(p - halfSize) - (halfSize - vec2(r));
    return length(max(q, vec2(0.0))) + min(max(q.x, q.y), 0.0) - r;
}

void main() {
    vec2 uv = qt_TexCoord0;
    vec2 p = uv * ubuf.uSize;
    float r = clamp(ubuf.radiusPx, 0.0, min(ubuf.uSize.x, ubuf.uSize.y) * 0.5);

    float sdf = roundedRectSdf(p, ubuf.uSize, r);
    float edgeDist = -sdf;
    if (edgeDist <= 0.0) {
        fragColor = vec4(0.0);
        return;
    }

    float widthPx = max(0.5, ubuf.edgePx);
    float edge = 1.0 - smoothstep(0.0, widthPx, edgeDist);

    float sdfX1 = roundedRectSdf(p + vec2(1.0, 0.0), ubuf.uSize, r);
    float sdfX0 = roundedRectSdf(p - vec2(1.0, 0.0), ubuf.uSize, r);
    float sdfY1 = roundedRectSdf(p + vec2(0.0, 1.0), ubuf.uSize, r);
    float sdfY0 = roundedRectSdf(p - vec2(0.0, 1.0), ubuf.uSize, r);
    vec2 grad = vec2(sdfX1 - sdfX0, sdfY1 - sdfY0);
    vec2 n = normalize((-grad) + vec2(1e-6));
    vec2 L = normalize(ubuf.lightDir);

    float ndotl = max(dot(n, -L), 0.0);
    float backNdotL = max(dot(n, L), 0.0);
    float s = clamp(ubuf.sharpness, 0.0, 1.0);
    float broad = pow(ndotl, mix(1.2, 4.5, s));
    float spec = pow(ndotl, mix(3.0, 16.0, s));
    float backSpec = pow(backNdotL, mix(2.0, 8.0, s));

    // Keep a faint continuous rim, with directional emphasis and a weak back lobe.
    float rimBase = 0.20;
    float alpha = edge * (rimBase + (0.40 * broad) + (0.55 * spec) + (0.12 * backSpec)) * ubuf.intensity;
    alpha = clamp(alpha, 0.0, 1.0);

    vec3 col = vec3(0.95, 0.98, 1.0);
    fragColor = vec4(col * alpha, alpha) * ubuf.qt_Opacity;
}
