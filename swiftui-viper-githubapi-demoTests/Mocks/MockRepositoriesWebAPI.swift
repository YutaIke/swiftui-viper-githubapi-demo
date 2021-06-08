//
//  MockRepositoriesWebAPI.swift
//  swiftui-viper-githubapi-demoTests
//
//  Created by 池友太 on 2021/06/07.
//

import Foundation
import Combine
@testable import swiftui_viper_githubapi_demo

final class MockRepositoriesWebAPI: RepositoriesWebAPI {
    var stub: Any?

    func setStub(response: AnyPublisher<RepositoriesResponse, APIError>) {
        stub = response
    }

    func loadRepositories(query: String?) -> AnyPublisher<RepositoriesResponse, APIError> {
        guard let response = stub as? AnyPublisher<RepositoriesResponse, APIError> else {
            return Empty<RepositoriesResponse, APIError>().eraseToAnyPublisher()
        }
        return response
    }
}
