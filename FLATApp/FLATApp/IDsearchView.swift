//
//  IDsearchView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI

struct IDsearchView: View { //友達追加画面
    @State private var number = ""
    var body: some View {
        VStack(){
            VStack(){
                Text("IDを入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
                    
                
            }
            HStack(){
                TextField("000000", text: $number)
                    .padding(3.0)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding(.top,139)
        Spacer()
    }
}
