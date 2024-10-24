import QtQuick
import QtQuick.Controls.Material
import QtQuick.Dialogs
import QtQuick.Layouts

Window {
    id: app
    width: 640
    height: 480
    visible: true
    title: qsTr("MobileNet Image Classification")
    color: "#243642"

    ColumnLayout {
        anchors.fill: parent
        Layout.alignment: Qt.AlignCenter

        Button {
            text: "Pick Image"
            Layout.preferredWidth: 200
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignCenter
            onClicked: fileDialog.open()
            Material.background: "#387478"
            Material.foreground: "#E2F1E7"
        }

        Rectangle {
            id: rect
            property bool showImage: false
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: app.width / 1.5
            Layout.preferredHeight: app.height / 1.5
            color: "#F2EED7"
            border.color: "black"
            radius: 15
            Image {
                visible: rect.showImage
                id: selectedImage
                anchors.fill: parent
                source: ""
                fillMode: Image.Stretch
            }
            Text {
                visible: !rect.showImage
                text: "Choose an image for anlysis"
                anchors.centerIn: rect
                color: "#A04747"
                font.pixelSize: 18
            }
        }

        FileDialog {
            id: fileDialog
            title: "Select an Image"
            nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp *.gif)"]
            onAccepted: {
                selectedImage.source = fileDialog.selectedFile
                rect.showImage = true
                AiModel.loadImage(fileDialog.selectedFile)
                AiModel.predict()
            }
            onRejected: {
                console.log("Image selection was canceled")
            }
        }

        Rectangle {
            id: status
            Layout.preferredWidth: app.width
            height: 50
            color: "#F2E5BF"
            Layout.alignment: Qt.AlignBottom
            RowLayout {
                anchors.fill: parent
                Text {
                    text: "Label:  " + AiModel.label
                    Layout.alignment: Qt.AlignCenter
                    font.pixelSize: 16
                    color: "#243642"
                }
                Text {
                    text: "Confidence:  " + AiModel.confidence
                    Layout.alignment: Qt.AlignCenter
                    font.pixelSize: 16
                    color: "#243642"
                }
            }
        }
    }
}
