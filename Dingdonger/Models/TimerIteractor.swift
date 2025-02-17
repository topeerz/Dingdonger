//
//  TimeIteractor.swift
//  Dingdonger
//
//  Created by topeerz on 03/02/2025.
//

import Foundation
import AVFoundation

@MainActor
protocol TimerIteractorProtocol {
    func onResetButtonTap()
    func onPauseStartButtonTap()
    func onAddCycleButtonTap()

    var timerViewModel: TimerViewModel? { get set }
}

class TimerIteractor: TimerIteractorProtocol {
    var audioPlayer: AVAudioPlayer?
    var timer: Timer? = nil
    let totalTime = 10.0
    var timeRemaining = 10.0
    var timerViewModel: TimerViewModel?

    func onResetButtonTap() {
        guard let timerViewModel = self.timerViewModel else {
            return
        }

        stopTimer()
        timeRemaining = totalTime
        timerViewModel.progress = 1.0
        timerViewModel.isRunning = false
    }

    func onPauseStartButtonTap() {
        guard let timerViewModel = self.timerViewModel else {
            return
        }

        if timerViewModel.isRunning {
            stopTimer()

        } else {
            startTimer()
        }
        timerViewModel.isRunning.toggle()
    }

    private func startTimer() {
        // TODO: probably need to abstract timer in oreder to be able to test this ...
        let step = 0.1
        timer = Timer.scheduledTimer(withTimeInterval: step, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self = self else {
                    return
                }

                guard let timerViewModel = self.timerViewModel else {
                    return
                }

                if timeRemaining > 0 {
                    timeRemaining -= step
                    timerViewModel.progress = timeRemaining / totalTime

                } else {
                    self.playSound()

                    timerViewModel.cycles -= 1

                    if timerViewModel.cycles == 0 {
                        self.stopTimer()
                        return
                    }

                    timeRemaining = totalTime
                }
            }
        }
    }

    func onAddCycleButtonTap() {
        guard let timerViewModel = self.timerViewModel else {
            return
        }

        timerViewModel.cycles += 1
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func playSound() {
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
