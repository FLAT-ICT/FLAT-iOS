//
//  IDsearchView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI



struct IDsearchView: View { //友達追加画面
    @State private var editting = false
    @Binding var isActive: Bool
    @State private var user: UserData = UserData(id: "", name: "",  icon_path: "",applied: false, requested: false)//通信用
    
    struct UserData: Codable {
        var id: String
        var name: String
        var icon_path: String
        var applied: Bool
        var requested: Bool
    }
    
    var body: some View {
        VStack(){
            HStack(){ //上のキャンセルボタン
                Button("キャンセル") {
                    isActive = false
                }
                Spacer()
                    .padding(.top, 44)
            }
            .padding(.leading, 25.0)
            Divider()
        }
        VStack(){ //ID入力項目
            VStack(){
                Text("IDを入力してください")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 25.0)
            }
            VStack(){
                HStack(){
                    TextField("000000", text: $user.id)
                        .padding(3.0)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.leading,24.0)
                .padding(.trailing,24.0)
            }
            VStack{
                Button("検索"){//検索ボタン
                    getData()
                    
                }
                .padding()
                Text(user.name)
                Text(user.icon_path)
                    .padding()
            }
        }
        .padding(.top,139)
        Spacer()
    }
    
    
    func getData() {
        guard let url = URL(string: "http://34.68.157.198:8080/") else { return }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let userdata = data {
                    let decodedData = try JSONDecoder().decode(UserData.self, from: userdata)
                    self.user = decodedData
                } else {
                    print("No data", data as Any)
                }
            } catch {
                print("Error", error)
            }
        }.resume()
    }
}

struct IDsearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
