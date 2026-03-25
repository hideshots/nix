import QtQuick 2.15

Rectangle {
    id: root

    property string userName: ""
    property string displayText: ""
    property string fontFamily: "Apple Color Emoji"
    property color textColor: "#ffffff"
    property color startColor: "#929292"
    property color endColor: "#4d4d4d"

    radius: width / 2
    antialiasing: true

    readonly property string label: {
        const text = String(root.displayText || "").trim();

        if (text.length) {
            return text;
        }

        return "👤";
    }

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: root.startColor
        }
        GradientStop {
            position: 1.0
            color: root.endColor
        }
    }

    Text {
        anchors.centerIn: parent
        text: root.label
        color: root.textColor
        font.pixelSize: Math.round(Math.min(root.width, root.height) * 0.6)
        font.family: root.fontFamily
    }
}
