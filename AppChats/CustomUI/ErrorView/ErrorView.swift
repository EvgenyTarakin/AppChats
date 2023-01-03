//
//  ErrorView.swift
//  AppChats
//
//  Created by Евгений Таракин on 03.01.2023.
//

import UIKit
import SnapKit

class ErrorView: UIView {
    
//    MARK: - property
    private lazy var label: UILabel = {
        let label = UILabel()
        
        return label
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
        addSubview(label)
        label.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
    
//    MARK: - func
    func configurate(_ text: String) {
        label.setErrorLabel(text)
    }
    
}
