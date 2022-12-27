//
//  RegistrationView.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit
import SnapKit
import PhoneNumberKit

// MARK: - RegistrationViewDelegate
protocol RegistrationViewDelegate: AnyObject {
    func tapRegistrationButton()
    func dismissKeyboard()
}

class RegistrationView: UIView {

//    MARK: - property
    weak var delegate: RegistrationViewDelegate?
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        return contentView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = AppFont.bold36
        label.text = "Регистрация"
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular16
        label.text = "Введите имя и никнейм"
        label.textColor = .lightGray
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.setTextFieldBorder()
        
        return textField
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.setTextFieldBorder()

        return textField
    }()
    
    private lazy var numberTextField: PhoneNumberTextField = {
        let textField = PhoneNumberTextField()
        textField.setTextFieldBorder()
        textField.withPrefix = true
        textField.withFlag = true
        textField.withExamplePlaceholder = true
        textField.withDefaultPickerUI = true
        textField.isEnabled = false
        
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setEnterButton("Зарегистрироваться")
        
        return button
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
        addGestureRecognizer(tap)
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
            $0.height.width.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-48)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(nameTextField.snp.top).inset(-8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }
        
        contentView.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).inset(-16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        contentView.addSubview(numberTextField)
        numberTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).inset(-16)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        contentView.addSubview(button)
        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        registerForKeyboardNotifications()
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    MARK: - func
    func configurate(_ number: String) {
        numberTextField.text = number
    }
    
//    MARK: - obj-c
    @objc private func tapRegistrationButton() {
        delegate?.tapRegistrationButton()
    }
    
    @objc private func tapOnView() {
        delegate?.dismissKeyboard()
    }
    
    @objc private func showKeyboard(_ sender: Notification) {
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var inset = scrollView.contentInset
            inset.bottom = keyboardSize.height
            scrollView.contentInset = inset
        }
    }
    
    @objc private func hideKeyboard() {
        scrollView.contentInset = .zero
    }
    
}