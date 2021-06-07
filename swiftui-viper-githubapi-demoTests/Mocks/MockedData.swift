//
//  MockedData.swift
//  swiftui-viper-githubapi-demoTests
//
//  Created by 池友太 on 2021/06/07.
//

import Foundation
@testable import swiftui_viper_githubapi_demo

#if DEBUG
extension Repository {
    static let mockedData: [Repository] = [
        Repository(id: 11111,
                   name: "Repository Name",
                   htmlUrl: "https://google.com",
                   description: "Repository description",
                   stargazersCount: 1111,
                   language: "Japanese",
                   owner: Repository.Owner(id: 111,
                                           avatarUrl: "")),
        Repository(id: 22222,
                   name: "Repository Name 2",
                   htmlUrl: "https://google.com",
                   description: "Repository description 2",
                   stargazersCount: 2222,
                   language: "Japanese",
                   owner: Repository.Owner(id: 222,
                                           avatarUrl: ""))
                   ]
}

extension RepositoriesResponse {
    static let mockedData: RepositoriesResponse = RepositoriesResponse(items: Repository.mockedData)
}
#endif
