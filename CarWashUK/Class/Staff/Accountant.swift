//
//  Accountant.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Accountant: Staff<Washer> {
        
    override open func finishProcessing(object washer: Washer) {
        self.state = .waitProcessing
        print("Accountent am free i can take mone for clien and count \(self.money.value)")
    }
    
    override func performProcessing(object: Washer) {

        self.anyFunc(object)
    }
}
