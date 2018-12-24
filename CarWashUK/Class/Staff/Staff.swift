//
//  Staff.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Staff<Processing: MoneyGiver>: Employee, Synchronizable {
    
    override public var state: State {
        get { return super.state }
        set {
            self.atomicState.modify {
                $0 = newValue
                self.notify(state: $0)
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
    
    func performProcessing(object: Processing) { }
    
    func completeProcessing(object: Processing) { }
    
    func completePerformWork() {
        self.state = .waitProcessing
    }
    
    func processObject(_ processedObject: Processing) {
        self.atomicState.modify { state in
            if state == .available {
                state = .busy
                self.queue.asyncAfter(deadline: .randomDuration())  {
                    self.takeMoney(processedObject.giveMoney())
                    self.performProcessing(object: processedObject)
                    self.completeProcessing(object: processedObject)
                    self.completePerformWork()
                }
            }
        }
    }
}
