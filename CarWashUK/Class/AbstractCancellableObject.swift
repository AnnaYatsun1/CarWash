//
//  AbstractCancellableObject.swift
//  CarWashUK
//
//  Created by Anna Yatsun on 24/12/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

class AbstractCancellableObject<Storage> {
    
    public var value: Storage {
        get { return self.atomicCancellable.value }
        set { self.atomicCancellable.value = newValue }
    }
    
    private let atomicCancellable: Atomic<Storage>
    
    init(initial: Storage, dispose: @escaping (Storage) -> ()) {
        self.atomicCancellable = Atomic(initial, lock: .init(), willSet: { dispose($0.old) })
    }
}

class CancellableObject: AbstractCancellableObject<Cancellable?> {

    init() {
        super.init(initial: nil) {
            $0?.cancel() }
    }
}

class CompositeCancellableObject: AbstractCancellableObject<[Cancellable]> {
    
    init() {
        super.init(initial: []) {
            $0.forEach { $0.cancel()  }
        }
    }
}
