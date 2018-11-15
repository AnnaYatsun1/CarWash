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
        print("washer am free i can wash you'r car")
        object.state = .clean
    }
    
    
    
   override open func finishProcessing(object: Car) {
        self.state = .waitProcessing
        print("washer - your car is clean i take from \(self.money.value)")
    }
}
