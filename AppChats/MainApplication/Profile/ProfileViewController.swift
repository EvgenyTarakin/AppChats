//
//  ProfileViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
//    MARK: - property
    private lazy var profileView: ProfileView = {
        let profileView = ProfileView()
        
        return profileView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.setWhiteBackgroundColor()
        setNavigationBar(title: "Профиль", type: .profile)
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(68)
            $0.bottom.left.right.equalToSuperview()
        }
    }

}
