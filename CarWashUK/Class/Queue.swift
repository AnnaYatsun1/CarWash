//
//  Queue.swift
//  CarWashUK
//
//  Created by Student on 01/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class Queue<Element> {
    
    private var elements = Atomic([Element]())
    var elementsa = [Element]()


    var isEmpty: Bool {
        return self.elements.value.isEmpty
    }
    
    func enqueue(_ newElement: Element) {
        self.elements.modify {
            $0.append(newElement)
        }
    }
    
    func dequeue() -> Element? {
        return self.elements.modify {
            $0.safeRemoveFirst()
        }
    }
    
    func  peek() ->Element?  {
        return self.elements.transform {
            $0.first
        }
    }
    func next() -> Element? {
        let numbersIterator = elements.value.makeIterator()
        return numbersIterator as? Element
    }
}
