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
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "person.badge.plus")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .frame(width: 60, height: 60)
                            .background(Color(red: 0.2, green: 0.85, blue: 0.721))
                            .cornerRadius(75.0)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 107.0, trailing: 24.0))
                    }
                }
                
            }
            .fullScreenCover(isPresented: self.$show) {
                IDsearchView(isActive: $show)
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
