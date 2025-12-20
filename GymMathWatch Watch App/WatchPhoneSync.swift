//
//  WatchPhoneSync.swift
//  GymMathWatch Watch App
//
//  Created by Daniel Yankiver on 12/20/25.
//

import Foundation
import WatchConnectivity

final class WatchPhoneSync: NSObject, WCSessionDelegate {
  static let shared = WatchPhoneSync()

  func activate() {
    guard WCSession.isSupported() else { return }
    let session = WCSession.default
    session.delegate = self
    session.activate()
  }

  func sendLog(
    timestamp: Date,
    liftName: String,
    totalWeight: Int,
    barWeight: Int,
    isBar35: Bool,
    platesPerSideCSV: String
  ) {
    guard WCSession.isSupported() else { return }
    let session = WCSession.default

    let payload: [String: Any] = [
      "timestamp": timestamp,
      "liftName": liftName,
      "totalWeight": totalWeight,
      "barWeight": barWeight,
      "isBar35": isBar35,
      "platesPerSideCSV": platesPerSideCSV
    ]

    // ✅ Reliable delivery (will queue if phone not reachable)
    session.transferUserInfo(payload)
  }

  // MARK: - WCSessionDelegate
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
  func sessionReachabilityDidChange(_ session: WCSession) {}
}
