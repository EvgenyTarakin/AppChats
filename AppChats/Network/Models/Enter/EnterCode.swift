//
//  EnterCode.swift
//  AppChats
//
//  Created by Евгений Таракин on 05.01.2023.
//

import Foundation

struct EnterCode: Codable {
    let phone: String
    let code: String
}

struct EnterCodeResponse: Codable {
    let refreshToken, accessToken: String
    let userID: Int
    let isUserExists: Bool

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case userID = "user_id"
        case isUserExists = "is_user_exists"
    }
}
