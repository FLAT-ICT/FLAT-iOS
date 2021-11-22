//
//  IDsearchView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI
import UIKit

struct NamesearchView: View { //友達追加画面
    @Binding var friendList: FriendList
    @Binding var isActive: Bool
    @State private var editting = false
    @State private var users: [UserData] = []//通信用 UserData型の空配列
    @State var targetName: String = ""
    @State private var buttonText = "申請"
    @State private var buttonchange = false
    // @State private var showError = false//バリデーションチェック
    @State private var passValidation = true // バリデーション結果
    // @State private var errorMessage = "" //バリデーションチェックのためのエラーメッセージ
    @State private var searchCount = 0 //検索ボタンを押した回数
    @AppStorage("id") private var id = -1
    var body: some View {
        VStack(){
            HStack(){ //上のキャンセルボタン
                Button("キャンセル") {
                    isActive = false
                }
                Spacer()
                    .padding(.top, 44)
            }
            .padding(.leading, 25.0)
            Divider()
        }
        VStack(){ //ID入力項目
            VStack(){
                Text("名前を入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
            }
            VStack{
                HStack(){
                    TextField("未来太郎", text: $targetName, onCommit: {
                        // self.validateName() //バリデーションチェック
                        self.passValidation = validationName(name: targetName)
                        self.users = [] // ボタン押下時に一度空にしないと前回の検索結果が残ることがある
                        if self.passValidation {
                            searchName(
                                id: self.id,
                                targetName: targetName,
                                success: {
                                    (userData) in self.users = userData
                                }
                            ) { (error) in
                                print(error)
                            }
                            self.searchCount += 1
                        }
                    })
                        .padding(3.0)
                        .keyboardType(.default)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.leading,24.0)
                .padding(.trailing,24.0)
                // 検索ボックス下のメッセージはここにまとめる
                if !passValidation {
                    Text("10文字以内の名前を入力してください")
                        .foregroundColor(Color.red)
                }else if self.searchCount > 0 && users.isEmpty{
                    Text("見つかりませんでした")
                    Text("もう一度検索してください")
                }
            }
            List{
                ForEach(users){ user in
                    SearchedUserView(id: self.id, user: user, friendList: $friendList)
                }
            }.listStyle(InsetListStyle())
        }
        .onDisappear{
            // 画面非表示時に検索回数をリセットしなければいけないとおもいます
            self.searchCount = 0
        }
        .padding(.top,139)
        Spacer()
    }
    
    //    private func validateName() {//バリデーションチェック
    //        if   self.targetName.isEmpty || self.targetName.count > 10 {
    //            self.errorMessage = "１０文字以内の名前を入力してください"
    //            self.showError = true
    //        }
    //    }
    func countup(){//検索ボタンの回数を数える関数
        self.searchCount += 1
    }
}


func validationName(name: String) -> Bool {
    // validation が成功したらTrueを返すのが関数名と合ってると思う
    // - 0文字はだめ
    // - 10文字より多いのもだめ
    // エラーメッセージをStateとして持つのは後処理が面倒そう
    return !(name.isEmpty || name.count > 10)
}
    
struct SearchedUserView: View{
    var id: Int
    var user: UserData
    @Binding var friendList: FriendList
    var body: some View{
        HStack{
            IconLoaderView(size: 40, withUrl: user.iconPath)
            Text(user.name).foregroundColor(.black)
            Spacer()
            RequestButtonView(user: user, myId: self.id, friendList: self.$friendList)
        }
    }
}

struct RequestButtonView: View{
    var myId: Int
    var targetId: Int
    @Binding var friendList: FriendList
    @State var buttonText: String
    @State var applied: Bool
    @State var requested: Bool
    
    init(user: UserData, myId: Int, friendList: Binding<FriendList>){
        self.myId = myId
        self._friendList = friendList
        self.targetId = user.id
        self.applied = user.applied
        self.requested = user.requested
        self.buttonText = user.applied ? "承認待ち" : "申請"
    }
    
    var body: some View{
        Button(action: {
            if !self.applied {
                addFriend(idPair: IdPair(myId: self.myId, targetId: self.targetId) ,success: {(msg) in
                    print(msg)
                    // TODO: getFriendして更新する必要あり
                    getFriends(id: myId, success: { (friendlist: FriendList) in
                        self.friendList = friendlist
                        self.applied = true
                        self.buttonText = self.requested ? "すでに友だち" : "承認待ち"
                    })
                    {( error )in
                        print("getFriend failure")
                        print(error)
                    }
                }) { (error) in
                    print("addFriend failure")
                    print(error)
                }
            }
        }){
            Text(buttonText)
        }.buttonStyle(LabeledButtonStyle(
            type: (self.applied
                   ? ButtonColor.pusshed
                   : ButtonColor.normal)))
    }
}


struct NamesearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
