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
    func asyncAfterRepeating(interval: TimeInterval, execute: @escaping F.Execute) -> Token {
        let token = Token()  //  default true
        
        self.asyncAfter(deadline: .after(interval: interval)) {
            if token.isRunning.value {
                self.asyncAfter(deadline: .after(interval: interval)) {
                    execute()
                }
            } else {
                print("token.isRunning.value false")
            }
        }
        
        return token
    }
}
