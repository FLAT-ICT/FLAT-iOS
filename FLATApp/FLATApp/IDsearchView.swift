//
//  IDsearchView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI



struct IDsearchView: View { //友達追加画面
    @State private var id = ""
    @State private var name = ""
    @State private var icon_path = ""
    @State private var editting = false
    @Binding var isActive: Bool
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
        }
        VStack(){ //ID入力項目
            VStack(){
                Text("IDを入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
            }
            VStack(){
                HStack(){
                    TextField("000000", text: $id)
                        .padding(3.0)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.leading,24.0)
                .padding(.trailing,24.0)
            }
            VStack{
                Button("検索"){ //検索ボタン
                    if self.id == "111111"{ //一時的にIDを設定
                        self.name = "名前"
                        self.icon_path = "アイコン"
                    } else { //IDではなかった場合
                        self.name = "見つかりませんでした"
                        self.icon_path = "もう一度検索してください。"
                    }
                }
                .padding()
                Text(name)
                Text(icon_path)
                .padding()
            }
        }
        .padding(.top,139)
        Spacer()
    }
}

struct IDsearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
