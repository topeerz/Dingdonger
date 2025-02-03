//
//  DingdongerApp.swift
//  Dingdonger
//
//  Created by topeerz on 03/02/2025.
//

import Observation
import SwiftUI

@main
struct Launcher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil { // this seems to work now event for Testing framework and UI testing
            DingdongerApp.main()

        } else {
            TestApp.main()
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            Text("This is test ...")
        }
    }
}

struct DingdongerApp: App {
    var body: some Scene {
        WindowGroup {
            TimerView()
        }
    }
}

#Preview {
    NavigationStack {
        TimerView()
    }
}
