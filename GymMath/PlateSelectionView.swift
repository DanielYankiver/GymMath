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

  var body: some View {
    VStack(spacing: 10) {
      // Quick summary
      HStack {
        Text("Plates per side: \(selectedPlates.count)")
          .font(.subheadline.weight(.semibold))
          .opacity(0.9)

        Spacer()

        if !selectedPlates.isEmpty {
          Text(selectedPlates.map { "\($0.weight)" }.joined(separator: ", "))
            .font(.caption)
            .opacity(0.75)
            .lineLimit(1)
        }
      }

      HStack(spacing: 14) {
        // Remove last plate
        Button {
          if !selectedPlates.isEmpty {
            selectedPlates.removeLast()
          }
        } label: {
          Image(systemName: "minus.circle")
            .font(.system(size: 34, weight: .bold))
            .foregroundStyle(selectedPlates.isEmpty ? .gray : .red)
        }
        .disabled(selectedPlates.isEmpty)

        // Picker (same wheel feel as Watch)
        Picker("Select Plate", selection: $selectedIndex) {
          ForEach(plates.indices, id: \.self) { index in
            Text("\(plates[index].weight) lb").tag(index)
          }
        }
        .labelsHidden()
        .pickerStyle(.wheel)
        .frame(height: 90)
        .clipped()
        .frame(maxWidth: .infinity)

        // Add
        Button {
          if !isAtMax {
            selectedPlates.append(plates[selectedIndex])
          }
        } label: {
          Image(systemName: "plus.circle")
            .font(.system(size: 34, weight: .bold))
            .foregroundStyle(isAtMax ? .red : .green)
        }
        .disabled(isAtMax)
      }
    }
    .padding()
    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
  }
}
