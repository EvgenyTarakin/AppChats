//
//  ProfileViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 28.12.2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
//    MARK: - property
    private let network = NetworkService<Api>()
    private var data: ProfileData?
    
    private lazy var profileView: ProfileView = {
        let profileView = ProfileView()
        profileView.delegate = self
        
        return profileView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        loadProfileData { [weak self] result in
            switch result {
            case .success(_): self?.profileView.configurate(data: self?.data)
            case .failure(_): break
            }
        }
    }
    
//    MARK: - private func
    private func commonInit() {
        view.setWhiteBackgroundColor()
        navigationItem.title = "Профиль"
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadProfileData(completion: @escaping (Result<ProfileData, ApiError>) -> Void) {
        network.getData(accessToken: UserDefaults.standard.object(forKey: "accessToken") as! String, endPoint: .meGet, type: ProfileResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data.profileData
                
            case .failure(_): break
            }
        }
    }

}

// MARK: - extension
extension ProfileViewController: ProfileViewDelegate {
    func tapAvatarImageView() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate { 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileView.updateAvatar(image)
        dismiss(animated: true)
    }
    
}
