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
    @ObservedObject var timerHolder = TimerHolder()
    var BluetoothScan = Bluetooth()
    
    var body: some View {
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
            IconView()
                .tabItem {
                    Image(systemName: "face.smiling")
                }
                .tag(2)
        }.onAppear{//画面が表示された時
//            TimerHolder.environmentObject(TimerHolder)
            timerHolder.start()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
