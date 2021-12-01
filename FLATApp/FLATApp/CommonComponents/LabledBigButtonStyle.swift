//
//  LabledBigButtonStyle.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/27.
//

import SwiftUI

struct LabledBigButtonStyle: ButtonStyle {
    var type: ButtonColor
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .frame(width: 140, height: 40)
            .foregroundColor(self.type.fgColor)
            .background(self.type.bgColor)
            .cornerRadius(24)
            // .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

//enum BigButtonColor{
//    case normal, pusshed, cancel, login
//    
//    var bgColor: Color?{
//        switch self {
//        case .normal:
//            return Color("primary")
//        case .pusshed:
//            return Color("primary_pale")
//        case .cancel:
//            return Color("red")
//        case .login:
//            return Color(.white)
//        }
//    }
//    
//    var fgColor: Color?{
//        switch self {
//        case .normal:
//            return Color(.white)
//        case .pusshed:
//            return Color("primary")
//        case .cancel:
//            return Color(.white)
//        case .login:
//            return Color(.black)
//        }
//    }
//}

struct LabledBigButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Button(action: { }) {
                Text("button")
            }
            .buttonStyle(LabledBigButtonStyle(type: ButtonColor.normal))
            Button(action: { }) {
                Text("button")
            }
            .buttonStyle(LabledBigButtonStyle(type: ButtonColor.pusshed))
            Button(action: { }) {
                Text("button")
            }
            .buttonStyle(LabledBigButtonStyle(type: ButtonColor.cancel))
            Button(action: { }) {
                Text("button")
            }
            .buttonStyle(LabledBigButtonStyle(type: ButtonColor.login))
        }
    }
}
