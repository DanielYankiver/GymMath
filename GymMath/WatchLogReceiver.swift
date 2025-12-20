//
//  WatchLogReceiver.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/20/25.
//

import Foundation
import SwiftData
import WatchConnectivity

@MainActor
final class WatchLogReceiver: NSObject, WCSessionDelegate {
  static let shared = WatchLogReceiver()

  private var container: ModelContainer?

  // MARK: - Public

  func configure(container: ModelContainer) {
    self.container = container

    guard WCSession.isSupported() else { return }

    let session = WCSession.default
    session.delegate = self
    session.activate()
  }

  // MARK: - WCSessionDelegate

  nonisolated func session(
    _ session: WCSession,
    activationDidCompleteWith activationState: WCSessionActivationState,
    error: Error?
  ) {
    // No-op (you can add logging if you want)
  }

  nonisolated func sessionDidBecomeInactive(_ session: WCSession) {}
  nonisolated func sessionDidDeactivate(_ session: WCSession) {
    session.activate()
  }

  // Reliable background delivery
  nonisolated func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
    Task { @MainActor in
      self.insertLog(from: userInfo)
    }
  }

  // If you ever use sendMessage later (foreground), handle it too:
  nonisolated func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    Task { @MainActor in
      self.insertLog(from: message)
    }
  }

  // MARK: - Insert

  private func insertLog(from dict: [String: Any]) {
    guard let container else { return }

    let timestamp = (dict["timestamp"] as? Date) ?? Date()
    let liftName = (dict["liftName"] as? String) ?? ""
    let totalWeight = (dict["totalWeight"] as? Int) ?? 0
    let barWeight = (dict["barWeight"] as? Int) ?? 45
    let isBar35 = (dict["isBar35"] as? Bool) ?? false
    let platesCSV = (dict["platesPerSideCSV"] as? String) ?? ""

    // Create a context from the shared container and insert
    let context = ModelContext(container)

    // ✅ This initializer matches the “expanded” LogItem we discussed earlier.
    // If your LogItem is still just `timestamp`, tell me and I’ll adjust.
    let item = LogItem(
      timestamp: timestamp,
      liftName: liftName,
      totalWeight: totalWeight,
      barWeight: barWeight,
      isBar35: isBar35,
      platesPerSideCSV: platesCSV
    )

    context.insert(item)

    do {
      try context.save()
    } catch {
      // In dev, avoid crashing—just ignore/log.
      // print("Failed saving watch log item: \(error)")
    }
  }
}
