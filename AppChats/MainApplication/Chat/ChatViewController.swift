//
//  ChatViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {
    
//    MARK: - property
    private lazy var chatView: ChatView = {
        let chatView = ChatView()
        
        return chatView
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.setWhiteBackgroundColor()
        
        view.addSubview(chatView)
        chatView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(68)
            $0.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
//    MARK: - func
    func configurate(_ title: String) {
        setNavigationBar(title: title, type: .chat)
    }

}
