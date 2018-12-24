//
//  CarWash.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class CarWash: Synchronizable {
    
    private let washerManager: EmployeeManager<Washer, Car>
    private let accountantManager: EmployeeManager<Accountant, Washer>
    private let directorManager: EmployeeManager<Director, Accountant>
    private let washManegerObserver = CancellableObject()
    
    init(
        accountant: [Accountant],
        director: [Director],
        washers: [Washer]
        ) {
        self.washerManager = EmployeeManager(objects: washers)
        self.accountantManager = EmployeeManager(objects: accountant)
        self.directorManager = EmployeeManager(objects: director)
        self.attach()
    }
    
    func washCar(_ car: Car) {
        self.washerManager.performWork(processedObject: car)
    }
    
    private func attach() {        
       self.washManegerObserver.value = self.washerManager.observer(handler: self.accountantManager.performWork)
       self.washManegerObserver.value = self.accountantManager.observer(handler: self.directorManager.performWork)
    }
}




