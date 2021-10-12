//
//  FriendListView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/13.
//

import SwiftUI

struct FriendListView: View {
    @State private var show: Bool = false
    @State private var selection = 0
    var body: some View {
        VStack{
            VStack{
                HStack{
                    Text("友達が誰もいないようです。下のボタンから追加しましょう。")
                }
                .padding(.leading,24.0)
                .padding(.trailing,24.0)
            }
            .padding(.top,107)
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
        }
    }
    
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
    }
}
