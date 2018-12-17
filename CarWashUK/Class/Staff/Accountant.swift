//
//  Accountant.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Accountant: Manager<Washer> {

    override func finishProcessing() {
        super.finishProcessing()
        print("Accountent am free i can take mone for clien and count \(self.money.value), \(self.state)")
    }
}

