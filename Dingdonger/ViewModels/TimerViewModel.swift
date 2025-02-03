//
//  TimerViewModel.swift
//  Dingdonger
//
//  Created by topeerz on 03/02/2025.
//

import Foundation
import Observation
import AVFoundation

@MainActor
@Observable
class TimerViewModel {
    var progress: CGFloat = 1.0
    var timeRemaining: Int = 10
    var isRunning: Bool = false
    var audioPlayer: AVAudioPlayer?
    let totalTime: Int = 10
    var timer: Timer? = nil

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self = self else {
                    return
                }

                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.progress = CGFloat(self.timeRemaining) / CGFloat(self.totalTime)

                } else {
                    self.stopTimer()
                    self.playSound()
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func playSound() {
        guard let soundURL = Bundle.main.url(forResource: "ding", withExtension: "wav") else {
            print("Sound file not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Couldn't play sound: \(error)")
        }
    }
}
