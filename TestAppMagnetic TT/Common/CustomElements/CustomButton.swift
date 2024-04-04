//
//  CustomButton.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import UIKit

class CustomButton: UIButton {
    
    private var iconImageViewTopConstraint: NSLayoutConstraint!
    private var titleLblBottomConstraint: NSLayoutConstraint!
    private var titlerightConstraint: NSLayoutConstraint!
    private var titleLeftConstraint: NSLayoutConstraint!
    private var iconImageView: UIImageView!
    private var titleLbl: UILabel!
    
    // MARK: - Check button size
    override func layoutSubviews() {
        super.layoutSubviews()
        
            
        let screenSize = UIScreen.main.bounds.size
        let screenHeight = max(screenSize.width, screenSize.height)
        
        if screenHeight == 560 {
            titleLbl.font = UIFont(name: "Roboto-Regular", size: 13)
            setupForSEConstreints()
        } else {
            titleLbl.font = UIFont(name: "Roboto-Regular", size: 17)
            setupForBigScreen()
        }
        self.layoutIfNeeded()
    }
    
    init(icon: UIImage?, title: String) {
        super.init(frame: .zero)
        
        iconImageView = UIImageView(image: icon)
        titleLbl = UILabel()
        self.backgroundColor = UIColor.navigationCellColor
        self.layer.cornerRadius = 8
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let modifiedTitle = title.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
                                     .map(String.init)
                                     .joined(separator: "\n")
            
        titleLbl.text = modifiedTitle
        titleLbl.textAlignment = .center
        titleLbl.font = UIFont(name: "Roboto-Regular", size: 17)
        titleLbl.textColor = .white
        titleLbl.numberOfLines = 0
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconImageView)
        addSubview(titleLbl)
        
        heightAnchor.constraint(lessThanOrEqualToConstant: 140).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupForBigScreen() {
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        iconImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 44).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: titleLbl.topAnchor, constant: -10).isActive = true
        
        titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    private func setupForSEConstreints() {
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        iconImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 22).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: titleLbl.topAnchor, constant: -10).isActive = true
        
        titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
    }
}
