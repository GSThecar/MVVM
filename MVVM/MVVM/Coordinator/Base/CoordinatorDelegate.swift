//
//  CoordinatorDelegate.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/09.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorFinished(with child: CoordinatorType)
}
