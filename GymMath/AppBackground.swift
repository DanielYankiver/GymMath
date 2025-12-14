//
//  AppBackground.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI

struct AppBackground: View {
  var body: some View {
    Image("BarbellBackground")
      .resizable()
      .scaledToFill()
      .ignoresSafeArea()
      .overlay(
        // Liquid-glass readability layer
        LinearGradient(
          colors: [
            Color.black.opacity(0.35),
            Color.black.opacity(0.15),
            Color.black.opacity(0.35)
          ],
          startPoint: .top,
          endPoint: .bottom
        )
        .ignoresSafeArea()
      )
  }
}

#Preview {
  AppBackground()
}
