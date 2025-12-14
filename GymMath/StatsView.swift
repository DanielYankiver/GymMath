//
//  StatsView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI

struct StatsView: View {
  var body: some View {
    ZStack {
      AppBackground()

      VStack(spacing: 12) {
        Text("Stats")
          .font(.largeTitle.bold())

        Text("Coming soon")
          .font(.subheadline)
          .opacity(0.9)
      }
      .padding()
      .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
      .padding()
    }
    .navigationTitle("Stats")
    .toolbarBackground(.hidden, for: .navigationBar)
  }
}

#Preview {
  NavigationStack { StatsView() }
}
