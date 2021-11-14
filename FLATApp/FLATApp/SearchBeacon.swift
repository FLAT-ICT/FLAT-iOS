//
//  SearchBeacon.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/15.
//

import Foundation
import CoreLocation
import Combine

class SearchBeacon: CLLocationManager, CLLocationManagerDelegate{
    let defaultUUID = "E8C65602-6D9C-44EF-9734-B2D3EF1CD961" //自分が持っているiBeaconのUUIDを指定
    var locationManager = CLLocationManager()

    var beaconConstraints = [CLBeaconIdentityConstraint: [CLBeacon]]()
    var beacons = [CLProximity: [CLBeacon]]()
    
//指定したUUIDを出す処理(タイムホルダーをスタートした時に指定したビーコンのUUID、メジャー、マイナー、RSSIを表示する）
   



func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
    let beaconRegion = region as? CLBeaconRegion
    if state == .inside {
        // Start ranging when inside a region.
        manager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
    } else {
        // Stop ranging when not inside a region.
        manager.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
    }


/// - Tag: didRange
func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
    /*
     Beacons are categorized by proximity. A beacon can satisfy
     multiple constraints and can be displayed multiple times.
     */
    beaconConstraints[beaconConstraint] = beacons
    
    self.beacons.removeAll()
    
    var allBeacons = [CLBeacon]()
    
    for regionResult in beaconConstraints.values {
        allBeacons.append(contentsOf: regionResult)
    }
    
    for range in [CLProximity.unknown, .immediate, .near, .far] {
        let proximityBeacons = allBeacons.filter { $0.proximity == range }
        if !proximityBeacons.isEmpty {
            self.beacons[range] = proximityBeacons
        }
    }
}
}
}
