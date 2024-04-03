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
    private var updateLabelTask50: DispatchWorkItem?
    private var updateLabelTask100: DispatchWorkItem?
    
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
        image.image = ImageAssets.circleArrow.image
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.arrow.image
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var searchButton = UIButton.reusableButton(withTitle: "Search")
    
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
        image.image = ImageAssets.speedometer.image
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.backgroundMagnetImage.image
        image.alpha = 0.6
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var groupImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.groupImage.image
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
        backButton.setImage(ImageAssets.chevronLeft.image, for: .normal)
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
            make.top.equalTo(backgroundImage.snp.bottom).offset(62)
            make.right.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.lessThanOrEqualTo(187)
            make.bottom.equalTo(infoLabel.snp.top).offset(-25)
        }
        
        rotationContainer.snp.makeConstraints { make in
            make.top.equalTo(speedometerImage.snp.bottom).offset(-25)
            make.width.lessThanOrEqualTo(106)
            make.centerX.equalTo(speedometerImage.snp.centerX)
        }
        
        circleArrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(rotationContainer.snp.centerY)
            make.centerX.equalTo(rotationContainer.snp.centerX)
            make.height.width.lessThanOrEqualTo(32)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(rotationContainer.snp.centerY)
            make.width.lessThanOrEqualTo(80)
            make.centerX.equalTo(rotationContainer.snp.centerX).offset(-35)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(speedometerImage.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-36)
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.height.lessThanOrEqualTo(329)
            make.left.right.equalToSuperview()
            make.width.equalTo(backgroundImage.snp.height).multipliedBy(16.0/9.0).priority(.high)
        }
        
        groupImage.snp.makeConstraints { make in
            make.center.equalTo(backgroundImage)
            make.height.lessThanOrEqualTo(190)
            make.width.lessThanOrEqualTo(324)
            make.width.equalTo(groupImage.snp.height).multipliedBy(16.0/9.0).priority(.high)
        }
    }
    
    @objc private func backButtonPressed() {
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
        
        updateLabelTask50 = DispatchWorkItem {
            self.infoLabel.text = "50 µT"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: updateLabelTask50!)
        
        updateLabelTask100 = DispatchWorkItem {
            self.infoLabel.text = "100 µT"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: updateLabelTask100!)
    }
    
    private func stopAnimation() {
        searchButton.setTitle("Search", for: .normal)
        isAnimating = false
        self.infoLabel.text = "Search checking"
        
        updateLabelTask50?.cancel()
        updateLabelTask100?.cancel()
        
        rotationContainer.layer.removeAllAnimations()
        rotationContainer.transform = CGAffineTransform.identity
    }
}
