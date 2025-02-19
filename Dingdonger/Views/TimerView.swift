//
//  ContentView.swift
//  Dingdonger
//
//  Created by topeerz on 03/02/2025.
//

import SwiftUI
import Observation

struct Theme {
    static let backgroundColor = Color.gray
    static let primaryColor = Color.orange
}

struct TimerView: View {
    @Bindable private var viewModel = TimerViewModel()
    private var iteractor = TimerIteractor()

    var body: some View {
        let _ = iteractor.timerViewModel = viewModel
        let _ = Self._printChanges()

        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)

                Circle()
                    .trim(from: 0, to: viewModel.progress)
                    .stroke(Theme.primaryColor, lineWidth: 10)
                    .rotationEffect(.degrees(90))
                    .animation(.linear(duration: 1), value: viewModel.progress)

                GeometryReader { geometry in
                        let buttonSize: CGFloat = 50 // Adjust size as needed

                        // TODO: Add gluing smaller bubbles to larger ones on touch-and-hold on smaller one
                        // TODO: Add plitting larger bubbles on tap (similar to popping small ones)

                        HStack {
                            Button("+") {
                                // TODO: move this to model
                                viewModel.buttonPositions.append(randomPosition(in: geometry.size))
                                iteractor.onAddCycleButtonTap()
                            }
                            .padding()
                            .background(Theme.primaryColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .frame(width: buttonSize, height: buttonSize)

                            Spacer()

                            Button("+5") {
                                for _ in 0..<5 {
                                    // TODO: move this to model
                                    viewModel.buttonPositions.append(randomPosition(in: geometry.size))
                                }
                                iteractor.onAddLargeCycleButtonTap()
                            }
                            .padding(20)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .frame(width: buttonSize * 2, height: buttonSize)
                        }
    
                        ForEach(0..<viewModel.cycles, id: \.self) { cycle in
                            Button( "+1") {
                                iteractor.onCycleButtonTap()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .position(viewModel.buttonPositions[cycle])
                            .onAppear {
                                startFloating(for: cycle, in: geometry.size)
                            }
                        }
                }
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

    // TODO: move to model
    func randomPosition(in size: CGSize) -> CGPoint {
        let x = CGFloat.random(in: 0...size.width)
        let y = CGFloat.random(in: 0...size.height)
        return CGPoint(x: x, y: y)
    }

    // TODO: move to model
    func startFloating(for index: Int, in size: CGSize) {
        let duration = Double.random(in: 2...5)
        withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: true)) {
            viewModel.buttonPositions[index] = randomPosition(in: size)
        }
    }
}

#Preview {
    TimerView()
}
