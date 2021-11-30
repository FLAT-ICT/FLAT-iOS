//
//  FLATAppApp.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/10/09.
//

import SwiftUI
import CoreLocation

@main
struct FLATAppApp: App {
    @ObservedObject var timerHolder = TimerHolder()
    // アプリが起動して初めて走る処理
    init(){
        // @AppStorage("name") var name = ~~~
        // の形で代入すると代入した値が捨てられ、下の値を使えるようになる
        UserDefaults.standard.register(defaults: [
            "name": "test0",
            "id": 1,
            "status": 0,
            "spot": "",
            "iconPath": "",
            "loggedinAt": "",
            "isFirstVisit": true
        ])
        timerHolder.start()
    }
    
    
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "isFirstVisit"){
                StartupView()
            }else{
                ContentView()
            }
        }
    }
}

//class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
//    var locationManager : CLLocationManager?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        locationManager = CLLocationManager()
//        locationManager!.delegate = self
//       locationManager!.requestAlwaysAuthorization()
//        //locationManager!.requestWhenInUseAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager!.distanceFilter = 10
//            locationManager!.activityType = .fitness
//            locationManager!.startUpdatingLocation()
//        }
//
//        return true
//    }

//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {//前回コードコード
//        guard let newLocation = locations.last else {
//            return
//        }
//
//        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
//
//        print("緯度: ", location.latitude, "経度: ", location.longitude)
//        }

