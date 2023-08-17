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
        
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HapticManager.instace.impact(type: .medium)
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
    
    // MARK: - Header영역 관련
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
        header.backgroundColor = .blue

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0))
        header.backgroundColor = .secondarySystemBackground
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 0
        }
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.configure(profileImage: "Kevin", name: "최케빈", email: "cbcng@oliveunion.com")
            cell.logOutButtonTapped = { [weak self] in
                AlertBuilder(viewController: self)
                    .addAction(title: "로그아웃", style: .default) {
                        self?.restartSplachVC()
                    }
                    .addAction(title: "취소", style: .cancel)
                    .show(title: "로그아웃", message: "로그아웃 하시겠습니까?")
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "OthersTableViewCell", for: indexPath) as! OthersTableViewCell
            cell.configure(row: indexPath.row)
            return cell
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
