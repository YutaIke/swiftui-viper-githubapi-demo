//
//  RepositoriesInteractor.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/04.
//

import Foundation
import Combine

protocol RepositoriesInteractor {
    func loadRepositories(query: String?)
}

final class RealRepositoriesInteractor: RepositoriesInteractor {
    
    let webAPI: RepositoriesWebAPI
    let appState: AppState
    private var cancellables: [AnyCancellable] = []

    init(webAPI: RepositoriesWebAPI, appState: AppState) {
        self.webAPI = webAPI
        self.appState = appState
    }
    
    func loadRepositories(query: String?) {
        appState.repositoriesListView.repositories = .isLoading
        let responseSubscriber = webAPI.loadRepositories(query: query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    self.appState.repositoriesListView.repositories = .failed(error)
                default:
                    print("default")
                }
            }, receiveValue: { repositories in
                self.appState.repositoriesListView.repositories = .loaded(repositories.items)
                print(repositories.items)
            })
        
        cancellables += [responseSubscriber]
    }
}

struct StubCountriesInteractor: RepositoriesInteractor {
    func loadRepositories(query: String?) {
        
    }
}
