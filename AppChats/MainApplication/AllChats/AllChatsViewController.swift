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
        view.setWhiteBackgroundColor()
        
        view.addSubview(allChatsView)
        allChatsView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

// MARK: - extesnion
extension AllChatsViewController: AllChatsDelegate {
    func didSelectProfileButton() {
        let controller = ProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func didSelectCell() {
        let controller = ChatViewController()
        controller.configurate("Имя любимое мое")
        navigationController?.pushViewController(controller, animated: true)
    }
}
