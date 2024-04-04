//
//  MainScreenViewController.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import UIKit
import SnapKit

class MainScreenViewController: UIViewController {
    
    //MARK: - Properties
    var informationView: InformationView!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        informationView = InformationView()
        setupUI()
        constraints()
        magneticButtonPressed()
        goToScanScreen()
    }
    
    //MARK: - View
    private lazy var infraredButton = CustomButton(icon: ImageAssets.webcam.image, title: "Infrared Detection")
    private lazy var bluetoothButton = CustomButton(icon: ImageAssets.bluetooth.image, title: "Bluetooth Detection")
    private lazy var magneticButton = CustomButton(icon: ImageAssets.magnet.image, title: "Magnetic Detection")
    private lazy var antispyButton = CustomButton(icon: ImageAssets.lamp.image, title: "Antispy Tips")
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topRowStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infraredButton, bluetoothButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 35
        return stackView
    }()
    
    private lazy var bottomRowStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [magneticButton, antispyButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 35
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topRowStackView, bottomRowStackView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 35
        return stackView
    }()
    
    private lazy var imageBackground: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.backgroundMainImage.image
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var wifiImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.routerImage.image
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var settingIcon: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.filter.image
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - SetupUI and Constraints
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        
    }
    
    private func constraints() {
        [mainStackView, imageBackground, wifiImage, informationView, settingIcon].forEach(view.addSubview)
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(informationView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-36)
            make.bottom.equalToSuperview().offset(-35)
        }
        
        imageBackground.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(informationView.snp.top).offset(49)
        }
        
        wifiImage.snp.makeConstraints { make in
            make.centerY.equalTo(imageBackground)
            make.left.equalToSuperview().offset(33)
            make.right.equalToSuperview().offset(-33.5)
            make.width.equalTo(wifiImage.snp.height).multipliedBy(16.0/9.0).priority(.high)
        }
        
        informationView.snp.makeConstraints { make in
            make.bottom.equalTo(mainStackView.snp.top).offset(-15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.lessThanOrEqualTo(198)
        }
        
        settingIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    
    //MARK: - Action
    private func magneticButtonPressed() {
        magneticButton.addTarget(self, action: #selector(magneticButtonTapped), for: .touchUpInside)
    }
    
    @objc private func magneticButtonTapped() {
        let magneticViewController = MagneticViewController()
        navigationController?.pushViewController(magneticViewController, animated: true)
    }
    
    private func goToScanScreen() {
        informationView.onscanButtonTap = {
            let scanViewController = ScanViewController()
            self.navigationController?.pushViewController(scanViewController, animated: true)
        }
    }
}

