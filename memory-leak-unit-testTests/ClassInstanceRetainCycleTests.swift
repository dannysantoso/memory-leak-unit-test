//
//  ClassInstanceRetainCycle.swift
//  memory-leak-unit-testTests
//
//  Created by danny santoso on 03/04/22.
//

import Nimble
import Quick
import SpecLeaks

@testable import memory_leak_unit_test

class SomeOjectTests: QuickSpec {
    override func spec() {
        describe("a SomeObject") {
            describe("init") {
                it("must not leak"){

                    let someObject = LeakTest{
                        return Apartment(unit: "Dicoding Space")
                    }

                    let doSomethingIsCalled : (Apartment) -> ()  = {obj in obj.doSomething()}

                    expect(someObject).to(leakWhen(doSomethingIsCalled))
                }
            }
        }
    }
}
