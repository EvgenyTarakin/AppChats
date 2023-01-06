//
//  NetworkService.swift
//  AppChats
//
//  Created by Евгений Таракин on 05.01.2023.
//

import Foundation
import Alamofire

class NetworkService<R: Request> {
    func getData<T: Codable>(accessToken: String, endPoint: R, type: T.Type, completion: @escaping ((Result<T, ApiError>) -> ())) {
        guard let url = URL(string: endPoint.baseURL + endPoint.path) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.method = Alamofire.HTTPMethod(rawValue: endPoint.method.rawValue)
        request.headers = Alamofire.HTTPHeaders(endPoint.headers)
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")


        AF.request(request).responseDecodable(of: T.self) { (response) in
            guard let _ = response.response else {
                completion(.failure(.noResponse))
                return
            }
            
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
//                switch resp.statusCode {
//                case 401:
//                    self.requestForGetNewAccessToken(alaomReq: request, requestType: .Load, target: endPoint, responseClass: responseClass, completion: completion)
////                    completion(.failure(.unauthorized))
//                case 403:
//                    self.requestForGetNewAccessToken(alaomReq: request, requestType: .Load, target: target, responseClass: responseClass, completion: completion)
//                case 200:
//                    let str = String(decoding: response.data!, as: UTF8.self)
//                    log(str)
//                    completion(.failure(.decode))
//                default:
                completion(.failure(.unexpectedStatusCode))
//                }
            }
        }
    }
    
    func request<T: Codable>(endPoint: R, jsonData: Data, type: T.Type, completion: @escaping((Result<T, ApiError>) -> Void)) {
        guard let url = URL(string: endPoint.baseURL + endPoint.path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.method = Alamofire.HTTPMethod(rawValue: endPoint.method.rawValue)
        request.headers = Alamofire.HTTPHeaders(endPoint.headers)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        AF.request(request).responseDecodable(of: T.self) { (response) in
            guard let _ = response.response else {
                completion(.failure(.noResponse))
                return
            }
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(_):
                switch response.response?.statusCode {
                case 200:
//                    let str = String(decoding: response.data!, as: UTF8.self)
                    completion(.success(response.data as! T))
                case 400:
                    completion(.failure(.noAccount))
                case 401:
                    completion(.failure(.noAccount))
                case 403:
                    completion(.failure(.noAccount))
                case 422:
                    completion(.failure(.wrongInputForm))
                default:
                    completion(.failure(.unexpectedStatusCode))
                }
            }
        }
    }
}
