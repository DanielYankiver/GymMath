//
//  ContentView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]

  var body: some View {
    NavigationSplitView {

      ZStack {
        AppBackground()

        List {
          ForEach(items) { item in
            NavigationLink {
              ZStack {
                AppBackground()

                VStack(alignment: .leading, spacing: 12) {
                  Text("Item")
                    .font(.headline)

                  Text(item.timestamp, format: .dateTime)
                    .font(.subheadline)
                    .opacity(0.9)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18))
                .padding()
              }
              .navigationTitle("Items")
              .toolbarBackground(.hidden, for: .navigationBar)
            } label: {
              HStack(spacing: 8) {
                Text(item.timestamp, format: .dateTime)
                  .lineLimit(1)
                  .truncationMode(.tail)
                  .minimumScaleFactor(0.9)
                  .allowsTightening(true)
                  .layoutPriority(1)
                  .frame(maxWidth: .infinity, alignment: .leading)
              }
              .contentShape(Rectangle())
            }
            .listRowBackground(Color.clear)
          }
          .onDelete(perform: deleteItems)
        }
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .scrollIndicators(.hidden)
        .scrollBounceBehavior(.basedOnSize)
      }
      .navigationTitle("Logged Items")
      .toolbar {
        ToolbarItem {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
      }
      .toolbarBackground(.hidden, for: .navigationBar)

    } detail: {
      ZStack {
        AppBackground()

        Text("Select an item")
          .font(.title3)
          .padding()
          .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18))
          .padding()
      }
      .toolbarBackground(.hidden, for: .navigationBar)
    }
  }

  private func addItem() {
    withAnimation {
      modelContext.insert(Item(timestamp: .now))
    }
  }

  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(items[index])
      }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
