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
                NicknameView()
                    .padding(.top, 32)
                FirstPaswordView()
                    .padding(.top, 18)
                SecondPaswordView()
                    .padding(.top, 18)
                AccountButtonView()
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
    @State var nickname: String = ""
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
    @State var firstPassword: String = ""
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
    @State var secondPassword : String = ""
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
    var body: some View{
        Button(action: {
            UserDefaults.standard.set(false, forKey: "isFirstVisit")
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

struct SignupView_Previews: PreviewProvider {
    @State static var screenStatus: SwitchStartUp = .signup
    static var previews: some View {
        SignupView(screenStatus: $screenStatus)
    }
}
