//
//  IDsearchView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI
import UIKit

struct IDsearchView: View { //友達追加画面
    @State private var editting = false
    @Binding var isActive: Bool
    @State private var user: UserData = UserData(id: "", name: "",  icon_path: "",applied: false, requested: false)//通信用
    //    @Binding var target_id: String
    @State private var buttonText = "申請"
    @State private var buttonchange = false
    @State private var showError = false //バリデーションチェック
    @State private var errorMessage = "" //バリデーションチェックのためのエラーメッセージ
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
            VStack(){
                HStack(){
                    TextField("000000", text: $user.name,onCommit: {
                        self.validateName() //バリデーションチェック
                    })
                        .padding(3.0)
                        .keyboardType(.default)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.leading,24.0)
                .padding(.trailing,24.0)
                Text(self.errorMessage)
                    .foregroundColor(Color.red)
            }
            VStack{
                Button("検索"){//検索ボタン
                    searchID(target_id: user.id,
                             success: {(userData) in self.user = userData}) { (error) in
                        print(error)
                    }
                    
                }
                .padding()
                Text(user.name)
                Text(user.icon_path)
                    .padding()
                Button(action: {
                    buttonText = "承認待ち"
                }){
                    Text(buttonText)
                        .frame(width: 100, height: 35)
                        .foregroundColor(Color(.white))
                        .background(Color(red: 0.2, green: 0.85, blue: 0.721))
                        .cornerRadius(24)
                }
            }
        }
        .padding(.top,139)
        Spacer()
    }
    
    
    func getData() {
        guard let url = URL(string: "http://34.68.157.198:8080/") else { return }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let userdata = data {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: userdata)
                    self.user = decodedData
                } else {
                    print("No data", data as Any)
                }
            } catch {
                print("Error", error)
            }
        }.resume()
    }
    
    private func validateName() {
        if self.user.name.count == 0 {
            self.errorMessage = "名前を入力してください。"
            self.showError = true
        }
        if   self.user.name.count < 0 || self.user.name.count >= 10 {
            self.errorMessage = "１０文字以内の名前を入力してください"
            self.showError = true
        }
}
}

struct IDsearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
