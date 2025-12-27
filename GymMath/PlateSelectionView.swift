//
//  PlateSelectionView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/20/25.
//

import SwiftUI

struct PlateSelectionView: View {
  let plates: [Plate]
  @Binding var selectedPlates: [Plate]
  @State private var selectedIndex: Int = 0

  private var isAtMax: Bool { selectedPlates.count >= 9 }

  private var pickerTint: Color {
    .white.opacity(0.06)
  }

  var body: some View {
    VStack(spacing: 10) {
      // Quick summary
      HStack {
        Text("Plates per side: \(selectedPlates.count)")
          .font(.subheadline.weight(.semibold))
          .foregroundStyle(.white.opacity(0.92))

        Spacer()

        if !selectedPlates.isEmpty {
          Text(selectedPlates.map { "\($0.weight)" }.joined(separator: ", "))
            .font(.caption)
            .foregroundStyle(.white.opacity(0.72))
            .lineLimit(1)
        }
      }

      HStack(spacing: 14) {

        // MARK: – Minus (Glass)
        Button {
          if !selectedPlates.isEmpty {
            selectedPlates.removeLast()
          }
        } label: {
          Image(systemName: "minus")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(selectedPlates.isEmpty ? .gray : .red)
            .frame(width: 44, height: 44)
        }
        .disabled(selectedPlates.isEmpty)
        .glassEffect(
          .clear
            .interactive()
            .tint(selectedPlates.isEmpty ? .gray.opacity(0.3) : .red.opacity(0.35)),
          in: .circle
        )

        // MARK: – Picker (Glass)
        ZStack {
          Picker("Select Plate", selection: $selectedIndex) {
            ForEach(plates.indices, id: \.self) { index in
              Text("\(plates[index].weight) lb")
                .tag(index)
            }
          }
          .labelsHidden()
          .pickerStyle(.wheel)
          .frame(height: 90)
          .frame(maxWidth: .infinity)
          .clipped()
        }
        .frame(height: 96)
        .frame(maxWidth: .infinity)
        .contentShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .glassEffect(
          .regular
            .interactive()
            .tint(pickerTint),
          in: RoundedRectangle(cornerRadius: 22, style: .continuous)
        )

        // MARK: – Plus (Glass)
        Button {
          if !isAtMax {
            selectedPlates.append(plates[selectedIndex])
          }
        } label: {
          Image(systemName: "plus")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(isAtMax ? .red : .green)
            .frame(width: 44, height: 44)
        }
        .disabled(isAtMax)
        .glassEffect(
          .clear
            .interactive()
            .tint(isAtMax ? .red.opacity(0.3) : .green.opacity(0.35)),
          in: .circle
        )
      }
    }
  }
}
