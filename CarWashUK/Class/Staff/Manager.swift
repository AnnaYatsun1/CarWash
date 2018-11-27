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
            
            if newValue == .available && self.state == .busy  {
                self.doStaffWork(object: nil, completion: nil)
            }
            
            super.state = newValue
        }
    }
 
    override func doStaffWork(object: Processing?, completion: F.Completion?) {
        if let object = object {
            if object.state == .waitProcessing {
                super.doStaffWork(object: object)
            }
        } else {
            self.doCheking()
        }
    }
    
    override func completeProcessing(object: Processing) {
        object.state = .busy
        super .completeProcessing(object: object)
    }
    
    override func performProcessing(object: Processing) {
        object.state = .available
        super .performProcessing(object: object)
    }
    
}
