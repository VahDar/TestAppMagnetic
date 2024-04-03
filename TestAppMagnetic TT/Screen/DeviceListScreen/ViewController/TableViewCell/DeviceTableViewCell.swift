//
//  DeviceTableViewCell.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 02.04.2024.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {
    
    private lazy var wifiImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var chevronImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageAssets.chevron.image
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var wifiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ipLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Roboto-Regular", size: 13)
        label.textColor = .grayColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [wifiLabel, ipLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        return stackView
    }()
    
    //MARK: - Flow funcs
    func configure(with model: WifiModel) {
        ipLabel.text = model.ip
        wifiLabel.text = model.name
        wifiImage.image = model.status ? ImageAssets.wifiSuccess.image : ImageAssets.wifiFail.image
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.cell
        [mainStackView, wifiImage, chevronImage].forEach(contentView.addSubview)
        
        wifiImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(9)
            make.width.height.equalTo(36)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.bottom.equalToSuperview().offset(-7)
            make.left.equalTo(wifiImage.snp.right).offset(16)
            make.right.equalToSuperview().offset(-123)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.bottom.equalToSuperview().offset(-19)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
