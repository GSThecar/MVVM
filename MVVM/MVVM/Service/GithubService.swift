//
//  GithubService.swift
//  MVVM
//
//  Created by 이덕화 on 2021/08/31.
//

import Foundation

protocol GitHubServiceType {
    func fetchGithubRepositories(by setting: GithubSetting, completion: @escaping (ServiceResult<GithubRepositories, ServiceError>) -> Void )
}

final class GithubService: Networking {}

extension GithubService: GitHubServiceType {
    func fetchGithubRepositories(by setting: GithubSetting, completion: @escaping (ServiceResult<GithubRepositories, ServiceError>) -> Void) {
        
        let baseUrl  = "https://api.github.com/search/repositories?q="
        let language = "language:\(setting.language)"
        let userID = setting.userID.isEmpty ? setting.userID : "+user:\(setting.userID)"
        let sortType = "&sort=\(setting.sortType)"
        
        guard let url = URL(string: baseUrl + language + userID + sortType) else {completion(.failure(.invalidURL));  return }
        
        let request = request(url: url, method: "GET", header: [:])
        
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, let data = data else {completion(.failure(.unknown)); return}
            DispatchQueue.main.async {
                guard 200..<300 ~= response.statusCode else { completion(.failure(.failRequest(response: response, data: data))); return}
                
                do {
                    let items = try JSONDecoder().decode(GithubRepositories.self, from: data)
                    completion(.success(items))
                } catch let error {
                    completion(.failure(.decode(error)))
                }
            }
            
        }.resume()
        
    }
}
