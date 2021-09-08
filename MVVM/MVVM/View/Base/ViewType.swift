//
//  ViewType.swift
//  MVVM
//
//  Created by 이덕화 on 2021/08/28.
//

import UIKit
import RxSwift

protocol ViewType: AnyObject {
    associatedtype T = ViewModelType
    
    var viewModel: T! { get set }
    var disposeBag: DisposeBag! { get set }
    
    func setUpUI()
    func setUpLayout()
    func setUpBinding()
}

extension ViewType where Self: UIViewController {
    static func create(with viewModel: T) -> Self {
        let `self` = Self()
        self.viewModel = viewModel
        self.disposeBag = DisposeBag()
        self.setUpUI()
        self.setUpLayout()
        self.setUpBinding()
        return self
    }
}
