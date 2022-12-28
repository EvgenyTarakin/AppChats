//
//  AppNavigationBar.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit

// MARK: - protocol
protocol AppNavigationBarDelegate: AnyObject {
    func didSelectBackButton()
}

class AppNavigationBar: UIView {

//    MARK: - property
    weak var delegate: AppNavigationBarDelegate?
    private var type: NavBarType?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        
        return button
    }()
    
//    MARK: - init
    init(frame: CGRect, type: NavBarType) {
        super.init(frame: frame)
        commonInit()
        self.type = type
        titleLabel.font = type.font
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    MARK: - private func
    private func commonInit() {
        addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.width.equalTo(backButton.snp.height)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().inset(16)
            $0.left.equalTo(backButton.snp.right)
        }
    }
    
//    MARK: - func
    func configurate(_ title: String) {
        titleLabel.setTitleLabel(title)
    }
    
//    MARK: - obj-c
    @objc private func tapBackButton() {
        delegate?.didSelectBackButton()
    }

}
