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
    
    private lazy var scanButton = UIButton.reusableButton(withTitle: "Scan current network")
    
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
        label.textColor = .purpleColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelWifi, currentWifiLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 6
        return stackView
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
        [scanButton, mainStackView, statusLabel].forEach(contentView.addSubview)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scanButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(statusLabel.snp.top).offset(-16)
            
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(mainStackView.snp.bottom).offset(16)
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
