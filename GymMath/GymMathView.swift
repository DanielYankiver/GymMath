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

      ScrollView {
        VStack(spacing: 14) {
          // Barbell + plates + total
          BarbellView(
            selectedPlates: selectedPlates,
            barWeight: barWeight,
            isBar35: isBar35,
            selectedLift: selectedLift
          )

          // Plate picker + +/- (same cap as Watch)
          PlateSelectionView(plates: plates, selectedPlates: $selectedPlates)

          // Action row (bar type, clear, log)
          HStack(spacing: 18) {

            // Toggle bar size (45 ↔ 35)
            Button {
              isBar35.toggle()
              barWeight = isBar35 ? 35 : 45
            } label: {
              Image(systemName: "arrowshape.up.circle")
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(isBar35 ? .pink : .blue)
                .rotationEffect(.degrees(isBar35 ? 180 : 0))
                .animation(.easeInOut(duration: 0.25), value: isBar35)
                .padding(10)
                .background(.ultraThinMaterial, in: Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Toggle bar weight")
          }
          .padding(.top, 2)
          .padding(.bottom, 18)
        }
        .padding(.horizontal, 14)
        .padding(.top, 6)
        // Lift Menu
        .sheet(isPresented: $showLiftMenu) {
          LiftMenuView(selectedLift: $selectedLift)
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
      }
    }
    .toolbar {
      // MARK: - Left
      ToolbarItemGroup(placement: .topBarLeading) {
        Button {
          selectedPlates.removeAll()
        } label: {
          Image(systemName: "trash")
        }
      }

      // MARK: - Center
      ToolbarItem(placement: .principal) {
        VStack {
          Button {
            showLiftMenu = true
          } label: {
            if !selectedLift.isEmpty {
              Text(selectedLift.uppercased())
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .frame(width: 200, height: 32)
            } else {
              Image(systemName: "figure.strengthtraining.traditional")
                .font(.headline)
                .foregroundStyle(.white)
                .frame(width: 200, height: 32)
            }
          }
          .padding(6)
        }
        .glassEffect(
          .regular.interactive(),
          in: .capsule
        )
      }


      // MARK: - Right
      ToolbarItemGroup(placement: .topBarTrailing) {
        Button {
          logCurrentSetup()
        } label: {
          Image(systemName: "square.and.arrow.down")
        }
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
