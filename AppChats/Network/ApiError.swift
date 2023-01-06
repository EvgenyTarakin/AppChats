//
//  ApiError.swift
//  AppChats
//
//  Created by Евгений Таракин on 05.01.2023.
//

import Foundation

enum ApiError: Error {
    case decode
    case invalidURL
    case noResponse
    case wrongInputForm
    case unexpectedStatusCode
    case noAccount

    var message: String {
        switch self {
        case .decode: return "Decode error"
        case .wrongInputForm: return "Неправильная форма ввода."
        case .noAccount: return "Неправильный логин или пароль"
        default: return "Unknown error"
        }
    }
}
