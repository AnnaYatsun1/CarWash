//
//  Washer.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Washer: Staff<Car> {
    
//  override func performProcessing(object: Car) {
//        print("\(self.name) washer am free i can wash you'r car \(self.money.value), \(self.state)")
//        object.state = .clean
//    }
    
    override func completeProcessing(object car: Car) {
                print("\(self.name) washer am free i can wash you'r car \(self.money.value), \(self.state)")
                car.state = .clean
    }
}
