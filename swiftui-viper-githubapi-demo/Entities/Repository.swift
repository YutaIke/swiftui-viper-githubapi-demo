//
//  Repository.swift
//  swiftui-viper-githubapi-demo
//
//  Created by 池友太 on 2021/06/04.
//

import Foundation

struct Repository: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
    let htmlUrl: String
    let description: String
    let stargazersCount: Int
    let language: String
    let owner: Owner
    
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        if (lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.htmlUrl == rhs.htmlUrl &&
            lhs.description == rhs.description &&
            lhs.stargazersCount == rhs.stargazersCount &&
            lhs.language == rhs.language) {
            return true
        } else {
            return false
        }
        
    }
}

extension Repository {
    struct Owner: Codable {
        let id: Int
        let avatarUrl: String
    }
}
