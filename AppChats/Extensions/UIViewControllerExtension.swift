//
//  UIViewControllerExtension.swift
//  AppChats
//
//  Created by Евгений Таракин on 29.12.2022.
//

import UIKit
import SnapKit

extension UIViewController {
    func setNavigationBar(title: String, type: NavBarType) {
        let navigationBar = AppNavigationBar(frame: .zero, type: type)
        navigationBar.configurate(title)
        navigationBar.delegate = self

        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(60)
        }
    }
}

extension UIViewController: AppNavigationBarDelegate {
    func didSelectBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
