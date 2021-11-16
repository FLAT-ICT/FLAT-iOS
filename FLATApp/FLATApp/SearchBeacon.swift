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
    //let defaultUUID = "E8C65602-6D9C-44EF-9734-B2D3EF1CD961" //自分が持っているiBeaconのUUIDを指定
    var locationManager = CLLocationManager()
    var beaconConstraints = [CLBeaconIdentityConstraint: [CLBeacon]]()
    var beacons = [CLProximity: [CLBeacon]]()
    var isBeaconRange :Bool = false
    let uuid = "E8C65602-6D9C-44EF-9734-B2D3EF1CD961"//自分のiBeaconを指定
    var majorBeacon = Int()
    var minorBeacon = Int()
    var rssiBeacon = Float()
    //指定したUUIDを出す処理(タイムホルダーをスタートした時に指定したビーコンのUUID、メジャー、マイナー、RSSIを表示する）
    
    init(uuids: [String]) {
        super.init()
        locationManager.delegate = self
        
        for uuid in uuids {
            self.monitoringBeacon(setUUID: uuid)
        }
    }
    func monitoringBeacon (setUUID: String) {
        
        if let uuid = UUID(uuidString: setUUID) {
            self.locationManager.requestWhenInUseAuthorization() //アプリ使用中許可
            let constraint = CLBeaconIdentityConstraint(uuid: uuid) //特定したビーコンの制約
            self.beaconConstraints[constraint] = []  //制約を保存する配列
            let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: setUUID)
            //CLbeaconRegion < CLRegionより代入できる
            self.locationManager.startMonitoring(for: beaconRegion)
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        let beaconRegion = region as? CLBeaconRegion
        if state == .inside {
            // Start ranging when inside a region.
            print("検知中")
            manager.startRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        } else {
            // Stop ranging when not inside a region.
            print("検知停止")
            manager.stopRangingBeacons(satisfying: beaconRegion!.beaconIdentityConstraint)
        }
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
    
//    func PrintBeacon(titleForHeaderInSection section: Int) -> String? {
//        var title: String?
//        let sectionKeys = Array(beacons.keys)
//        
//        // The table view displays beacons by proximity.
//        let sectionKey = sectionKeys[section]
//        
//        
//        switch sectionKey {
//            case .immediate:
//                title = "Immediate"
//            case .near:
//                title = "Near"
//            case .far:
//                title = "Far"
//            default:
//                title = "Unknown"
//        }
//        
//        return title
//    }
//    func numberOfSections() -> Int {
//        return beacons.count
//    }
//    
//    func PrintBeacon(numberOfRowsInSection section: Int) -> Int {
//        return Array(beacons.values)[section].count
//    }
//    
//    func PrintBeacon(cellForRowAt indexPath: IndexPath) -> String {
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//
//        // Display the UUID, major, and minor for each beacon.
//        let sectionkey = Array(beacons.keys)[indexPath.section]
//        let beacon = beacons[sectionkey]![indexPath.row]
//    
//        
//        print(beacon.uuid.uuidString)
//        print(beacon.major)
//        print(beacon.minor)
//        
//    }


        
            
//            for distance in allBeacons{
//                //位置情報許可
//                let accuracyBeacons = distance.accuracy
//                let rssiBeacon = distance.rssi
//                let doubleAccuracyBeacons: Double = Double(accuracyBeacons)
//                let stringAccuracyBeacons = String(format: "accuracy: %.3f m", doubleAccuracyBeacons)
//                let uuidBeacons = distance.uuid
//                majorBeacon = Int(distance.major.intValue)
//                minorBeacon = Int(distance.minor.intValue)
//                print("major: \(majorBeacon)")
//                print("miner: \(minorBeacon)")
//                print("rssi: \(rssiBeacon)")
//                if distance.uuid.uuidString == uuid {
//                    isBeaconRange = true
//                }else{
//                    isBeaconRange = false
//                }
//            }
        
//    func changeView() {
//            //viewが消えたときにモニタリング停止
//            for region in locationManager.monitoredRegions {
//                locationManager.stopMonitoring(for: region)
//            }
//            //viewが消えたときにレンジング停止
//            for constraint in beaconConstraints.keys {
//                locationManager.stopRangingBeacons(satisfying: constraint)
//            }
//        }
}
