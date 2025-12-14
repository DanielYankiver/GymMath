//
//  GymMathApp.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI
import SwiftData

@main
struct GymMathApp: App {

  init() {
    // ✅ Force UIKit-hosted backgrounds used by List / SplitView to be transparent
    UITableView.appearance().backgroundColor = .clear
    UICollectionView.appearance().backgroundColor = .clear
    UIScrollView.appearance().backgroundColor = .clear

    // Also helps some SplitView hosting cases
    UIView.appearance(whenContainedInInstancesOf: [UISplitViewController.self]).backgroundColor = .clear
  }

  var sharedModelContainer: ModelContainer = {
    let schema = Schema([Item.self])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(sharedModelContainer)
  }
}
