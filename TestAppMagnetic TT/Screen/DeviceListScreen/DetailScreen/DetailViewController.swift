//
//  DetailViewController.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 02.04.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    var device: WifiModel?
    let dividerOne = CustomDividerView()
    let dividerTwo = CustomDividerView()
    let dividerThree = CustomDividerView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        constraints()
    }
    
    // MARK: - Init
    init(device: WifiModel) {
        self.device = device
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColorInfoColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cameraLabel: UILabel = {
        let label = UILabel()
        label.text = "Camera"
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        label.textColor = .purpleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.backgroundMainImage.image
        image.contentMode = .scaleAspectFill
        image.alpha = 0.6
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var circleImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.circle.image
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var wifiImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.wifi.image
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var statusImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var connectLabel = label(text: "Connection Type", textColor: .white, textAlignment: .left)
    
    private lazy var ipMainLabel = label(text: "", textColor: .white, textAlignment: .center)
    
    private lazy var ipAddressLabel = label(text: "IP Address", textColor: .white, textAlignment: .left)
    
    private lazy var macAddressLabel = label(text: "MAC Address", textColor: .white, textAlignment: .left)
    
    private lazy var hostnameLabel = label(text: "Hostname", textColor: .white, textAlignment: .left)
    
    private lazy var connectWifiLabel = label(text: "Wifi", textColor: .grayColor, textAlignment: .right)
    
    private lazy var ipLabel = label(text: "", textColor: .grayColor, textAlignment: .right)
    
    private lazy var macLabel = label(text: "", textColor: .grayColor, textAlignment: .right)
    
    private lazy var hostLabel = label(text: "", textColor: .grayColor, textAlignment: .right)
    
    // MARK: - SetupUI and Constraints
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        guard let device = device else { return }
        self.title = "Device Details"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backButtonImage = UIImage(named: ImageAssets.chevronLeft.rawValue)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        ipMainLabel.text = device.ip
        ipLabel.text = device.ip
        macLabel.text = device.macAddress
        hostLabel.text = device.hostname
        cameraLabel.textColor = device.status ? .purpleColor : .red
        statusImage.image = device.status ? UIImage(named: ImageAssets.checkmrk.rawValue) : UIImage(named: ImageAssets.wifiFail.rawValue)
    }
    
    private func constraints() {
        [backImage, wifiImage, statusImage, circleImage, contentView].forEach(view.addSubview)
        [cameraLabel, ipMainLabel, ipAddressLabel, ipLabel, connectLabel,  macAddressLabel, macLabel, hostnameLabel, hostLabel, connectWifiLabel, dividerOne, dividerTwo, dividerThree].forEach(contentView.addSubview)
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(280)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(hostnameLabel.snp.bottom).offset(13)
        }
        
        backImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        circleImage.snp.makeConstraints { make in
            make.top.equalTo(backImage.snp.top).offset(109)
            make.bottom.equalTo(backImage.snp.bottom).offset(-84)
            make.centerX.equalTo(backImage.snp.centerX)
        }
        wifiImage.snp.makeConstraints { make in
            make.top.equalTo(circleImage.snp.top).offset(44)
            make.bottom.equalTo(circleImage.snp.bottom).offset(-48)
            make.left.equalTo(circleImage.snp.left).offset(39)
            make.right.equalTo(circleImage.snp.right).offset(-39)
        }
        
        statusImage.snp.makeConstraints { make in
            make.top.equalTo(circleImage.snp.top).offset(72)
            make.left.equalTo(circleImage.snp.left).offset(75)
            make.bottom.equalTo(circleImage.snp.bottom).offset(-2)
            make.right.equalTo(circleImage.snp.right).offset(-1)
            make.height.width.equalTo(42)
        }
        
        cameraLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        ipMainLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(58)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        connectLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(115)
            make.left.equalTo(contentView.snp.left).offset(16)
        }
        
        connectWifiLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(115)
            make.right.equalTo(contentView.snp.right).offset(-16)
        }
        
        dividerOne.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(connectLabel.snp.bottom).offset(13)
            make.height.equalTo(1)
        }
        
        ipAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerOne.snp.bottom).offset(13)
            make.left.equalTo(contentView.snp.left).offset(16)
        }
        
        ipLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerOne.snp.bottom).offset(13)
            make.right.equalTo(contentView.snp.right).offset(-16)
        }
        
        dividerTwo.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(ipAddressLabel.snp.bottom).offset(13)
            make.height.equalTo(1)
        }
        
        macAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerTwo.snp.bottom).offset(13)
            make.left.equalTo(contentView.snp.left).offset(16)
        }
        
        macLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerTwo.snp.bottom).offset(13)
            make.right.equalTo(contentView.snp.right).offset(-16)
        }
        
        dividerThree.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(macAddressLabel.snp.bottom).offset(13)
            make.height.equalTo(1)
        }
        
        hostnameLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerThree.snp.bottom).offset(13)
            make.left.equalTo(contentView.snp.left).offset(16)
        }
        
        hostLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerThree.snp.bottom).offset(13)
            make.right.equalTo(contentView.snp.right).offset(-16)
        }
    }
    
    @objc private func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Preset for label
    private func label(text: String, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
