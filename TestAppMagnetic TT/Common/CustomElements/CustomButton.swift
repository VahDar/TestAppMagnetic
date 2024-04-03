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

        let buttonWidth = self.bounds.size.width
        let buttonHeight = self.bounds.size.height

        if buttonWidth < 80 || buttonHeight < 80 {
            titleLbl.font = UIFont(name: "Roboto-Regular", size: 11)
            setupForSEConstreints()
        } else if buttonWidth < 120 || buttonHeight < 120 {
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
        
        titleLbl.text = title
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
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: titleLbl.topAnchor, constant: -10).isActive = true
        
        titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    private func setupForSEConstreints() {
        iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: titleLbl.topAnchor, constant: -5).isActive = true
        
        titleLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLbl.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5).isActive = true
        titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
}
