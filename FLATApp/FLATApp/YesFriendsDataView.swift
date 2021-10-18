//
//  YesFriendsDataView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/19.
//承認済みの友だちのデータ表示する用

import SwiftUI

struct YesFriendsDataView: View {
    var data2: YesFriendsData
    
    var body: some View {
        HStack{
            Image(data2.icon_path)
                .resizable()
                .frame(width: 50, height: 50)
            Text(data2.name)
            Spacer()
            Text(data2.beacon)
        }
    }
}

struct YesFriendsDataView_Previews: PreviewProvider {
    static var previews: some View {
        YesFriendsDataView(data2: data2[0])
    }
}
