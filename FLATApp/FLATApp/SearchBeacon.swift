//
//  SearchBeacon.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/15.
//

import Foundation
import CoreLocation
import Combine


class BeaconDetecter: NSObject, ObservableObject, CLLocationManagerDelegate{
    var didChange = PassthroughSubject<Void, Never>()
    var locationManager: CLLocationManager?
    @Published var lastDistance = CLProximity.unknown
    @Published var idBeacon: IdAndBeacon = IdAndBeacon(user_id: 1, major: 0, minor: 0, rssi: 1)
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
        let uuid = UUID(uuidString: "E8C65602-6D9C-44EF-9734-B2D3EF1CD961")!
//        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: 0, minor: 7954)
        let constraint = CLBeaconIdentityConstraint(uuid: uuid)
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: "MyBeacon")
        //self.id_beacon = IdAndBeacon(user_id: 1, major: 0, minor: 7954, rssi: -74)
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: constraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint){
        self.idBeacon = IdAndBeacon(user_id: 1, major: 0, minor: -1, rssi: 0)
        for beacon in beacons {
            if let beacon = beacons.first{
                update(distance: beacon.proximity)
                //print("major:\(beacon.major), minor:\(beacon.minor), rssi:\(beacon.rssi)")
                self.idBeacon = IdAndBeacon(user_id: 1, major: Int(beacon.major), minor: Int(beacon.minor), rssi: beacon.rssi)
            }else{
                update(distance: .unknown)
                //print("major:\(beacon.major), minor:\(beacon.minor), rssi:\(beacon.rssi)")
            }
        }
    }
    
    func update(distance: CLProximity){
        lastDistance = distance
        didChange.send(())
       // print(lastDistance.rawValue)
    }
}
