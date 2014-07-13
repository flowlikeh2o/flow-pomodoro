import QtQuick 2.1
import QtQuick.Controls 1.0

import Controller 1.0

ModalDialog {
    enabled: _controller.taskBeingEdited !== null && _controller.editMode === Controller.EditModeEditor
    dialogHeight: _style.taskEditorHeight

    content:
    Item {
        anchors.fill: parent

        Text {
            id: titleText
            font.pointSize: _style.taskEditorFontSize
            color: _style.regularTextColor
            anchors.top: parent.top
            anchors.topMargin: _style.marginMedium
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Edit Task")
        }

        Grid {
            anchors.top: titleText.bottom
            anchors.topMargin: _style.marginMedium

            anchors.horizontalCenter: parent.horizontalCenter

            columns: 2
            rows: 3
            rowSpacing: 4
            horizontalItemAlignment: Grid.AlignRight
            columnSpacing: 4

            Text {
                text: qsTr("Summary:")
            }

            TaskTextField {
                id: textField
                objectName: "Task editor text field"
                width: descriptionTextArea.width
            }

            Text {
                text: qsTr("Description:")
            }

            TextArea {
                id: descriptionTextArea
                objectName: "Task editor text area"
                focus: false
                height: 100
                text: _controller.taskBeingEdited !== null ? _controller.taskBeingEdited.description : ""
                Binding {
                    // two way binding
                    target: _controller.taskBeingEdited
                    when: visible && _controller.taskBeingEdited !== null
                    property: "description"
                    value: descriptionTextArea.text
                }
            }

            Text {
                text: qsTr("Tags:")
            }

            Item {
                id: tagItem
                width: descriptionTextArea.width
                height: 70

                Flow {
                    id: flow
                    anchors.fill: parent
                    anchors.leftMargin: 3
                    Repeater {
                        model: _controller.taskBeingEdited === null ? 0 : _controller.taskBeingEdited.tagModel
                        Text {
                            property bool last: model !== null && _controller.taskBeingEdited.tagModel.count === index + 1
                            text: tag.name + (last ? "" : ", ")
                            color: "black"
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }

        Button {
            id: buttonCancel
            text: qsTr("OK")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: _style.dialogButtonsMargin
            onClicked: {
                _controller.editTask(-1, Controller.EditModeNone)
            }
        }
    }
}
