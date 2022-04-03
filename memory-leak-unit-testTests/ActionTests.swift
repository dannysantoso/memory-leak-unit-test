//
//  ActionTests.swift
//  memory-leak-unit-testTests
//
//  Created by danny santoso on 03/04/22.
//

import Nimble
import Quick
import SpecLeaks

@testable import memory_leak_unit_test

class LeakWhenActionCalledSpec: QuickSpec {
    
    override func spec() {
        
        describe("an ObjectThatLeaksWhenActionCalled") {
            
            let test = LeakTest{
                return LeakWhenActionCalled()
            }
            
            describe("init") {
                it("must not leak"){
                    expect(test).toNot(leak())
                }
            }
            
            describe("leak with no action"){
                it("must not leak"){
                    let leakingAction : Handler<LeakWhenActionCalled> = {_ in }
                    expect(test).toNot(leakWhen(leakingAction))
                }
            }
            
            
            describe("leak"){
                it("must leak"){
                    let leakingAction : Handler<LeakWhenActionCalled> = {leaker in leaker.leak()}
                    expect(test).to(leakWhen(leakingAction))
                }
            }
            
            describe("dontLeak"){
                it("must not leak"){
                    let notLeakingAction : Handler<LeakWhenActionCalled> = {leaker in leaker.dontLeak()}
                    expect(test).toNot(leakWhen(notLeakingAction))
                }
            }
            
            describe("returnLeakingBlock"){
                it("must leak"){
                    let leak : (LeakWhenActionCalled)-> Any  = {leaker in return leaker.returnLeakingBlock()}

                    expect(test).to(leakWhen(leak))
                }
            }
            
            describe("returnNotLeakingBlock"){
                it("must not leak"){
                    let leak : (LeakWhenActionCalled)-> Any  = {leaker in return leaker.returnNotLeakingBlock()}
                    
                    expect(test).toNot(leakWhen(leak))
                }
            }
        }
    }
}
