//
//  ApiView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/16.
//

import SwiftUI

struct Dummy: Codable{}

enum NetworkError : Error{//失敗した時用
    case unknown
    case invalidResponse
    case invalidURL
}


enum HttpMethod{
    case GET, POST, DELETE, PUT
}


public final class Api{
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let object = try decoder.decode(T2.self, from: data)
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
