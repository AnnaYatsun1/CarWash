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

    var isEmpty: Bool {
        return self.elements.value.isEmpty
    }
    
    var count: Int {
        return self.elements.value.count
    }
    
    func enqueue(_ newElement: Element) {
        self.elements.modify {
            $0.append(newElement)
        }
    }
    func enqueueForOptional(_ newElement: Element?) {
        newElement.do(self.enqueue)
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
    
    init(elements: [Element]) {
        self.elements = Atomic(elements)
    }
    
    convenience init() {
        self.init(elements: [Element]())
    }
    
    func element(at index: Int) -> Element {
        return self.elements.value[index]
    }
}
