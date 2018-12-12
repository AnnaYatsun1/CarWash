//
//  Employ.swift
//  CarWashUK
//
//  Created by Student on 11/12/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class  Emploee: MoneGiver, Stateble, MoneyReceiver {
    
    enum State {
        case busy
        case available
        case waitProcessing
    }
    
    public let name: String
    public let money = Atomic(0)
    let atomicState = Atomic(State.available)
    
    public var state: State {
        get {
            print("employee state getter")
            return atomicState.value }
        set {
            print("employee state setter")
            self.atomicState.modify {
                let oldValue = $0
                if oldValue != newValue {
                    $0 = newValue
                    self.notify(state: newValue)
                }
            }
            
//    public var state: State {
//        get { return atomicState.value }
//        set {
//            self.atomicState.modify {
//                let oldValue = $0
//                if oldValue != newValue {
//                    $0 = newValue
//                    self.notify(state: newValue)
//                }
//            }
//        }
        
//
//        }
        }
    }
    
    func giveMoney() -> Int {
        return self.money.modify { money in
            defer { money = 0 }
            
            return money
        }
    }
    
    func takeMoney(_ money: Int) {
        self.money.modify { $0 += money }
    }
    public init(name: String) {
        self.name = name
    }
    
    let atomicObservers = Atomic([Observer]())

    public class Observer: Hashable {
        public typealias Handler = (State) -> ()
        let handler: Handler
        private weak var emploee: Emploee?
     
        init(emploee: Emploee?, hendler: @escaping Handler) {
            self.handler = hendler
            self.emploee = emploee
        }
        
        public var isObserving: Bool {
            return self.emploee != nil
        }
        
        public func cancel() {
            self.emploee = nil
        }
        
        public var hashValue: Int {
            return ObjectIdentifier(self).hashValue
        }
        
        static func == (lhs: Observer, rhs: Observer) -> Bool {
            return lhs === rhs
        }
    }
    
    func observer(handler: @escaping Observer.Handler) -> Observer {
        return self.atomicObservers.modify {
            let observer = Observer(emploee: self, hendler: handler)
            $0.append(observer)
//            observer.hendler(self.state)
            return observer
        }
    }

    func notify(state: State) {
        self.atomicObservers.modify { observers in
//            observers = observers.filter { $0.isObserving}
//            print("observers count \(self.atomicObservers.value.count)")
            print("notify")
            observers.forEach {
                $0.handler(state)
            }
        }
    }
    
}

