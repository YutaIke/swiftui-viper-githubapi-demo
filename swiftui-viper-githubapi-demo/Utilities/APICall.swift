//
//  APICall.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/05.
//

import Foundation
import Combine

protocol APICall {
//    associatedtype Response: Decodable

    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

extension APICall {
    func urlRequest(baseUrl: String, queryItems: [URLQueryItem]?) throws -> URLRequest {
        guard let url = URL(string: baseUrl + path) else {
            throw APIError.invalidURL
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = queryItems

        print(urlComponents.url!)
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        
        return request
    }
        
}
