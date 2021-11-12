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

func addFriend(idPair: IdPair,
               success: @escaping (String) -> (),
               failure: @escaping (Error) -> ()) {
    let req_url="/v1/friends/add"
    Api.util(endpoint: req_url, method: HttpMethod.GET, args: idPair, success: { msg in
        success(msg)
    }){(error) in
        failure(error)
    }
}

func rejectFriend(idPair: IdPair,
               success: @escaping (String) -> (),
               failure: @escaping (Error) -> ()) {
    let req_url="/v1/friends/reject"
    Api.util(endpoint: req_url, method: HttpMethod.GET, args: idPair, success: { msg in
        success(msg)
    }){(error) in
        failure(error)
    }
}
