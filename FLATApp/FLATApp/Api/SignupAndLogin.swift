//
//  SignupAndLogin.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/30.
//

import Foundation


struct Credential: Codable{
    var name: String
    var password: String
}

func signup(credential: Credential,
            success: @escaping (User) -> (),
            failure: @escaping (Error) -> ()) {
    let reqUrl="/v1/register"
    Api.util(endpoint: reqUrl, method: .POST, args:
            credential, success: { user in
        success(user)
    }){(error) in
        failure(error)
    }
}

func login(credential: Credential,
            success: @escaping (User) -> (),
            failure: @escaping (Error) -> ()) {
    let reqUrl="/v1/login"
    Api.util(endpoint: reqUrl, method: .POST, args:
            credential, success: { user in
        success(user)
    }){(error) in
        failure(error)
    }
}

//func logout(){
//    let reqUrl="/v1/login"
//    Api.util(endpoint: reqUrl, method: .POST, args:
//            credential, success: { user in
//        success(user)
//    }){(error) in
//        failure(error)
//    }
//}
