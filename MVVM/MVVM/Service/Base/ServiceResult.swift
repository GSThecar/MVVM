//
//  ServiceResult.swift
//  MVVM
//
//  Created by 이덕화 on 2021/08/28.
//

import Foundation

enum ServiceResult<T, U> where U: Error {
    case success(T)
    case failure(U)
    
    var isSuccess: Bool {
        switch self {
        case .success(_):
            return true
        case .failure(_):
            return false
        }
    }
    
    var error: U? {
        switch self {
        case .success(_):
            return nil
        case let .failure(error):
            return error
        }
    }
}
