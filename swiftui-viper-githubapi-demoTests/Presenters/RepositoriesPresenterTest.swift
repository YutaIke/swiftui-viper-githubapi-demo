//
//  RepositoriesPresenterTest.swift
//  swiftui-viper-githubapi-demoTests
//
//  Created by 池友太 on 2021/06/07.
//

import XCTest
import Combine
@testable import swiftui_viper_githubapi_demo

class RepositoriesPresenterTest: XCTestCase {
    
//    var repositoriesInteractor
    var appState: AppState!
    var repositoriesInteractor: RepositoriesInteractor!
    var presenter: RepositoriesPresenter!
    var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.appState = AppState()
        self.repositoriesInteractor = MockRealRepositoriesInteractor()
        self.presenter = RealRepositoriesPresenter(appState: appState, repositoriesInteractor: self.repositoriesInteractor)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        subscriptions = Set<AnyCancellable>()
    }

    func test_reloadRepositories() throws {
        let initial: AppState.RepositoriesListView.LoadableState<[Repository]> = .notRequested
        XCTAssertEqual(appState.repositoriesListView.repositories, initial)

        presenter.reloadRepositories(query: "swift")

        let repository = Repository(id: 11111,
                                    name: "Repository Name",
                                    htmlUrl: "https://google.com",
                                    description: "Repository description",
                                    stargazersCount: 22222,
                                    language: "Japanese",
                                    owner: Repository.Owner(id: 111,
                                                            avatarUrl: "")
        )
        let expected: AppState.RepositoriesListView.LoadableState<[Repository]> = .loaded([repository])
        XCTAssertEqual(appState.repositoriesListView.repositories, expected)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
