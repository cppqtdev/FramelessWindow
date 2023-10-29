//import QtQuick 2.15
//import QtQuick.Window 2.15
//import QtQuick.Controls 2.15
//import QtQuick.Layouts 1.15
//import FluentUI 1.0

//FluWindow {
//    id:app
//    title:"Hello Window"
//    width: 640
//    height: 480
//    fixSize: false
//    launchMode: FluWindowType.Standard
//    function changeDark(){
//        if(FluTheme.dark){
//            FluTheme.darkMode = FluThemeType.Light
//        }else{
//            FluTheme.darkMode = FluThemeType.Dark
//        }
//    }


//    FluMenuBar {
//        FluMenu {
//            title: qsTr("File")
//            Action { text: qsTr("New...") }
//            Action { text: qsTr("Open...") }
//            Action { text: qsTr("Save") }
//            Action { text: qsTr("Save As...") }
//            FluMenuSeparator { }
//            Action { text: qsTr("Dark");onTriggered: changeDark()}
//            Action { text: qsTr("Quit") }
//        }
//        FluMenu {
//            title: qsTr("Edit")
//            Action { text: qsTr("Cut") }
//            Action { text: qsTr("Copy") }
//            Action { text: qsTr("Paste") }
//        }
//        FluMenu {
//            title: qsTr("Help")
//            Action { text: qsTr("About")}
//        }
//    }

//    FluText{
//        anchors.centerIn: parent
//        text:"I am a Standard mode window, and I will create a new window every time"
//    }

//}


import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentUI 1.0

Item {
    id: app

    Connections{
        target: FluTheme
        function onDarkModeChanged(){
            SettingsHelper.saveDarkMode(FluTheme.darkMode)
        }
    }

    Connections{
        target: FluApp
        function onVsyncChanged(){
            SettingsHelper.saveVsync(FluApp.vsync)
        }
    }

    FluHttpInterceptor{
        id:interceptor
        function onIntercept(request){
            if(request.method === "get"){
                request.params["method"] = "get"
            }
            if(request.method === "post"){
                request.params["method"] = "post"
            }
            request.headers["token"] ="yyds"
            request.headers["os"] ="pc"
            console.debug(JSON.stringify(request))
            return request
        }
    }

    Component.onCompleted: {
        FluApp.httpInterceptor = interceptor
    }
}
