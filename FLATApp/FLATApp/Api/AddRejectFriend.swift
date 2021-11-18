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
    let reqUrl="/v1/friends/add"
    Api.util(endpoint: reqUrl, method: HttpMethod.POST, args: idPair, success: { msg in
        success(msg)
    }){(error) in
        failure(error)
    }
}

func rejectFriend(idPair: IdPair,
               success: @escaping (String) -> (),
               failure: @escaping (Error) -> ()) {
    let reqUrl="/v1/friends/reject"
    Api.util(endpoint: reqUrl, method: HttpMethod.POST, args: idPair, success: { msg in
        success(msg)
    }){(error) in
        failure(error)
    }
}
