//
//  EnterView.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit
import SnapKit
import PhoneNumberKit

// MARK: - protocol
protocol EnterViewDelegate: AnyObject {
    func tapEnterWithNumberButton(_ number: String)
    func dismissKeyboard()
}

class EnterView: UIView {
    
//    MARK: - property
    weak var delegate: EnterViewDelegate?
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
//    private lazy var alertView: UIAlertView = {
//
//    }
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true

        return indicator
    }()
    
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
        label.textAlignment = .center
        label.textColor = .blue
        label.font = AppFont.bold56
        label.text = "AppChats"
        
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.setDescriptionLabel("Введите номер телефона")
        
        return label
    }()
    
    private lazy var numberTextField: AppPhoneNumberTextField = {
        let textField = AppPhoneNumberTextField()
        textField.delegate = self
        textField.setTextFieldBorder()
        textField.setButtonsOnKeyboard()
        textField.withPrefix = true
        textField.withFlag = true
        textField.withExamplePlaceholder = true
        textField.withDefaultPickerUI = true
        
        return textField
    }()
    
    private lazy var enterWithNumberButton: UIButton = {
        let button = UIButton()
        button.setEnterButton("Войти по номеру телефона")
        button.addTarget(self, action: #selector(tapEnterButton), for: .touchUpInside)
        
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
            $0.left.right.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview().dividedBy(2)
            $0.height.equalTo(60)
        }
        
        contentView.addSubview(numberTextField)
        numberTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.center.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(numberTextField.snp.top).inset(-8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(20)
        }

        contentView.addSubview(enterWithNumberButton)
        enterWithNumberButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        registerForKeyboardNotifications()
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    MARK: - obj-c
    @objc private func tapEnterButton() {
//        indicatorView.startAnimating()
//        contentView.alpha = 0.1
        self.delegate?.tapEnterWithNumberButton(self.numberTextField.text ?? "")
    }
    
    @objc private func tapOnView() {
        contentView.alpha = 1
        indicatorView.stopAnimating()
        delegate?.dismissKeyboard()
//        DispatchQueue.global().as
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

// MARK: - extension
extension EnterView: UITextFieldDelegate {

}
