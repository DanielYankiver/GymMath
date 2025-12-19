//
//  WatchPlateSelectionView.swift
//  GymMathWatch Watch App
//
//  Created by Daniel Yankiver on 12/19/25.
//

import SwiftUI

struct WatchPlateSelectionView: View {
  let plates: [WatchPlate]
  @Binding var selectedPlates: [WatchPlate]
  @State private var selectedIndex: Int = 0

  var body: some View {
    HStack {
      // Remove last plate
      Button {
        if !selectedPlates.isEmpty {
          selectedPlates.removeLast()
        }
      } label: {
        Image(systemName: "minus.circle")
          .font(.largeTitle)
          .foregroundStyle(selectedPlates.isEmpty ? .gray : .red)
      }
      .disabled(selectedPlates.isEmpty)
      .buttonStyle(.plain)

      Spacer()

      // Spinner
      Picker("Select Plate", selection: $selectedIndex) {
        ForEach(plates.indices, id: \.self) { index in
          Text("\(plates[index].weight) lbs").tag(index)
        }
      }
      .labelsHidden()
      .pickerStyle(.wheel)
      .frame(width: 90, height: 70)
      .clipped()

      Spacer()

      // Add button
      Button {
        if selectedPlates.count < 9 {
          selectedPlates.append(plates[selectedIndex])
        }
      } label: {
        Image(systemName: "plus.circle")
          .font(.largeTitle)
          .foregroundStyle(selectedPlates.count == 9 ? .red : .green)
      }
      .frame(height: 66)
      .buttonStyle(.plain)
    }
    .padding(.vertical, 6)
  }
}
