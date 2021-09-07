//
//  TableViewCellType.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/07.
//

import UIKit

protocol TableViewCellType {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: TableViewCellType {
    static var reuseIdentifier: String {
        String(describing: self.self)
    }
}

extension UITableView {
    func register<Cell> (cell: Cell.Type) where Cell: UITableViewCell {
        register(cell, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    func dequeue<Cell> (_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewCell {
        dequeueReusableCell(withIdentifier: reusableCell.reuseIdentifier) as? Cell
    }
}
