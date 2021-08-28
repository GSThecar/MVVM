//
//  UIView+Size.swift
//  MVVM
//
//  Created by 이덕화 on 2021/08/28.
//

import UIKit

extension UIViewController {
    typealias UI = UIView.UI
}

extension UIView {
    struct UI {
        static let defaultMargin = CGFloat(16)
        static let smallMargin = CGFloat(8)
        static let bigMargin = CGFloat(32)
    }
}
