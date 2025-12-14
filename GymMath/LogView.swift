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
  @Query(sort: [SortDescriptor(\LogItem.timestamp, order: .reverse)]) private var logItems: [LogItem]
  @State private var showingDeleteAllConfirm = false
  @State private var showGlassAlert = false
  @State private var showAddSheet = false
  @State private var pendingLogItemTimestamp: Date = .now

  var body: some View {
    ZStack {
      AppBackground()

      VStack(spacing: 12) {
        List {
          ForEach(logItems) { logItem in
            NavigationLink {
              ZStack {
                AppBackground()

                VStack(alignment: .leading, spacing: 12) {
                  Text("Log Item")
                    .font(.headline)

                  Text(logItem.timestamp, format: .dateTime)
                    .font(.subheadline)
                    .opacity(0.9)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding()
              }
              .navigationTitle("Log Item")
              .toolbarBackground(.hidden, for: .navigationBar)
            } label: {
              HStack(spacing: 8) {
                Text(logItem.timestamp, format: .dateTime)
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
          .onDelete(perform: deleteLogItems)
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
      
      if showAddSheet {
        // Dimmed background behind sheet
        Color.black.opacity(0.05)
          .ignoresSafeArea()
          .transition(.opacity)
          .onTapGesture { withAnimation(.snappy) { showAddSheet = false } }

        // Bottom sheet container
        VStack {
          Spacer()
          VStack(spacing: 16) {
            HStack(spacing: 8) {
              Image(systemName: "plus.circle")
                .font(.title2)
                .symbolRenderingMode(.hierarchical)
              Text("Add Log Item")
                .font(.headline)
                .fontWeight(.semibold)
              Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {
              Text("You're about to add:")
                .font(.subheadline)
                .opacity(0.9)
              HStack {
                Image(systemName: "calendar")
                Text(pendingLogItemTimestamp, format: .dateTime)
                  .font(.body)
                  .fontWeight(.medium)
              }
              .opacity(0.95)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 12) {
              Button(role: .cancel) {
                withAnimation(.snappy) { showAddSheet = false }
              } label: {
                Text("Cancel")
                  .frame(maxWidth: .infinity)
              }
              .buttonStyle(.bordered)

              Button {
                withAnimation {
                  modelContext.insert(LogItem(timestamp: pendingLogItemTimestamp))
                }
                withAnimation(.snappy) { showAddSheet = false }
              } label: {
                Text("Confirm")
                  .frame(maxWidth: .infinity)
              }
              .buttonStyle(.borderedProminent)
            }
          }
          .padding(20)
          .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
          .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
              .strokeBorder(.white.opacity(0.12))
          )
          .padding(.horizontal, 12)
          .padding(.bottom, 8)
          .transition(.move(edge: .bottom).combined(with: .opacity))
        }
      }
    }
    .animation(.snappy, value: showGlassAlert)
    .animation(.snappy, value: showAddSheet)
    .navigationTitle("Log")
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        if !logItems.isEmpty {
          Button(action: { showGlassAlert = true }) {
            Label("Delete All", systemImage: "trash")
          }
          .buttonStyle(.plain)
        }
      }
      ToolbarItem {
        Button(action: {
          pendingLogItemTimestamp = .now
          showAddSheet = true
        }) {
          Label("Add Log Item", systemImage: "plus")
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
      modelContext.insert(LogItem(timestamp: .now))
    }
  }

  private func deleteLogItems(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(logItems[index])
      }
    }
  }

  private func deleteAllItems() {
    withAnimation {
      for logItem in logItems {
        modelContext.delete(logItem)
      }
    }
  }
}

#Preview {
  NavigationStack { LogView() }
    .modelContainer(for: LogItem.self, inMemory: true)
}
