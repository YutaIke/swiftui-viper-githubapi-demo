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

    var webAPI: MockRepositoriesWebAPI!
    var interactor: RepositoriesInteractor!
    var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        self.webAPI = MockRepositoriesWebAPI()
        self.interactor = RealRepositoriesInteractor(webAPI: webAPI)
    }

    override func tearDownWithError() throws {
        subscriptions = Set<AnyCancellable>()
    }

    func test_loadRepositories_success() throws {
        let query = "swift"
        var expected: AppState.RepositoriesListView.LoadableState<[Repository]>!
        var repositories: AppState.RepositoriesListView.LoadableState<[Repository]>!

        webAPI.setStub(response: Result.Publisher(RepositoriesResponse.mockedData).eraseToAnyPublisher())
        
        expected = AppState.RepositoriesListView.LoadableState.loaded(Repository.mockedData)

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
