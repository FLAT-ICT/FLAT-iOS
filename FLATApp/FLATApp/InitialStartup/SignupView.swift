//
//  NewSignupView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/27.
//

import SwiftUI

struct SignupView: View {
    @State var nickname: String = ""
    @State var firstPassword: String = ""
    @State var secondPassword : String = ""
    @Binding var screenStatus: SwitchStartUp
    var body: some View {
        VStack(){
            Text("アカウントを登録しましょう")
                .font(.title)
            //.padding(.top, 50)
            VStack(){
                NicknameView(nickname: $nickname)
                    .padding(.top, 32)
                FirstPaswordView(firstPassword: $firstPassword)
                    .padding(.top, 18)
                SecondPaswordView(secondPassword: $secondPassword)
                    .padding(.top, 18)
                AccountButtonView(nickname: $nickname, firstPassword: $firstPassword, secondPassword: $secondPassword,  screenStatus: $screenStatus)
                    .padding(.top, 32)
            }
            .padding(.leading,24.0)
            .padding(.trailing,24.0)
            AccountMessageView(screenStatus: $screenStatus)
                .padding(.top, 200)
            
            
            //.padding(.top, 60)
            //Spacer()
        }
    }
}
struct NicknameView: View{
    @Binding var nickname: String
    var body: some View{
        VStack(){
            Text("ニックネームを入力してください")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.gray)
            TextField("ニックネーム", text: $nickname)
            // .padding(3.0)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct FirstPaswordView: View{
    @Binding var firstPassword: String
    var body: some View{
        VStack(){
            Text("パスワードを入力してください")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.gray)
            //.padding(.top,18)
            TextField("パスワード", text: $firstPassword)
            // 入力中の文字を隠す
            //.padding(3.0)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct SecondPaswordView: View{
    @Binding var secondPassword : String
    var body: some View{
        VStack(){
            Text("パスワードを再度入力してください")
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.gray)
            TextField("パスワード", text: $secondPassword)
            // 入力中の文字を隠す
            //.frame(maxWidth: .infinity,maxHeight: 40)
                .cornerRadius(10, antialiased: true)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct AccountButtonView: View{
    @Binding var nickname: String
    @Binding var firstPassword: String
    @Binding var secondPassword: String
    @Binding var screenStatus: SwitchStartUp
    var body: some View{
        Button(action: {
            
            if !validateName(name: nickname){
                print("invalid name")
                return
            }
            
            if !validatePassword(password: firstPassword){
                print("invalid password")
                return
            }
            
            if firstPassword != secondPassword {
                print("not the same password")
                return
            }
            
            signup(credential: Credential(name: nickname, password: firstPassword)) { user in
                print(user)
                UserDefaults.standard.set(user.id, forKey: "id")
                UserDefaults.standard.set(user.name, forKey: "name")
                UserDefaults.standard.set(user.spot, forKey: "spot")
                UserDefaults.standard.set(user.status, forKey: "status")
                UserDefaults.standard.set(user.iconPath, forKey: "iconPath")
                UserDefaults.standard.set(user.loggedInAt, forKey: "loggedinAt")
                UserDefaults.standard.set(false, forKey: "isFirstVisit")
                self.screenStatus = .home
                
            } failure: { e in
                print(e)
            }
        }){//ホーム画面に画面遷移
            Text("登録する")
                .frame(maxWidth:.infinity, maxHeight: 40)
                .foregroundColor(Color.white)
                .background(
                    (Color("primary"))
                )
                .cornerRadius(10, antialiased: true)
        }
    }
}

struct AccountMessageView: View{
    @Binding var screenStatus: SwitchStartUp
    var body: some View{
        HStack(){
            Text("アカウントを持っている人は")
            Button(action: {
                self.screenStatus = .login
            }){//ログイン画面に画面遷移
                Text("こちら")
                    .foregroundColor(Color("primary"))
            }
        }
    }
}

func validateName(name: String) -> Bool {
    let length = name.count
    if 0 < length && length <= 10 {
        return true
    }
    return false
}

func validatePassword(password: String) -> Bool {
    let length = password.count
    if 0 < length && length < 256 {
        return true
    }
    return false
}

struct SignupView_Previews: PreviewProvider {
    @State static var screenStatus: SwitchStartUp = .signup
    static var previews: some View {
        SignupView(screenStatus: $screenStatus)
    }
}
