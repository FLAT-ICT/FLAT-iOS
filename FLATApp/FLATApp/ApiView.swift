//
//  ApiView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/16.
//

import SwiftUI

struct UserData: Decodable {
    var id: String
    var name: String
    var icon_path: String
    var applied: Bool
    var requested: Bool
}
enum NetworkError : Error{//失敗した時用
    case unknown
    case invalidResponse
    case invalidURL
}

func searchID(target_id: String){ //相手のIDを検索した時にそのIDをURLに入れる
    guard let target_id_encode = target_id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        return
    }
    
    guard let req_url = URL(string: "http://34.68.157.198:8080/v1/user/check?my_id=000000&target_id=\(target_id_encode)") else {
        return
    }
    print(req_url)
}
