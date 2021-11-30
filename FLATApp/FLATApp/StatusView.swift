//
//  IconView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/13.
//

import SwiftUI

struct StatusView: View { // アイコン画面 ??? ステータス画面
    @AppStorage("name") var name = "name"
    @AppStorage("id") var id = 0
    @AppStorage("spot") var spot = "name"
    @AppStorage("loggedinAt") var loggedinAt = "name"
    @AppStorage("ifFirstVisit") var isFirstVisit = false
    @AppStorage("iconPath") var iconPath = ""
    @State var visible: Bool = false
    var body: some View {
        if visible {
            StartupView()
        }else{
            
            VStack{
                IconLoaderView(size: 160, withUrl: iconPath)
                Text("your name is \(self.name)")
                Text("your id is \(self.id)")
                Text("your spot is \(self.spot)")
                Text("your loggedinAt is \(self.loggedinAt)")
                Text("your isFirstVisit is \(self.isFirstVisit ? "True" : "False")")
                Button(action: {
                    // TODO: logout
                    logout(userId: UserId(id: self.id), success: {msg in
                        print(msg)
                        UserDefaults.standard.set(-1, forKey: "id")
                        UserDefaults.standard.set("", forKey: "name")
                        UserDefaults.standard.set("", forKey: "spot")
                        UserDefaults.standard.set(0, forKey: "status")
                        UserDefaults.standard.set("", forKey: "loggedinAt")
                        UserDefaults.standard.set(true, forKey: "isFirstVisit")
                        visible = true
                    }){(error) in
                        print(error)
                    }
                }){
                    Text("logout")
                }.buttonStyle(LabeledButtonStyle(type: .cancel))
            }
        }
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
