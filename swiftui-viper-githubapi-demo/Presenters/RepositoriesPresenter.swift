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

class RealRepositoriesPresenter: RepositoriesPresenter, ObservableObject {
    private let repositoriesInteractor: RepositoriesInteractor

    @Published var repositories: [Repository] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(repositoriesInteractor: RepositoriesInteractor) {
        self.repositoriesInteractor = repositoriesInteractor
    }
    
    func reloadRepositories(query: String?) {
        repositoriesInteractor.loadRepositories(query: query)
    }
}

class StubRepositoriesPresenter: RepositoriesPresenter {
    func reloadRepositories(query: String?) {
        
    }
}
