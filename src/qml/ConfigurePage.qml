import QtQuick 2.0

import Controller 1.0
import QtQuick.Controls 1.1

Page {
    id: root
    page: Controller.ConfigurePage

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (_controller.tagEditStatus !== Controller.TagEditStatusNone)
                _controller.editTag("")

            // Don't collapse
            mouse.accepted = false
        }

        Component {
            id: mobileTabBarComponent
            Item {
                anchors.fill: parent
                MobileTabView {
                    anchors.fill: parent
                    selectedIndex: 1
                    anchors.horizontalCenter: parent.horizontalCenter
                    model: ListModel { // TODO: ListElement doesn't accept qsTr
                        ListElement { text: "General" ; source: "config/General.qml"}
                        ListElement { text: "Tags"    ; source: "config/Tags.qml" }
                        ListElement { text: "WebDAV"  ; source: "config/WebDavSync.qml";}
                        ListElement { text: "Hacking" ; source: "config/Hacking.qml";}

                        Component.onCompleted: {
                            if (!_controller.hackingMenuSupported) {
                                remove(3)
                            }

                            if (!_storage.webDAVSyncSupported) {
                                remove(2)
                            }
                        }
                    }
                }
            }
        }

        Component {
            id: desktopTabBarComponent
            TabView {
                frameVisible: false
                currentIndex: _controller.configureTabIndex
                anchors.fill: parent

                Tab {
                    title: qsTr("General")
                    source: "config/General.qml"
                }

                Tab {
                    title: qsTr("Tags")
                    source: "config/Tags.qml"
                }

                Tab {
                    title: qsTr("Plugins")
                    source: "config/Plugins.qml"
                }

                Repeater {
                    // Apparently the only way to hide a tab is through a repeater hack
                    model: _storage.webDAVSyncSupported ? 1 : 0
                    Tab {
                        title: qsTr("WebDAV")
                        source: "config/WebDavSync.qml"
                    }
                }

                Repeater {
                    model: _controller.hackingMenuSupported ? 1 : 0
                    Tab {
                        title: qsTr("Hacking")
                        source: "config/Hacking.qml"
                    }
                }
            }
        }

        Item {
            id: tabView
            anchors.top: parent.top
            anchors.topMargin: _style.marginMedium
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: _style.marginSmall
            anchors.bottom: okButton.top

            Loader {
                anchors.fill: parent
                sourceComponent: _controller.isMobile ? mobileTabBarComponent
                                                      : desktopTabBarComponent
            }
        }

        PushButton {
            id: okButton
            objectName: "configurePageOKButton"
            text: qsTr("OK")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: _style.marginMedium

            onClicked: {
                _controller.currentPage = Controller.MainPage
            }
        }
    }
}
