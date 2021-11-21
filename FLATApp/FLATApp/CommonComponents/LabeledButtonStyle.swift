//
//  LabeledButtonStyle.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/21.
//

import SwiftUI

struct LabeledButtonStyle: ButtonStyle {
    //    var backGroundColor: Color
    var type: ButtonColor
    //    var bgColor: Color
    //    init(type: ButtonColor){
    //        self.type = type
    //    }
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .frame(width: 100, height: 35)
            .foregroundColor(self.type.fgColor)
            .background(self.type.bgColor)
            .cornerRadius(24)
    }
}

enum ButtonColor{
    case normal, pusshed, cancel
    
    var bgColor: Color?{
        switch self {
        case .normal:
            return Color("primary")
        case .pusshed:
            return Color("primary_pale")
        case .cancel:
            return Color("red")
        }
    }
    
    var fgColor: Color?{
        switch self {
        case .normal:
            return Color(.white)
        case .pusshed:
            return Color("primary")
        case .cancel:
            return Color(.white)
        }
    }
}

struct LabeledButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Button(action: { }) {
                Text("button")
            }
            .buttonStyle(LabeledButtonStyle(type: ButtonColor.normal))
            Button(action: { }) {
                Text("button")
            }
            .buttonStyle(LabeledButtonStyle(type: ButtonColor.pusshed))
            Button(action: { }) {
                Text("button")
            }
            .buttonStyle(LabeledButtonStyle(type: ButtonColor.cancel))
        }
        
    }
}
