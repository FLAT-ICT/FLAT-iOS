//
//  AddFriend.swift
//  FLATApp
//
//  Created by Ryuki Yamamoto on 2021/11/10.
//

struct IdPair: Codable {
    var myId: Int
    var targetId: Int
}

func addFriend(id_pair: IdPair,
               success: @escaping (String) -> (),
               failure: @escaping (Error) -> ()) {
    let req_url="/v1/friends/add"
    Api.util(endpoint: req_url, method: HttpMethod.GET, args: id_pair, success: { msg in
        success(msg)
    }){(error) in
        failure(error)
    }
}

