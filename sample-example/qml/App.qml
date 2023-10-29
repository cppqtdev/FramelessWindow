import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import FluentUI 1.0

Item {
    id: app
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
        FluApp.init(app)
        FluTheme.darkMode = true
        FluTheme.enableAnimation = true
        FluApp.routes = {
            "/":"qrc:/example/qml/window/StandardWindow.qml",
        }
        FluApp.initialRoute = "/"
        FluApp.httpInterceptor = interceptor
        FluApp.run()
    }
}
