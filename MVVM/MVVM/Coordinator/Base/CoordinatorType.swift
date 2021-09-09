//
//  CoordinatorType.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import UIKit

protocol CoordinatorType: AnyObject {
    
    var coordinatorChidren: [CoordinatorType] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
