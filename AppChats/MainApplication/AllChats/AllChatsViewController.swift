//
//  AllChatsViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit

class AllChatsViewController: UIViewController {
    
//    MARK: - property
    private lazy var allChatsView: AllChatsView = {
        let allChatsView = AllChatsView()
        allChatsView.delegate = self
        
        return allChatsView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Чаты"
        navigationItem.hidesBackButton = true
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(tapProfileButton)), animated: true)
        view.setWhiteBackgroundColor()
        
        view.addSubview(allChatsView)
        allChatsView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
//    MARK: - obj-c
    @objc private func tapProfileButton() {
        let controller = ProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - extesnion
extension AllChatsViewController: AllChatsDelegate {
    func didSelectCell() {
        let controller = ChatViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
