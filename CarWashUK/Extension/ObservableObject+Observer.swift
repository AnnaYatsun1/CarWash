//
//  ObservableObject+Observer.swift
//  CarWashUK
//
//  Created by Student on 17/12/2018.
//  Copyright © 2018 Student. All rights reserved.
//

extension ObservableObject {
    
    class Observer {
        
        public let handler: ObserverHandler
        
        private weak var observable: ObservableObject?
        
        public var isObserving: Bool {
            return self.observable != nil 
        }
        
        init(target: ObservableObject, handler: @escaping ObserverHandler) {
            self.handler = handler
            self.observable = target
        }
        
        public func cancel() {
            self.observable = nil
        }
    }
}
