//
//  RepositoriesWebAPITest.swift
//  swiftui-viper-githubapi-demoTests
//
//  Created by 池友太 on 2021/06/09.
//

import XCTest
import Mockingjay
import Combine
@testable import swiftui_viper_githubapi_demo

class RepositoriesWebAPITest: XCTestCase {
    
    var session: URLSession!
    var baseURL: String!
    var bgQueue = DispatchQueue(label: "bg_parse_queue_test")
    var webAPI: RepositoriesWebAPI!
    var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 1
        configuration.timeoutIntervalForResource = 1

        self.session = URLSession(configuration: configuration)
        self.baseURL = "https://api.github.com"
        self.webAPI = RealRepositoriesWebAPI(session: session, baseURL: baseURL)
    }

    override func tearDownWithError() throws {
        subscriptions = Set<AnyCancellable>()
    }

    func test_loadRepositories_query_is_swift_success() throws {
        let body = [
            "items":[
                [
                    "id": 11111,
                    "name": "Repository Name",
                    "html_url": "https://google.com",
                    "description": "Repository description",
                    "stargazers_count": 1111,
                    "language": "Japanese",
                    "owner": [
                        "id": 111,
                        "avatar_url": ""
                    ]
                ],
                [
                    "id": 22222,
                    "name": "Repository Name 2",
                    "html_url": "https://google.com",
                    "description": "Repository description 2",
                    "stargazers_count": 2222,
                    "language": "Japanese",
                    "owner": [
                        "id": 222,
                        "avatar_url": ""
                    ]
                ]
            ]
        ]
        
        stub(uri("https://api.github.com/search/repositories?q=swift&sort=stars"), json(body))
        
        let exp = expectation(description: "wait for complete api")
        let expected = RepositoriesResponse.mockedData

        webAPI.loadRepositories(query: "swift")
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    XCTFail(error.errorDescription!)
                default:
                    print("")
                    exp.fulfill()
                }
            }, receiveValue: { value in
                XCTAssertEqual(value.items[0], expected.items[0])
                XCTAssertEqual(value.items[1], expected.items[1])
            })
            .store(in: &subscriptions)
        
        wait(for: [exp], timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
