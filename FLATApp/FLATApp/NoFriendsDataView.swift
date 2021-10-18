//
//  NoFriendDataUIView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/19.
//未承認の友だち用のデータを表示する

import SwiftUI

struct NoFriendsDataView: View {
    var data1: NoFriendsData
    
    var body: some View {
        HStack{
            Image(data1.icon_path)
                .resizable()
                .frame(width: 50, height: 50)
            Text(data1.name)
            Spacer()
            Text(data1.beacon)
        }
    }
}

struct NoFriendsDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoFriendsDataView(data1: data[0])
    }
}
