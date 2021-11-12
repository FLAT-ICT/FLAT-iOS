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
    var icon_path: String
    var applied: Bool
    var requested: Bool
}

func searchName(targetName: String,
              success: @escaping ([UserData]) -> (),
              failure: @escaping (Error) -> ()
){ //相手の名前を検索した時にその名前をURLに入れる
    guard let target_name_encode = target_name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        return
    }
    
    let req_url = "/v1/user/search?my_id=0&target_name=\(target_name_encode)"
   
    Api.util(endpoint: req_url, method: HttpMethod.GET, args: Dummy(), success: {(dictionary: [UserData]) in
        success(dictionary)
    }) {(error) in
        failure(error)
    }
}
