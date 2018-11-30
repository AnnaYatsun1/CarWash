//
//  Washer.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Washer: Staff<Car> {
    
  override open func performProcessing(object: Car) {
        print("\(self.name) washer am free i can wash you'r car \(self.money.value)")
        object.state = .clean
    }
}
