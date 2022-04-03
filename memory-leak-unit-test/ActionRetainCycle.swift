//
//  ActionRetainCycle.swift
//  memory-leak-unit-test
//
//  Created by danny santoso on 03/04/22.
//

import Foundation

class LeakWhenActionCalled {
    
    var something : AnyObject? = nil

    func dontLeak(){
        print("don't leak")
    }
    
    func leak(){
        self.something = self
    }
    
    func returnLeakingBlock() -> Action{
        return {
            self.dontLeak()
            print ("I leak because i'm not using weak " )
        }
    }
    
    func returnNotLeakingBlock() -> Action{
        return {[weak self] in
            self?.dontLeak()
            print ("I don't leak because i'm using weak " )
        }
    }
}
