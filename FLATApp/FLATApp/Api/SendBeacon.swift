//
//  SendBeacon.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/10.
//

struct IdAndBeacon: Codable{
    var user_id: Int
    var uuid: String
    var major: Int
    var minor: Int
    var rssi: Float
    var distance: Float
}

func sendBeacon(beacon: IdAndBeacon,
                success: @escaping ([String:String]) -> (),
                failure: @escaping (Error) -> ()
){
    let reqUrl = "/v1/user/beacon"
    Api.util(endpoint: reqUrl, method: HttpMethod.POST, args: beacon, success: {(msg:[String:String]) in
        print(msg)
        success(msg)
    }) {(error) in
        failure(error)
    }
}
