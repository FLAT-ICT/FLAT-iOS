//
//  ContentView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI

struct ContentView: View{ //メイン画面
    init(){
        UITabBar.appearance().backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    }
    @State private var selection = 0
    @State var isLoggedIn: Bool = true;
    //    @ObservedObject var timerHolder = TimerHolder()
    var BluetoothScan = Bluetooth()
    
    var body: some View {
        if (isLoggedIn) {
            TabView(selection: $selection){
                PlaceView()
                    .tabItem {
                        Image(systemName: "mappin.and.ellipse")
                    }
                    .tag(0)
                FriendListView()
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(1)
                StatusView(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "face.smiling")
                    }
                    .tag(2)
            }
        }
        else {
            StartupView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
