//
//  APIError.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/05.
//

import Foundation

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(Int)
    case unexpectedResponse
    case decodeError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .decodeError: return "Failed to decode"
        }
    }
}
