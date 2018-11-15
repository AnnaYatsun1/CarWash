//
//  TimerAfthe.swift
//  CarWashUK
//
//  Created by Student on 13/11/2018.
//  Copyright © 2018 Student. All rights reserved.
//

import Foundation
class TimerAfther {
    enum State {
        case suspended
        case resumed
        case closed
    }
    
    var isRuning = false
    private let timer = DispatchSource.makeTimerSource()
    private(set) var state = State.suspended
    var eventHandler: (() -> ())?
    
    private let repeating: TimeInterval
    private let deadline: DispatchTime
    private let leeway: DispatchTimeInterval
    
    init(
        repeating: TimeInterval,
        deadline: DispatchTime = .now(),
        leeway: DispatchTimeInterval = .seconds(1)
        ) {
        self.repeating = repeating
        self.deadline = deadline
        self.leeway = leeway
    }
    
    
    func timering() -> DispatchSourceTimer  {
        self.timer.setEventHandler(handler: eventHandler)
        self.timer.schedule(deadline: deadline, repeating: repeating, leeway: leeway)
        return self.timer
    }
    
    func resume() {
        guard self.state == .suspended else { return }
        self.timer.resume()
        self.state = .resumed
        self.isRuning = true
    }
    
    func suspend() {
        guard self.state == .resumed else { return }
        self.timer.suspend()
        self.state = .suspended
    }
    
    func stoped() {
        if self.state == .suspended {
            self.state = .suspended
        }
        self.timer.cancel()
        self.state = .closed
    }
}
