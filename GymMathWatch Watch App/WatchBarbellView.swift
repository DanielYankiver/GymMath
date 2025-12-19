//
//  WatchBarbellView.swift
//  GymMathWatch Watch App
//
//  Created by Daniel Yankiver on 12/19/25.
//

import SwiftUI

struct WacthBarbellView: View {
  let selectedPlates: [WatchPlate]
  let barWeight: Int
  let isBar35: Bool
  let selectedLift: String

  public var totalWeight: Int {
    let platesTotal = selectedPlates.map { $0.weight }.reduce(0, +) * 2
    return platesTotal + barWeight
  }

  var body: some View {
    ZStack {
      Text(selectedPlates.isEmpty ? "GymMath" : "\(totalWeight) lbs")
        .font(.title3)
        .bold()
        .foregroundColor(selectedPlates.isEmpty ? .white.opacity(0.4) : .green)
        .padding(.bottom, 40)

      // MARK: - Barbell

      RoundedRectangle(cornerRadius: 2)
        .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
        .frame(width: 200, height: 10)
        .overlay(
          RoundedRectangle(cornerRadius: 4)
            .stroke(isBar35 ? Color.pink.opacity(0.4) : Color.blue.opacity(0.4), lineWidth: 2)
        )
        .padding(.vertical, 20)

      Text(selectedLift.isEmpty ? "" : "\(selectedLift.uppercased())")
      //      Text()
        .font(.system(size: 9))
        .bold()

      HStack(spacing: 0) {
        // MARK: - Left Plates
        ForEach(selectedPlates.reversed(), id: \.id) { plate in
          Rectangle()
            .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
            .frame(width: plate.width / 2, height: plate.height / 2)
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
            )
        }

        Spacer().frame(width: 104)

        // MARK: - Right Plates
        ForEach(selectedPlates, id: \.id) { plate in
          Rectangle()
            .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
            .frame(width: plate.width / 2, height: plate.height / 2)
            .cornerRadius(5)
            .overlay(
              RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
            )
        }
      }
      .padding(.horizontal, 20)
    }
    .padding(.bottom, -10)
  }
}
