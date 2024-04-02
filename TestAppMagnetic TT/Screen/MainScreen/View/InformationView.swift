//
//  InformationView.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 01.04.2024.
//

import Foundation
import UIKit


final class InformationView: UIView {
    
    var onscanButtonTap: (() -> Void)?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColorInfoColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var scanButton = UIButton.reusableButton(withTitle: "Scan current network", fontSize: 20)
    
    private lazy var labelWifi: UILabel = {
        let label = UILabel()
        label.text = "Current Wi-Fi"
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
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Ready to Scan this network"
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textAlignment = .center
        label.textColor = UIColor(red: 82/255, green: 88/255, blue: 120/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        scanButtonPressed()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        self.addSubview(contentView)
        [scanButton, labelWifi, currentWifiLabel, statusLabel].forEach(contentView.addSubview)
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(198)
            make.width.equalTo(350)
            make.edges.equalToSuperview()
        }
        
        scanButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(318)
            make.top.equalTo(contentView.snp.top).offset(114)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        labelWifi.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        currentWifiLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(84)
            make.centerX.equalTo(contentView.snp.centerX)
        }
    }
    
    private func scanButtonPressed() {
        scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
    }
    
    @objc private func scanButtonTapped() {
        onscanButtonTap?()
    }
}
