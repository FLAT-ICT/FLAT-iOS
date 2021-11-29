//
//  SwiftUIView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/26.
//

import SwiftUI

struct StartupView: View {
    @State var login = false
    @State var signup = false
    var body: some View {
        if login && signup{
            VStack(){
                TitleView()
                HStack(){
                    Button(action: {
                        self.login = true
                    }) {
                        Text("ログイン")
                    }
                    .buttonStyle(LabledBigButtonStyle(type: ButtonColor.login))
                    .padding()
                    Spacer()
                    
                    Button(action: {
                        self.signup = true
                    }) {
                        Text("新規登録")
                    }
                    .buttonStyle(LabledBigButtonStyle(type: ButtonColor.normal))
                    .padding()
                    Spacer()
                }
            }
        }else if login == true && signup == false{
            LoginView()
        } else if signup == true && login == false{
            SignupView()
        } else {
            VStack(){
                TitleView()
                ButtomView()
            }
        }
    }
}

struct TitleView: View{
    var body: some View{
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
    }
}


struct ButtomView : View{
    var body: some View{
        HStack(){
            Button(action: {
            }) {
                Text("ログイン")
            }
            .buttonStyle(LabledBigButtonStyle(type: ButtonColor.login))
            .padding()
            Spacer()
            
            Button(action: {}) {
                Text("新規登録")
            }
            .buttonStyle(LabledBigButtonStyle(type: ButtonColor.normal))
            .padding()
            Spacer()
        }
    }
}


struct StartupView_Previews: PreviewProvider {
    static var previews: some View {
        StartupView()
    }
}
