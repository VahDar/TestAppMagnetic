//
//  MagneticViewController.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import UIKit
import QuartzCore

class MagneticViewController: UIViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupUI()
        searchButtonPressed()  
    }
    
    // View
    private lazy var circleArrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageAssets.circleArrow.rawValue)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageAssets.arrow.rawValue)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var searchButton = UIButton.reusableButton(withTitle: "Search", fontSize: 20)
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textAlignment = .center
        label.text = "Search checking"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var speedometerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageAssets.speedometer.rawValue)
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageAssets.backgroundMagnetImage.rawValue)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var groupImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: ImageAssets.groupImage.rawValue)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        self.title = "Magnetic Detection"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: ImageAssets.chevronLeft.rawValue), for: .normal)
        backButton.setTitle(" Main", for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonItem
        backButton.sizeToFit()
    }
    
    //MARK: - Layout
    private func setupLayout() {
        [speedometerImage, circleArrowImage, arrowImage, infoLabel, searchButton, backgroundImage, groupImage].forEach(view.addSubview)
        
        speedometerImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(391)
        }
        
        circleArrowImage.snp.makeConstraints { make in
            make.top.equalTo(speedometerImage.snp.bottom).offset(-25)
            make.centerX.equalTo(speedometerImage.snp.centerX)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(circleArrowImage.snp.centerY)
            make.right.equalTo(circleArrowImage.snp.right).offset(-15)
            
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(speedometerImage.snp.bottom).offset(47)
            make.centerX.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-70)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(speedometerImage.snp.top).offset(-62)
            make.left.right.equalToSuperview()
        }
        
        groupImage.snp.makeConstraints { make in
            make.center.equalTo(backgroundImage.snp.center)
        }
    }
    
    //MARK: - Animation
    func searchButtonPressed() {
        searchButton.addTarget(self, action: #selector(animateArrow), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func animateArrow() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi
        rotationAnimation.duration = 2.0
        rotationAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotationAnimation.isRemovedOnCompletion = false
        arrowImage.layer.add(rotationAnimation, forKey: nil)
    }
}
