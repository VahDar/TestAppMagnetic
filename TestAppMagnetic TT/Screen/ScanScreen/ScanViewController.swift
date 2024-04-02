//
//  ScanViewController.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 02.04.2024.
//

import UIKit
import Lottie

class ScanViewController: UIViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layout()
        configureButton()
    }
    
    //MARK: - View
    private lazy var scanButton = UIButton.reusableButton(withTitle: "Start", fontSize: 20)
    
    private lazy var labelWifi: UILabel = {
        let label = UILabel()
        label.text = "Scanning your Wi-Fi"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentWifiLabel: UILabel = {
        let label = UILabel()
        label.text = WifiModel.MOCK_USER.name
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        label.textColor = UIColor(red: 109/255, green: 89/255, blue: 211/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deviceLabel: UILabel = {
        let label = UILabel()
        label.text = "Devices Found..."
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 17)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countWifiLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        label.textColor = UIColor(red: 109/255, green: 89/255, blue: 211/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var radarAnimationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "radar")
        animation.loopMode = .loop
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    //MARK: - SetupUI and Constraints
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        view.addSubview(radarAnimationView)
    }
    
    private func layout() {
        [labelWifi, currentWifiLabel, deviceLabel, scanButton, countWifiLabel, radarAnimationView].forEach(view.addSubview)
        
        labelWifi.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(123)
            make.centerX.equalToSuperview()
        }
        currentWifiLabel.snp.makeConstraints { make in
            make.top.equalTo(labelWifi.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        scanButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-70)
            make.height.equalTo(50)
        }
        
        deviceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(scanButton.snp.top).offset(-62)
            make.centerX.equalToSuperview()
        }
        
        countWifiLabel.snp.makeConstraints { make in
            make.centerY.equalTo(deviceLabel.snp.centerY)
            make.right.equalTo(deviceLabel.snp.left).offset(-8)
        }
        
        radarAnimationView.snp.makeConstraints { make in
            make.top.equalTo(currentWifiLabel.snp.bottom).offset(71)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(deviceLabel.snp.top).offset(-32)
        }
    }
    
    // MARK: - Configure
    private func configureButton() {
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
    }
    
    @objc private func scanButtonTapped() {
        if scanButton.title(for: .normal) == "Start" {
            scanButton.setTitle("Stop", for: .normal)
            countWifiLabel.text = "\(WifiModel.wifiData.count)"
            radarAnimationView.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
                guard let self = self else { return }
                let deviceListViewController = DeviceListViewController()
                self.navigationController?.pushViewController(deviceListViewController, animated: true)
            }
        } else {
            scanButton.setTitle("Start", for: .normal)
            radarAnimationView.stop()
        }
    }
}
