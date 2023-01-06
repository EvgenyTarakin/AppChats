//
//  EnterViewController.swift
//  AppChats
//
//  Created by Евгений Таракин on 22.12.2022.
//

import UIKit
import SnapKit

class EnterViewController: UIViewController {
    
//    MARK: - property
    private let enterApi = NetworkService<Api>()
    private lazy var number = ""
    private lazy var code = ""
    
    private lazy var enterView: EnterView = {
        let enterView = EnterView(frame: .zero)
        enterView.delegate = self
        
        return enterView
    }()
    
//    MARK: - ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
//    MARK: - private func
    private func commonInit() {
        view.setWhiteBackgroundColor()
        
        view.addSubview(enterView)
        enterView.snp.makeConstraints {
            $0.top.bottom.left.right.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func enterWithPhone(input: EnterPhone, completion: @escaping (Result<EnterPhoneResponse, ApiError>) -> Void) {
        do {
            let json = try JSONEncoder().encode(input)
            self.enterApi.request(endPoint: .sendAuthCode, jsonData: json, type: EnterPhoneResponse.self, completion: { result in
                switch result {
                case .success(let enterResponse):
                    let data = enterResponse
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        } catch {
            print(error)
        }
    }
    
    private func enterWithPhoneAndCode(input: EnterCode, completion: @escaping(Result<EnterCodeResponse, ApiError>) -> Void) {
        do {
            let json = try JSONEncoder().encode(input)
            self.enterApi.request(endPoint: .checkAuthCode, jsonData: json, type: EnterCodeResponse.self, completion: { result in
                switch result {
                case .success(let enterResponse):
                    let data = enterResponse
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        } catch {
            print(error)
        }
    }

}

// MARK: - extensions
extension EnterViewController: EnterViewDelegate {    
    func tapEnterWithNumberButton(_ number: String) {
        self.number = number
        enterWithPhone(input: EnterPhone(phone: number)) { [weak self] result in
            switch result {
            case .success(let data):
                if data.isSuccess {
                    self?.enterView.updateView()
                } else {
                    self?.enterView.showToastError("Что-то не работает... Попробуйте позже :(")
                }
            case .failure(_): break
            }
        }
    }
    
    func tapEnterButton(_ code: String) {
        self.code = code
        enterWithPhoneAndCode(input: EnterCode(phone: self.number, code: self.code)) { [weak self] result in
            switch result {
            case .success(let data):
                if data.isUserExists {
                    let controller = AllChatsViewController()
                    self?.navigationController?.pushViewController(controller, animated: true)
                } else {
                    let controller = RegistrationViewController()
                    controller.configurate(self?.number ?? "")
                    self?.navigationController?.pushViewController(controller, animated: true)
                }
            case .failure(_):
                let controller = RegistrationViewController()
                controller.configurate(self?.number ?? "")
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
    
    func tapEnterButtonWithClearField(_ error: String) {
        enterView.showToastError(error)
    }
    
    func dismissKeyboard() {
        enterView.endEditing(true)
    }
}

