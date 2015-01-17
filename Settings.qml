import QtQuick 2.3

QtObject {
    id: root;

    property string qqNumber: MySettings.getValue("qq_number", "");
    onQqNumberChanged: MySettings.setValue("qq_number", qqNumber);

    property string qqPassword: MySettings.getValue("qq_password", "");
    onQqPasswordChanged: MySettings.setValue("qq_password", qqPassword);

    property string tail: MySettings.getValue("tail", qsTr("From AnyQQTail"));
    onTailChanged: MySettings.setValue("tail", tail);
}
