//
//  Helper.swift
//  memory-leak-unit-test
//
//  Created by danny santoso on 03/04/22.
//

import Foundation

typealias ErrorHandler = (Error)->()
typealias Action = () -> ()
typealias Handler<T> = (T) -> ()
