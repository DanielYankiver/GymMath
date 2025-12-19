//
//  WatchPlate.swift
//  GymMathWatch Watch App
//
//  Created by Daniel Yankiver on 12/19/25.
//

import SwiftUI

struct WatchPlate: Identifiable, Equatable {
  let id = UUID()
  let weight: Int

  var height: CGFloat {
    switch weight {
    case 45: return 90
    case 35: return 90
    case 25: return 90
    case 15: return 90
    case 10: return 90
    case 5:  return 50
    default: return 0
    }
  }

  var width: CGFloat {
    switch weight {
    case 45: return 14
    case 35: return 12
    case 25: return 10
    case 15: return 8
    case 10: return 6
    case 5:  return 4
    default: return 0
    }
  }

  var weightColor: Color {
    switch weight {
    case 45: return .gray.opacity(0.2)
    case 35: return .gray.opacity(0.2)
    case 25: return .gray.opacity(0.2)
    case 15: return .gray.opacity(0.2)
    case 10: return .gray.opacity(0.2)
    case 5:  return .gray.opacity(0.2)
    default: return .gray.opacity(0.2)
    }
  }
}
