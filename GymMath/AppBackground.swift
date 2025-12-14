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
    // Optional: readability for text
      .overlay(Color.black.opacity(0.25))
  }
}

#Preview {
  AppBackground()
}
