//
//  GymMathView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI
import SwiftData

struct GymMathView: View {
  @Environment(\.modelContext) private var modelContext

  @State private var selectedPlates: [Plate] = []
  @State private var isBar35 = false
  @State private var barWeight = 45
  @State private var showLiftMenu = false
  @State private var selectedLift: String = ""

  // MARK: - View Switching
  private enum MathView: String, CaseIterable, Identifiable {
    case barbellMath = "BarbellMath"
    case airBikeMath = "AirBikeMath"

    var id: String { rawValue }
    var title: String { rawValue }
  }

  @State private var selectedMathView: MathView = .barbellMath

  // Same plate options as the Watch app
  private let plates: [Plate] = [
    Plate(weight: 45),
    Plate(weight: 35),
    Plate(weight: 25),
    Plate(weight: 15),
    Plate(weight: 10),
    Plate(weight: 5)
  ]

  private var totalWeight: Int {
    barWeight + (selectedPlates.reduce(0) { $0 + $1.weight } * 2)
  }

  var body: some View {
    ZStack {
      AppBackground()

      Group {
        switch selectedMathView {
        case .barbellMath:
          BarbellMathView(
            selectedPlates: $selectedPlates,
            isBar35: $isBar35,
            barWeight: $barWeight,
            showLiftMenu: $showLiftMenu,
            selectedLift: $selectedLift,
            plates: plates,
            onLog: logCurrentSetup
          )
          .padding(.top, -10)

        case .airBikeMath:
          AirBikeMathView()
            .padding(.top, -10)
        }
      }
      // Lift Menu (kept here so it works regardless of which view is showing)
      .sheet(isPresented: $showLiftMenu) {
        LiftMenuView(selectedLift: $selectedLift)
          .presentationDetents([.medium, .large])
          .presentationDragIndicator(.visible)
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        HStack(spacing: 14) {
          Button {
            selectedPlates.removeAll()
          } label: {
            Image(systemName: "trash")
          }

          Button {
            print("Hello from hand")
          } label: {
            Image(systemName: "hand.raised")
          }
        }
        .padding(.horizontal, 8)
      }


      // ✅ Center toolbar item is now owned by BarbellMathView only

      // MARK: - Right (Popover Menu)
      ToolbarItemGroup(placement: .topBarTrailing) {
        HStack(spacing: 14) {
          Button {
            print("Hello from hand")
          } label: {
            Image(systemName: "hand.raised")
          }
          Menu {
            Picker("Math View", selection: $selectedMathView) {
              Text(MathView.barbellMath.title).tag(MathView.barbellMath)
              Text(MathView.airBikeMath.title).tag(MathView.airBikeMath)
            }
          } label: {
            Image(systemName: "ellipsis")
          }
        }
        .padding(.horizontal, 8)
      }
    }
  }

  private func logCurrentSetup() {
    let platesSummary = selectedPlates.map { String($0.weight) }.joined(separator: ",")
    let item = LogItem(
      timestamp: .now,
      liftName: selectedLift,
      totalWeight: totalWeight,
      barWeight: barWeight,
      isBar35: isBar35,
      platesPerSideCSV: platesSummary
    )
    modelContext.insert(item)
  }
}

#Preview {
  NavigationStack { GymMathView() }
    .modelContainer(for: LogItem.self, inMemory: true)
}
