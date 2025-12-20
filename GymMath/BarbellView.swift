//
//  BarbellView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/20/25.
//

import SwiftUI

struct BarbellView: View {
  let selectedPlates: [Plate]
  let barWeight: Int
  let isBar35: Bool
  let selectedLift: String

  var totalWeight: Int {
    barWeight + (selectedPlates.reduce(0) { $0 + $1.weight } * 2)
  }

  private var barTint: Color {
    isBar35 ? .pink : .blue
  }

  var body: some View {
    VStack(spacing: 10) {
      // Total + lift
      VStack(spacing: 4) {
        Text("\(totalWeight) lb")
          .font(.system(size: 46, weight: .heavy, design: .rounded))
          .monospacedDigit()
          .minimumScaleFactor(0.6)
          .lineLimit(1)

        if !selectedLift.isEmpty {
          Text(selectedLift.uppercased())
            .font(.system(size: 12, weight: .bold, design: .rounded))
            .opacity(0.9)
        }
      }

      // Bar
      RoundedRectangle(cornerRadius: 6, style: .continuous)
        .fill(Color(red: 0.18, green: 0.18, blue: 0.18))
        .frame(height: 14)
        .overlay(
          RoundedRectangle(cornerRadius: 6, style: .continuous)
            .stroke(barTint.opacity(0.45), lineWidth: 2)
        )
        .padding(.vertical, 10)

      GeometryReader { proxy in
        let availableHalf = max(0, (proxy.size.width - 130) / 2)
        let plateBlockWidth = min(availableHalf, 180)

        HStack(spacing: 0) {
          // Left plates (reverse so biggest is closest to sleeve)
          HStack(spacing: 0) {
            ForEach(selectedPlates.reversed(), id: \.id) { plate in
              plateView(plate)
            }
          }
          .frame(width: plateBlockWidth, alignment: .trailing)

          // Center sleeve gap
          Spacer().frame(width: 130)

          // Right plates
          HStack(spacing: 0) {
            ForEach(selectedPlates, id: \.id) { plate in
              plateView(plate)
            }
          }
          .frame(width: plateBlockWidth, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .frame(height: 190)
    }
    .padding()
    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
  }

  @ViewBuilder
  private func plateView(_ plate: Plate) -> some View {
    RoundedRectangle(cornerRadius: 10, style: .continuous)
      .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
      .frame(width: plate.width, height: plate.height)
      .overlay(
        RoundedRectangle(cornerRadius: 10, style: .continuous)
          .stroke(Color.gray.opacity(0.9), lineWidth: 1)
      )
      .padding(.horizontal, 1)
  }
}
