//
//  ClassInstanceRetainCycle.swift
//  memory-leak-unit-test
//
//  Created by danny santoso on 03/04/22.
//

import Foundation

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
    
    var memberDicoding: Person?
    
    func doSomething(){
        memberDicoding = Person(name: "Danny Santoso")
        memberDicoding!.apartment = self
        self.tenant = memberDicoding
    }
}
