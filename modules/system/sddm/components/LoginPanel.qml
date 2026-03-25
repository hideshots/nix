import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    property Item backgroundSource: null
    property string userName: ""
    property string avatarText: "👤"
    property string fontFamily: "SF Pro Display"
    property string avatarFontFamily: "Apple Color Emoji"
    property color textColor: "#ffffff"

    property int avatarSize: 52
    property int passwordWidth: 160
    property int passwordHeight: 28

    property real refraction: 0.0
    property real depth: 0.0
    property real dispersion: 0.0
    property real frost: 0.0
    property real splay: 0.0
    property real splayDepth: 18.0
    property real rimWidth: 18.0
    property real rimStrength: 1.0
    property real bodyDepth: 64.0
    property real bodyExponent: 0.75
    property real bodyStrength: 0.25
    property real magnifyStrength: 0.03
    property real vibrance: 0.0
    property real lightAngleDeg: 335.0
    property real lightStrength: 1.0
    property real lightWidthPx: 14.0
    property real lightSharpness: 0.45
    property real bodyRefractionWidthPx: 28.0
    property real cornerBoost: 0.55
    property real dispersionLimit: 0.35
    property real dispersionWidthPx: 10.0
    property real dispersionCurve: 0.7
    property real glassOpacity: 1.0
    property color tint: Qt.rgba(0.92, 0.97, 1.0, 0.0)
    property real blurSize: 2.0
    property real blurPasses: 2
    property real timeSeconds: 0.0
    property string statusText: ""
    property color statusColor: root.textColor

    signal activityRequested(bool focusPassword)
    signal passwordSubmitted
    signal userPickerRequested(Item anchorItem)

    property alias passwordText: passwordField.text

    width: avatarSize + 24
    height: loginColumn.implicitHeight

    function clearPassword() {
        passwordField.text = "";
    }

    function focusPassword() {
        passwordField.forceActiveFocus();
    }

    function clearStatus() {
        root.statusText = "";
        root.statusColor = root.textColor;
    }

    function showStatus(message, color) {
        root.statusText = String(message || "").trim();
        root.statusColor = color || root.textColor;
    }

    function appendPasswordText(text) {
        const typedText = String(text || "");

        if (!typedText.length) {
            return;
        }

        root.clearStatus();
        passwordField.text += typedText;
        passwordField.cursorPosition = passwordField.text.length;
        root.focusPassword();
    }

    function lightDirFromDeg(deg) {
        const radians = deg * Math.PI / 180.0;
        return Qt.vector2d(Math.sin(radians), -Math.cos(radians));
    }

    Column {
        id: loginColumn
        width: parent.width
        spacing: 10

        Item {
            width: parent.width
            height: root.avatarSize

            UserAvatar {
                id: avatar
                width: root.avatarSize
                height: root.avatarSize
                anchors.horizontalCenter: parent.horizontalCenter
                displayText: root.avatarText
                fontFamily: root.avatarFontFamily
                textColor: root.textColor
            }

            MouseArea {
                anchors.fill: avatar
                onClicked: {
                    root.activityRequested(false);
                    root.userPickerRequested(avatar);
                }
            }
        }

        Text {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: root.userName
            color: root.textColor
            font.pixelSize: 15
            font.family: root.fontFamily
            font.weight: Font.Bold
            font.letterSpacing: -0.90
            wrapMode: Text.NoWrap
            elide: Text.ElideRight
        }

        TextField {
            id: passwordField
            width: root.passwordWidth
            height: root.passwordHeight
            anchors.horizontalCenter: parent.horizontalCenter

            echoMode: TextInput.Password
            color: root.textColor
            font.pixelSize: 13
            font.family: root.fontFamily
            font.weight: Font.Bold

            leftPadding: 14
            rightPadding: 14

            placeholderText: "Enter Password"
            placeholderTextColor: Qt.rgba(1, 1, 1, 0.45)

            background: Item {
                id: passwordGlassBackground

                readonly property int texW: Math.max(1, Math.round(passwordField.width))
                readonly property int texH: Math.max(1, Math.round(passwordField.height))
                readonly property real sampleX: root.x + passwordField.x
                readonly property real sampleY: root.y + passwordField.y

                ShaderEffectSource {
                    id: inputCapture
                    sourceItem: root.backgroundSource
                    hideSource: false
                    live: true
                    smooth: true
                    mipmap: false
                    sourceRect: Qt.rect(passwordGlassBackground.sampleX, passwordGlassBackground.sampleY, passwordField.width, passwordField.height)
                    textureSize: Qt.size(passwordGlassBackground.texW, passwordGlassBackground.texH)
                }

                Rectangle {
                    id: inputMaskRect
                    visible: false
                    width: passwordField.width
                    height: passwordField.height
                    radius: height / 2
                    antialiasing: true
                    color: "#ffffff"
                }

                ShaderEffectSource {
                    id: inputMaskSource
                    sourceItem: inputMaskRect
                    hideSource: true
                    live: true
                    smooth: true
                    mipmap: false
                    textureSize: Qt.size(passwordGlassBackground.texW, passwordGlassBackground.texH)
                }

                LiquidGlassEffect {
                    anchors.fill: parent

                    sourceTexture: inputCapture
                    maskTexture: inputMaskSource
                    blurPasses: root.blurPasses
                    blurSize: root.blurSize
                    frost: root.frost
                    radius: height / 2
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
                    time: root.timeSeconds
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
                    anchors.fill: parent

                    property vector2d uSize: Qt.vector2d(width, height)
                    property real radiusPx: height * 0.5
                    property real edgePx: Math.max(0.8, root.lightWidthPx * 0.18)
                    property real intensity: Math.max(0.05, root.lightStrength * 0.32)
                    property real sharpness: root.lightSharpness
                    property vector2d lightDir: root.lightDirFromDeg(root.lightAngleDeg)

                    fragmentShader: Qt.resolvedUrl("../shaders/input_edge_light.frag.qsb")
                }
            }

            Keys.onReturnPressed: root.passwordSubmitted()
            Keys.onEnterPressed: root.passwordSubmitted()

            onTextEdited: {
                root.clearStatus();
                root.activityRequested(false);
            }
        }

        Text {
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: root.statusText.length ? root.statusText : "Your password is required to\nlog in"
            opacity: root.statusText.length ? 0.9 : 0.45
            color: root.statusText.length ? root.statusColor : root.textColor
            font.pixelSize: 13
            font.family: root.fontFamily
            font.weight: Font.Bold
            font.letterSpacing: -0.65
            wrapMode: Text.WordWrap
        }
    }
}
