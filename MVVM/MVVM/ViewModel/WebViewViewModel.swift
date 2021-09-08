//
//  WebViewViewModel.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import RxSwift
import RxCocoa

class WebViewViewModel: ViewModelType {
    
    private let url: URL
    
    init(with url: URL) {
        self.url = url
    }
    
    struct Input {
        let viewWillAppear: Driver<Void>
    }
    
    struct Output {
        let load: Driver<URLRequest>
    }
    
    
    func transform(input: Input) -> Output {
        let load = input.viewWillAppear.compactMap { [weak self] () -> URLRequest? in
            guard let weakSelf = self else { return nil }
            return URLRequest(url: weakSelf.url) }
        
        return Output(load: load)
    }
}
