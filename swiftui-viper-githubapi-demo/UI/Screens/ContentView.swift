//
//  ContentView.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/04.
//

import SwiftUI

struct ContentView: View {
    
    private let appState: AppState
    private let presenter: RepositoriesPresenter
    
    init(appState: AppState, presenter: RepositoriesPresenter) {
        self.appState = appState
        self.presenter = presenter
    }
    
    var body: some View {
        RepositoriesListView()
//            .environment(\.appState, appState)
            .environmentObject(appState)
            .environment(\.presenter, presenter)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState(), presenter: StubRepositoriesPresenter())
    }
}
