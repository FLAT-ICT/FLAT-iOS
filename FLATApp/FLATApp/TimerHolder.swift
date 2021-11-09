//
//  TimerHolder.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/09.
//

import SwiftUI
import Combine

class TimerHolder: ObservableObject{
    @Published var timer: Timer!
    
    func start() {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true){ _ in
            print("scanning...")
            // scanBeacon
        }
    }
}
