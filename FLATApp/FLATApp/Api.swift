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
enum NetworkError : Error{//失敗した時用
    case unknown
    case invalidResponse
    case invalidURL
}


func searchName(target_name: String,
              success: @escaping ([UserData]) -> (),
              failure: @escaping (Error) -> ()
){ //相手の名前を検索した時にその名前をURLに入れる
    guard let target_name_encode = target_name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        return
    }
    
    let req_url = "http://34.68.157.198:8080/v1/user/search?my_id=0&target_name=\(target_name_encode)"
   
    Api().checkUser(urlString: req_url, success: {(dictionary) in
        success(dictionary)
    }) {(error) in
        failure(error)
    }
}

func postNamesearch(target_name: String,
                    success: @escaping ([UserData]) -> (),
                    failure: @escaping (Error) -> ()){//申請ボタンを押した時に友人の名前をPOSTする
    let req_url = "http://34.68.157.198:8080/"
    Api().postfriends(urlString: req_url, success: {(dictionary) in
        success(dictionary)
    }) {(error) in
        failure(error)
    }
}

class Api{
    
    //    @Published var userData = UserData()
    
    func checkUser(//GET用
        urlString: String,
        success: @escaping ([UserData]) -> (),
        failure: @escaping (Error) -> ()
    ){
        guard let url = URL(string: urlString) else {
            return failure(NetworkError.invalidURL)
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
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
                    let object = try JSONDecoder().decode([UserData].self, from: data)
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
    
    func postfriends(//POST用
        urlString: String,
        success: @escaping ([UserData]) -> (),
        failure: @escaping (Error) -> ()
    ){
        guard let url = URL(string: urlString) else {
            return failure(NetworkError.invalidURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
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
                    let object = try JSONDecoder().decode([UserData].self, from: data)
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
    
    func requestAsyncJson(
        urlString: String,
        success: @escaping ([Dictionary<String, Any>]) -> (),
        failure: @escaping (Error) -> ()){
            
            guard let url = URL(string: urlString) else {
                return failure(NetworkError.invalidURL)
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
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
                        
                        let object = try JSONSerialization.jsonObject(with: data, options: []) as! [Dictionary<String, Any>]
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
