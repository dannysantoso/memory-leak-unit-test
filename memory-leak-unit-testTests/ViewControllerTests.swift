//
//  ViewControllerTests.swift
//  memory-leak-unit-testTests
//
//  Created by danny santoso on 03/04/22.
//

import Nimble
import Quick
import SpecLeaks

@testable import memory_leak_unit_test

class ViewControllerTests: QuickSpec {
    
    override func spec() {
        describe("UIViewController"){
            let test = LeakTest{
                return UIViewController()
            }

            describe("init") {
                it("must not leak"){
                    expect(test).toNot(leak())
                }
            }
        }

        describe("LeakingViewController") {
            let test = LeakTest{
                let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle(for: ViewController.self))
                return storyboard.instantiateInitialViewController() as! ViewController
            }
            
            describe("init") {
                it("must not leak"){
                    expect(test).toNot(leak())
                }
            }
            
            describe("doSomething") {
                it("must not leak"){
                    let action : (ViewController) -> () = { vc in

                        vc.cleanLeakedObjects()
                        vc.doSomething()
                    }

                    expect(test).toNot(leakWhen(action))
                }
            }
            
            describe("createLeak") {
                it("must leak"){
                    let action : (ViewController) -> () = { vc in

                        vc.cleanLeakedObjects()
                        vc.createLeak()
                    }

                    expect(test).to(leakWhen(action))
                }
            }

            describe("createLeakInBlock") {
                it("must leak"){
                    let action : (ViewController) -> Any = { vc in

                        vc.cleanLeakedObjects()
                        return vc.createLeakInBlock()
                    }

                    expect(test).to(leakWhen(action))
                }

                it("must leak"){
                    let action : (ViewController) -> Any = { vc in

                        vc.cleanLeakedObjects()
                        return vc.createLeakInBlock()
                    }

                    expect(test).to(leakWhen(action))
                }
            }
            describe("dontCreateLeakInBlock") {
                it("must not leak"){
                    let action : (ViewController) -> Any = { vc in
                        
                        vc.cleanLeakedObjects()
                        return vc.dontCreateLeakInBlock()
                    }
                    
                    expect(test).toNot(leakWhen(action))
                }
            }

            describe("createLeakInFlatMap") {
                it("must leak"){
                    let action : (ViewController) -> Any = { vc in

                        vc.cleanLeakedObjects()
                        return vc.createLeakInFlatMap()
                    }

                    expect(test).to(leakWhen(action))
                }
            }
            
            describe("dontCreateLeakInFlatMap") {
                it("must not leak"){
                    let action : (ViewController) -> Any = { vc in
                        
                        vc.cleanLeakedObjects()
                        return vc.dontCreateLeakInFlatMap()
                    }
                    
                    expect(test).toNot(leakWhen(action))
                }
            }
        }
    }
}
