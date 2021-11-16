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
    @State var id_beacon: IdAndBeacon = IdAndBeacon(user_id: 1, uuid: "this-is-uuid", major: 0, minor: 1, rssi: 1.0, distance: 1.0)
    @State var bluetooth = Bluetooth()
    //@State var searchbeacon = SearchBeacon(uuids: ["E8C65602-6D9C-44EF-9734-B2D3EF1CD961"])//ビーコンのUUIDのリストを入れる
//    init(){}
    
    func start() {
        if let _timer = timer{
            _timer.cancel()
        }
        timer = Timer.publish(every: 30, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: ({ _ in
                print("scanning...")
                //self.bluetooth.startScan()
               //ビーコン検知呼び出し
                //self.searchbeacon.locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion)
                self.id_beacon = IdAndBeacon(user_id: 1, uuid: "this-is-uuid", major: 0, minor: 1, rssi: 1.0, distance: 1.0)
                sendBeacon(beacon: self.id_beacon, success: {
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
