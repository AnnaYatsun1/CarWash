//
//  Staff.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation


class Staff<Processing: MoneGiver>: MoneGiver, MoneyReceiver, Stateble, Synchronizable {
    
    private let id: UInt
    private let queue: DispatchQueue
    private let privateState = Atomic(State.available)
    let objects = Queue<Processing>()
    public var objectCount = 0
    var completion: F.Completion?
    
    let money = Atomic(0)
    let name: String
    
    var state: State {
        get {
            return self.privateState.value
        }
        set {
            self.privateState.modify { $0 = newValue }
        }
    }
    
    init(id: UInt, name: String, queue: DispatchQueue) {
        self.id = id
        self.name = name
        self.queue = queue
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
    
    func doStaffWork(object: Processing?, completion: F.Completion? = nil) {
        self.synchronize {
            self.objects.enqueueForOptional(object)
            
            if self.state != .busy  {
                self.state = .busy
                if let object = self.objects.dequeue() {
                    self.asyncWork(with: object, completion: completion)
                }
                //                       print("\(self) async2222 work \(object),")
                if self.completion == nil {
                    self.completion = completion
                }
            }
            
        }
    }
    
    
    private func asyncWork(
        with object: Processing?,
        completion:  F.Completion? = nil
        ) {
        object.do { objects in
            self.queue.asyncAfter(deadline: .randomDuration()) {
                self.takeMoney(from: objects)
                self.performProcessing(object: objects)
                self.completeProcessing(object: objects)
                //
                self.finishProcessing(object: objects)
                completion?()
            }
        }
    }
    
    open func performProcessing(object: Processing) {
        
    }
    
    open func completeProcessing(object: Processing) {
        
    }
    
    open func finishProcessing(object: Processing) {
        self.synchronize {
            print("\(self)")
            if self.objects.isEmpty {
                print("object is empty, \(self)")
                self.state = .waitProcessing //  will process in completion
            } else {
                self.doStaffWork(object: nil, completion: self.completion)
            }
        }
    }
}
