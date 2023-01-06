//
//  Request.swift
//  AppChats
//
//  Created by Евгений Таракин on 05.01.2023.
//

import Alamofire

public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public enum HTTPTask {
    case request
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding = JSONEncoding.default)
}

public typealias HTTPHeaders = [String: String]

public protocol Request {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
}

extension Request {
    public var baseURL: String {
        switch self {
        default: return "https://plannerok.ru/api/v1/users"
        }
    }
}

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}

public enum ResponseResult<String>{
    case success
    case failure(String)
}
