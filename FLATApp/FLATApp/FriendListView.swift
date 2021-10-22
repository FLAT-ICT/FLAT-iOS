//
//  FriendListView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/13.
//

import SwiftUI

struct User: Identifiable {//ローカルデータ
    var id: String //ID
    var name: String //名前
    var status: String //ステータス
    var beacon: String //場所
    var icon_path: String //アイコン
}

struct FriendListView: View { //友達一覧画面
    @State private var show: Bool = false
    @State private var selection = 0
    @State private var isError: Bool = false
    let Nofriends = [ //未承認友だちのデータ
        User(id: "000001", name: "user01", status: "0", beacon: "595教室", icon_path: "Image_icon"),
        User(id: "000002", name: "user02", status: "0", beacon: "595教室", icon_path: "Image_icon"),
        User(id: "000003", name: "user03", status: "0", beacon: "595教室", icon_path: "Image_icon"),
        User(id: "000004", name: "user04", status: "0", beacon: "595教室", icon_path: "Image_icon"),
        User(id: "000005", name: "user05", status: "0", beacon: "595教室", icon_path: "Image_icon")
       
    ]
    let Yesfriends = [ //承認済み友だちのデータ
    User(id: "000006", name: "user06", status: "0", beacon: "595教室", icon_path: "Image_icon"),
    User(id: "000007", name: "user07", status: "0", beacon: "595教室", icon_path: "Image_icon"),
    User(id: "000008", name: "user08", status: "0", beacon: "595教室", icon_path: "Image_icon"),
    User(id: "000009", name: "user09", status: "0", beacon: "595教室", icon_path: "Image_icon"),
    User(id: "000010", name: "user10", status: "0", beacon: "595教室", icon_path: "Image_icon")
    ]
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
                        
                        VStack{
                        Button(action:{
                            self.isError = true
                        }){
                            Image(systemName: "multiply")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .frame(width: 50, height: 50)
                                .background(Color(red: 0.913, green: 0.286, blue: 0.286))
                                .clipShape(Circle())
                        }.alert(isPresented: $isError, content: {
                            Alert(title: Text("本当に拒否しますか？"), message: Text("この操作は戻せません。"),
                                  primaryButton: .destructive(Text("拒否"), action: {}),
                                  secondaryButton: .cancel(Text("キャンセル"), action: {}))
                        })
                        }
                        
                        VStack{
                        Button(action:{}){ //承認ボタン
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .frame(width: 50, height: 50)
                                .background(Color(red: 0.29, green: 0.91, blue: 0.27))
                                .clipShape(Circle())
                        }
                    }
                    }
                }
            } header: {
                Text("未承認の友だち")
                    .frame(width: UIScreen.main.bounds.width,height: 28, alignment: .leading)
                    .background(Color(red: 0.2, green: 0.85, blue: 0.721))
                    .foregroundColor(Color.white)
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
                    .frame(width: UIScreen.main.bounds.width,height: 28, alignment: .leading)
                    .background(Color(red: 0.2, green: 0.85, blue: 0.721))
                    .foregroundColor(Color.white)
            }
        }.listStyle(InsetListStyle())
        VStack{
            Spacer()
        HStack{
            Spacer()
                .frame(width: 320,height: 107)
        Button(action: { self.show = true /*またはself.show.toggle() */ }) {
           Image(systemName: "person.badge.plus")
                        .foregroundColor(.white)
                        .font(.system(size: 40))
                        .frame(width: 72, height: 72)
                        .background(Color(red: 0.2, green: 0.85, blue: 0.721))
                        .cornerRadius(72.0)
        }
        .fullScreenCover(isPresented: self.$show) {
            IDsearchView(isActive: $show)
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
