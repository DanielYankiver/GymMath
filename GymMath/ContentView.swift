//
//  ContentView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      NavigationStack {
        LogView()
      }
      .tabItem {
        Label("Log", systemImage: "list.bullet.rectangle")
      }

      NavigationStack {
        ProfileView()
      }
      .tabItem {
        Label("Profile", systemImage: "person.crop.circle")
      }

      NavigationStack {
        StatsView()
      }
      .tabItem {
        Label("Stats", systemImage: "chart.bar.xaxis")
      }
    }
    // Liquid-glass bottom bar look
    .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    .toolbarBackground(.visible, for: .tabBar)
  }
}

#Preview {
  ContentView()
}
