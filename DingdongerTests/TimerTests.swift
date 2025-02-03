//
//  DingdongerTests.swift
//  DingdongerTests
//
//  Created by topeerz on 03/02/2025.
//

import Testing
@testable import Dingdonger

@MainActor
struct TimerTests {

    @Test func test_startingTimer() throws {
        // given
        let sut = TimerIteractor()
        let viewModel = TimerViewModel()
        sut.timerViewModel = viewModel

        sut.timerViewModel?.isRunning = false

        // when
        sut.onPauseStartButtonTap()

        // then
        #expect(viewModel.isRunning == true)
    }

    @Test func test_pausingTimer() throws {
        // given
        let sut = TimerIteractor()
        let viewModel = TimerViewModel()
        sut.timerViewModel = viewModel

        sut.timerViewModel?.isRunning = false

        // when
        sut.onPauseStartButtonTap()
        sut.onPauseStartButtonTap()

        // then
        #expect(viewModel.isRunning == false)
    }

    @Test func test_resetWhileRunning() throws {
        // given
        let sut = TimerIteractor()
        let viewModel = TimerViewModel()
        sut.timerViewModel = viewModel

        sut.timerViewModel?.isRunning = true

        // when
        sut.onResetButtonTap()

        // then
        #expect(viewModel.isRunning == false)
    }

}
