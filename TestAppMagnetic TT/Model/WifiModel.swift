//
//  WifiModel.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import Foundation

struct WifiModel: Codable {
    var name: String
    var status: Bool
    var ip: String
    var macAddress: String
    var hostname: String
    
    static let wifiData: [WifiModel] = Bundle.main.decode(file: "wifi.json")
    
}

extension WifiModel: Hashable {
        
     static var MOCK_USER = WifiModel(name: "Iphone", status: true, ip: "192.168.1.51", macAddress: "Not Available", hostname: "My spot")
 }
