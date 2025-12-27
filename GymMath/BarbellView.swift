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

  // Tuning
  private let centerGap: CGFloat = 130
  private let maxPlateBlock: CGFloat = 180
  private let barHeight: CGFloat = 14
  private let sleeveHeight: CGFloat = 18

  private var maxPlateHeight: CGFloat {
    let h = selectedPlates.map(\.height).max() ?? 0
    // give a nice minimum so the bar area doesn't collapse when empty
    return max(h, 90)
  }

  private var renderHeight: CGFloat {
    // Plates should straddle the bar, so give space above/below
    maxPlateHeight + 40
  }

  var body: some View {
    VStack(spacing: 10) {
      // Total
      VStack(spacing: 4) {
        Text("\(totalWeight) lb")
          .font(.system(size: 46, weight: .heavy, design: .rounded))
          .monospacedDigit()
          .minimumScaleFactor(0.6)
          .lineLimit(1)
      }

      GeometryReader { proxy in
        let availableHalf = max(0, (proxy.size.width - centerGap) / 2)
        let plateBlockWidth = min(availableHalf, maxPlateBlock)

        ZStack {
          // BAR (runs through the CENTER of the plates)
          RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(Color(red: 0.18, green: 0.18, blue: 0.18))
            .frame(height: barHeight)
            .overlay(
              RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(barTint.opacity(0.45), lineWidth: 2)
            )
            .frame(maxWidth: .infinity)
            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)

          // PLATES (centered on the bar)
          HStack(spacing: 0) {
            // Left plates (reverse so biggest is closest to sleeve)
            HStack(spacing: 0) {
              ForEach(selectedPlates.reversed(), id: \.id) { plate in
                plateView(plate)
              }
            }
            .frame(width: plateBlockWidth, alignment: .trailing)

            Spacer().frame(width: centerGap)

            // Right plates
            HStack(spacing: 0) {
              ForEach(selectedPlates, id: \.id) { plate in
                plateView(plate)
              }
            }
            .frame(width: plateBlockWidth, alignment: .leading)
          }
          // This centers the entire plate row on the bar
          .frame(maxWidth: .infinity)
          .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .frame(height: renderHeight)
    }
    .padding()
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
