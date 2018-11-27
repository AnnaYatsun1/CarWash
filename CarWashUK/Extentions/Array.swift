//
//  Array.swift
//  CarWashUK
//
//  Created by Student on 21/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

extension Array {
    
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    func split() -> [[Element]] {
            let ct = self.count
            let half = ct / 2
            let leftSplit = self[0 ..< half]
            let rightSplit = self[half ..< ct]
            return [Array(leftSplit), Array(rightSplit)]
        }
    }

