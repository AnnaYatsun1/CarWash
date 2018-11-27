//
//  Manager.swift
//  CarWashUK
//
//  Created by Student on 16/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Manager<Processing: MoneGiver & Stateble>: Staff<Processing> {
    
    override func performProcessing(object: Processing) {
    
        //  проверить статус бухгалтера
        object.state = .available
    }
}
