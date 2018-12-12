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
    override public var state: State {
        get {
            print("staff state getter")
            return super.state }
        set {
            print("staff state setter")
            if newValue == .available && self.state == .busy && !self.chekingForEmpty {
                self.processingQueue()
            } else {
                super.state = newValue
            }
        }
    }
    
    var chekingForEmpty: Bool {
        return self.processedObjects.isEmpty
    }
    
    private let queue = DispatchQueue.background
    private let processedObjects = Queue(elements: [Processing]())

    
    func doStaffWork(object: Processing) {
//        self.synchronize {
        self.queue.sync {
            let isAvailable = (self.state == .available)
            
            if isAvailable {
                self.state = .busy
                self.asyncWork(object)
            } else {
                self.processedObjects.enqueue(object)
            }
        }
        
//        }
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
        self.queue.sync {
            if let object = self.processedObjects.dequeue() {
                self.asyncWork(object)
            } else {
                self.state = .waitProcessing
            }
        }
    }
}

