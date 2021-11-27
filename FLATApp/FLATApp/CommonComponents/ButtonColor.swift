//
//  ButtonColor.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/27.
//

import SwiftUI



enum ButtonColor{
    case normal, pusshed, cancel, login
    
    var bgColor: Color?{
        switch self {
        case .normal:
            return Color("primary")
        case .pusshed:
            return Color("primary_pale")
        case .cancel:
            return Color("red")
        case .login:
            return Color(.white)
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
        case .login:
            return Color(.black)
        }
    }
}

