//
//  TimerHolder.swift
//  FLATApp
//
//  Created by t4t5u0 on 2021/11/09.
//

import Foundation
import Combine
import SwiftUI

class TimerHolder: ObservableObject{
    @Published var timer: AnyCancellable!
    // これ使ってなさそう
    // @State var idBeacon: IdAndBeacon = IdAndBeacon(user_id: 1, major: 0, minor: 1, rssi: 1)
    @State var bluetooth = Bluetooth()
    @ObservedObject var detector = BeaconDetecter()
    // init(){}
    
    func start() {
        if let _timer = timer{
            _timer.cancel()
        }
        timer = Timer.publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: ({ _ in
                print("scanning...")
                // scanBeacon
                //self.idBeacon = IdAndBeacon(user_id: 1, major: 0, minor: 1, rssi: 1)
                sendBeacon(beacon: self.detector.idBeacon, success: {
                    (msg: [String:String]) in print(msg["message"] ?? "no message")
                }
                ) { (error) in print(error)}
            }))
        //        self.timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true){ _ in
        //            print("scanning...")
        //            // scanBeacon
        //            self.id_beacon = IdAndBeacon(user_id: 1, uuid: "this-is-uuid", major: 0, minor: 1, rssi: 1.0, distance: 1.0)
        //            sendBeacon(beacon: self.id_beacon, success: {
        //                (msg: [String:String]) in print(msg["message"] ?? "no message")
        //                }
        //            ) { (error) in print(error)}
        //        }
    }
}
