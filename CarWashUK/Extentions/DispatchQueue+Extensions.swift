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
        let token = Token.shared  //  default true
       
        while token.isRunning {

            self.asyncAfter(deadline: .after(interval: interval)) {
                    print("11111")
//                if token.isRunning {
                    //            self.asyncAfter(deadline: .after(interval: interval)) {
                    execute()
                }
        }
        return token
    }
}

class Token {
    
    private(set) var isRunning = true
    
    func stop() {
        self.isRunning = false
    }

    static let shared = Token()
    
    private init() {
        
    }
}
