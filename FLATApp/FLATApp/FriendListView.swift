//
//  FriendListView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/13.
//

import SwiftUI

//struct User: Identifiable {//ローカルデータ
//    var id: String //ID
//    var name: String //名前
//    var status: String //ステータス
//    var beacon: String //場所
//    var icon_path: String //アイコン
//}

struct FriendListView: View { //友達一覧画面
    @State private var show: Bool = false
    @State private var selection = 0
    @State private var isError: Bool = false
    @State private var noFriends: [User] = []
    @State private var yesFriends: [User] = []
    @AppStorage("id") private var id = -1
    let tabsName = ["友だち", "未承認", "承認待ち"]
    
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
        //        VStack(spacing: 0){
        ZStack{
            if self.noFriends.count == 0 && self.yesFriends.count == 0 {
                Text("友達が一人もいないようです。下のボタンから追加しましょう！")
            }else{
                FriendTabsView(id: self.id, mutual: self.yesFriends, applied: self.noFriends, isOpen: self.$isError, requested: [])
            }
            SearchFriendButtonView(show: self.$show)
        }
        .onAppear(perform: {
            getFriends(id: self.id, success: { (friendlist: FriendList) in
                self.noFriends = friendlist.oneSide
                self.yesFriends = friendlist.mutual
            })
            {( error )in
                print("failure")
                print(error)
            }
        })
        //        }
    }
}

struct FriendTabsView: View {
    @State private var selectedTab = 0
    var id: Int
    var mutual: [User]
    var applied: [User]
    @Binding var isOpen: Bool
    var requested: [User]
    let tabsName = ["友だち", "未承認"]
    var body: some View {
        GeometryReader {geo in
            VStack(spacing: 0){
                Tabs(tabsName: tabsName, geoWidth: geo.size.width, selectedTab: $selectedTab)
                TabView(selection: $selectedTab, content: {
                    // 友だち
                    MutualFriendsView(mutual: mutual).tag(0)
                    AppliedFriendsView(id: id, applied: applied, isOpen: $isOpen).tag(1)
//                    ScrollView{
//                        ForEach(requested){ _ in
//                            Text("承認待ちの友達")
//                        }
//                    }.tag(2)
                })
            }
            .foregroundColor(Color.white)
        }
    }
}


struct MutualFriendsView: View{
    var mutual: [User]
    var body: some View{
        List{
            ForEach(mutual) { friend in
                HStack{
                    IconLoaderView(size: 40, withUrl: friend.iconPath)
                    Text(friend.name).foregroundColor(.black)
                    Spacer()
                    Text(friend.spot ?? "")
                }
            }.listStyle(GroupedListStyle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct AppliedFriendsView: View{
    var id: Int
    var applied: [User]
    @Binding var isOpen: Bool
    var body: some View{
        List{
            ForEach(applied) { friend in
                HStack{
                    IconLoaderView(size: 40, withUrl: friend.iconPath)
                    Text(friend.name).foregroundColor(.black)
                    Spacer()
                    CancelButtonView(myId: self.id, targetId: friend.id, isOpen: $isOpen)
                    CheckButtonView(myId: self.id, targetId: friend.id)
                }
            }
        }
    }
}

struct CheckButtonView: View {
    var myId: Int
    var targetId: Int
    var body: some View {
        Button(action:{
            addFriend(idPair: IdPair(myId: myId, targetId: targetId) ,success: {(msg) in
                print(msg)
            }) { (error) in
                print(error)
            }
        }){ //承認ボタン
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .frame(width: 40, height: 40)
                .background(Color(red: 0.29, green: 0.91, blue: 0.27))
                .clipShape(Circle())
        }.buttonStyle(PlainButtonStyle())
    }
}

struct CancelButtonView: View{
    var myId: Int
    var targetId: Int
    @Binding var isOpen: Bool
    var body: some View {
        Button(action:{
            self.isOpen = true
        }){
            Image(systemName: "multiply")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .frame(width: 40, height: 40)
                .background(Color(red: 0.913, green: 0.286, blue: 0.286))
                .clipShape(Circle())
        }.buttonStyle(PlainButtonStyle())
            .alert(isPresented: $isOpen, content: {
                Alert(title: Text("本当に拒否しますか？"), message: Text("この操作は戻せません。"),
                      primaryButton: .destructive(Text("拒否"), action: {
                    rejectFriend(idPair: IdPair(myId: myId, targetId: targetId) ,success: {(msg) in
                        print(msg)
                    }) { (error) in
                        print(error)
                    }
                }),
                      secondaryButton: .cancel(Text("キャンセル"), action: {}))
            })
    }
}

struct SearchFriendButtonView: View{
    @Binding var show: Bool
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button(action: { self.show = true /*またはself.show.toggle() */ }) {
                    Image(systemName: "person.badge.plus")
                        .foregroundColor(.white)
                        .font(.system(size: 28))
                    // 大きさを横幅に対する割合にする
                        .frame(width: 48, height: 48)
                        .background(Color("primary"))
                        .cornerRadius(24)
                        .shadow(color: .gray, radius: 4, x: 0, y: 4)
                }
                .fullScreenCover(isPresented: self.$show) {
                    NamesearchView(isActive: $show)
                }
            }.padding(.trailing,16)
        }
        .padding(.bottom, 16)
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView()
    }
}
