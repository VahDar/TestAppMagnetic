//
//  UIButton.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import UIKit

extension UIButton {
    static func reusableButton(withTitle title: String, fontSize: CGFloat = 20) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        
        if let robotoFont = UIFont(name: "Roboto-Bold", size: fontSize) {
            button.titleLabel?.font = robotoFont
        } else {
            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        }
        button.backgroundColor = UIColor.buttonColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 27
        button.layer.masksToBounds = true
        
        return button
    }
    
//    static func customButton(withTitle title: UILabel, fontSize: CGFloat = 20) -> UIButton {
//        let button = UIButton(type: .system)
//        button.setTitle(title, for: .normal)
//        
//        if let robotoFont = UIFont(name: "Roboto-Regular", size: fontSize) {
//            button.titleLabel?.font = robotoFont
//        } else {
//            button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
//        }
//        button.backgroundColor = UIColor.buttonColor
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.layer.cornerRadius = 27
//        button.layer.masksToBounds = true
//        
//        return button
//    }
}
