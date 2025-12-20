//
//  GymMathView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI

struct GymMathView: View {
  var body: some View {
    VStack(spacing: 12) {
      Text("Coming soon")
        .font(.title.bold())
    }
    .padding()
    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    .padding()
    .navigationTitle("GymMath")
    .toolbarBackground(.hidden, for: .navigationBar)
  }
}

#Preview {
  NavigationStack { GymMathView() }
}
