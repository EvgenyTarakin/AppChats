//
//  Api.swift
//  AppChats
//
//  Created by Евгений Таракин on 05.01.2023.
//

import Foundation

public enum Api {
    case sendAuthCode
    case checkAuthCode
    case register
    case meGet
    case mePut
}

extension Api: Request {
    public var path: String {
        switch self {
        case .sendAuthCode: return "/send-auth-code/"
        case .checkAuthCode: return "/check-auth-code/"
        case .register: return "/register/"
        case .meGet, .mePut: return "/me/"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .sendAuthCode, .checkAuthCode, .register: return .post
        case .meGet: return .get
        case .mePut: return .put
        }
    }

    public var task: HTTPTask {
        switch self {
        default: return .request
        }
    }

    public var headers: HTTPHeaders {
        switch self {
        default: return [:]
        }
    }
}
