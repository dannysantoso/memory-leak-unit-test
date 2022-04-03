//
//  NotificationRetainCycle.swift
//  memory-leak-unit-test
//
//  Created by danny santoso on 03/04/22.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: - Not Leaking
class NotLeakingWithAppNotification{
    private var disposeBag = DisposeBag()
    
    var s : Int = 5
    
    func doSomething(){
        s = Int(arc4random())
    }
    
    init() {
        NotificationCenter.default.rx
            .notification(Notification.Name.init("Some notification"))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self](_) in
                self.doSomething()
            })
            .disposed(by: self.disposeBag)
    }
}

//MARK: - Leaking
class LeakingWithAppNotification{
    private var disposeBag = DisposeBag()
    
    var s : Int = 5
    
    func doSomething(){
        s = Int(arc4random())
    }
    
    init() {
        NotificationCenter.default.rx
            .notification(Notification.Name.init("Some notification"))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (_) in //NOTICE that [unowned self] was taken out, creating a leak
                self.doSomething()
            })
            .disposed(by: self.disposeBag)
    }
}
