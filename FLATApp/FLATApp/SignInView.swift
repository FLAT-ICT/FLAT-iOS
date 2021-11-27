//
//  SwiftUIView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/26.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        VStack(){
            HStack(){
                Text("FLAT")
                    .font(.largeTitle)
                    .frame(width: 327.0, height: 41.0)
                    .padding(.top,154)
            }
            HStack(){
                Rectangle()
                    .foregroundColor(Color("primary"))
                    .frame(width: 270, height: 3)
            }
            Spacer()
            HStack(){
                Button("ログイン"){
                    //ログイン画面に遷移
                    //　ボタンのスタイルは、CommonComponentsの中のスタイルを使用してください
                    // 他のViewで使用しているのでそちらを参照してください
                    // ログインボタンの左側のスペースがないので後で修正してください
                }
                .foregroundColor(.black)
                .frame(width:140,height:40)
                .padding()
                Spacer()
                Button("新規登録"){
                    //アカウント登録画面に遷移
                }
                // 白いボタンのスタイルは作っていませんが、スタイルを作るといいと思います。
                .foregroundColor(.white)
                .background(
                    Capsule()
                        .foregroundColor(Color("primary"))
                        .frame(width:140,height:40)
                )
                .padding()
                Spacer()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
