//
//  Staff.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation


class Staff<Processing: MoneGiver>: Emploee, Synchronizable {
    
    public var objectCount = 0
    public var completion: F.ParamCompletion<Processing>?
    
    private let queue = DispatchQueue.background
    private let processedObjects = Queue(elements: [Processing]())
    
    override public var state: State {
        get { return super.state }
        set {
            if newValue == .available && self.state == .busy && !self.chekingForEmpty {
                self.restartIfNeeded()
            } else {
                super.state = newValue
            }
        }
    }
    
    var chekingForEmpty: Bool {
        return self.processedObjects.isEmpty
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
}

