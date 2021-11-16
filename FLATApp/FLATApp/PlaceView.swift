//
//  PlaceView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/13.
//

import SwiftUI

struct PlaceView: View { //位置画面
    @State var tmp = ""
    @State var idBeacon = IdAndBeacon(user_id: 1, major: 0, minor: 1, rssi: 1)
    var body: some View {
        // test用なので後で消す。裏で動かしたい。
        VStack(){
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button("post test"){
                sendBeacon(beacon: self.idBeacon, success: {
                    (msg: [String:String]) in self.tmp = msg["message"] ?? "no message"
                }
                ) { (error) in print(error)}
            }
            Text(self.tmp)
        }
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView()
    }
}

