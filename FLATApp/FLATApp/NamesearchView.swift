//
//  IDsearchView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI
import UIKit

struct NamesearchView: View { //友達追加画面
    @State private var editting = false
    @Binding var isActive: Bool
    @State private var users: [UserData] = []//通信用
    @State var target_name: String = ""
    @State private var buttonText = "申請"
    @State private var buttonchange = false
    @State private var showError = false//バリデーションチェック
    @State private var errorMessage = "" //バリデーションチェックのためのエラーメッセージ
    @State private var counter = 0 //検索ボタンを押した回数
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
                    TextField("000000", text: $target_name, onCommit: {
                                          self.validateName() //バリデーションチェック
                        
                                          searchName(target_name: target_name,
                                                   success: {(userData) in self.users = userData
                                          }
                                          ) { (error) in
                                              print(error)
                                          }
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
               
                ForEach(users){ user in
                    Text(user.name)
                    Text(user.icon_path)
                        .padding()
                    if user.applied == true && user.requested == true {
                        Text("既に友だちです")
                    } else {
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
                if counter > 0 && users.isEmpty{
                    Text("見つかりませんでした")
                    Text("もう一度検索してください")
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
                    let decodedData = try JSONDecoder().decode([UserData].self, from: userdata)
                    self.users = decodedData
                } else {
                    print("No data", data as Any)
                }
            } catch {
                print("Error", error)
            }
        }.resume()
        
        
    }
    private func validateName() {//バリデーションチェック
        if   self.target_name.isEmpty || self.target_name.count > 10 {
            self.errorMessage = "１０文字以内の名前を入力してください"
            self.showError = true
        }
    }
    func countup(){//検索ボタンの回数を数える関数
        self.counter += 1
    }
}


struct NamesearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
