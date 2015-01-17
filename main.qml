import QtQuick 2.3
import QtQuick.Controls 1.2
import "main.js" as Script

ApplicationWindow {
    visible: true;
    title: qsTr("Any QQ Tail");

    menuBar: MenuBar {
        /*Menu {
            title: qsTr("More")
            MenuItem {
                text: qsTr("About")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }*/
    }

    Settings {
        id: settings;
    }
    SignalCenter {
        id: signalCenter;
    }


    StackView {
        id: stackView;
        anchors.fill: parent;
        Rectangle {
            id: msgBox;
            color: "Black";
            opacity: 0.7;
            visible: false;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: parent.height * 0.2;
            width: msgText.width + 20;
            height: msgText.height + 20;
            onVisibleChanged: {
                if (visible == true) {
                    disappearTimer.start();
                }
            }
            Text {
                id: msgText;
                anchors.centerIn: parent;
                color: "White";
            }
            Timer {
                id: disappearTimer;
                repeat: false;
                interval: 5000;
                onTriggered: {
                    msgBox.visible = false;
                    running = false;
                }
            }
        }
        Column {
            anchors.centerIn: parent;
            width: parent.width * 0.8;
            //anchors.margins: parent.width * 0.1;
            spacing: 30;

            Text {
                text: qsTr("QQ number");
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            TextField {
                id: qqNumber;
                width: parent.width;
                inputMethodHints: Qt.ImhDigitsOnly;
            }
            Text {
                text: qsTr("QQ password");
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            TextField {
                id: qqPassword;
                width: parent.width;
                echoMode: TextInput.Password;
            }
            Text {
                text: qsTr("QQ mood content");
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            TextArea {
                id: content;
                width: parent.width;
                height: qqNumber.height * 3;
            }
            Text {
                text: qsTr("Tail");
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            TextField {
                id: tail;
                width: parent.width;
            }
            Button {
                id: post;
                width: parent.width;
                text: qsTr("Post");
                onClicked: {
                    enabled = false;
                    text = qsTr("Posting");
                    settings.qqNumber = qqNumber.text;
                    settings.qqPassword = qqPassword.text;
                    settings.tail = tail.text;
                    Script.cont = content.text;
                    Script.tail = tail.text;
                    Script.postShuoshuo(qqNumber.text, qqPassword.text);
                }
            }
            Text {
                text: qsTr("About");
                anchors.horizontalCenter: parent.horizontalCenter;
            }
            Text {
                text: qsTr("By : Perqin\nThank ZiXing for providing API.\nYou are able to send a Mood with custom Tail.\n");
                width: parent.width;
                wrapMode: Text.Wrap;
            }
        }
    }
    Connections {
        target: signalCenter;
        onPostSucceeded: {
            msgText.text = qsTr("Post succeeded!");
            msgBox.visible = true;
            post.enabled = true;
            post.text = qsTr("Post");
            content.text = "";
        }
        onPostFailed: {
            msgText.text = qsTr("Post failed. Please retry.");
            msgBox.visible = true;
            post.enabled = true;
            post.text = qsTr("Post");
        }
    }

    Component.onCompleted: {
        Script._signalCenter = signalCenter;
        qqNumber.text = settings.qqNumber;
        qqPassword.text = settings.qqPassword;
        tail.text = settings.tail;
    }
}
