//
//  ReactiveTextField.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/07.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    var editingChanged: ControlEvent<Void> {
        controlEvent(.editingChanged)
    }
}
