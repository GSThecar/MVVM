//
//  ReactiveWKWebview.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import Foundation
import WebKit
import RxSwift
import RxCocoa

extension Reactive where Base: WKWebView {
    var estimatedProgress: ControlEvent<Float> {
        let events = observeWeakly(Double.self, "estimatedProgress").map { $0 ?? 0.0 }.map { Float($0) }
        return ControlEvent(events: events)
    }
}
