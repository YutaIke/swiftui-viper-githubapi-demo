//
//  AppState.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/05.
//

import Foundation
import Combine

class AppState: ObservableObject {
    @Published var repositoriesListView = AppState.RepositoriesListView()
}

extension AppState {
    struct RepositoriesListView {
        enum Action {
            case requestStart
            case requestSuccess(response: [Repository])
            case requestError(error: Error)
        }
        
        enum LoadableState<T>: Equatable where T: Equatable{
            case notRequested
            case isLoading
            case loaded(T)
            case failed(Error)

            var value: T? {
                switch self {
                case let .loaded(value): return value
    //            case let .isLoading(last, _): return last
                default: return nil
                }
            }
            
            var error: Error? {
                switch self {
                case let .failed(error): return error
                default: return nil
                }
            }
            
            static func == (lhs: LoadableState<T>, rhs: LoadableState<T>) -> Bool {
                switch (lhs, rhs) {
                case (.notRequested, .notRequested): return true
                case (.isLoading, .isLoading): return true
                case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
                case let (.failed(lhsE), .failed(rhsE)):
                    return lhsE.localizedDescription == rhsE.localizedDescription
                default: return false
                }
            }
        }
        
        var repositories: LoadableState<[Repository]> = .notRequested
    }
}
