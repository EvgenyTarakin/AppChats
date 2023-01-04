//
//  EnterView.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit
import SnapKit
import PhoneNumberKit
import Toast

// MARK: - protocol
protocol EnterViewDelegate: AnyObject {
    func tapEnterWithNumberButton(_ number: String)
    func tapEnterButton(_ code: String)
    func tapEnterButtonWithClearField(_ error: String)
    func dismissKeyboard()
}

class EnterView: UIView {
    
//    MARK: - StateEnterView
    enum StateEnterView {
        case number
        case code
    }
    
//    MARK: - property
    weak var delegate: EnterViewDelegate?
    private var state: StateEnterView = .number
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
    
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
        textField.setStandartTextField()
        textField.setButtonsOnKeyboard()
        textField.withPrefix = true
        textField.withFlag = true
        textField.withExamplePlaceholder = true
        textField.withDefaultPickerUI = true
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var codeTextField: UITextField = {
        let textField = UITextField()
        textField.setButtonsOnKeyboard()
        textField.setCodeTextField()
        textField.delegate = self
        
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
    
//    MARK: - func
    func updateView() {
        state = .code
        tapOnView()
        numberTextField.isHidden = true
        descriptionLabel.text = "Введите код подтверждения из смс"
        contentView.addSubview(codeTextField)
        codeTextField.becomeFirstResponder()
        codeTextField.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.center.equalToSuperview()
            $0.height.equalTo(44)
        }
        enterWithNumberButton.setTitle("Войти", for: .normal)
    }
    
    func showToastError(_ error: String) {
        tapOnView()
        let errorView = ErrorView()
        errorView.configurate(error)
        let toastView = AppleToastView(child: errorView)
        let config = ToastConfiguration(
            displayTime: 1
        )
        let toast = Toast.custom(view: toastView, config: config)
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        toast.show()
    }
    
//    MARK: - obj-c
    @objc private func tapEnterButton() {
        indicatorView.startAnimating()
        contentView.alpha = 0.1
        if state == .number {
            if numberTextField.text?.count == 16 {
                delegate?.tapEnterWithNumberButton(numberTextField.text ?? "")
            } else {
                delegate?.tapEnterButtonWithClearField("Введите правильный номер")
            }
        } else {
            if codeTextField.text?.count == 4 {
                delegate?.tapEnterButton(codeTextField.text ?? "")
            } else {
                delegate?.tapEnterButtonWithClearField("Введите правильный код")
            }
        }
    }
    
    @objc private func tapOnView() {
        contentView.alpha = 1
        indicatorView.stopAnimating()
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

// MARK: - extension
extension EnterView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numberTextField {
            if textField.text?.count != 16 || string.count == 0 {
                return true
            }
        } else {
            if textField.text?.count != 4 || string.count == 0 {
                return true
            }
        }
        return false
    }
}
