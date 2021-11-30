//
//  SwiftUIView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/26.
//

import SwiftUI

enum SwitchStartUp{
    case startup, signup, login
}

struct StartupView: View {
    @State var screenStatus: SwitchStartUp = .startup
    var body: some View {
        switch self.screenStatus{
        case .startup:
            VStack(){
                TitleView()
                ButtomView(screenStatus: $screenStatus)
            }
        case .signup:
            SignupView(screenStatus: $screenStatus)
        case .login:
            LoginView(screenStatus: $screenStatus)
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
    @Binding var screenStatus: SwitchStartUp
    var body: some View{
        HStack(){
            Button(action: {
                self.screenStatus = .login
            }) {
                Text("ログイン")
            }
            .buttonStyle(LabledBigButtonStyle(type: ButtonColor.login))
            .padding()
            Spacer()
            
            Button(action: {
                self.screenStatus = .signup
            }) {
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
