//
//  RepositoriesListView.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/04.
//

import SwiftUI

struct RepositoriesListView: View {
    
    @EnvironmentObject private var appState: AppState
    @Environment(\.presenter) private var presenter: RepositoriesPresenter
    
    var body: some View {
        switch appState.repositoriesListView.repositories {
        case .notRequested:
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onAppear {
                    self.presenter.reloadRepositories(query: "swift")
                }
        case .isLoading:
            Text("loading")
        case let .loaded(repositories):
            List(repositories) { repository in
                Text(repository.name)
            }
        default:
            Text("default")
        }
    }
}

struct RepositoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesListView()
    }
}
