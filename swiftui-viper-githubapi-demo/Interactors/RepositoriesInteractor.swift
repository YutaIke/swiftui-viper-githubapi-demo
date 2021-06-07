//
//  RepositoriesInteractor.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/04.
//

import Foundation
import Combine

protocol RepositoriesInteractor {
    func loadRepositories(query: String?) -> AnyPublisher<AppState.RepositoriesListView.LoadableState<[Repository]>, APIError>
}

final class RealRepositoriesInteractor: RepositoriesInteractor {
    
    let webAPI: RepositoriesWebAPI

    init(webAPI: RepositoriesWebAPI) {
        self.webAPI = webAPI
    }
    
    func loadRepositories(query: String?) -> AnyPublisher<AppState.RepositoriesListView.LoadableState<[Repository]>, APIError> {
        return webAPI.loadRepositories(query: query)
            .map { repositoriesResponse in .loaded(repositoriesResponse.items) }
            .eraseToAnyPublisher()
    }
}

struct StubCountriesInteractor: RepositoriesInteractor {
    func loadRepositories(query: String?) -> AnyPublisher<AppState.RepositoriesListView.LoadableState<[Repository]>, APIError> {
        let repository = Repository(id: 11111,
                                    name: "Repository Name",
                                    htmlUrl: "https://google.com",
                                    description: "Repository description",
                                    stargazersCount: 22222,
                                    language: "Japanese",
                                    owner: Repository.Owner(id: 111,
                                                            avatarUrl: "")
        )
        let loadableRepository: AppState.RepositoriesListView.LoadableState<[Repository]> = .loaded([repository])
        return Future<AppState.RepositoriesListView.LoadableState<[Repository]>, APIError> { promise in
            promise(.success(loadableRepository))
        }
        .eraseToAnyPublisher()
    }
}
