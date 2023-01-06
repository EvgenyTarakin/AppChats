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
    func didSelectCell(_ chat: Chat)
}

class AllChatsView: UIView {
    
//   MARK: - property
    weak var delegate: AllChatsDelegate?
    private var data: [Chat] = []
    
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
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.left.right.equalToSuperview()
        }
    }
    
//    MARK: - func
    func configurate(data: [Chat]) {
        self.data = data
        tableView.reloadData()
    }
    
}

// MARK: - extension
extension AllChatsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCell(data[indexPath.row])
    }
}

extension AllChatsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.reuseIdentifier, for: indexPath) as? ChatCell else {
            return UITableViewCell() }
        cell.configurate(name: data[indexPath.row].name, message: data[indexPath.row].lastMessage, time: data[indexPath.row].date)
        
        return cell
    }
}
