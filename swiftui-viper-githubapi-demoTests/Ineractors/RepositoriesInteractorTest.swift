//
//  RepositoriesInteractorTest.swift
//  swiftui-viper-githubapi-demoTests
//
//  Created by 池友太 on 2021/06/07.
//

import XCTest
import Combine
@testable import swiftui_viper_githubapi_demo

class RepositoriesInteractorTest: XCTestCase {

    var webAPI: RepositoriesWebAPI!
    var interactor: RepositoriesInteractor!
    var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        self.webAPI = MockRepositoriesWebAPI()
        self.interactor = RealRepositoriesInteractor(webAPI: webAPI)
    }

    override func tearDownWithError() throws {
        subscriptions = Set<AnyCancellable>()
    }

    func test_loadRepositories() throws {
        let query = "swift"
        var expected: AppState.RepositoriesListView.LoadableState<[Repository]>!
        var repositories: AppState.RepositoriesListView.LoadableState<[Repository]>!

        Future<AppState.RepositoriesListView.LoadableState<[Repository]>, Never> { promise in
            promise(.success(.loaded(Repository.mockedData)))
        }
        .sink { value in
            expected = value
        }
        .store(in: &subscriptions)

        interactor.loadRepositories(query: query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    XCTFail(error.errorDescription!)
                default:
                    print("")
                }
            }, receiveValue: { value in
                repositories = value
            })
            .store(in: &subscriptions)
        
        XCTAssertEqual(repositories, expected)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
