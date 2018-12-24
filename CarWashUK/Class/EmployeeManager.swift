//
//  Controller.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 19/12/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class EmployeeManager<Object: Staff<ProcessingObject>, ProcessingObject: MoneyGiver>: ObservableObject<Object>, Synchronizable {
    
    var processingObjectsIsEmpty: Bool {
        return self.processingObjects.isEmpty
    }
    
    private let weakObservers = Atomic([Employee.Observer]())
    private let processingObjects = Queue<ProcessingObject>()
    private let objects = Atomic([Object]())
    
    init(objects: [Object]) {
        self.objects.value = objects
        super.init()
        self.associate()
    }
    
    func performWork(processedObject: ProcessingObject) {
        self.objects.transform {
            let availableObject = $0.first {
                $0.state == .available
            }
            
            let enqueueProcessingObject = { self.processingObjects.enqueue(processedObject) }
            if self.processingObjects.isEmpty {
                if let availableObject = availableObject {
                    availableObject.processObject(processedObject)
                } else {
                    enqueueProcessingObject()
                }
            } else {
                enqueueProcessingObject()
            }
        }
    }
    
    private func associate() {
        self.synchronize {
            weak var weakSelf = self
            self.weakObservers.value = self.objects.value.map { object in
                let weakWasherObserver = object.observer { [weak object] state in
                    DispatchQueue.background.async {
                        switch state {
                        case .available:
                            weakSelf?.processingObjects.dequeue().apply(object?.processObject)
                        case .waitProcessing:
                            object.apply(weakSelf?.notify)
                        case .busy: return
                        }
                    }
                }
                return weakWasherObserver
            }
        }
    }
}
