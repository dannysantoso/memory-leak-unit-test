//
//  NotificationTests.swift
//  memory-leak-unit-testTests
//
//  Created by danny santoso on 03/04/22.
//

import Nimble
import Quick
import SpecLeaks

@testable import memory_leak_unit_test

class NotificationsTests: QuickSpec {
    
    override func spec() {
        describe("an NotLeakingWithAppNotification") {
           
            it("must not leak"){
                let listeningAppNotification = LeakTest{
                    return NotLeakingWithAppNotification()
                }
                
                expect(listeningAppNotification).toNot(leak())
            }
        }
        
        describe("a LeakWithAppNotification") {
            
            it("must leak"){
                let leaker = LeakTest{
                    return LeakingWithAppNotification()
                }
                
                expect(leaker).to(leak())
            }
        }
    }
}
