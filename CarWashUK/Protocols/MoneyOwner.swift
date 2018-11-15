//
//  MoneyOwner.swift
//  CarWashUK
//
//  Created by Student on 31/10/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

protocol MoneyOwner {
    
    var money: Atomic<Int> { get }
}
