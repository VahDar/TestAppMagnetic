//
//  DeviceListViewController.swift
//  TestAppMagnetic TT
//
//  Created by Vakhtang on 02.04.2024.
//

import UIKit

class DeviceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var deviceCell: DeviceTableViewCell!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceCell = DeviceTableViewCell()
        setupUI()
        constraints()
        tableView.reloadData()
    }
    
    //MARK: View
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "\(WifiModel.wifiData.count)"
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        label.textColor = UIColor(red: 109/255, green: 89/255, blue: 211/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deviceLabel: UILabel = {
        let label = UILabel()
        label.text = "Devices"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var wifiLabel: UILabel = {
        let label = UILabel()
        label.text = "WIFI_Name"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 15)
        label.textColor = UIColor(red: 82/255, green: 88/255, blue: 120/255, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countLabel, deviceLabel])
        stackView.distribution = .equalCentering
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .mainBackgroundColor
        self.title = "Result"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backButtonImage = UIImage(named: ImageAssets.chevronLeft.rawValue)
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 8
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.register(DeviceTableViewCell.self, forCellReuseIdentifier: String(describing: DeviceTableViewCell.self))
    }
    
    // MARK: - Constreints
    private func constraints() {
        [labelStackView, wifiLabel, tableView].forEach(view.addSubview)
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(123)
            make.centerX.equalToSuperview()
            
        }
        
        wifiLabel.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(wifiLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WifiModel.wifiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DeviceTableViewCell.self), for: indexPath) as? DeviceTableViewCell else {
            fatalError("Cannot dequeue reusable cell with identifier: \(String(describing: DeviceTableViewCell.self))")
        }
        let model = WifiModel.wifiData[indexPath.row]
        cell.configure(with: model)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDevice = WifiModel.wifiData[indexPath.row]
        let detailViewController = DetailViewController(device: selectedDevice)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
