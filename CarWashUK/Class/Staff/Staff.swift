//
//  Staff.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation


class Staff<Processing: MoneGiver>: MoneGiver, MoneyReceiver, Stateble, Synchronizable {
    
    public var completion: F.Completion?
    public var objectCount = 0
    public let money = Atomic(0)
    public let name: String
    
    private let id: UInt
    private let queue: DispatchQueue
    private let privateState = Atomic(State.available)
    private let dispatchQueue = DispatchQueue.background
    private var objectInProses = Queue(elements: [(object: Processing?, completion: F.Completion?)]())
    
    var state: State {
        get { return self.privateState.value }
        set { self.privateState.value = newValue }
    }
    
    init(id: UInt, name: String, queue: DispatchQueue = .background) {
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
    
    var chekingForEmpty: Bool {
        return self.objectInProses.isEmpty
    }
    
    func takeMoney(_ money: Int) {
        self.money.modify { $0 += money }
    }
    
    func doStaffWork(object: Processing?, completion: F.Completion? = nil) {
        self.synchronize {
            self.completion = completion
            if self.state == .available {
//                print("in staff busy \(self)")
                self.state = .busy
                self.asyncWork(object: object, completion: completion)
            } else {
                let objectWithCimpletion = (object: object, completion: 	completion)
                self.objectInProses.enqueue(objectWithCimpletion)
            }
        }
    }
    
    private func asyncWork(object: Processing?, completion: F.Completion? = nil) {
        object.do { objects in
            self.queue.asyncAfter(deadline: .randomDuration()) {
                self.takeMoney(from: objects)
                self.performProcessing(object: objects)
                self.completeProcessing(object: objects)
                self.finishProcessing(object: objects)
                completion?()
            }
        }
    }
    
    open func performProcessing(object: Processing) {
//        print("perfom prosessng")
    }
    
    open func completeProcessing(object: Processing) {
//        print("completeProcessing")
    }
    
    open func finishProcessing(object: Processing) {
//        print("finishProcessing \(object)")
        self.processingQueue()
    }
    
    func processingQueue() {
        self.synchronize {
            if let object = self.objectInProses.dequeue() {
                self.dispatchQueue.async {
                    self.asyncWork(
                        object: object.object,
                        completion: object.completion
                    )
                }
            } else {
//                print("wait prosessing in cheking \(self)")
                self.state = .waitProcessing
            }
        }
    }
}

