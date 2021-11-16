//
//  SearchBeaconView.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/16.
//

import SwiftUI
import Combine
import CoreLocation

class BeaconDetecter: NSObject, ObservableObject, CLLocationManagerDelegate{
    var didChange = PassthroughSubject<Void, Never>()
    var locationManager: CLLocationManager?
    @Published var lastDistance = CLProximity.unknown
    override init(){
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
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
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: constraint)
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint){
        if let beacon = beacons.first{
            update(distance: beacon.proximity)
        }else{
            update(distance: .unknown)
        }
    }
    
    func update(distance: CLProximity){
        lastDistance = distance
        didChange.send(())
        print(lastDistance.rawValue)
    }
}

struct BigText: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(Font.system(size: 72, design: .rounded))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,maxHeight: .infinity)
    }
}

struct SearchBeaconView: View {
    @ObservedObject var detector = BeaconDetecter()
    var body: some View {
        if detector.lastDistance == .immediate{
            return Text("Reght Here")
                .modifier(BigText())
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)
        }else if detector.lastDistance == .near{
            return Text("Near")
                .modifier(BigText())
                .background(Color.orange)
                .edgesIgnoringSafeArea(.all)
        }else if detector.lastDistance == .far{
            return Text("Far")
                .modifier(BigText())
                .background(Color.blue)
                .edgesIgnoringSafeArea(.all)
        }else {
        return Text("Unknow")
            .modifier(BigText())
            .background(Color.gray)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SearchBeaconView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBeaconView()
    }
}
