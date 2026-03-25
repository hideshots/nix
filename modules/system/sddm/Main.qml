pragma ComponentBehavior: Bound

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "components"

Item {
    id: root

    width: parent ? parent.width : (Screen.width > 0 ? Screen.width : 1920)
    height: parent ? parent.height : (Screen.height > 0 ? Screen.height : 1080)
    focus: true

    // SDDM injects these objects into the root context at runtime.
    // qmllint disable unqualified
    readonly property var themeConfig: config
    // qmllint disable unqualified
    readonly property var sessionModelProxy: sessionModel
    // qmllint disable unqualified
    readonly property var userModelProxy: userModel
    // qmllint disable unqualified
    readonly property var greeter: sddm

    readonly property string sharedWallpaperPath: root.themeConfig && root.themeConfig.BackgroundImage ? String(root.themeConfig.BackgroundImage).trim() : "/var/tmp/sddm-wallpaper.png"
    readonly property int inactivityMs: 30000
    readonly property int fadeMs: 820

    property bool uiVisible: false

    // Clock liquid-glass controls.
    property real clockRefraction: 8.0
    property real clockDepth: 0.2
    property real clockDispersion: 1.0
    property real clockFrost: 0.0
    property real clockSplay: 2.5
    property real clockSplayDepth: 30.0
    property real clockRimWidth: 195.0
    property real clockRimStrength: 9.0
    property real clockBodyDepth: 64.0
    property real clockBodyExponent: 0.75
    property real clockBodyStrength: 0.25
    property real clockMagnifyStrength: -0.1
    property real clockVibrance: 0.8
    property real clockLightAngleDeg: 320.0
    property real clockLightStrength: 3.0
    property real clockLightWidthPx: 2.0
    property real clockLightSharpness: 0.25
    property real clockLightSoftnessPx: 2.0
    property real clockBodyRefractionWidthPx: 0.0
    property real clockCornerBoost: 0.0
    property real clockDispersionLimit: 0.35
    property real clockDispersionWidthPx: 10.0
    property real clockDispersionCurve: 0.9
    property real clockGlassOpacity: 0.42
    property color clockGlassTint: Qt.rgba(1, 1, 1, 1.0)
    property real clockBlurSize: 1.0
    property real clockBlurPasses: 3

    property real inputRefraction: 0.0
    property real inputDepth: 0.0
    property real inputDispersion: 0.0
    property real inputFrost: 0.0
    property real inputSplay: 0.0
    property real inputSplayDepth: 18.0
    property real inputRimWidth: 18.0
    property real inputRimStrength: 1.0
    property real inputBodyDepth: 64.0
    property real inputBodyExponent: 0.75
    property real inputBodyStrength: 0.25
    property real inputMagnifyStrength: 0.03
    property real inputVibrance: 0.0
    property real inputLightAngleDeg: 335.0
    property real inputLightStrength: 1.0
    property real inputLightWidthPx: 14.0
    property real inputLightSharpness: 0.45
    property real inputBodyRefractionWidthPx: 28.0
    property real inputCornerBoost: 0.55
    property real inputDispersionLimit: 0.35
    property real inputDispersionWidthPx: 10.0
    property real inputDispersionCurve: 0.7
    property real inputGlassOpacity: 1.0
    property color inputGlassTint: Qt.rgba(0.92, 0.97, 1.0, 0.0)
    property real inputBlurSize: 2.0
    property real inputBlurPasses: 2

    property int selectedSessionIndex: root.initialSessionIndex()
    property string selectedUserName: root.userModelProxy && root.userModelProxy.lastUser ? root.userModelProxy.lastUser : ""

    property date now: new Date()

    QtObject {
        id: theme

        readonly property color white: "#ffffff"
        readonly property color background: root.themeConfig && root.themeConfig.Background ? root.themeConfig.Background : "#101218"
        readonly property color panel: Qt.lighter(background, 1.6)
        readonly property color accent: root.themeConfig && root.themeConfig.Accent ? root.themeConfig.Accent : "#0088ff"
        readonly property real scale: Math.max(0.82, Math.min(root.width / 1920, root.height / 1080))

        readonly property int topMargin: Math.round(96 * scale)
        readonly property int corner: Math.max(10, Math.round(13 * scale))
        readonly property int loginBottomMargin: Math.round(108 * scale)
        readonly property int loginWidth: Math.round(198 * scale)
        readonly property int avatarSize: Math.round(52 * scale)
        readonly property int passwordWidth: Math.round(160 * scale)
        readonly property int passwordHeight: Math.round(28 * scale)

        readonly property string fontUI: "SF Pro Display"
        readonly property string fontEmoji: "Apple Color Emoji"
    }

    function initialSessionIndex() {
        if (root.sessionModelProxy && root.sessionModelProxy.lastIndex >= 0) {
            return root.sessionModelProxy.lastIndex;
        }

        return 0;
    }

    function userNameAt(index) {
        const userEntry = userNameRepeater.itemAt(index);
        // qmllint disable missing-property
        return (userEntry && userEntry["name"]) ? userEntry["name"] : "";
    }

    function findUserIndex(userName) {
        if (!userName) {
            return -1;
        }

        for (let i = 0; i < userNameRepeater.count; ++i) {
            if (root.userNameAt(i) === userName) {
                return i;
            }
        }

        return -1;
    }

    function ensureValidUserSelection() {
        if (root.findUserIndex(root.selectedUserName) >= 0) {
            return;
        }

        root.selectedUserName = root.userNameAt(0);
    }

    function emojiForUser(u) {
        if (u === "drama")
            return "🦅";
        if (u === "root")
            return "🛠️";
        return "👤";
    }

    function closePopups() {
        if (sessionPicker.visible) {
            sessionPicker.close();
        }

        if (userPicker.visible) {
            userPicker.close();
        }
    }

    function bumpActivity(focusPassword) {
        root.uiVisible = true;
        idleTimer.restart();

        if (focusPassword === true) {
            Qt.callLater(function () {
                loginPanel.focusPassword();
            });
        }
    }

    function handleRevealKey(event) {
        const pressedText = String(event.text || "");
        const hasShortcutModifier = Boolean(event.modifiers & (Qt.ControlModifier | Qt.AltModifier | Qt.MetaModifier));
        const isPrintableText = pressedText.length > 0 && pressedText.charCodeAt(0) >= 0x20;

        root.bumpActivity(true);

        if (!hasShortcutModifier && isPrintableText) {
            loginPanel.appendPasswordText(pressedText);
        }

        event.accepted = true;
    }

    function submitLogin() {
        if (!root.greeter || !root.selectedUserName) {
            return;
        }

        loginPanel.clearStatus();
        root.greeter.login(root.selectedUserName, loginPanel.passwordText, root.selectedSessionIndex);
    }

    Connections {
        target: root.greeter

        function onLoginSucceeded() {
            root.bumpActivity(false);
            loginPanel.showStatus(qsTr("Logging in..."), theme.accent);
        }

        function onLoginFailed() {
            loginPanel.clearPassword();
            loginPanel.showStatus(qsTr("Login failed"), "#ffb0a8");
            root.bumpActivity(true);
        }

        function onInformationMessage(message) {
            const statusMessage = String(message || "").trim();

            if (!statusMessage.length) {
                return;
            }

            loginPanel.showStatus(statusMessage, "#ffb0a8");
            root.bumpActivity(true);
        }
    }

    Component.onCompleted: Qt.callLater(root.ensureValidUserSelection)

    Item {
        visible: false
        width: 0
        height: 0

        Repeater {
            id: userNameRepeater
            model: root.userModelProxy
            onItemAdded: root.ensureValidUserSelection()
            onItemRemoved: root.ensureValidUserSelection()

            delegate: Item {
                required property string name
                visible: false
                width: 0
                height: 0
            }
        }
    }

    BackgroundStage {
        id: backgroundLayer
        anchors.fill: parent
        z: -10
        backgroundColor: theme.background
        wallpaperSource: root.sharedWallpaperPath
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        onPositionChanged: root.bumpActivity(false)
    }

    TapHandler {
        enabled: !root.uiVisible
        onTapped: root.bumpActivity(true)
    }

    Keys.onPressed: function(event) {
        if (!root.uiVisible) {
            root.handleRevealKey(event);
            return;
        }

        root.bumpActivity(false);
    }

    Timer {
        id: idleTimer
        interval: root.inactivityMs
        repeat: false
        running: true

        onTriggered: {
            root.uiVisible = false;
            root.closePopups();
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.now = new Date()
    }

    ClockStage {
        id: dateTimeBox
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        z: 50

        now: root.now
        backgroundSource: backgroundLayer
        topMargin: theme.topMargin
        textColor: theme.white
        timeFontFamily: theme.fontUI
        dateFontFamily: theme.fontUI
        refraction: root.clockRefraction
        depth: root.clockDepth
        dispersion: root.clockDispersion
        frost: root.clockFrost
        splay: root.clockSplay
        splayDepth: root.clockSplayDepth
        rimWidth: root.clockRimWidth
        rimStrength: root.clockRimStrength
        bodyDepth: root.clockBodyDepth
        bodyExponent: root.clockBodyExponent
        bodyStrength: root.clockBodyStrength
        magnifyStrength: root.clockMagnifyStrength
        vibrance: root.clockVibrance
        lightAngleDeg: root.clockLightAngleDeg
        lightStrength: root.clockLightStrength
        lightWidthPx: root.clockLightWidthPx
        lightSharpness: root.clockLightSharpness
        lightSoftnessPx: root.clockLightSoftnessPx
        bodyRefractionWidthPx: root.clockBodyRefractionWidthPx
        cornerBoost: root.clockCornerBoost
        dispersionLimit: root.clockDispersionLimit
        dispersionWidthPx: root.clockDispersionWidthPx
        dispersionCurve: root.clockDispersionCurve
        glassOpacity: root.clockGlassOpacity
        tint: root.clockGlassTint
        blurSize: root.clockBlurSize
        blurPasses: root.clockBlurPasses
    }

    FocusScope {
        id: chrome
        anchors.fill: parent
        z: 49

        opacity: root.uiVisible ? 1.0 : 0.0
        visible: opacity > 0.01
        enabled: visible

        Behavior on opacity {
            NumberAnimation {
                duration: root.fadeMs
                easing.type: Easing.OutCubic
            }
        }

        ComboBox {
            id: sessionSelect
            visible: false
            model: root.sessionModelProxy
            textRole: "name"
            currentIndex: root.selectedSessionIndex
            onCurrentIndexChanged: root.selectedSessionIndex = currentIndex
        }

        Item {
            id: sessionButton
            width: 28
            height: 28
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 15
            anchors.rightMargin: 15
            z: 50

            Text {
                anchors.centerIn: parent
                text: "􀣌"
                color: theme.white
                opacity: 0.7
                font.pixelSize: 14
                font.family: theme.fontUI
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    root.bumpActivity(true);
                    sessionPicker.toggle();
                }
            }
        }

        LoginPanel {
            id: loginPanel
            visible: !userPicker.visible
            width: theme.loginWidth
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: theme.loginBottomMargin
            z: 50

            backgroundSource: backgroundLayer
            userName: root.selectedUserName
            avatarText: root.emojiForUser(root.selectedUserName)
            fontFamily: theme.fontUI
            avatarFontFamily: theme.fontEmoji
            textColor: theme.white
            avatarSize: theme.avatarSize
            passwordWidth: theme.passwordWidth
            passwordHeight: theme.passwordHeight
            refraction: root.inputRefraction
            depth: root.inputDepth
            dispersion: root.inputDispersion
            frost: root.inputFrost
            splay: root.inputSplay
            splayDepth: root.inputSplayDepth
            rimWidth: root.inputRimWidth
            rimStrength: root.inputRimStrength
            bodyDepth: root.inputBodyDepth
            bodyExponent: root.inputBodyExponent
            bodyStrength: root.inputBodyStrength
            magnifyStrength: root.inputMagnifyStrength
            vibrance: root.inputVibrance
            lightAngleDeg: root.inputLightAngleDeg
            lightStrength: root.inputLightStrength
            lightWidthPx: root.inputLightWidthPx
            lightSharpness: root.inputLightSharpness
            bodyRefractionWidthPx: root.inputBodyRefractionWidthPx
            cornerBoost: root.inputCornerBoost
            dispersionLimit: root.inputDispersionLimit
            dispersionWidthPx: root.inputDispersionWidthPx
            dispersionCurve: root.inputDispersionCurve
            glassOpacity: root.inputGlassOpacity
            tint: root.inputGlassTint
            blurSize: root.inputBlurSize
            blurPasses: root.inputBlurPasses
            timeSeconds: root.now.getTime() / 1000.0

            onActivityRequested: root.bumpActivity(focusPassword)
            onPasswordSubmitted: root.submitLogin()
            onUserPickerRequested: userPicker.openAt(anchorItem)
        }
    }

    Popup {
        id: sessionPicker
        parent: Overlay.overlay ? Overlay.overlay : root
        z: 100
        padding: 0
        modal: false
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        function reposition() {
            const point = sessionButton.mapToItem(sessionPicker.parent, 0, 0);
            let popupWidth = sessionPicker.implicitWidth;

            if (popupWidth <= 0 && sessionPicker.contentItem) {
                popupWidth = sessionPicker.contentItem.implicitWidth;
            }

            if (popupWidth <= 0) {
                popupWidth = 200;
            }

            const gap = 15;
            const desiredX = (point.x + sessionButton.width - popupWidth) - gap;
            const maxX = sessionPicker.parent.width - popupWidth;

            sessionPicker.x = Math.round(Math.max(0, Math.min(maxX, desiredX)));
            sessionPicker.y = Math.round(point.y + sessionButton.height + 8);
        }

        function toggle() {
            root.bumpActivity(false);

            if (!chrome.visible) {
                return;
            }

            if (sessionPicker.visible) {
                sessionPicker.close();
            } else {
                sessionPicker.open();
            }
        }

        onOpened: reposition()
        onWidthChanged: if (visible)
            reposition()
        onImplicitWidthChanged: if (visible)
            reposition()

        background: Rectangle {
            radius: theme.corner
            color: theme.panel
            opacity: 0.85
        }

        contentItem: Item {
            implicitWidth: sessionListView.implicitWidth + 24
            implicitHeight: sessionListView.contentHeight + 10

            ListView {
                id: sessionListView
                x: 12
                y: 5
                width: implicitWidth
                height: contentHeight
                interactive: false
                model: root.sessionModelProxy

                property real implicitWidth: Math.max(95, Math.min(320, maxTextWidth + 24))
                property real maxTextWidth: 0

                delegate: Item {
                    id: sessionDelegate

                    required property int index
                    required property string name

                    width: sessionListView.implicitWidth
                    height: 24

                    Component.onCompleted: sessionListView.maxTextWidth = Math.max(sessionListView.maxTextWidth, sessionLabel.implicitWidth)

                    Rectangle {
                        x: -7
                        y: 0
                        width: parent.width + 14
                        height: parent.height
                        radius: 8
                        color: theme.accent
                        visible: hoverArea.containsMouse
                    }

                    Text {
                        id: sessionLabel
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        anchors.right: parent.right
                        anchors.rightMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        text: sessionDelegate.name
                        color: theme.white
                        font.pixelSize: 13
                        font.family: theme.fontUI
                        font.weight: Font.Medium
                    }

                    MouseArea {
                        id: hoverArea
                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            root.bumpActivity(true);
                            root.selectedSessionIndex = sessionDelegate.index;
                            sessionSelect.currentIndex = sessionDelegate.index;
                            sessionPicker.close();
                        }
                    }
                }
            }
        }
    }

    Popup {
        id: userPicker
        parent: Overlay.overlay ? Overlay.overlay : root
        z: 100
        padding: 10
        modal: false
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

        property Item anchorItem: null

        function openAt(item) {
            anchorItem = item;
            open();
        }

        function reposition() {
            if (!anchorItem) {
                return;
            }

            const point = anchorItem.mapToItem(userPicker.parent, 0, 0);
            const desiredX = point.x + (anchorItem.width - userPicker.width) / 2;
            const aboveY = point.y - userPicker.height - 10;
            const belowY = point.y + anchorItem.height + 10;
            const desiredY = aboveY >= 0 ? aboveY : belowY;

            userPicker.x = Math.round(Math.max(0, Math.min(userPicker.parent.width - userPicker.width, desiredX)));
            userPicker.y = Math.round(Math.max(0, Math.min(userPicker.parent.height - userPicker.height, desiredY)));
        }

        onOpened: {
            root.bumpActivity(false);
            reposition();
        }
        onWidthChanged: if (visible)
            reposition()
        onHeightChanged: if (visible)
            reposition()

        background: Rectangle {
            radius: theme.corner
            color: theme.panel
            opacity: 0.85
        }

        contentItem: ListView {
            id: userListView
            spacing: 13
            interactive: contentHeight > height
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            model: root.userModelProxy

            implicitWidth: 260
            implicitHeight: Math.min(260, contentHeight)

            ScrollIndicator.vertical: ScrollIndicator {}

            delegate: Item {
                id: userDelegate

                required property string name

                width: userListView.width
                height: theme.avatarSize

                Rectangle {
                    anchors.fill: parent
                    radius: theme.corner
                    color: theme.accent
                    opacity: userHoverArea.containsMouse ? 0.32 : 0.0
                }

                Row {
                    anchors.fill: parent
                    spacing: 11

                    UserAvatar {
                        width: theme.avatarSize
                        height: theme.avatarSize
                        displayText: root.emojiForUser(userDelegate.name)
                        fontFamily: theme.fontEmoji
                        textColor: theme.white
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        width: userListView.width - theme.avatarSize - 11
                        text: userDelegate.name
                        font.pixelSize: 15
                        font.family: theme.fontUI
                        font.weight: Font.Bold
                        font.letterSpacing: -0.90
                        color: theme.white
                        wrapMode: Text.NoWrap
                        elide: Text.ElideRight
                    }
                }

                MouseArea {
                    id: userHoverArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        root.bumpActivity(true);
                        root.selectedUserName = userDelegate.name;
                        loginPanel.clearPassword();
                        loginPanel.clearStatus();
                        userPicker.close();
                    }
                }
            }
        }
    }
}
