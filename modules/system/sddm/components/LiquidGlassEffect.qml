import QtQuick 2.15

Item {
    id: root

    property variant sourceTexture
    property variant maskTexture

    property int blurPasses: 1
    property real blurSize: 1.0
    property real frost: 0.0

    property real radius: 0.0
    property real refraction: 0.0
    property real depth: 0.0
    property real dispersion: 0.0
    property real splay: 0.0
    property real splayDepth: 0.0
    property real rimWidth: 0.0
    property real rimStrength: 0.0
    property real bodyDepth: 0.0
    property real bodyExponent: 1.0
    property real bodyStrength: 0.0
    property real magnifyStrength: 0.0
    property real vibrance: 0.0
    property real glassOpacity: 1.0
    property color tint: Qt.rgba(1, 1, 1, 1.0)
    property real time: 0.0
    property real debug: 0.0
    property real debugView: 2.0
    property real lightAngleDeg: 0.0
    property real lightStrength: 1.0
    property real lightWidthPx: 10.0
    property real lightSharpness: 0.5
    property real bodyRefractionWidthPx: 0.0
    property real cornerBoost: 0.0
    property real dispersionLimit: 0.35
    property real dispersionWidthPx: 10.0
    property real dispersionCurve: 0.7

    readonly property vector2d texelSize: Qt.vector2d(1.0 / Math.max(1, root.width), 1.0 / Math.max(1, root.height))
    readonly property int effectiveBlurPasses: Math.max(1, Math.min(3, Math.round(root.blurPasses)))
    readonly property real blurBase: Math.max(0.001, root.blurSize) * (1.0 + root.frost * 0.8)
    readonly property variant blurredTexture: root.effectiveBlurPasses >= 3 ? blur3VSource : (root.effectiveBlurPasses >= 2 ? blur2VSource : blurVSource)

    ShaderEffect {
        id: blurH
        visible: false
        width: Math.max(1, Math.round(root.width))
        height: Math.max(1, Math.round(root.height))

        property variant source: root.sourceTexture
        property vector2d texelSize: root.texelSize
        property real blurStrength: root.blurBase * 1.0

        fragmentShader: Qt.resolvedUrl("../shaders/blur_h.frag.qsb")
    }

    ShaderEffectSource {
        id: blurHSource
        sourceItem: blurH
        hideSource: true
        live: true
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(root.width)), Math.max(1, Math.round(root.height)))
    }

    ShaderEffect {
        id: blurV
        visible: false
        width: Math.max(1, Math.round(root.width))
        height: Math.max(1, Math.round(root.height))

        property variant source: blurHSource
        property vector2d texelSize: root.texelSize
        property real blurStrength: root.blurBase * 1.0

        fragmentShader: Qt.resolvedUrl("../shaders/blur_v.frag.qsb")
    }

    ShaderEffectSource {
        id: blurVSource
        sourceItem: blurV
        hideSource: true
        live: true
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(root.width)), Math.max(1, Math.round(root.height)))
    }

    ShaderEffect {
        id: blur2H
        visible: false
        width: Math.max(1, Math.round(root.width))
        height: Math.max(1, Math.round(root.height))

        property variant source: blurVSource
        property vector2d texelSize: root.texelSize
        property real blurStrength: root.blurBase * 1.7

        fragmentShader: Qt.resolvedUrl("../shaders/blur_h.frag.qsb")
    }

    ShaderEffectSource {
        id: blur2HSource
        sourceItem: blur2H
        hideSource: true
        live: root.effectiveBlurPasses >= 2
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(root.width)), Math.max(1, Math.round(root.height)))
    }

    ShaderEffect {
        id: blur2V
        visible: false
        width: Math.max(1, Math.round(root.width))
        height: Math.max(1, Math.round(root.height))

        property variant source: blur2HSource
        property vector2d texelSize: root.texelSize
        property real blurStrength: root.blurBase * 1.7

        fragmentShader: Qt.resolvedUrl("../shaders/blur_v.frag.qsb")
    }

    ShaderEffectSource {
        id: blur2VSource
        sourceItem: blur2V
        hideSource: true
        live: root.effectiveBlurPasses >= 2
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(root.width)), Math.max(1, Math.round(root.height)))
    }

    ShaderEffect {
        id: blur3H
        visible: false
        width: Math.max(1, Math.round(root.width))
        height: Math.max(1, Math.round(root.height))

        property variant source: blur2VSource
        property vector2d texelSize: root.texelSize
        property real blurStrength: root.blurBase * 2.4

        fragmentShader: Qt.resolvedUrl("../shaders/blur_h.frag.qsb")
    }

    ShaderEffectSource {
        id: blur3HSource
        sourceItem: blur3H
        hideSource: true
        live: root.effectiveBlurPasses >= 3
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(root.width)), Math.max(1, Math.round(root.height)))
    }

    ShaderEffect {
        id: blur3V
        visible: false
        width: Math.max(1, Math.round(root.width))
        height: Math.max(1, Math.round(root.height))

        property variant source: blur3HSource
        property vector2d texelSize: root.texelSize
        property real blurStrength: root.blurBase * 2.4

        fragmentShader: Qt.resolvedUrl("../shaders/blur_v.frag.qsb")
    }

    ShaderEffectSource {
        id: blur3VSource
        sourceItem: blur3V
        hideSource: true
        live: root.effectiveBlurPasses >= 3
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(root.width)), Math.max(1, Math.round(root.height)))
    }

    ShaderEffect {
        anchors.fill: parent

        property variant sceneTex: root.blurredTexture
        property variant maskTex: root.maskTexture
        property vector2d uSize: Qt.vector2d(width, height)
        property vector4d uUvRect: Qt.vector4d(0.0, 0.0, 1.0, 1.0)
        property real uRadius: root.radius
        property real uRefraction: root.refraction
        property real uDepth: root.depth
        property real uDispersion: root.dispersion
        property real uFrost: root.frost
        property real uSplay: root.splay
        property real uSplayDepth: root.splayDepth
        property real uRimWidth: root.rimWidth
        property real uRimStrength: root.rimStrength
        property real uBodyDepth: root.bodyDepth
        property real uBodyExponent: root.bodyExponent
        property real uBodyStrength: root.bodyStrength
        property real uMagnifyStrength: root.magnifyStrength
        property real uVibrance: root.vibrance
        property real uGlassOpacity: root.glassOpacity
        property color uTint: root.tint
        property real uTime: root.time
        property real uDebug: root.debug
        property real uDebugView: root.debugView
        property real uLightAngleDeg: root.lightAngleDeg
        property real uLightStrength: root.lightStrength
        property real uLightWidthPx: root.lightWidthPx
        property real uLightSharpness: root.lightSharpness
        property real uBodyRefractionWidthPx: root.bodyRefractionWidthPx
        property real uCornerBoost: root.cornerBoost
        property real uDispersionLimit: root.dispersionLimit
        property real uDispersionWidthPx: root.dispersionWidthPx
        property real uDispersionCurve: root.dispersionCurve

        fragmentShader: Qt.resolvedUrl("../shaders/liquid_glass.frag.qsb")
    }
}
