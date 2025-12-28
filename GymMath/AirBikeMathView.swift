//
//  AirBikeMathView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/28/25.
//

import SwiftUI

struct AirBikeMathView: View {
  var body: some View {
    ZStack {
      AppBackground()

      VStack {
        Text("Hello from AirbikeMathView!")
          .font(.title2.bold())
          .foregroundStyle(.white)

        Spacer()
      }
      .padding(.top, -10)
    }
    .toolbar {
      // Center toolbar item for AirBikeMath
      ToolbarItem(placement: .principal) {
        Button {
          print("find toolbar action")
        } label: {
          Image(systemName: "bicycle")
            .font(.headline)
            .foregroundStyle(.white)
            .frame(width: 200, height: 32)
        }
        .padding(6)
        .glassEffect(
          .regular.interactive(),
          in: .capsule
        )
      }
    }
  }
}

#Preview {
  NavigationStack {
    AirBikeMathView()
  }
}
