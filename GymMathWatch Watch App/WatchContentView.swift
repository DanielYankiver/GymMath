//
//  WatchContentView.swift
//  GymMathWatch Watch App
//
//  Created by Daniel Yankiver on 12/19/25.
//

import SwiftUI

struct WatchContentView: View {
  @State private var selectedPlates: [WatchPlate] = []
  @State private var isBar35 = false
  @State private var barWeight = 45
  @State private var showLiftMenu: Bool = false
  @State private var selectedLift: String = ""

  let plates = [
    WatchPlate(weight: 45),
    WatchPlate(weight: 35),
    WatchPlate(weight: 25),
    WatchPlate(weight: 15),
    WatchPlate(weight: 10),
    WatchPlate(weight: 5)
  ]

  var body: some View {
    VStack {
      // Pick a Lift
      HStack {
        Spacer()
        Button {
          showLiftMenu = true
        } label: {
          Image(systemName: "figure.strengthtraining.traditional.circle")
            .font(.title)
            .foregroundStyle(.green.opacity(0.9))
            .bold()
        }
        .buttonStyle(.plain)
        .padding(.top, -14) // MARK: - play with this
        Spacer()
      }
      .fullScreenCover(isPresented: $showLiftMenu) {
        WatchLiftMenuView(showMenu: $showLiftMenu, selectedLift: $selectedLift)
      }

      // Barbell + Plates
      WacthBarbellView(selectedPlates: selectedPlates, barWeight: barWeight, isBar35: isBar35, selectedLift: selectedLift)
      // Weight Plate Selection Spinner
      WatchPlateSelectionView(plates: plates, selectedPlates: $selectedPlates)
      Spacer()

      //      Spacer()


      HStack {
        // Change Barbel Size
        Spacer()
        Button {
          isBar35.toggle()
          barWeight = isBar35 ? 35 : 45
        } label: {
          Image(systemName: "arrowshape.up.circle")
          //          .foregroundColor(selectedPlates.isEmpty ? .black : .red)
            .font(.largeTitle)
            .foregroundStyle(isBar35 ? .pink : .blue)
            .rotationEffect(Angle(degrees:isBar35 ? 180 : 0))
            .animation(.easeInOut(duration: 0.3), value: isBar35)
            .bold()
        }
        .buttonStyle(.plain)

        Spacer().frame(width: 20)
        // Clear Plates Button
        Button{
          selectedPlates.removeAll()
        } label: {
          Image(systemName: selectedPlates.isEmpty ? "x.circle" : "x.circle")
            .foregroundStyle($selectedPlates.isEmpty ? .gray : .red)
            .font(.largeTitle)
            .bold()
        }
        .buttonStyle(.plain)
        //        .padding(.leading, 20)
        .disabled(selectedPlates.isEmpty)

        Spacer().frame(width: 20)
        // Log Weight
        Button {
          // plates per side CSV (same idea as iPhone)
          let platesCSV = selectedPlates.map { String($0.weight) }.joined(separator: ",")

          let totalWeight = (selectedPlates.map { $0.weight }.reduce(0, +) * 2) + barWeight

          WatchPhoneSync.shared.sendLog(
            timestamp: Date(),
            liftName: selectedLift,
            totalWeight: totalWeight,
            barWeight: barWeight,
            isBar35: isBar35,
            platesPerSideCSV: platesCSV
          )
        } label: {
          Image(systemName: "camera.aperture")
            .font(.largeTitle)
            .foregroundStyle(.gray)
            .bold()
        }
        .buttonStyle(.plain)
        //        .padding(.leading, 10)
        Spacer()
      }
    }
    .padding(.bottom, 20)
  }
}

#Preview {
  WatchContentView()
}
