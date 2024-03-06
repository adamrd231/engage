//
//  Item.swift
//  EngageTimerApp
//
//  Created by Adam Reed on 3/6/24.
//

import Foundation
import SwiftData

@Model
final class EngageTimer {
    var rounds: Int
    var time: Int
    var restBetweenRounds: Int
    var sound: String
    var lowBoundaryInterval: Int
    var highBoundaryInterval: Int
    
    init(rounds: Int, time: Int, restBetweenRounds: Int, sound: String, lowBoundaryInterval: Int, highBoundaryInterval: Int) {
        self.rounds = rounds
        self.time = time
        self.restBetweenRounds = restBetweenRounds
        self.sound = sound
        self.lowBoundaryInterval = lowBoundaryInterval
        self.highBoundaryInterval = highBoundaryInterval
    }
}

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
