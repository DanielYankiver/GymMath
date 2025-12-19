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
          Image(systemName: "list.bullet.clipboard")
            .font(.title2)
            .foregroundStyle(.green.opacity(0.9))
            .bold()
          //            .padding(.top, 6)
          //          ZStack {
          //            Image(systemName: "clipboard")
          //              .font(.title2)
          //              .bold()
          //              .foregroundStyle(.green.opacity(0.9))
          //            Image(systemName: "figure.strengthtraining.traditional")
          //              .font(.caption2)
          //              .foregroundStyle(.green.opacity(0.9))
          //              .bold()
          //              .padding(.top, 6)
          //          }
        }
        .buttonStyle(.plain)


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

        Spacer()
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

        Spacer()
        // Screen Shot
        Button {
          print("Take a Screen shot on my watch")
        } label: {
          Image(systemName: "figure.strengthtraining.traditional.circle")
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
