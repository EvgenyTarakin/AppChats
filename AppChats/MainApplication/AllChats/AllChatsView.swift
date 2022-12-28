//
//  AllChatsView.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit

// MARK: - protocol
protocol AllChatsDelegate: AnyObject {
    func didSelectCell()
    func didSelectProfileButton()
}

class AllChatsView: UIView {
    
//   MARK: - property
    weak var delegate: AllChatsDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setTitleLabel("Чаты")
        label.font = AppFont.bold36
        
        return label
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(systemName: "person"), for: .normal)
        button.addTarget(self, action: #selector(tapProfileButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 72
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
//    MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        addSubview(profileButton)
        profileButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.right.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
    }
    
//    MARK: - obj-c
    @objc private func tapProfileButton() {
        delegate?.didSelectProfileButton()
    }
    
}

// MARK: - extension
extension AllChatsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCell()
    }
}

extension AllChatsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.reuseIdentifier, for: indexPath) as? ChatCell else {
            return UITableViewCell() }
        
        return cell
    }
}
