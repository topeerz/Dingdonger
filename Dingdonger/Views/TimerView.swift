//
//  ContentView.swift
//  Dingdonger
//
//  Created by topeerz on 03/02/2025.
//

import SwiftUI

struct Theme {
    static let backgroundColor = Color.gray
    static let primaryColor = Color.orange
}

struct TimerView: View {
    @State private var viewModel = TimerViewModel()
    private var iteractor = TimerIteractor()

    var body: some View {
        let _ = iteractor.timerViewModel = viewModel

        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)

                Circle()
                    .trim(from: 0, to: viewModel.progress)
                    .stroke(Theme.primaryColor, lineWidth: 10)
                    .rotationEffect(.degrees(90))
                    .animation(.linear(duration: 1), value: viewModel.progress)

                Button( "+ \(viewModel.cycles)") {
                    iteractor.onAddCycleButtonTap()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
            .frame(width: 300, height: 300)

            HStack {
                Button(viewModel.isRunning ? "Pause" : "Start") {
                    iteractor.onPauseStartButtonTap()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())

                Spacer().frame(width: 30)

                Button("Reset") {
                    iteractor.onResetButtonTap()
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
}

#Preview {
    TimerView()
}
