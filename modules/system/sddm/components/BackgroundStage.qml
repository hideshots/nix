import QtQuick 2.15

Item {
    id: root

    property color backgroundColor: "#101218"
    property string wallpaperSource: ""
    property real overlayOpacity: 0.16
    property real warpStrength: 0.2
    property real warpZoom: 1.09

    readonly property string requestedWallpaperSource: String(root.wallpaperSource || "").trim()
    readonly property bool wallpaperReady: root.requestedWallpaperSource.length > 0 && wallpaper.status === Image.Ready

    Rectangle {
        anchors.fill: parent
        color: root.wallpaperReady ? root.backgroundColor : "#000000"
    }

    Image {
        id: wallpaper
        anchors.fill: parent
        visible: root.wallpaperReady
        source: root.requestedWallpaperSource
        fillMode: Image.PreserveAspectCrop
        smooth: true
        cache: true
    }

    ShaderEffectSource {
        id: wallpaperSourceItem
        anchors.fill: parent
        sourceItem: root.wallpaperReady ? wallpaper : null
        live: true
        hideSource: true
    }

    ShaderEffect {
        anchors.fill: parent
        visible: root.wallpaperReady

        property variant source: wallpaperSourceItem
        property real strength: root.warpStrength
        property real zoom: root.warpZoom

        fragmentShader: Qt.resolvedUrl("../shaders/pincushion.frag.qsb")
    }

    Rectangle {
        anchors.fill: parent
        visible: !root.wallpaperReady
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Qt.rgba(1.0, 1.0, 1.0, 0.2)
            }
            GradientStop {
                position: 1.0
                color: Qt.rgba(1.0, 1.0, 1.0, 0.0)
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        visible: root.wallpaperReady
        color: root.backgroundColor
        opacity: root.overlayOpacity
    }
}
