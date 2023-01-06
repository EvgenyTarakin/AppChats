//
//  RegistrationViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
//    MARK: - property
    private let enterApi = NetworkService<Api>()
    private lazy var phone = ""
    
    private lazy var registrationView: RegistrationView = {
        let registartionView = RegistrationView()
        registartionView.delegate = self
        
        return registartionView
    }()

//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.setWhiteBackgroundColor()

        view.addSubview(registrationView)
        registrationView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func register(input: Register, completion: @escaping (Result<RegisterResponse, ApiError>) -> Void) {
        do {
            let json = try JSONEncoder().encode(input)
            self.enterApi.request(endPoint: .register, jsonData: json, type: RegisterResponse.self, completion: { result in
                switch result {
                case .success(let response):
                    let data = response
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        } catch {
            print(error)
        }
    }
    
//    MARK: - func
    func configurate(_ number: String) {
        self.phone = number
        registrationView.configurate(number)
    }

}

extension RegistrationViewController: RegistrationViewDelegate {
    func tapRegistrationButton(name: String, username: String) {
        register(input: Register(phone: self.phone, name: name, username: username)) { [weak self] result in
            switch result {
            case .success(let data):
                let controller = AllChatsViewController()
                
                let userDefaults = UserDefaults.standard
                userDefaults.set(data.accessToken, forKey: "accessToken")
                userDefaults.set(data.refreshToken, forKey: "refreshToken")
                self?.navigationController?.pushViewController(controller, animated: true)
            case .failure(let error):
                self?.registrationView.showToastError(error.localizedDescription)
            }
        }
    }
    
    func tapRegistrationButtonWithClearFields() {
        registrationView.showToastError("Заполните все поля")
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
