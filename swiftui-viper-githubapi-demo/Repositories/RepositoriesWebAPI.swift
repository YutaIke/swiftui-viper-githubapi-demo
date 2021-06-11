//
//  repositoriesWebAPI.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/05.
//

import Foundation
import Combine

protocol RepositoriesWebAPI {
    func loadRepositories(query: String?) -> AnyPublisher<RepositoriesResponse, APIError>
}

struct RealRepositoriesWebAPI: RepositoriesWebAPI {
    
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")

    init(session: URLSession, baseURL: String = "https://api.github.com") {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadRepositories(query: String? = nil) -> AnyPublisher<RepositoriesResponse, APIError> {
        let api = RealRepositoriesWebAPI.API.searchRepositories
        let queryItems:[URLQueryItem] = [.init(name: "q", value: query),
                                         .init(name: "sort", value: "stars")]

        do {
            let request = try api.urlRequest(baseUrl: baseURL, queryItems: queryItems)

            let decorder = JSONDecoder()
            decorder.keyDecodingStrategy = .convertFromSnakeCase
            return session
                .dataTaskPublisher(for: request)
                .map { data, urlResponse in data }
                .mapError { _ in APIError.unexpectedResponse }
                .decode(type: RepositoriesResponse.self, decoder: decorder)
                .mapError({ (error) -> APIError in
                    APIError.decodeError
                })
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<RepositoriesResponse, APIError>(error: error as! APIError).eraseToAnyPublisher()
        }
    }

}

extension RealRepositoriesWebAPI {
    enum API {
        case searchRepositories
    }
}

extension RealRepositoriesWebAPI.API: APICall {
//    typealias Response = RepositoriesResponse
    
    var path: String {
        switch self {
        case .searchRepositories: return "/search/repositories"
        }
    }
    
    var method: String {
        switch self {
        case .searchRepositories: return "GET"
        }
    }
    
    var headers: [String : String]? {
        return ["Accept": "application/json"]
    }
        
    func body() throws -> Data? {
        nil
    }
}
