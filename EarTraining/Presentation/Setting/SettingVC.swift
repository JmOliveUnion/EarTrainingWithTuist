//
//  SettingVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit
import Combine

import SnapKit

extension SettingVC {
    static var instance: SettingVC {
        return UIStoryboard(name: "Setting", bundle: nil)
            .instantiateViewController(withIdentifier: "SettingVC")
        as! SettingVC
    }
}

class SettingVC: BaseViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ProfileTableViewCell.nib(), forCellReuseIdentifier: ProfileTableViewCell.identifier)
        table.register(AchivementTableViewCell.nib(), forCellReuseIdentifier: AchivementTableViewCell.identifier)
        table.register(OthersTableViewCell.self, forCellReuseIdentifier: OthersTableViewCell.identifier)
        table.register(AdvertisingTableViewCell.nib(), forCellReuseIdentifier: AdvertisingTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    private func setUp() {
        view.backgroundColor = .systemBackground
       
        view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Table View

extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if section == 0 {
            return nil
        }

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
        header.backgroundColor = .secondarySystemBackground

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 20
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.configure(profileImage: Image.homeTabSelected.rawValue, name: "Minjong", email: "dev@oliveunion.com")
            
            return cell
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AchivementTableViewCell", for: indexPath) as! AchivementTableViewCell
//            cell.configure()
//            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OthersTableViewCell", for: indexPath) as! OthersTableViewCell
            cell.configure(row: indexPath.row)
            return cell
//        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AdvertisingTableViewCell", for: indexPath) as! AdvertisingTableViewCell
//            cell.configure()
//            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath)
            cell.textLabel?.text = "Hello \(indexPath.section) row : \(indexPath.row)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 570
        case 1:
            return 60
        default:
            return 100
            
        }
    }
}
