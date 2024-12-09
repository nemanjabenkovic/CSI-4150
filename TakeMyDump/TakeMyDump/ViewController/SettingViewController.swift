//
//  SettingViewController.swift
//  TakeMyDump
//
//  Created by 신민규 on 12/9/24.
//

import UIKit

class SettingCell: UITableViewCell {
    // -MARK: Properties
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "S-CoreDream-4Regular", size: 14)
        label.textColor = .black
        
        return label
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "S-CoreDream-4Regular", size: 12)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .none
        selectionStyle = .none
        contentView.addSubview(cellLabel)
        contentView.addSubview(versionLabel)
        contentView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            versionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            versionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with label: String, versionText: String? = nil) {
        cellLabel.text = label
        versionLabel.text = versionText
        versionLabel.isHidden = versionText == nil
    }
}

final class SettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum SettingSection: Int, CaseIterable {
        case myInfo
        case serviceInfo
        
        var title: String {
            switch self {
            case .myInfo:
                return "내 정보 관리"
            case .serviceInfo:
                return "서비스 정보"
            }
        }
        
        var items: [String] {
            switch self {
            case .myInfo:
                return ["로그인 정보",
                        "내 리뷰 관리",
                        "이벤트",
                        // "알림 설정"
                ]
            case .serviceInfo:
                return [
                    //"공지사항",
                    //"의견 보내기",
                    "약관 및 정책", "버전 정보"]
            }
        }
    }
    
    private enum Constant {
        static let tableTop: CGFloat = 96
    }
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellIdentifier = "SettingCell"
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 52
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
    }
    // -MARK: UI Component
    func configureUI() {
        [tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constant.tableTop),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SettingViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let settingSection = SettingSection(rawValue: section) else { return 0 }
        return settingSection.items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let settingSection = SettingSection(rawValue: section) else { return nil }
        return settingSection.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell,
              let settingSection = SettingSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        let item = settingSection.items[indexPath.row]
        
        if item == "버전 정보" {
            let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "v0.1"
            cell.configure(with: item, versionText: appVersion)
        } else {
            cell.configure(with: item)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let settingSection = SettingSection(rawValue: section) else { return nil }
        
        // 헤더에 사용할 UILabel 생성
        let headerLabel = UILabel()
        headerLabel.text = settingSection.title
        headerLabel.font = UIFont(name: "S-CoreDream-4Regular", size: 12) // 원하는 폰트 설정
        headerLabel.textColor = .black // 원하는 색상 설정
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 헤더 뷰 생성
        let headerView = UIView()
        headerView.addSubview(headerLabel)
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let settingSection = SettingSection(rawValue: indexPath.section) else { return }
        let selectedItem = settingSection.items[indexPath.row]
        
    }
}

