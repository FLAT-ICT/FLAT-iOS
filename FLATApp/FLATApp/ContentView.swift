//
//  ContentView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI

struct ContentView: View{ //メイン画面
    @State private var show: Bool = false
    var body: some View {
        TabView{
            
            Button(action: { self.show = true /*またはself.show.toggle() */ }) {
                ZStack{
                    Circle()
                        .frame(width: 75.0)
                        .foregroundColor(Color(red: 0.2, green: 0.85, blue: 0.721))
                    Image(systemName: "person.badge.plus")
                        .resizable()
                        .frame(width: 50.0, height: 50.0, alignment: .leading)
                        .foregroundColor(.white)
                    
                }
                .position(x: 276, y: 425)
            }
            .sheet(isPresented: self.$show) {
                IDsearchView()
            }
            .tabItem {
                Image(systemName: "person")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
