//
//  Plate.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/20/25.
//

import SwiftUI

struct Plate: Identifiable, Equatable {
  let id = UUID()
  let weight: Int

  // Dimensions tuned for iPhone (bigger than Watch)
  var height: CGFloat {
    switch weight {
    case 45: return 170
    case 35: return 165
    case 25: return 160
    case 15: return 150
    case 10: return 140
    case 5:  return 110
    default: return 0
    }
  }

  var width: CGFloat {
    switch weight {
    case 45: return 26
    case 35: return 22
    case 25: return 20
    case 15: return 16
    case 10: return 14
    case 5:  return 10
    default: return 0
    }
  }
}
