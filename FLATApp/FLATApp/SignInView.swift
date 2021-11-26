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
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
