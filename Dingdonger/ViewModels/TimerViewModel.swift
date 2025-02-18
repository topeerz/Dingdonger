//
//  TimerViewModel.swift
//  Dingdonger
//
//  Created by topeerz on 03/02/2025.
//

import Foundation
import Observation

@MainActor
@Observable
class TimerViewModel {
    var progress = 1.0
    var isRunning = false
    var cycles = 0
    var buttonPositions: [CGPoint] = []
}
