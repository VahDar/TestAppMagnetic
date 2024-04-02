//
//  ImageAssets.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import Foundation
import UIKit

enum ImageAssets: String {
    
    case alert = "alert"
    case checkmrk = "checkmarkIcon"
    case wifi = "wifi"
    case circle = "circle"
    case lamp = "lamp"
    case magnet = "magnet"
    case bluetooth = "bluetooth"
    case webcam = "webcam"
    case wifiSuccess = "wifiSuccess"
    case wifiFail = "wifiFail"
    case routerImage = "routerImage"
    case groupImage = "groupImage"
    case backgroundMainImage = "backgroundMainImage"
    case backgroundMagnetImage = "backgroundMagnetImage"
    case filter = "filter"
    case circleArrow = "circleArrow"
    case arrow = "arrow"
    case speedometer = "speedometer"
    case chevron = "chevronRight"
    case chevronLeft = "chevronLeft"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
