import QtQuick 2.15

Item {
    id: root

    property date now: new Date()
    property Item backgroundSource: null
    property color textColor: "#ffffff"
    property real topMargin: 96
    property string timeFontFamily: "SF Pro Display"
    property string dateFontFamily: "SF Pro Display"

    property real refraction: 8.0
    property real depth: 0.2
    property real dispersion: 1.0
    property real frost: 0.0
    property real splay: 2.5
    property real splayDepth: 30.0
    property real rimWidth: 195.0
    property real rimStrength: 9.0
    property real bodyDepth: 64.0
    property real bodyExponent: 0.75
    property real bodyStrength: 0.25
    property real magnifyStrength: -0.1
    property real vibrance: 0.8
    property real lightAngleDeg: 390.0
    property real lightStrength: 3.0
    property real lightWidthPx: 20.0
    property real lightSharpness: 0.25
    property real lightSoftnessPx: 1.35
    property real bodyRefractionWidthPx: 0.0
    property real cornerBoost: 0.0
    property real dispersionLimit: 0.35
    property real dispersionWidthPx: 10.0
    property real dispersionCurve: 0.9
    property real glassOpacity: 0.42
    property color tint: Qt.rgba(1, 1, 1, 1.0)
    property real blurSize: 1.0
    property real blurPasses: 3

    anchors.topMargin: root.topMargin
    width: Math.max(timeText.implicitWidth, dateText.implicitWidth)
    height: Math.max(timeText.y + timeText.implicitHeight, dateText.y + dateText.implicitHeight)

    function lightDirFromDeg(deg) {
        const radians = deg * Math.PI / 180.0;
        return Qt.vector2d(Math.sin(radians), -Math.cos(radians));
    }

    Text {
        id: dateText
        opacity: 0.52
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatDateTime(root.now, "ddd MMM d")
        color: root.textColor
        font.pixelSize: 32
        font.family: root.dateFontFamily
        font.weight: Font.DemiBold
        font.letterSpacing: -0.64
        wrapMode: Text.NoWrap
    }

    Text {
        id: timeText
        opacity: 0.0
        anchors.top: parent.top
        anchors.topMargin: 17
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatTime(root.now, "h:mm AP").split(" ")[0]
        color: root.textColor
        font.pixelSize: 150
        font.family: root.timeFontFamily
        font.weight: Font.Bold
        font.letterSpacing: -3.0
        wrapMode: Text.NoWrap
    }

    Item {
        id: timeGlassBounds
        anchors.fill: timeText
        z: timeText.z + 1

        readonly property real sampleX: root.x + x
        readonly property real sampleY: root.y + y
        readonly property real uvX: Math.max(0.0, Math.min(1.0, sampleX / Math.max(1.0, root.backgroundSource ? root.backgroundSource.width : root.width)))
        readonly property real uvY: Math.max(0.0, Math.min(1.0, sampleY / Math.max(1.0, root.backgroundSource ? root.backgroundSource.height : root.height)))
        readonly property real uvW: Math.max(1.0 / Math.max(1.0, root.backgroundSource ? root.backgroundSource.width : root.width), Math.min(1.0 - uvX, width / Math.max(1.0, root.backgroundSource ? root.backgroundSource.width : root.width)))
        readonly property real uvH: Math.max(1.0 / Math.max(1.0, root.backgroundSource ? root.backgroundSource.height : root.height), Math.min(1.0 - uvY, height / Math.max(1.0, root.backgroundSource ? root.backgroundSource.height : root.height)))
    }

    Text {
        id: timeMaskText
        visible: false
        anchors.fill: timeText
        text: timeText.text
        color: root.textColor
        font: timeText.font
        wrapMode: Text.NoWrap
    }

    ShaderEffectSource {
        id: timeMaskSource
        sourceItem: timeMaskText
        hideSource: true
        live: true
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(timeGlassBounds.width)), Math.max(1, Math.round(timeGlassBounds.height)))
    }

    ShaderEffectSource {
        id: timeGlassCapture
        sourceItem: root.backgroundSource
        hideSource: false
        live: true
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(root.backgroundSource ? root.backgroundSource.width : root.width)), Math.max(1, Math.round(root.backgroundSource ? root.backgroundSource.height : root.height)))
    }

    ShaderEffect {
        id: timeGlassCrop
        width: Math.max(1, Math.round(timeGlassBounds.width))
        height: Math.max(1, Math.round(timeGlassBounds.height))
        visible: false

        property variant source: timeGlassCapture
        property vector4d uUvRect: Qt.vector4d(timeGlassBounds.uvX, timeGlassBounds.uvY, timeGlassBounds.uvW, timeGlassBounds.uvH)

        fragmentShader: Qt.resolvedUrl("../shaders/time_crop_subrect.frag.qsb")
    }

    ShaderEffectSource {
        id: timeGlassCropSource
        sourceItem: timeGlassCrop
        hideSource: true
        live: true
        smooth: true
        mipmap: false
        textureSize: Qt.size(Math.max(1, Math.round(timeGlassBounds.width)), Math.max(1, Math.round(timeGlassBounds.height)))
    }

    LiquidGlassEffect {
        id: timeLiquidClock
        anchors.fill: timeGlassBounds
        z: timeText.z + 1

        sourceTexture: timeGlassCropSource
        maskTexture: timeMaskSource
        blurPasses: root.blurPasses
        blurSize: root.blurSize
        frost: root.frost
        radius: 2.0
        refraction: root.refraction
        depth: root.depth
        dispersion: root.dispersion
        splay: root.splay
        splayDepth: root.splayDepth
        rimWidth: root.rimWidth
        rimStrength: root.rimStrength
        bodyDepth: root.bodyDepth
        bodyExponent: root.bodyExponent
        bodyStrength: root.bodyStrength
        magnifyStrength: root.magnifyStrength
        vibrance: root.vibrance
        glassOpacity: root.glassOpacity
        tint: root.tint
        time: root.now.getTime() / 1000.0
        lightAngleDeg: root.lightAngleDeg
        lightStrength: root.lightStrength
        lightWidthPx: root.lightWidthPx
        lightSharpness: root.lightSharpness
        bodyRefractionWidthPx: root.bodyRefractionWidthPx
        cornerBoost: root.cornerBoost
        dispersionLimit: root.dispersionLimit
        dispersionWidthPx: root.dispersionWidthPx
        dispersionCurve: root.dispersionCurve
    }

    ShaderEffect {
        anchors.fill: timeGlassBounds
        z: timeLiquidClock.z + 1

        property variant maskSource: timeMaskSource
        property real edgePx: Math.max(0.4, root.lightWidthPx * 0.12)
        property real intensity: Math.max(0.05, root.lightStrength * 0.22)
        property real sharpness: root.lightSharpness
        property real softnessPx: root.lightSoftnessPx
        property vector2d invSize: Qt.vector2d(1.0 / Math.max(1, width), 1.0 / Math.max(1, height))
        property vector2d lightDir: root.lightDirFromDeg(root.lightAngleDeg)

        fragmentShader: Qt.resolvedUrl("../shaders/time_edge_light.frag.qsb")
    }
}
