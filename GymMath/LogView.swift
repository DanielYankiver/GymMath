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
  @State private var showingDeleteAllConfirm = false
  @State private var showGlassAlert = false

  var body: some View {
    ZStack {
      AppBackground()

      VStack(spacing: 12) {
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

      if showGlassAlert {
        // Dimmed background
        Color.black.opacity(0.35)
          .ignoresSafeArea()
          .transition(.opacity)
          .onTapGesture { withAnimation(.snappy) { showGlassAlert = false } }

        // Glass dialog
        VStack(spacing: 16) {
          HStack(spacing: 8) {
            Image(systemName: "trash")
              .font(.title2)
              .symbolRenderingMode(.hierarchical)
            Text("Delete all items?")
              .font(.headline)
              .fontWeight(.semibold)
          }
          .frame(maxWidth: .infinity, alignment: .leading)

          Text("This will permanently delete all log items.")
            .font(.subheadline)
            .opacity(0.85)
            .frame(maxWidth: .infinity, alignment: .leading)

          HStack(spacing: 12) {
            Button(role: .cancel) {
              withAnimation(.snappy) { showGlassAlert = false }
            } label: {
              Text("Cancel")
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)

            Button(role: .destructive) {
              deleteAllItems()
              withAnimation(.snappy) { showGlassAlert = false }
            } label: {
              Text("Delete All")
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
          }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
          RoundedRectangle(cornerRadius: 20, style: .continuous)
            .strokeBorder(.white.opacity(0.15))
        )
        .padding(.horizontal, 24)
        .transition(.scale.combined(with: .opacity))
      }
    }
    .animation(.snappy, value: showGlassAlert)
    .navigationTitle("Log")
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        if !items.isEmpty {
          Button(action: { showGlassAlert = true }) {
            Label("Delete All", systemImage: "trash")
          }
          .buttonStyle(.plain)
        }
      }
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

  private func deleteAllItems() {
    withAnimation {
      for item in items {
        modelContext.delete(item)
      }
    }
  }
}

#Preview {
  NavigationStack { LogView() }
    .modelContainer(for: Item.self, inMemory: true)
}
