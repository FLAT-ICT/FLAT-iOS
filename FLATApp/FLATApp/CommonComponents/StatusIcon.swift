//
//  StatusIcon.swift
//  FLATApp
//
//  Created by Yourein on 2022/08/18.
//

import SwiftUI

struct onSchoolIcon: View {
    var body : some View{
        Image(systemName: "circle.fill")
            .foregroundColor(.green)
            .font(.system(size: 50))
    }
}

struct freeNowIcon: View {
    var body : some View{
        Image(systemName: "circle.fill")
            .foregroundColor(.blue)
            .font(.system(size: 50))
    }
}

struct busyNowIcon: View{
    var body : some View {
        if #available(iOS 15.0, *) {
            Image(systemName: "circle.fill")
                .foregroundColor(.red)
                .font(.system(size: 50))
                .overlay(content: {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: 40, height: 8)
                })
        } else {
            Image(systemName: "circle.fill")
        }
    }
}

struct notOnSchoolIcon: View {
    var body : some View {
        Image(systemName: "circle.fill")
            .foregroundColor(.gray)
            .font(.system(size: 50))
    }
}
