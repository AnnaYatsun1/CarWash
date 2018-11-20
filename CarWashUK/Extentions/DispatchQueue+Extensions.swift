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

    func asyncAfterRepeating(
        interval: TimeInterval,
        execute: @escaping F.Execute
    )
        -> Token
    {
        let token = Token()
        self.nextStep(token: token, interval: interval,execute: execute)

        return token
    }

    private func nextStep(token: Token, interval: TimeInterval,execute: @escaping F.Execute
        ) {
     self.asyncAfter(deadline: .after(interval: interval)) {
            if token.isRunning.value {
                execute()
                self.nextStep(token: token, interval: interval, execute: execute)
            }
        }
    }
}

class Token: Synchronizable {
    
    private(set) var isRunning = Atomic(true)
    
    func stop() {
        self.isRunning.value = false
    }
}
