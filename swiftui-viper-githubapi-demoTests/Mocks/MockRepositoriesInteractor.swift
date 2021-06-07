//
//  MockRepositoriesInteractor.swift
//  swiftui-viper-githubapi-demoTests
//
//  Created by 池友太 on 2021/06/07.
//

import Foundation
import Combine
@testable import swiftui_viper_githubapi_demo

class MockRealRepositoriesInteractor: RepositoriesInteractor {
    func loadRepositories(query: String?) -> AnyPublisher<AppState.RepositoriesListView.LoadableState<[Repository]>, APIError> {
        let loadableRepository: AppState.RepositoriesListView.LoadableState<[Repository]> = .loaded(Repository.mockedData)
        return Future<AppState.RepositoriesListView.LoadableState<[Repository]>, APIError> { promise in
            promise(.success(loadableRepository))
        }
        .eraseToAnyPublisher()
    }
}
