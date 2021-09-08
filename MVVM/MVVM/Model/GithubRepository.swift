//
//  GithubRepository.swift
//  MVVM
//
//  Created by 이덕화 on 2021/08/31.
//

import Foundation

struct GithubRepositories: Decodable {
  let items: [GithubRepository]
  enum CodingKeys: String, CodingKey {
    case items
  }
}

struct GithubRepository: Decodable {
    let fullName: String
    let description: String?
    let starCount: Int
    let forkCount: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
      case fullName = "full_name"
      case description = "description"
      case starCount = "stargazers_count"
      case forkCount = "forks_count"
      case url = "html_url"
    }
}
