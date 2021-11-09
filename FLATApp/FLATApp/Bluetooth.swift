//
//  Bluetooth.swift
//  FLATApp
//
//  Created by 小田嶋　亜美 on 2021/11/01.
//

import CoreBluetooth
import UIKit
import SwiftUI

class Bluetooth: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    
        override init () {
            // CentralManager 初期化
            super.init()
            centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: true])
    }
     
    
    // CentralManager status
    func centralManagerDidUpdateState(_ central: CBCentralManager) {//セントラルマネージャーを起動する
        switch central.state {
        case CBManagerState.poweredOn:
            print("CBManager is powered on")
            return
        case CBManagerState.poweredOff:
            print("CBManager is not powered on")
            return
        case CBManagerState.resetting:
            print("CBManager is resetting")
        case CBManagerState.unauthorized:
            print("Unexpected authorization")
            return
        case CBManagerState.unknown:
            print("CBManager state is unknown")
            return
        case CBManagerState.unsupported:
            print("Bluetooth is not supported on this device")
            return
        @unknown default:
            print("A previously unknown central manager state occurred")
            return
        }
    }
    
     // Peripheral探索結果を受信
        func centralManager(_ central: CBCentralManager,
                            didDiscover peripheral: CBPeripheral,
                            advertisementData: [String: Any],
                            rssi RSSI: NSNumber) {
            self.centralManager.connect(peripheral, options: nil)
                   self.peripheral = peripheral
                   self.centralManager.stopScan()
            print("pheripheral.name: \(String(describing: peripheral.name))")
            print("advertisementData:\(advertisementData)")
            print("RSSI: \(RSSI)")
            print("peripheral.identifier.uuidString: \(peripheral.identifier.uuidString)\n")
        }
    
    // 接続時に呼ばれる
        func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
            self.peripheral.delegate = self
            self.peripheral.discoverServices(nil)
        }
    // サービスの取得時に呼ばれる
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            self.peripheral.discoverCharacteristics(nil, for: (peripheral.services?.first)!)
        }

        // キャラクタリスティック取得時に呼ばれる
        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        }
   
}
    
//    var centralManager: CBCentralManager?
//
//    override init () {
//        super.init()
//        centralManager = CBCentralManager(delegate: self, queue: nil)
//    }
//
//    func scanStart() {//ペレフィラルを検出するためにスキャン開始
//        if centralManager!.isScanning == false {
//            // サービスのUUIDを指定しない
//            centralManager!.scanForPeripherals(withServices: nil, options: nil)
//
//            // サービスのUUIDを指定する
//            // let service: CBUUID = CBUUID(string: "サービスのUUID")
//            // centralManager!.scanForPeripherals(withServices: service, options: nil)
//        }
//    }
//
//    func stopBluetoothScan() {//スキャン停止
//        self.centralManager!.stopScan()
//    }
//
//
//    var peripherals: [CBPeripheral] = []//ペレフィラルと接続
//
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        peripherals.append(peripheral)
//    }
//
//    var cbPeripheral: CBPeripheral? = nil
//
//    func connect() {//ペレフィラルと接続
//        for peripheral in peripherals {
//            if peripheral.name != nil && peripheral.name == "デバイス名" {
//                cbPeripheral = peripheral
//                centralManager?.stopScan()
//                break;
//            }
//        }
//
//        if cbPeripheral != nil {
//            centralManager!.connect(cbPeripheral!, options: nil)
//        }
//    }
//
//
//    // 接続が成功すると呼ばれるデリゲートメソッド
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        cbPeripheral?.delegate = self
//
//        //           // 指定のサービスを探す
//        //           let services: [CBUUID] = [CBUUID(string: "サービスのUUID")]
//        //           cbPeripheral!.discoverServices(services)
//        cbPeripheral!.discoverServices(nil)// すべてのサービスを探す
//    }
//
//    // 接続が失敗すると呼ばれるデリゲートメソッド
//    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
//        print("connection failed.")
//    }
//
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {//サービスが見つかり、キャラクタリスティックを探す
//        let serviceUUID: CBUUID = CBUUID(string: "サービスのUUID")
//        for service in cbPeripheral!.services! {
//            if(service.uuid == serviceUUID) {
//                cbPeripheral?.discoverCharacteristics(nil, for: service)
//            }
//        }
//    }
//
//    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {//キャラクタリスティックを発見
//        guard error == nil else {
//            print("キャラクタリスティックデータ書き込み時エラー：\(String(describing: error))")
//            // 失敗処理
//            return
//        }
//        // 読み込み開始
//        peripheral.readValue(for: characteristic)
//    }
//
//    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {//データを更新
//        guard error == nil else {
//            print("キャラクタリスティック値取得・変更時エラー：\(String(describing: error))")
//            // 失敗処理
//            return
//        }
//        guard let data = characteristic.value else {
//            // 失敗処理
//            return
//        }
//        // データが渡ってくる
//        print(data)
//    }
//
//}
//
////    // begin to scan
////    func startScan(){
////        print("begin to scan ...")
////        centralManager.scanForPeripherals(withServices: nil)
////    }
////
////    // stop scan
////    func stopBluetoothScan() {
////        self.centralManager.stopScan()
////    }
////
////    // Peripheral探索結果を受信
////    func centralManager(_ central: CBCentralManager,
////                        didDiscover peripheral: CBPeripheral,
////                        advertisementData: [String: Any],
////                        rssi RSSI: NSNumber) {
////
////        print("pheripheral.name: \(String(describing: peripheral.name))")
////        print("advertisementData:\(advertisementData)")
////        print("RSSI: \(RSSI)")
////        print("peripheral.identifier.uuidString: \(peripheral.identifier.uuidString)\n")
////    }
////
//
