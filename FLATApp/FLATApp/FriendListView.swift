//
//  FriendListView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/13.
//

import SwiftUI

struct FriendListView: View { //友達一覧画面
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
          // VStack{
                //HStack{
                    //Text("未承認の友だち")
                       // .underline(true, color: .green)
                   // Spacer()
               // }
               // List(data){ item in
                 //   NoFriendsDataView(data1: item)
                    
                //}
                //.listStyle(PlainListStyle())
                
               // HStack{
                 //   Text("友だち一覧")
                   //     .underline(true, color: .green)
                    //Spacer()
                //}
                //List(data2){ item in
                  //  YesFriendsDataView(data2: item)
                    
               // }
                //.listStyle(PlainListStyle())
           // }
            
            Button(action: { self.show = true /*またはself.show.toggle() */ }) {
               
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "person.badge.plus")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .frame(width: 60, height: 60)
                            .background(Color(red: 0.2, green: 0.85, blue: 0.721))
                            .cornerRadius(72.0)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 107.0, trailing: 24.0))
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
