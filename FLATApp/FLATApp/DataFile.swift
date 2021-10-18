//
//  DataFile.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/19.
//

import Foundation
import SwiftUI

var data:[FriendsData] = makeData()

struct FriendsData: Identifiable{
    var id: String //ID
    var name: String //名前
    var status: String //ステータス
    var beacon: String //場所
    var icon_path: String //アイコン
}

func makeData()->[FriendsData]{
    var dataArray:[FriendsData] = []
    dataArray.append(FriendsData(id: "000001", name: "user01", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(FriendsData(id: "000002", name: "user02", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(FriendsData(id: "000003", name: "user03", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(FriendsData(id: "000004", name: "user04", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(FriendsData(id: "000005", name: "user05", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(FriendsData(id: "000005", name: "user06", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    return dataArray
}

var data2:[FriendsData2] = makeData2()

struct FriendsData2: Identifiable{
    var id: String //ID
    var name: String //名前
    var status: String //ステータス
    var beacon: String //場所
    var icon_path: String //アイコン
}


func makeData2()->[FriendsData2]{
    var dataArray:[FriendsData2] = []
    dataArray.append(FriendsData2(id: "000006", name: "user06", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(FriendsData2(id: "000007", name: "user07", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(FriendsData2(id: "000008", name: "user08", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(FriendsData2(id: "000009", name: "user09", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    return dataArray
}


