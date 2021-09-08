//
//  StringExtension.swift
//  MVVM
//
//  Created by 이덕화 on 2021/09/08.
//

import Foundation

extension String {
    var url: URL? { URL(string: self) }
}
