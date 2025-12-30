//
//  BarbellMathView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/28/25.
//

import SwiftUI

struct BarbellMathView: View {
  @Binding var selectedPlates: [Plate]
  @Binding var isBar35: Bool
  @Binding var barWeight: Int
  @Binding var showLiftMenu: Bool
  @Binding var selectedLift: String

  let plates: [Plate]
  let onLog: () -> Void

  var body: some View {
    VStack {
      VStack {
        BarbellView(
          selectedPlates: selectedPlates,
          barWeight: barWeight,
          isBar35: isBar35,
          selectedLift: selectedLift
        )
      }
      .frame(width: 380, height: 260)
      .glassEffect(
        .clear,
        in: RoundedRectangle(cornerRadius: 24, style: .continuous)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .stroke(
            LinearGradient(
              colors: [.white.opacity(0.35), .white.opacity(0.05)],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            lineWidth: 1
          )
      )

      Spacer().frame(height: 20)

      VStack(spacing: 14) {
        PlateSelectionView(plates: plates, selectedPlates: $selectedPlates)
          .padding(.horizontal, 14)
          .padding(.top, 6)
      }
      .padding(16)
      .frame(maxWidth: 380, alignment: .leading)
      .glassEffect(
        .clear,
        in: RoundedRectangle(cornerRadius: 24, style: .continuous)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 24, style: .continuous)
          .stroke(
            LinearGradient(
              colors: [.white.opacity(0.35), .white.opacity(0.05)],
              startPoint: .topLeading,
              endPoint: .bottomTrailing
            ),
            lineWidth: 1
          )
      )

      Spacer().frame(height: 40)

      VStack {
        Button {
          onLog()
        } label: {
          Text("LOG LIFT")
            .font(.title.bold())
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .frame(height: 54)
            .contentShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
        .buttonStyle(.plain)
        .padding(7)
        .frame(maxWidth: 380)
        .glassEffect(
          .clear.interactive(),
          in: RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
        .overlay(
          RoundedRectangle(cornerRadius: 24, style: .continuous)
            .stroke(
              LinearGradient(
                colors: [.white.opacity(0.35), .white.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              ),
              lineWidth: 1
            )
        )
      }

      Spacer()
    }
    // ✅ ONLY the center toolbar item is defined here
    .toolbar {
      ToolbarItem(placement: .principal) {
        VStack {
          Button {
            showLiftMenu = true
          } label: {
            if !selectedLift.isEmpty {
              Text(selectedLift.uppercased())
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .frame(width: 150, height: 30)
            } else {
              Image(systemName: "figure.strengthtraining.traditional")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 150, height: 30)
            }
          }
          .padding(6)
        }
        .glassEffect(.regular.interactive(), in: .capsule)
      }
    }
  }
}

#Preview {
  BarbellMathView(
    selectedPlates: .constant([Plate(weight: 45), Plate(weight: 25)]),
    isBar35: .constant(false),
    barWeight: .constant(45),
    showLiftMenu: .constant(false),
    selectedLift: .constant("Bench"),
    plates: [
      Plate(weight: 45),
      Plate(weight: 35),
      Plate(weight: 25),
      Plate(weight: 15),
      Plate(weight: 10),
      Plate(weight: 5)
    ],
    onLog: {}
  )
}
