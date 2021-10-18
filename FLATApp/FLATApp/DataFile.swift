//
//  DataFile.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/19.
//データをローカルに入れて一覧表示するためのファイル

import Foundation
import SwiftUI

var data:[NoFriendsData] = makeData()

struct NoFriendsData: Identifiable{
    var id: String //ID
    var name: String //名前
    var status: String //ステータス
    var beacon: String //場所
    var icon_path: String //アイコン
}

func makeData()->[NoFriendsData]{
    var dataArray:[NoFriendsData] = []
    dataArray.append(NoFriendsData(id: "000001", name: "user01", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(NoFriendsData(id: "000002", name: "user02", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(NoFriendsData(id: "000003", name: "user03", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(NoFriendsData(id: "000004", name: "user04", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(NoFriendsData(id: "000005", name: "user05", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(NoFriendsData(id: "000005", name: "user06", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    return dataArray
}

var data2:[YesFriendsData] = makeData2()

struct YesFriendsData: Identifiable{
    var id: String //ID
    var name: String //名前
    var status: String //ステータス
    var beacon: String //場所
    var icon_path: String //アイコン
}


func makeData2()->[YesFriendsData]{
    var dataArray:[YesFriendsData] = []
    dataArray.append(YesFriendsData(id: "000006", name: "user06", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(YesFriendsData(id: "000007", name: "user07", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(YesFriendsData(id: "000008", name: "user08", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    dataArray.append(YesFriendsData(id: "000009", name: "user09", status: "0", beacon: "595教室", icon_path: "Image_icon"))
    return dataArray
}


