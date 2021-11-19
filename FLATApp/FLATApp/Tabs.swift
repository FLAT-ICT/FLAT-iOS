//
//  Tabs.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/19.
//

import SwiftUI

//struct Tab {
//    var title: String
//}

struct Tabs: View {
    var fixed = true
    var tabsName: [String]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            ScrollViewReader {
                proxy in
                VStack(spacing: 0){
                    HStack(spacing: 0){
                        ForEach(0..<tabsName.count, id: \.self){ row in
                            Button(action: {
                                withAnimation{
                                    selectedTab = row
                                }
                            }, label:{
                                VStack(spacing: 0){
                                    Text(tabsName[row])
                                        .font(Font.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(width: fixed ? (geoWidth / (CGFloat(tabsName.count))) : .none, height: 52 )
                                    Rectangle().fill(selectedTab == row ? Color.white : Color.clear)
                                        .frame(height:3)
                                }
                                .background(Color("primary"))
                            })
                                .accentColor(.white)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selectedTab){ target in
                        withAnimation{
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
        .onAppear(perform: {
            UIScrollView.appearance().backgroundColor = UIColor(Color(.white))
            UIScrollView.appearance().bounces = !fixed
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs(tabsName: ["友だち", "未承認", "承認待ち"], geoWidth: 375, selectedTab: .constant(0))
    }
}
