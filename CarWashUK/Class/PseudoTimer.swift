//
//  ProgenousEntity.swift
//  CarWashUK
//
//  Created by Student on 13/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class PseudoTimer {
    
    enum State {
        case activated
        case suspended
    }
    
    private let queue: DispatchQueue
    let state = Atomic(State.suspended)
    
    
    init (queue: DispatchQueue = .background) {
        self.queue = queue
    }
    
    var isActivated: Bool {
        return self.state.value == .activated
    }

    private func makeCars(interval: TimeInterval, execute: @escaping F.Execute) {
        self.queue.asyncAfter(deadline: .after(interval: interval)) {
            execute()
            if self.isActivated {
                //                self.makeCars()
            }
            // timer
        }
    }
}

extension DispatchQueue {
 
    
    
    func testDispatchItems(execute: @escaping F.Execute) {
        let queue = DispatchQueue.global()
        
        var item: DispatchWorkItem!
        
        item = DispatchWorkItem {
            for _ in 0 ... 12 {
                if item.isCancelled { break }
                //                print(i)
                execute()
            }
            
        }
        queue.async(execute: item)
        
        queue.asyncAfter(deadline: .after(interval: 5)) { [weak item] in
            item?.cancel()
        }
        item.notify(queue: DispatchQueue.background){
            
        }
    }
}

