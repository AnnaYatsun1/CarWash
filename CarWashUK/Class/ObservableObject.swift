//
//  ObservableObject.swift
//  CarWashUK
//
//  Created by Student on 17/12/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class ObservableObject<ObservableProperty> {
    
    typealias ObserverHandler = (ObservableProperty) -> ()

    private let atomicObservers = Atomic([Observer]())
    
    func observer(handler: @escaping ObserverHandler) -> Observer {
        return self.atomicObservers.modify {
            let observer = Observer(target: self, handler: handler)
            $0.append(observer)
            return observer
        }
    }
    
    func notify(state: ObservableProperty) {
        DispatchQueue.background.async {
            self.atomicObservers.modify { observers in
                observers = observers.filter { $0.isObserving }
                observers.forEach {
                    $0.handler(state)
                }
            }
        }
    } 
}
