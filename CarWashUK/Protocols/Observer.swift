//
//  Observer.swift
//  CarWashUK
//
//  Created by Student on 04/12/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation

protocol Observer: class {
    
    var id: String { get }
    
    func listen<T: MoneGiver>(sender: Staff<T>, info: F.Event)
}

protocol Observable: class {

    func addObserver(observer: Observer)
    
    func removeObserver(observer: Observer)
    
    func notify(event: F.Event)
}


