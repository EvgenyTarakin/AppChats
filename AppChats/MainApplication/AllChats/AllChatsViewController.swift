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
    private let chats: [Chat] = [
        Chat(avatar: "", name: "Иван Гаврилов", lastMessage: "Ку, бро", date: "11.12"),
        Chat(avatar: "", name: "Мама", lastMessage: "Сынок, купи хлеба", date: "06.12"),
        Chat(avatar: "", name: "Брат", lastMessage: "Малой....", date: "06.12"),
        Chat(avatar: "", name: "Сын", lastMessage: "Пап, купи мне мороженое", date: "06.12"),
        Chat(avatar: "", name: "Дочь", lastMessage: "Пап, не покупай хлеб", date: "06.12"),
        Chat(avatar: "", name: "Друг", lastMessage: "Приезжай ко мне", date: "06.12"),
        Chat(avatar: "", name: "Подруга", lastMessage: "Приезжай ко мне", date: "06.12"),
        Chat(avatar: "", name: "Собака", lastMessage: "Гав-гав", date: "06.12"),
        Chat(avatar: "", name: "Кот", lastMessage: "Мяу", date: "06.12")
    ]
    
    private lazy var allChatsView: AllChatsView = {
        let allChatsView = AllChatsView()
        allChatsView.delegate = self
        
        return allChatsView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        presentChats()
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
    
    private func presentChats() {
        allChatsView.configurate(data: chats)
    }
    
//    MARK: - obj-c
    @objc private func tapProfileButton() {
        let controller = ProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - extesnion
extension AllChatsViewController: AllChatsDelegate {
    func didSelectCell(_ chat: Chat) {
        let controller = ChatViewController()
        controller.configurate(chat.name, lastMessage: chat.lastMessage)
        navigationController?.pushViewController(controller, animated: true)
    }
}
