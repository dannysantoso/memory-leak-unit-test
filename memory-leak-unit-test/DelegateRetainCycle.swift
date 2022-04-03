//
//  DelegateRetainCycle.swift
//  memory-leak-unit-test
//
//  Created by danny santoso on 03/04/22.
//

import Foundation

//MARK: - Leaking
protocol ServerDelegate : AnyObject{}

class LeakingServer{
    var delegate : ServerDelegate? = nil
}

class LeakingClient : ServerDelegate{
    var server : LeakingServer
    
    init(server: LeakingServer) {
        self.server = server
        server.delegate = self
    }
}

//MARK: - Not Leaking
class NotLeakingServer{
    weak var delegate : ServerDelegate? = nil
}

class NotLeakingClient : ServerDelegate{
    var server : NotLeakingServer
    
    init(server: NotLeakingServer) {
        self.server = server
        server.delegate = self
    }
}

class SomeObject{
    func doSomething(){
        
    }
}
