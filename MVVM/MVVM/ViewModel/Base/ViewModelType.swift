//
//  ViewModelType.swift
//  MVVM
//
//  Created by 이덕화 on 2021/08/28.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
