//
//  MagneticViewController.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import UIKit

class MagneticViewController: UIViewController {
    
    //MARK: - Properties
    private var isAnimating = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupUI()
        searchButtonPressed()
    }
    
    // MARK: - View
    
    private lazy var rotationContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
        image.contentMode = .scaleAspectFit
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
        
        [rotationContainer, speedometerImage, infoLabel, searchButton, backgroundImage, groupImage].forEach(view.addSubview)
        rotationContainer.addSubview(circleArrowImage)
        rotationContainer.addSubview(arrowImage)
        rotationContainer.sendSubviewToBack(circleArrowImage)
        rotationContainer.layoutIfNeeded()
        
        speedometerImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(391)
        }
        
        rotationContainer.snp.makeConstraints { make in
            make.top.equalTo(speedometerImage.snp.bottom).offset(-25)
            make.centerX.equalTo(speedometerImage.snp.centerX)
        }
        
        circleArrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(rotationContainer.snp.centerY)
            make.centerX.equalTo(rotationContainer.snp.centerX)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(rotationContainer.snp.centerY)
            make.centerX.equalTo(rotationContainer.snp.centerX).offset(-35)
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
            make.top.equalToSuperview().offset(109)
            make.bottom.equalTo(speedometerImage.snp.top).offset(-92)
            make.left.equalToSuperview().offset(33)
            make.right.equalToSuperview().offset(-33)
            
        }
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Animation
    func searchButtonPressed() {
        searchButton.addTarget(self, action: #selector(animateArrow), for: .touchUpInside)
    }
    
    @objc private func animateArrow() {
        isAnimating ? stopAnimation() : startAnimation()
    }
    
    
    private func startAnimation() {
        searchButton.setTitle("Stop", for: .normal)
        isAnimating = true
        
        let forwardAnimation = CABasicAnimation(keyPath: "transform.rotation")
        forwardAnimation.fromValue = 0
        forwardAnimation.toValue = CGFloat.pi
        forwardAnimation.duration = 5.0
        forwardAnimation.fillMode = .forwards
        forwardAnimation.isRemovedOnCompletion = false
        
        rotationContainer.layer.add(forwardAnimation, forKey: "forwardAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.infoLabel.text = "50 µT"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.infoLabel.text = "100 µT"
        }
    }
    
    private func stopAnimation() {
        searchButton.setTitle("Search", for: .normal)
        isAnimating = false
        self.infoLabel.text = "Search checking"
        
        let reverseAnimation = CABasicAnimation(keyPath: "transform.rotation")
        reverseAnimation.fromValue = CGFloat.pi
        reverseAnimation.toValue = 0
        reverseAnimation.duration = 2.0
        reverseAnimation.fillMode = .forwards
        reverseAnimation.isRemovedOnCompletion = false
        
        rotationContainer.layer.add(reverseAnimation, forKey: "reverseAnimation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.rotationContainer.transform = .identity
        }
    }
}
