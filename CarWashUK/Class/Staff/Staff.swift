//
//  Staff.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Staff<Processing: MoneyGiver>: Employee, Synchronizable {
    
    override public var state: State {
        get { return super.state }
        set {
            self.synchronize {
                if newValue == .available && self.state == .busy && !self.chekingForEmpty {
                    self.restartIfNeeded()
                } else {
                    super.state = newValue
                }
            }
        }
    }
    
    public var chekingForEmpty: Bool {
        return self.processedObjects.isEmpty
    }
    
    public var objectCount = 0
    public var completion: F.Completion<Processing>?
    
    private let queue = DispatchQueue.background
    private let processedObjects = Queue(elements: [Processing]())
    
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
    
    open func performProcessing(object: Processing) {
        
    }
    
    open func completeProcessing(object: Processing) {
        
    }
    
    open func finishProcessing() {
        self.restartIfNeeded()
    }
    
    func restartIfNeeded() {
        self.synchronize {
            if let object = self.processedObjects.dequeue() {
                self.asyncWork(object)
            } else {
                self.state = .waitProcessing
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
}

