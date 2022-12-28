//
//  ProfileView.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit
import PhoneNumberKit

// MARK: - protocol
protocol ProfileViewDelegate: AnyObject {
    
}

class ProfileView: UIView {

//    MARK: - property
    weak var delegate: ProfileViewDelegate?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [numberTextField, nicknameTextField, cityTextField, dateTextField, zodiacTextField])
        
        return stackView
    }()
    
    private lazy var numberTextField: PhoneNumberTextField = {
        let phoneTextField = PhoneNumberTextField()
        
        return phoneTextField
    }()
    
    private lazy var nicknameTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private lazy var cityTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private lazy var zodiacTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private lazy var infoTextView: UITextView = {
        let textView = UITextView()
        
        return textView
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
        
    }

}
