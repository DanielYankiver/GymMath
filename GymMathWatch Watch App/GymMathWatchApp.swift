//
//  GymMathWatchApp.swift
//  GymMathWatch Watch App
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI

@main
struct GymMathWatch_Watch_AppApp: App {
  var body: some Scene {
    WindowGroup {
      WatchContentView()
        .task {
          WatchPhoneSync.shared.activate()
        }
    }
  }
}
