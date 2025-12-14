//
//  LogView.swift
//  GymMath
//
//  Created by Daniel Yankiver on 12/14/25.
//

import SwiftUI
import SwiftData

struct LogView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var items: [Item]

  var body: some View {
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
              .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
              .padding()
            }
            .navigationTitle("Item")
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
    .navigationTitle("Log")
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
  NavigationStack { LogView() }
    .modelContainer(for: Item.self, inMemory: true)
}
