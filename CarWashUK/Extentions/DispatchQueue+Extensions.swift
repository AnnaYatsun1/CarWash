//
//  DispatchQueue.swift
//  CarWashUK
//
//  Created by Student on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension DispatchQueue {
    
    static var background: DispatchQueue {
        return self.global(qos: .background)
    }
}

extension DispatchQueue {
    
    @discardableResult
    func somthing(interval: TimeInterval, execute: @escaping F.Execute) -> Token {
        let token = Token()
        
        self.asyncAfter(deadline: .after(interval: interval)) {
            execute()
            if token.isRunning.value {
                self.somthing(interval: interval, execute: execute)
            }
            else {
                print("1011111")	
            }
        }
        
        return token
    }
}

class Token {
    var isRunning = Atomic(true)
}
