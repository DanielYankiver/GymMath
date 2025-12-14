//
//  ProfileView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    ZStack {
      AppBackground()

      VStack(spacing: 12) {
        Text("Profile")
          .font(.largeTitle.bold())

        Text("Coming soon")
          .font(.subheadline)
          .opacity(0.9)
      }
      .padding()
      .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
      .padding()
    }
    .navigationTitle("Profile")
    .toolbarBackground(.hidden, for: .navigationBar)
  }
}

#Preview {
  NavigationStack { ProfileView() }
}
