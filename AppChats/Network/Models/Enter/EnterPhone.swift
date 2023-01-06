//
//  EnterPhone.swift
//  AppChats
//
//  Created by Евгений Таракин on 05.01.2023.
//

import Foundation

struct EnterPhone: Codable {
    let phone: String
}

struct EnterPhoneResponse: Codable {
    let isSuccess: Bool

    enum CodingKeys: String, CodingKey {
        case isSuccess = "is_success"
    }
}
