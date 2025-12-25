//
//  PlayView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/21/25.
//

import SwiftUI

struct PlayView: View {
  var body: some View {
    ZStack {
      AppBackground()
      VStack(spacing: 16) {

        // Example above (unchanged)
        Text("Sample Text")
          .padding()
          .glassEffect(
            .regular.interactive().tint(.red.opacity(0.03)), in: .buttonBorder
          )

        // Label + Glass Card
        VStack(alignment: .leading, spacing: 8) {

          Label("Workout List", systemImage: "doc.fill")
            .font(.headline)
            .foregroundStyle(.white)

          Text("1 hour ago")
            .font(.caption)
            .foregroundStyle(.white.opacity(0.7))

        }
        .padding(16)
        .frame(height: 160)
        .frame(maxWidth: 300, alignment: .leading)
        .glassEffect(
          .clear
            .interactive(),
          in: RoundedRectangle(
            cornerRadius: 24,
            style: .continuous
          )
        )
        // subtle outline like the screenshot
        .overlay(
          RoundedRectangle(cornerRadius: 24, style: .continuous)
            .stroke(
              LinearGradient(
                colors: [
                  .white.opacity(0.35),
                  .white.opacity(0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              ),
              lineWidth: 1
            )
        )

        Spacer()
      }
      .padding()
    }
    .toolbar {
      // MARK: - Left
      ToolbarItemGroup(placement: .topBarLeading) {
        Button {
          print("Hello from hand")
        } label: {
          Image(systemName: "hand.raised")
        }

        Button {
          print("Hello from person")
        } label: {
          Image(systemName: "person")
        }
      }

      // MARK: - Center
      ToolbarItem(placement: .principal) {
        VStack {
          Button {
            print("Hello from dumbell")
          } label: {
            Image(systemName: "dumbbell")
              .font(.title3)
              .foregroundStyle(.white)
              .frame(width: 44, height: 44)
          }
          .padding(6)
        }
        .glassEffect(
          .regular.interactive(),
          in: .circle
        )
      }


      // MARK: - Right
      ToolbarItemGroup(placement: .topBarTrailing) {
        Button {
          print("Hello from star")
        } label: {
          Image(systemName: "star")
        }

        Button {
          print("Hello from envelope")
        } label: {
          Image(systemName: "envelope")
        }
      }
    }
  }
}

#Preview {
  PlayView()
}
