//
//  Director.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation


class Director: Manager<Accountant> {
    
    override func completePerformWork() {
        self.state = .available
        print("director i am free i can take profit \(self.money.value)")
    }
}
