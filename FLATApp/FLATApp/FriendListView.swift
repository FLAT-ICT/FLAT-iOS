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
    @State private var isError: Bool = false
    @State private var friendList: FriendList = FriendList(oneSide: [], mutual: [])
    @AppStorage("id") private var id = -1
    let tabsName = ["友だち", "未承認", "承認待ち"]
    
    var body: some View {
        ZStack{
            if self.friendList.oneSide.count == 0 && self.friendList.mutual.count == 0 {
                Text("友達が一人もいないようです。下のボタンから追加しましょう！")
            }else{
                FriendTabsView(id: self.id, friendList: self.$friendList, isOpen: self.$isError)
            }
            SearchFriendButtonView(show: self.$show, friendList: self.$friendList)
        }
        .onAppear(perform: {
            getFriends(id: self.id, success: { (friendlist: FriendList) in
                self.friendList = friendlist
            })
            {( error )in
                print("failure")
                print(error)
            }
        })
    }
}

struct FriendTabsView: View {
    @State private var selectedTab = 0
    var id: Int
    @Binding var friendList: FriendList
    @Binding var isOpen: Bool
    let tabsName = ["友だち", "未承認"]
    var body: some View {
        GeometryReader {geo in
            VStack(spacing: 0){
                Tabs(tabsName: tabsName, geoWidth: geo.size.width, selectedTab: $selectedTab)
                TabView(selection: $selectedTab, content: {
                    // 友だち
                    MutualFriendsView(mutual: friendList.mutual).tag(0)
                    // 未承認
                    AppliedFriendsView(id: id, isOpen: $isOpen, friendList: $friendList).tag(1)
                    // 申請済み
                    //
                })
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            //.foregroundColor(Color.white)
        }
    }
}


struct MutualFriendsView: View{
    var mutual: [User]
    var body: some View{
        List{
            ForEach(mutual) { friend in
                if #available(iOS 15.0, *){
                    MutualFrinedView(friend: friend)
                        .listRowSeparator(.hidden)
                }else{
                    MutualFrinedView(friend: friend)
                }
            }
        }.listStyle(InsetListStyle())
    }
}

struct MutualFrinedView: View {
    var friend: User
    var body: some View {
        HStack{
            IconLoaderView(size: 40, withUrl: friend.iconPath)
            Text(friend.name).foregroundColor(.black)
            Spacer()
            Text(friend.spot ?? "").foregroundColor(.black)
        }
    }
}

struct AppliedFriendsView: View{
    var id: Int
    //    var applied: [User]
    @Binding var isOpen: Bool
    //    @Binding var yesFriends: [User]
    @Binding var friendList: FriendList
    var body: some View{
        List{
            ForEach(self.friendList.oneSide) { friend in
                if #available(iOS 15.0, *) {
                    AppliedFrinedView(friend: friend, id: self.id, friendList: self.$friendList, isOpen: self.$isOpen)
                        .listRowSeparator(.hidden)
                } else {
                    // Fallback on earlier versions
                    AppliedFrinedView(friend: friend, id: self.id, friendList: self.$friendList, isOpen: self.$isOpen)
                }
            }
        }.listStyle(InsetListStyle())
    }
}

struct AppliedFrinedView: View {
    var friend: User
    var id: Int
    @Binding var friendList: FriendList
    @Binding var isOpen: Bool
    var body: some View {
        HStack{
            IconLoaderView(size: 40, withUrl: friend.iconPath)
            Text(friend.name).foregroundColor(.black)
            Spacer()
            CancelButtonView(myId: self.id, targetId: friend.id, isOpen: self.$isOpen, friendList: self.$friendList)
            CheckButtonView(myId: self.id, targetId: friend.id, friendList: self.$friendList)
        }
    }
}

struct CheckButtonView: View {
    var myId: Int
    var targetId: Int
    @Binding var friendList: FriendList
    var body: some View {
        Button(action:{
            addFriend(idPair: IdPair(myId: myId, targetId: targetId) ,success: {(msg) in
                print(msg)
                // TODO: getFriendして更新する必要あり
                getFriends(id: myId, success: { (friendlist: FriendList) in
                    self.friendList = friendlist
                })
                {( error )in
                    print("getFriend failure")
                    print(error)
                }
            }) { (error) in
                print("addFriend failure")
                print(error)
            }
        }){ //承認ボタン
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .frame(width: 40, height: 40)
                .background(Color("green"))
                .clipShape(Circle())
        }.buttonStyle(PlainButtonStyle())
    }
}

struct CancelButtonView: View{
    var myId: Int
    var targetId: Int
    @Binding var isOpen: Bool
    @Binding var friendList: FriendList
    var body: some View {
        Button(action:{
            self.isOpen = true
        }){
            Image(systemName: "multiply")
                .foregroundColor(.white)
                .font(.system(size: 20))
                .frame(width: 40, height: 40)
                .background(Color("red"))
                .clipShape(Circle())
        }.buttonStyle(PlainButtonStyle())
            .alert(isPresented: $isOpen, content: {
                Alert(title: Text("本当に拒否しますか？"), message: Text("この操作は戻せません。"),
                      primaryButton: .destructive(Text("拒否"), action: {
                    rejectFriend(idPair: IdPair(myId: myId, targetId: targetId) ,success: {(msg) in
                        print(msg)
                        // TODO: 友だち情報を更新する必要あり
                        getFriends(id: myId, success: { (friendlist: FriendList) in
                            self.friendList = friendlist
                        })
                        {( error )in
                            print("getFriend failure")
                            print(error)
                        }
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
    @Binding var friendList: FriendList
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
                    NamesearchView(friendList: self.$friendList, isActive: self.$show)
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
