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
    var body: some View {
        VStack(){
            VStack(){
                Text("アカウントを登録しましょう")
                    .font(.title)
                    .padding(.top, 115)
            }
            VStack(){
                Text("ニックネームを入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
                TextField("ニックネーム", text: $nickname)
                    .padding(3.0)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("パスワードを入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
                    .padding(.top,18)
                TextField("パスワード", text: $firstPassword)
                // 入力中の文字を隠す
                    .padding(3.0)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("パスワードを再度入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
                    .padding(.top,18)
                TextField("パスワード", text: $secondPassword)
                // 入力中の文字を隠す
                    .padding(3.0)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {}){//ホーム画面に画面遷移
                    Text("登録する")
                        .frame(width:327, height: 40)
                        .foregroundColor(Color.white)
                        .background(
                            (Color("primary"))
                        )
                        .cornerRadius(10, antialiased: true)
                }
                .padding(.top, 32)
                HStack(){
                    Text("アカウントを持っている人は")
                    Button(action: {}){//ログイン画面に画面遷移
                        Text("こちら")
                            .foregroundColor(Color("primary"))
                    }
                }
                .padding(.top, 200)
            }
            .padding(.leading,24.0)
            .padding(.trailing,24.0)
            .padding(.top, 60)
            Spacer()
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
