//
//  ScanViewController.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 02.04.2024.
//

import UIKit
import Lottie

class ScanViewController: UIViewController {
    
    //MARK: - Properties
    private var scanTask: DispatchWorkItem?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layout()
        configureButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startScanning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scanTask?.cancel()
    }
    
    //MARK: - View
    private lazy var scanButton = UIButton.reusableButton(withTitle: "Stop")
    
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
        label.textColor = .purpleColor
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
        label.text = "\(WifiModel.wifiData.count)"
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        label.textColor = .purpleColor
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
        self.navigationItem.hidesBackButton = true
        
    }
    
    private func layout() {
        view.addSubview(radarAnimationView)
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
    
    //MARK: - Scanning Logic
    private func startScanning() {
        countWifiLabel.text = "\(WifiModel.wifiData.count)"
        
        scanTask?.cancel()
        radarAnimationView.play()
        
        let task = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            let deviceListViewController = DeviceListViewController()
            self.navigationController?.pushViewController(deviceListViewController, animated: true)
        }
        scanTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: task)
    }
    
    // MARK: - Configure
    private func configureButton() {
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
    }
    
    @objc private func scanButtonTapped() {
        radarAnimationView.stop()
        scanTask?.cancel()
        self.navigationController?.popViewController(animated: true)
    }
}
