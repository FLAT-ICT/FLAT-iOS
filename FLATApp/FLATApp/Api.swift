//
//  ApiView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/16.
//

import SwiftUI

struct UserData: Decodable, Identifiable {
    var id: Int
    var name: String
    var icon_path: String
    var applied: Bool
    var requested: Bool
}

struct Dummy: Codable{}

enum NetworkError : Error{//失敗した時用
    case unknown
    case invalidResponse
    case invalidURL
}


enum HttpMethod{
    case GET, POST, DELETE, PUT
}


func searchName(target_name: String,
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


struct IdAndBeacon: Codable{
    var user_id: Int
    var major: Int
    var minor: Int
    var rssi: Int
}

func sendBeacon(beacon: IdAndBeacon,
                success: @escaping ([String:String]) -> (),
                failure: @escaping (Error) -> ()
){
    let req_url = "/v1/user/beacon"
    Api.util(endpoint: req_url, method: HttpMethod.POST, args: beacon, success: {(msg:[String:String]) in
//        print(msg)
        success(msg)
    }) {(error) in
        failure(error)
    }
}

final class Api{
    private init(){}
    static var baseUrl = "http://34.68.157.198:8080"
    static let shared = URLSession.shared
    
    class func util<T1: Codable, T2: Decodable>(
        endpoint: String,
        method: HttpMethod,
        args: T1,
        success: @escaping (T2) -> (),
        failure: @escaping (Error) -> ()
    ){
            
        guard let url = URL(string: baseUrl + endpoint) else {
                return failure(NetworkError.invalidURL)
            }
            var request = URLRequest(url: url)
        switch(method){
        case .GET:
            request.httpMethod = "GET"
        case .POST:
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "content-type")
            print(args)
            guard let httpBody = try? JSONEncoder().encode(args) else {
                print("invalid body")
                return
            }
            print(httpBody)
            request.httpBody = httpBody
            
        case .DELETE:
            request.httpMethod = "DELETE"
        case .PUT:
            request.httpMethod = "PUT"
        }
        shared.dataTask(with: request, completionHandler: {data, response, error in
            if let error = error {
                print(error.localizedDescription)
                failure(error)
                return
            }
            
            guard let data = data,
                    let response = response as? HTTPURLResponse else {
                        print("データまたはレスポンスがnil")
                        failure(NetworkError.unknown)
                        return
                    }
            if response.statusCode == 200 {
                do {
                    let object = try JSONDecoder().decode(T2.self, from: data)
                        // print(object["id"])
                        success(object)
                    } catch let error {
                        failure(error)
                    }
                } else {
                    print("statusCode: \(response.statusCode)")
                    failure(NetworkError.unknown)
                }
            }).resume()
        }
}
