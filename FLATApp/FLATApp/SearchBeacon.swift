//
//  SearchBeacon.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/15.
//

import Foundation
import CoreLocation
import Combine
import SwiftUI


class BeaconDetecter: NSObject, ObservableObject, CLLocationManagerDelegate{
    var didChange = PassthroughSubject<Void, Never>()
    var locationManager: CLLocationManager?
    var tmp_beacons: [CLBeacon] = []
    @AppStorage("id") private var id = -1
    @Published var lastDistance = CLProximity.unknown
    @Published var idBeacon: IdAndBeacon = IdAndBeacon(userId: 1, major: 0, minor: -1, rssi: 1)
    override init(){
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.distanceFilter = 10
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if status == .authorizedWhenInUse{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    //we are good to go!
                    startScanning()
                }
            }
        }
    }
    
    func startScanning(){
        for regionInfo in REGIONS{
            let uuid = UUID(uuidString: regionInfo.uuid)!
            let constraint = CLBeaconIdentityConstraint(uuid: uuid)
            let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: regionInfo.regionName)
            locationManager?.startMonitoring(for: beaconRegion)
            locationManager?.startRangingBeacons(satisfying: constraint)
        }
        //        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: 0, minor: 7954)
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint){
        // for beacon in beacons { // 多分このfor文いらない。動かなかったら戻す
        var _beacons = beacons.filter{$0.rssi != 0}
        if _beacons.isEmpty{
            _beacons = tmp_beacons
        }else{
            tmp_beacons = _beacons
        }
        print(_beacons)
        // rssiが一番大きいビーコンを取得する。直近30回分のRSSIについて平均をとり、最大のものを返すように実装し直した方がいい
        if let beacon = _beacons.max(by: {a, b in a.rssi < b.rssi}){
            update(distance: beacon.proximity)
            self.idBeacon = IdAndBeacon(userId: self.id, major: (beacon.major as! Int), minor: (beacon.minor as! Int), rssi: beacon.rssi)
            print("major:\(self.idBeacon.major), minor:\(self.idBeacon.minor), rssi:\(self.idBeacon.rssi)")
        }else{
            update(distance: .unknown)
            print("major:\(self.idBeacon.major), minor:\(self.idBeacon.minor), rssi:\(self.idBeacon.rssi)")
        }
        // }
    }
    
    func update(distance: CLProximity){
        lastDistance = distance
        didChange.send(())
        // print(lastDistance.rawValue)
    }
}
