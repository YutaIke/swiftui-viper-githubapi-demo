//
//  DepencencyInjector.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/05.
//

import SwiftUI
import Combine
import UIKit

struct DIAppState: EnvironmentKey {
    static let defaultValue: AppState = AppState()
}

struct DIPresenter: EnvironmentKey {
    static let defaultValue: RepositoriesPresenter = StubRepositoriesPresenter()
}

extension EnvironmentValues {
    var appState: AppState {
        get { self[DIAppState].self }
        set { self[DIAppState].self = newValue }
    }
    
    var presenter: RepositoriesPresenter {
        get { self[DIPresenter.self] }
        set { self[DIPresenter.self] = newValue }
    }
}
