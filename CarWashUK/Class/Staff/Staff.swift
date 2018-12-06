//
//  Staff.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation


class Staff<Processing: MoneGiver>: MoneGiver, MoneyReceiver, Stateble, Synchronizable, Observable {
    
    struct  WeekObserver {
        weak var value: Observer?
    }
    
    public var objectCount = 0
    public let money = Atomic(0)
    public let name: String
    public var completion: F.ParamCompletion<Processing>?
    public var state: State {
        get { return self.privateState.value }
        set {
            let oldValue = self.privateState.value
            self.privateState.value = newValue
            self.notify(event: (oldValue: oldValue, newValue: newValue))
        }
    }
    
    var chekingForEmpty: Bool {
        return self.processedObjects.isEmpty
    }
    
    private let id: String = NSUUID.init().uuidString
    private let queue: DispatchQueue
    private let privateState = Atomic(State.available)
    private let dispatchQueue = DispatchQueue.background
    private let processedObjects = Queue(elements: [Processing]())
    private var observers = [String : WeekObserver]()
    
    init( name: String, queue: DispatchQueue = .background) {
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
    
    func doStaffWork(object: Processing) {
        self.synchronize {
            if self.state == .available {
                self.state = .busy
                self.asyncWork(object)
            } else {
                self.processedObjects.enqueue(object)
            }
        }
    }
    
    private func asyncWork(_ object: Processing) {
        self.queue.asyncAfter(deadline: .randomDuration()) {
            self.takeMoney(from: object)
            self.performProcessing(object: object)
            self.completeProcessing(object: object)
            self.finishProcessing()
        }
    }
    
    open func performProcessing(object: Processing) {
        
    }
    
    open func completeProcessing(object: Processing) {
        
    }
    
    open func finishProcessing() {
        self.processingQueue()
    }
    
    func processingQueue() {
        self.synchronize {
            if let object = self.processedObjects.dequeue() {
                self.asyncWork(object)
            } else {
                self.state = .waitProcessing
            }
        }
    }
    
    func addObserver(observer: Observer) {
         self.observers[observer.id] = WeekObserver(value: observer)
    }
    
    func removeObserver(observer: Observer) {
        self.observers.removeValue(forKey: observer.id)
    }
    
    func notify(event: F.Event) {
        self.synchronize {
            for (key, value) in observers {
                if let observer = value.value {
                    observer.listen(sender: self, info: event)
                } else {
                    self.observers.removeValue(forKey: key)
                }
            }
        }
    }
}

