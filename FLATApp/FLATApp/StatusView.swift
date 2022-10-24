//
//  IconView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/13.
//

import SwiftUI

struct StatusView: View { // アイコン画面 ??? ステータス画面
    @AppStorage("name") var name = "name"
    @Binding var isLoggedIn: Bool
    var body: some View {
        VStack{
            iconView()
            Text("\(self.name)").font(.title)
            HStack(){
                Rectangle()
                    .foregroundColor(Color("primary"))
                    .frame(width: 270, height: 3)
            }
            Spacer()
            settingList(isLoggedIn: $isLoggedIn)
        }
    }
}

struct iconView: View {
    @AppStorage("iconPath") var iconPath = ""
    @AppStorage("status") var status:Int = 0
    
    var body: some View{
        if #available(iOS 15.0, *) {
            IconLoaderView(size: 160, withUrl: iconPath).overlay(content: {
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        if (status == 0){ //学校にいる
                            onSchoolIcon()
                        }
                        else if (status == 1){ //今暇
                            freeNowIcon()
                        }
                        else if (status == 2){ //忙しい
                            busyNowIcon()
                        }
                        else { //学校にいない or error
                            notOnSchoolIcon()
                        }
                    }
                }
            })
        } else {
            //iOS15がサポートされていない場合はIconだけ表示する
            IconLoaderView(size: 160, withUrl: iconPath)
        }
    }
}

struct settingList: View{
    @Binding var isLoggedIn: Bool
    
    var body: some View{
        //Heightが固定値なのはListを下に寄せるため
        //Listに必要な要素が増えたらHeightの値をそれに合わせて増やすこと
        //ここを動的にできるようになったら嬉しい(そもそもできるかわかってない)
        List{
            Section {
                nameSettingRow()
                iconSettingRow()
                statusSettingRow()
                logoutRow(isLoggedIn: $isLoggedIn)
            } header: {
                Text("アカウント設定")
            }
        }.frame(height: 260.0).listStyle(.plain)
    }
}

struct nameSettingRow: View {
    var body: some View {
        HStack{
            Text("名前を変更する")
            Spacer()
            Button (action: {
                //TODO: 名前変更の中身
                //これはどこに書くべき? (更新処理はApiに、変更のViewはこのファイルかまた別のファイルに?)
                print("Here: nameSettingRow")
            }){
                Image(systemName: "chevron.right")
            }
        }
    }
}

struct iconSettingRow: View{
    var body: some View {
        HStack{
            Text("アイコンを変更する")
            Spacer()
            Button (action: {
                //TODO: アイコン変更の中身
                //機能としてデカイのでファイル分けてもいいかも
                print("Here: iconsettingRow")
            }){
                Image(systemName: "chevron.right")
            }
        }
    }
}

struct statusSettingRow: View{
    var body: some View {
        HStack {
            Text("ステータスを変更する")
            Spacer()
            Button (action: {
                //TODO: ステータス変更の中身
                //ファイル分けるかちょっと迷ってる。分けてもいいかも。
                print("Here: statusSettingRow")
            }){
                Image(systemName: "chevron.right")
            }
        }
    }
}

struct logoutRow: View{
    @Binding var isLoggedIn: Bool
    @AppStorage("id") var id = 1
    var body: some View{
        HStack{
            Text("ログアウトする").foregroundColor(.red)
            Spacer()    
            Button(action: {
                //ログアウト処理
                logout(userId: UserId(id: self.id), success: {msg in
                    print(msg)
                    UserDefaults.standard.set(-1, forKey: "id")
                    UserDefaults.standard.set("", forKey: "name")
                    UserDefaults.standard.set("", forKey: "spot")
                    UserDefaults.standard.set(0, forKey: "status")
                    UserDefaults.standard.set("", forKey: "loggedinAt")
                    UserDefaults.standard.set(true, forKey: "isFirstVisit")
                    isLoggedIn = false
                }){(error) in
                    print(error)
                }
            }){
                Image(systemName: "chevron.right")
            }
        }
    }
}

struct IconView_Previews: PreviewProvider {
    @State static var isLoggedIn:Bool = true
    static var previews: some View {
        StatusView(isLoggedIn: $isLoggedIn)
    }
}
