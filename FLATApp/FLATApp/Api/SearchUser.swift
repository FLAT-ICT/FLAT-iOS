//
//  SearchUser.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/10.
//

import Foundation

struct UserData: Decodable, Identifiable {
    var id: Int
    var name: String
    var iconPath: String
    var applied: Bool
    var requested: Bool
}

func searchName(targetName: String,
              success: @escaping ([UserData]) -> (),
              failure: @escaping (Error) -> ()
){ //相手の名前を検索した時にその名前をURLに入れる
    guard let targetNameEncode = targetName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        return
    }
    
    let reqUrl = "/v1/user/search?my_id=0&target_name=\(targetNameEncode)"
   
    Api.util(endpoint: reqUrl, method: HttpMethod.GET, args: Dummy(), success: {(dictionary: [UserData]) in
        success(dictionary)
    }) {(error) in
        failure(error)
    }
}
