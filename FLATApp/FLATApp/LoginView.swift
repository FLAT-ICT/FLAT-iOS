//
//  LoginView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/27.
//

import SwiftUI

struct LoginView: View {
    @State var nickname: String = ""
    var body: some View {
        VStack(){
            VStack(){
                Text("ログイン画面")
                    .font(.largeTitle)
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
            }
            .padding(.leading,24.0)
            .padding(.trailing,24.0)
            .padding(.top, 60)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
