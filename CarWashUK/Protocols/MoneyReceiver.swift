//
//  MoneyReceive.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

protocol MoneyReceiver {
    
    func takeMoney(_ money: Int)
}

extension MoneyReceiver {
    
    func takeMoney(from moneyGiver: MoneGiver) {
        self.takeMoney(moneyGiver.giveMoney())
    }
}
