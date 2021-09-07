//
//  ReactiveBase.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/07.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
  var viewWillAppear: ControlEvent<Void> {
    let source = methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
    return ControlEvent(events: source)
  }
}
