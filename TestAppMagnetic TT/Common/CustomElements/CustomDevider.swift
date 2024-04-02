//
//  CustomDevider.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 02.04.2024.
//

import UIKit

class CustomDividerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDivider()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDivider()
    }

    private func setupDivider() {
        backgroundColor = UIColor(white: 1, alpha: 0.4)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
