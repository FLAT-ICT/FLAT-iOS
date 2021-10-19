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
        //VStack{
            //VStack{
                //HStack{
                   // Text("友達が誰もいないようです。下のボタンから追加しましょう。")
               // }
              //  .padding(.leading,24.0)
               // .padding(.trailing,24.0)
           // }
           // .padding(.top,107)
       
        ZStack{
        List{
            Section{
                ForEach(Nofriends) { nofriends in
                    HStack{
                        Image(nofriends.icon_path)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(nofriends.name)
                        Spacer()
                        Text(nofriends.beacon)
                    }
                }
            } header: {
                Text("未承認の友だち")
            }
            Section{
                ForEach(Yesfriends) { yesfriends in
                    HStack{
                    Image(yesfriends.icon_path)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text(yesfriends.name)
                    Spacer()
                    Text(yesfriends.beacon)
                   
                }
                }
            } header: {
                Text("友だち一覧")
            }
        }.listStyle(InsetListStyle())
        VStack{
            Spacer()
                .frame(height: 633)
        HStack{
            Spacer()
                .frame(width: 279)
        Button(action: { self.show = true /*またはself.show.toggle() */ }) {
           Image(systemName: "person.badge.plus")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .frame(width: 60, height: 60)
                        .background(Color(red: 0.2, green: 0.85, blue: 0.721))
                        .cornerRadius(72.0)
                        
            
            
        }
        .fullScreenCover(isPresented: self.$show) {
            //IDsearchView(isActive: $show)
        }
        }
        }
        }
    }
    
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
    }
}
