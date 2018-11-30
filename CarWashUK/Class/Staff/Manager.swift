//
//  Manager.swift
//  CarWashUK
//
//  Created by Student on 16/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Manager<Processing: MoneGiver & Stateble>: Staff<Processing> {
    
    override var state: State {
        
        willSet {
            self.synchronize {
                if newValue == .available && self.state == .waitProcessing && !self.chekingForEmpty {
                    self.doStaffWork(object: nil, completion: self.completion)
                }
                
                super.state = newValue
            }
        }
    }
    
    override func doStaffWork(object: Processing?, completion: F.Completion?) {
        self.synchronize {
            self.completion = completion
            if let object = object {
                if object.state == .waitProcessing {
                    super.doStaffWork(object: object, completion: completion)
                }
            } else {
                self.processingQueue()
            }
        }
    }
    
    override func completeProcessing(object: Processing) {
        object.state = .available
    }
}
