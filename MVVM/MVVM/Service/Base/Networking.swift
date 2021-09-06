//
//  Networking.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/06.
//

import Foundation

protocol NetworkingType {
    var session: URLSession {get}
    func request(url: URL, method: String, header: [String: String]) -> URLRequest
}

class Networking: NetworkingType {
    
    let session: URLSession
    
    init(with session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request(url: URL, method: String, header: [String: String]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        header.forEach { (field, value) in
            request.setValue(value, forHTTPHeaderField: field)
        }
        return request
    }
}
