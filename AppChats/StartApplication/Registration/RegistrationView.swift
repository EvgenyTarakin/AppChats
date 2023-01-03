//
//  RegistrationView.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit
import SnapKit
import Toast
import PhoneNumberKit

// MARK: - RegistrationViewDelegate
protocol RegistrationViewDelegate: AnyObject {
    func tapRegistrationButton()
    func tapRegistrationButtonWithClearFields()
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
        label.setTitleLabel("Регистрация")
        label.font = AppFont.bold36
        
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.setStandartTextField()
        textField.placeholder = "Введите имя"
        textField.returnKeyType = .next
        textField.setButtonsOnKeyboard()
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.setStandartTextField()
        textField.placeholder = "Введите никнейм"
        textField.returnKeyType = .done
        textField.setButtonsOnKeyboard()
        textField.setValidationUsername()
        textField.delegate = self

        return textField
    }()
    
    private lazy var numberTextField: PhoneNumberTextField = {
        let textField = PhoneNumberTextField()
        textField.setStandartTextField()
        textField.withPrefix = true
        textField.withFlag = true
        textField.withExamplePlaceholder = true
        textField.isEnabled = false
        
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setEnterButton("Зарегистрироваться")
        button.addTarget(self, action: #selector(tapRegistrationButton), for: .touchUpInside)
        
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
    
    func showToastError() {
        let errorView = ErrorView()
        errorView.configurate("Заполните все поля")
        let toastView = AppleToastView(child: errorView)
        let config = ToastConfiguration(
            displayTime: 1
        )
        let toast = Toast.custom(view: toastView, config: config)
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        toast.show()
    }
    
//    MARK: - obj-c
    @objc private func tapRegistrationButton() {
        if (nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            delegate?.tapRegistrationButtonWithClearFields()
        } else {
            delegate?.tapRegistrationButton()
        }
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

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            usernameTextField.becomeFirstResponder()
        } else {
            endEditing(true)
        }
        
        return true
    }
}
