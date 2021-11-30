//
//  LoginView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/27.
//

import SwiftUI

struct LoginView: View {
    @State var nickname: String = ""
    @State var paseword: String = ""
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
                TextField("パスワード", text: $paseword)
                    .padding(3.0)
                    .frame(width:327, height: 40)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "isFirstVisit")
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
