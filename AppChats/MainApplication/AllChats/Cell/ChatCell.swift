//
//  ChatCell.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit

class ChatCell: UITableViewCell {
    
//    MARK: - property
    static let reuseIdentifier = String(describing: ChatCell.self)
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarImageView, middleStackView, timeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.alignment = .firstBaseline
        
        avatarImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(avatarImageView.snp.height)
        }
        
        timeLabel.snp.makeConstraints {
            $0.width.equalTo(44)
        }
        
        return stackView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, lastMessageLabel])
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.setStandartLabel("standart label")
        
        return label
    }()
    
    private lazy var lastMessageLabel: UILabel = {
        let label = UILabel()
        label.setStandartLabel("standart label")
        
        return label
    }()

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.regular16
        label.textColor = .black
        label.numberOfLines = 1
        
        return label
    }()
    
//    MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
        nameLabel.text = nil
        lastMessageLabel.text = nil
        timeLabel.text = nil
    }
    
//    MARK: - private func
    private func commonInit() {
        selectionStyle = .none
        
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(8)
        }
    }
    
//    MARK: - func
    func configurate(image: UIImage?, name: String, message: String) {
        avatarImageView.image = image
        nameLabel.text = name
        lastMessageLabel.text = message
    }

}
