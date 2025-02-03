//
//  ContentView.swift
//  Dingdonger
//
//  Created by topeerz on 03/02/2025.
//

import SwiftUI
import AVFoundation

struct Theme {
    static let backgroundColor = Color.gray
    static let primaryColor = Color.orange
}

struct TimerView: View {
    @State private var progress: CGFloat = 1.0
    @State private var timeRemaining: Int = 10
    @State private var isRunning: Bool = false
    @State private var audioPlayer: AVAudioPlayer?
    let totalTime: Int = 10

    @State private var timer: Timer? = nil

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)

                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Theme.primaryColor, lineWidth: 10)
                    .rotationEffect(.degrees(90))
                    .animation(.linear(duration: 1), value: progress)
            }
            .frame(width: 300, height: 300)

            HStack {
                Button(isRunning ? "Pause" : "Start") {
                    if isRunning {
                        stopTimer()
                    } else {
                        startTimer()
                    }
                    isRunning.toggle()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())

                Spacer().frame(width: 30)

                Button("Reset") {
                    stopTimer()
                    timeRemaining = totalTime
                    progress = 1.0
                    isRunning = false
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Theme.backgroundColor)
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
                progress = CGFloat(timeRemaining) / CGFloat(totalTime)

            } else {
                stopTimer()
                playSound()
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

#Preview {
    TimerView()
}
