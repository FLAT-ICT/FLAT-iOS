//
//  IconLoader.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/19.
//

import SwiftUI
import Combine

class IconLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data(){
        didSet {
            didChange.send(data)
        }
    }
    
    init(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct IconLoaderView: View {
    var size: CGFloat
    @ObservedObject var iconLoader: IconLoader
    @State var image: UIImage = UIImage()
    
    init(size: Int, withUrl url: String){
        iconLoader = IconLoader(urlString: url)
        self.size = CGFloat(size)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: size, height: size)
            .cornerRadius(size/2)
            .onReceive(iconLoader.didChange){data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}

//struct IconLoader_Previews: PreviewProvider {
//    static var previews: some View {
//        IconLoaderView()
//    }
//}
