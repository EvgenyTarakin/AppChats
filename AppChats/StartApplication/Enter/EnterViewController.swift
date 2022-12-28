//
//  EnterViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit
import SnapKit

class EnterViewController: UIViewController {
    
//    MARK: - property
    private lazy var enterView: EnterView = {
        let enterView = EnterView(frame: .zero)
        enterView.delegate = self
        
        return enterView
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.setWhiteBackgroundColor()
        
        view.addSubview(enterView)
        enterView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

// MARK: - extensions
extension EnterViewController: EnterViewDelegate {    
    func tapEnterWithNumberButton(_ number: String) {
        let controller = RegistrationViewController()
        controller.configurate(number)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func dismissKeyboard() {
        enterView.endEditing(true)
    }
}

