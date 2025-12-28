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
    case 45: return 100
    case 35: return 100
    case 25: return 100
    case 15: return 100
    case 10: return 100
    case 5:  return 50
    default: return 0
    }
  }

  var width: CGFloat {
    switch weight {
    case 45: return 13
    case 35: return 12
    case 25: return 10
    case 15: return 8
    case 10: return 6
    case 5:  return 4
    default: return 0
    }
  }
}
