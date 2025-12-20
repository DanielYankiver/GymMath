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
              detailView(for: logItem)
            } label: {
              HStack(alignment: .top, spacing: 10) {
                // Weight pill
                Text("\(logItem.totalWeight)lb")
                  .font(.caption.weight(.heavy))
                  .padding(.vertical, 6)
                  .padding(.horizontal, 10)
                  .background(.ultraThinMaterial, in: Capsule())
                  .overlay(
                    Capsule().stroke(.white.opacity(0.12), lineWidth: 1)
                  )

                VStack(alignment: .leading, spacing: 4) {
                  if !logItem.liftName.isEmpty {
                    Text(logItem.liftName)
                      .font(.headline)
                      .lineLimit(1)
                  } else {
                    Text("Workout")
                      .font(.headline)
                      .lineLimit(1)
                  }

                  Text(logItem.timestamp, format: .dateTime)
                    .font(.subheadline)
                    .opacity(0.85)
                    .lineLimit(1)

                  if !logItem.platesPerSideCSV.isEmpty {
                    Text("Plates/side: \(logItem.platesPerSideCSV)")
                      .font(.caption)
                      .opacity(0.75)
                      .lineLimit(1)
                  } else {
                    Text("Bar: \(logItem.barWeight)lb")
                      .font(.caption)
                      .opacity(0.75)
                  }
                }

                Spacer(minLength: 0)
              }
              .padding(.vertical, 6)
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
        Color.black.opacity(0.35)
          .ignoresSafeArea()
          .transition(.opacity)
          .onTapGesture { withAnimation(.snappy) { showGlassAlert = false } }

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
        Color.black.opacity(0.05)
          .ignoresSafeArea()
          .transition(.opacity)
          .onTapGesture { withAnimation(.snappy) { showAddSheet = false } }

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
              Text("Timestamp:")
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

  private func detailView(for logItem: LogItem) -> some View {
    ZStack {
      AppBackground()

      VStack(alignment: .leading, spacing: 14) {
        VStack(alignment: .leading, spacing: 6) {
          Text("\(logItem.totalWeight) lb")
            .font(.system(size: 44, weight: .heavy, design: .rounded))
            .monospacedDigit()

          if !logItem.liftName.isEmpty {
            Text(logItem.liftName.uppercased())
              .font(.caption.weight(.bold))
              .opacity(0.85)
          }

          Text(logItem.timestamp, format: .dateTime)
            .font(.subheadline)
            .opacity(0.85)
        }

        VStack(alignment: .leading, spacing: 10) {
          HStack {
            Text("Bar")
              .font(.headline)
            Spacer()
            Text("\(logItem.barWeight) lb" + (logItem.isBar35 ? " (35)" : " (45)"))
              .font(.subheadline.weight(.semibold))
              .opacity(0.9)
          }

          if !logItem.platesPerSideCSV.isEmpty {
            HStack(alignment: .top) {
              Text("Plates / side")
                .font(.headline)
              Spacer()
              Text(logItem.platesPerSideCSV)
                .font(.subheadline.weight(.semibold))
                .multilineTextAlignment(.trailing)
                .opacity(0.9)
            }
          }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))

        Spacer()
      }
      .padding()
    }
    .navigationTitle("Log Item")
    .toolbarBackground(.hidden, for: .navigationBar)
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
