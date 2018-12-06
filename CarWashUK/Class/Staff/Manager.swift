//
//  Manager.swift
//  CarWashUK
//
//  Created by Student on 16/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Manager<Processing: MoneGiver & Stateble>: Staff<Processing> {
    
    override func completeProcessing(object: Processing) {
        object.state = .available
        super.completeProcessing(object: object)
    }
}
