//
//  Accountant.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Accountant: Manager<Washer> {

     override func completePerformWork() {
        super.completePerformWork()
        print("Accountent am free i can take mone for clien and count \(self.money.value)")
    }
}

