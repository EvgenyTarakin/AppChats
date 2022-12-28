//
//  RegistrationViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
//    MARK: - property
    private lazy var registrationView: RegistrationView = {
        let registartionView = RegistrationView()
        registartionView.delegate = self
        
        return registartionView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.setWhiteBackgroundColor()

        view.addSubview(registrationView)
        registrationView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
//    MARK: - func
    func configurate(_ number: String) {
        registrationView.configurate(number)
    }

}

extension RegistrationViewController: RegistrationViewDelegate {
    func tapRegistrationButton() {
        let controller = AllChatsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
