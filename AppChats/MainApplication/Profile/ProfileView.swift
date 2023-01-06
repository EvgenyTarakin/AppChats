//
//  ProfileView.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit

// MARK: - protocol
protocol ProfileViewDelegate: AnyObject {
    func tapAvatarImageView()
}

class ProfileView: UIView {

//    MARK: - property
    weak var delegate: ProfileViewDelegate?
    private lazy var isSelectEditButton = false
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var avatarButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
        
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [usernameLabel, numberLabel, cityTextField, dateTextField, zodiacTextField])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        
        return label
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
    
    private lazy var infoTextField: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setEnterButton("Редактировать")
        button.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
        
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
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(16)
            $0.width.equalToSuperview().multipliedBy(0.45)
            $0.height.equalTo(avatarImageView.snp.width)
        }
        
        addSubview(avatarButton)
        avatarButton.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(avatarImageView)
        }
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(16)
            $0.left.equalTo(avatarImageView.snp.right).inset(-16)
            $0.height.equalTo(avatarImageView.snp.height)
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(8)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        addSubview(infoTextField)
        infoTextField.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).inset(-8)
            $0.bottom.equalTo(editButton.snp.top).inset(-8)
            $0.left.right.equalToSuperview().inset(16)
        }
    }
    
//    MARK: - func
    func configurate(data: ProfileData?) {
//        avatarImageView.image = UIIdata.avatar
        numberLabel.setStandartLabel("Ваш номер: \(data?.phone ?? "")")
        usernameLabel.setStandartLabel(data?.username ?? "")
        cityTextField.text = data?.city
        dateTextField.text = data?.birthday
        zodiacTextField.text = data?.status
        infoTextField.text = data?.vk
    }
    
    func updateAvatar(_ avatar: UIImage?) {
        avatarImageView.image = avatar
    }
    
//    MARK: - obj-c
    @objc private func tapEditButton() {
        isSelectEditButton.toggle()
        if isSelectEditButton {
            editButton.setEditActiveButton()
            avatarButton.addTarget(self, action: #selector(changeAvatarImage), for: .touchUpInside)
        } else {
            editButton.setEnterButton("Редактировать")
            avatarButton.removeTarget(self, action: #selector(changeAvatarImage), for: .touchUpInside)
        }
    }

    @objc private func changeAvatarImage() {
        delegate?.tapAvatarImageView()
    }
    
}
