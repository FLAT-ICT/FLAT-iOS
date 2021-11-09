//
//  GetFriends.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/10.
//

struct User: Identifiable, Codable {//ローカルデータ
    var id: Int //ID
    var name: String //名前
    var status: String //ステータス
    var beacon: String //場所
    var iconPath: String //アイコン
}

struct FriendList: Codable{
    var oneSide: [User]
    var mutual: [User]
}

func getFriends(id: Int,
                success: @escaping (FriendList) -> (),
                failure: @escaping (Error) -> ()
){
    let req_url = "/v1/friends?my_id=\(id)"
    Api.util(endpoint: req_url, method: HttpMethod.GET, args: Dummy(), success: { (friendList: FriendList) in
        success(friendList)
    }) {(error) in
        failure(error)
    }
    
}
