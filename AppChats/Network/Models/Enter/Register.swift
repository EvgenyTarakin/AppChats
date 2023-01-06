//
//  Register.swift
//  AppChats
//
//  Created by Евгений Таракин on 05.01.2023.
//

import Foundation

struct Register: Codable {
    let phone: String
    let name: String
    let username: String
}

struct RegisterResponse: Codable {
    let refreshToken, accessToken: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case userID = "user_id"
    }
}
