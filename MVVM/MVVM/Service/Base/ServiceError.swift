//
//  ServiceError.swift
//  MVVM
//
//  Created by 이덕화 on 2021/08/31.
//

import Foundation

enum ServiceError: Error {
    case unknown
    case invalidURL
    case failRequest(response: HTTPURLResponse, data: Data?)
    case decode(Error)
    
    func print() {
        var errorString = "[ServiceError] "
        switch self {
        case .unknown:
            errorString += "unknown"
        case .invalidURL:
            errorString += "URL transform failed"
        case .failRequest(let response, let data):
            errorString += "request failed\nresponse: \(response) \ndata: \(String(describing: data))"
        case .decode(let error):
            errorString += "decode: \(error.localizedDescription)"
        }
        Swift.print(errorString)
    }
}
