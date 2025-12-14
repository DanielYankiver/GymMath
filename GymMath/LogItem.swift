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
  
  init(timestamp: Date) {
    self.timestamp = timestamp
  }
}
