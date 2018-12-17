//
//  Manager.swift
//  CarWashUK
//
//  Created by Student on 16/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Manager<Processing: MoneyGiver & Stateble>: Staff<Processing> {
    
    override func performProcessing(object: Processing) {
        object.state = .busy
        super.performProcessing(object: object)
    }
    
    override func completeProcessing(object: Processing) {
        object.state = .available
        super.completeProcessing(object: object)
    }
}
