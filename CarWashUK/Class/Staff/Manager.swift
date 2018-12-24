//
//  Manager.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 16/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Manager<Processing: MoneyGiver & Stateble>: Staff<Processing> {
    
    override func completeProcessing(object: Processing) {	
        object.state = .available
    }
    
    override func performProcessing(object: Processing) {
        object.state = .busy
        self.takeMoney(from: object)
    }
}
