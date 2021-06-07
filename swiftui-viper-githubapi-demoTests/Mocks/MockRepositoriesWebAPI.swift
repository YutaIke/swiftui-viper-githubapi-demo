//
//  MockRepositoriesWebAPI.swift
//  swiftui-viper-githubapi-demoTests
//
//  Created by 池友太 on 2021/06/07.
//

import Foundation
import Combine
@testable import swiftui_viper_githubapi_demo

struct MockRepositoriesWebAPI: RepositoriesWebAPI {
    func loadRepositories(query: String?) -> AnyPublisher<RepositoriesResponse, APIError> {
        let repositoriesResponse = RepositoriesResponse.mockedData
        return Future<RepositoriesResponse, APIError> { promise in
            promise(.success(repositoriesResponse))
        }
        .eraseToAnyPublisher()
    }
}
