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
    private lazy var infraredButton = CustomButton(icon: UIImage(named: ImageAssets.webcam.rawValue), title: "Infrared Detection")
    private lazy var bluetoothButton = CustomButton(icon: UIImage(named: ImageAssets.bluetooth.rawValue), title: "Bluetooth Detection")
    private lazy var magneticButton = CustomButton(icon: UIImage(named: ImageAssets.magnet.rawValue), title: "Magnetic Detection")
    private lazy var antispyButton = CustomButton(icon: UIImage(named: ImageAssets.lamp.rawValue), title: "Antispy Tips")
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
        stackView.heightAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: view.frame.height/2.5).isActive = true
        
        stackView.spacing = 35
        return stackView
    }()
    
    private lazy var imageBackground: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "backgroundMainImage")
        image.alpha = 0.6
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var wifiImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "routerImage")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var settingIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "filter")
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
            make.top.equalTo(informationView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-36)
            make.bottom.equalToSuperview().offset(-35)
        }
        
        imageBackground.snp.makeConstraints { make in
            make.height.equalTo(329)
            make.width.equalTo(390)
            make.top.leading.trailing.equalToSuperview()
        }
        
        wifiImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(107)
            make.centerX.equalToSuperview()
            make.height.equalTo(149)
            make.width.equalTo(323.5)
        }
        
        informationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(280)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        settingIcon.snp.makeConstraints { make in
            make.height.width.equalTo(21)
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

