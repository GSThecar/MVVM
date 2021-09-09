//
//  CoordinatorType.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import UIKit

protocol CoordinatorType: AnyObject {
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var coordinatorChidren: [CoordinatorType] { get set }
    var navigationController: UINavigationController { get set }
    
    var category: CoordinatorCategory { get }
    
    func start()
    func finish()
    
    init(with navigationController: UINavigationController)
}

extension CoordinatorType {
    func finish() {
        coordinatorChidren.removeAll()
        finishDelegate?.coordinatorFinished(with: self)
    }
}
