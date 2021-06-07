//
//  RepositoriesPresenter.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/04.
//

import Foundation
import Combine

protocol RepositoriesPresenter {
    func reloadRepositories(query: String?)
}

class RealRepositoriesPresenter: RepositoriesPresenter {
    private let appState: AppState
    private let repositoriesInteractor: RepositoriesInteractor
    private var cancellables: [AnyCancellable] = []
    
    init(appState: AppState, repositoriesInteractor: RepositoriesInteractor) {
        self.appState = appState
        self.repositoriesInteractor = repositoriesInteractor
    }
    
    func reloadRepositories(query: String?) {
        appState.repositoriesListView.repositories = .isLoading
        let repositorySubscriber = repositoriesInteractor.loadRepositories(query: query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    self.appState.repositoriesListView.repositories = .failed(error)
                default:
                    print("default")
                }
            }, receiveValue: { repositories in
                self.appState.repositoriesListView.repositories = repositories
            })

        cancellables += [repositorySubscriber]
    }
}

class StubRepositoriesPresenter: RepositoriesPresenter {
    func reloadRepositories(query: String?) {
        
    }
}
