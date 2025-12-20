//
//  LogItem.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import Foundation
import SwiftData

@Model
final class LogItem {
  var timestamp: Date

  // GymMath (barbell) details
  var liftName: String
  var totalWeight: Int
  var barWeight: Int
  var isBar35: Bool

  /// CSV of plate weights per side (example: "45,25,10")
  var platesPerSideCSV: String

  init(
    timestamp: Date,
    liftName: String = "",
    totalWeight: Int = 45,
    barWeight: Int = 45,
    isBar35: Bool = false,
    platesPerSideCSV: String = ""
  ) {
    self.timestamp = timestamp
    self.liftName = liftName
    self.totalWeight = totalWeight
    self.barWeight = barWeight
    self.isBar35 = isBar35
    self.platesPerSideCSV = platesPerSideCSV
  }
}
