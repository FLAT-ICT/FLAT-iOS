//
//  LoginView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/27.
//

import SwiftUI

struct LoginView: View {
    @State var nickname: String = ""
    @State var password: String = ""
    @Binding var screenStatus: SwitchStartUp
    var body: some View {
        VStack(){
            // 不要
                Text("ログイン画面")
                    .font(.largeTitle)
                    .padding(.top, 115)
            VStack(){
                Text("ニックネームを入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
                // 幅をログインボタンと揃えてください
                TextField("ニックネーム", text: $nickname)
                    .frame(width:327, height: 40)
                    .padding(3.0)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("パスワードを入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
                    .padding(.top,18)
                TextField("パスワード", text: $password)
                    .padding(3.0)
                    .frame(width:327, height: 40)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if !validateName(name: nickname){
                        print("invalid name")
                        return
                    }
                    
                    if !validatePassword(password: password){
                        print("invalid password")
                        return
                    }
                    login(credential: Credential(name: nickname, password: password)) { user in
                        print(user)
                        UserDefaults.standard.set(user.id, forKey: "id")
                        UserDefaults.standard.set(user.name, forKey: "name")
                        UserDefaults.standard.set(user.spot, forKey: "spot")
                        UserDefaults.standard.set(user.status, forKey: "status")
                        UserDefaults.standard.set(user.iconPath, forKey: "iconPath")
                        UserDefaults.standard.set(user.loggedinAt, forKey: "loggedinAt")
                        UserDefaults.standard.set(false, forKey: "isFirstVisit")
                        self.screenStatus = .home
                        
                    } failure: { e in
                        print(e)
                    }
                }){
                    Text("ログインする")
                        .frame(width:327, height: 40)
                        .foregroundColor(Color.white)
                        .background(
                            (Color("primary"))
                        )
                        .cornerRadius(10, antialiased: true)
                }
                .padding(.top, 32)
                HStack(){
                    Text("新規登録は")
                    Button(action: {
                        self.screenStatus = .signup
                    }){
                        Text("こちら")
                            .foregroundColor(Color("primary"))
                    }
                }
                .padding(.top, 241)
            }
            .padding(.leading,24.0)
            .padding(.trailing,24.0)
            .padding(.top, 60)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var screenStatus: SwitchStartUp = .signup
    static var previews: some View {
        LoginView(screenStatus: $screenStatus)
    }
}
