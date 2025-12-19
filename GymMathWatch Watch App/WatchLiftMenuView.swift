//
//  WatchLiftMenuView.swift
//  GymMathWatch Watch App
//
//  Created by Daniel Yankiver on 12/19/25.
//

import SwiftUI

struct WatchLiftMenuView: View {
  @Binding var showMenu: Bool
  @Binding var selectedLift: String

  let lifts = ["Power Clean", "Back Squat", "Front Squat", "Deadlift", "Bench Press", "Hang Clean", "Snatch", "Overhead Press"]

  var body: some View {
    ZStack {
      Color.black.opacity(0.6).ignoresSafeArea()

      ScrollView {
        Text("Select a Lift")
          .font(.caption)
          .foregroundColor(.white)

        ForEach(lifts, id: \.self) { lift in
          Button {
            selectedLift = lift
            showMenu = false
          } label: {
            Text(lift)
              .frame(maxWidth: .infinity)
              .padding(.vertical, 4)
              .background(.white.opacity(0.15))
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          .buttonStyle(.plain)
        }

        Button {
          showMenu = false
          selectedLift = ""
        } label: {
          Text("Cancel")
            .foregroundColor(.red)
        }
        .padding(.top, 8)
      }
      .padding()
    }
  }
}
