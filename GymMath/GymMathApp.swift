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
    UIView.appearance(whenContainedInInstancesOf: [UISplitViewController.self]).backgroundColor = .clear
  }

  var sharedModelContainer: ModelContainer = {
    let schema = Schema([LogItem.self])

    // ✅ This is the initializer your SDK expects (no `url:` parameter)
    let configName = "GymMath"
    let config = ModelConfiguration(configName, schema: schema, isStoredInMemoryOnly: false)

    do {
      return try ModelContainer(for: schema, configurations: [config])
    } catch {
      // 🔧 DEV RECOVERY: If schema changed or the store is corrupted,
      // delete the SwiftData SQLite files and retry once.
      deleteSwiftDataStoresLikelyForApp(named: configName)

      do {
        return try ModelContainer(for: schema, configurations: [config])
      } catch {
        fatalError("Could not create ModelContainer after deleting store: \(error)")
      }
    }
  }()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .task {
          WatchLogReceiver.shared.configure(container: sharedModelContainer)
        }
    }
    .modelContainer(sharedModelContainer)
  }
}

private func deleteSwiftDataStoresLikelyForApp(named name: String) {
  let fm = FileManager.default
  guard let appSupport = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
    return
  }

  // SwiftData uses SQLite files in Application Support. Filenames can vary,
  // so we delete any sqlite files that appear to belong to this app/config.
  // This is safe for DEV; don’t do this in production if you need to preserve user data.
  let possibleExtensions = ["sqlite", "sqlite-wal", "sqlite-shm", "db", "db-wal", "db-shm"]

  guard let enumerator = fm.enumerator(at: appSupport, includingPropertiesForKeys: [.isRegularFileKey]) else {
    return
  }

  for case let fileURL as URL in enumerator {
    guard
      (try? fileURL.resourceValues(forKeys: [.isRegularFileKey]).isRegularFile) == true
    else { continue }

    let filename = fileURL.lastPathComponent.lowercased()

    // Heuristics:
    // - remove sqlite/db files that contain the config name, OR contain "gymmath",
    //   OR contain "swiftdata" (some SDKs include this in the filename).
    let looksRelated =
    filename.contains(name.lowercased()) ||
    filename.contains("gymmath") ||
    filename.contains("swiftdata")

    let hasKnownExt = possibleExtensions.contains(where: { filename.hasSuffix($0) })

    if looksRelated && hasKnownExt {
      try? fm.removeItem(at: fileURL)
    }
  }
}
