//
//  Director.swift
//  CarWashUK
//
//  Created by Student on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation


class Director: Manager<Accountant> {
    
    override open func finishProcessing() {
        self.state = .available
        print("director i am free i can take profit \(self.money.value)")
    }
}
