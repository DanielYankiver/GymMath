//
//  LiftMenuView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/20/25.
//

import SwiftUI

struct LiftMenuView: View {
  @Environment(\.dismiss) private var dismiss
  @Binding var selectedLift: String

  private let lifts = [
    "Power Clean",
    "Back Squat",
    "Front Squat",
    "Deadlift",
    "Bench Press",
    "Hang Clean",
    "Snatch",
    "Overhead Press"
  ]

  var body: some View {
    NavigationStack {
      List {
        Section("Choose a lift") {
          ForEach(lifts, id: \.self) { lift in
            Button {
              selectedLift = lift
              dismiss()
            } label: {
              HStack {
                Text(lift)
                Spacer()
                if selectedLift == lift {
                  Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                }
              }
            }
          }
        }

        Section {
          Button(role: .destructive) {
            selectedLift = ""
            dismiss()
          } label: {
            Text("Clear selection")
          }
        }
      }
      .scrollContentBackground(.hidden)
      .background(AppBackground())
      .navigationTitle("Lift")
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.hidden, for: .navigationBar)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Done") { dismiss() }
        }
      }
    }
  }
}
