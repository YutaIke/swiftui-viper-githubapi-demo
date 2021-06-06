//
//  RepositoriesResponse.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/05.
//

import Foundation

struct RepositoriesResponse: Decodable {
    let items: [Repository]
}
