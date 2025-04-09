//
//  HistoryListView.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 26/03/25.
//
import SwiftUI

struct HistoryListView: View {
    @Environment(HistoryRouter.self) var historyRouter
    @Environment(RoutineStore.self) var routineStore
    
    @State private var groupedHistories: [Date: [HistoryModel]] = [:]
    
    private let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()

    var body: some View {
        Form {
            ForEach(groupedHistories.keys.sorted(by: >), id: \.self) { monthDate in
                Section(header: Text(monthFormatter.string(from: monthDate))) {
                    ForEach(groupedHistories[monthDate] ?? [], id: \.id) { history in
                        HistoryRowView(history: history)
                    }
                }
            }
        }
        .navigationTitle("History")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add") {
                    addRandomHistory()
                }
            }
        }
        .onAppear {
            routineStore.fetchHistories()
            groupedHistories = groupHistories(routineStore.userHistories)
        }
        .onChange(of: routineStore.userHistories) {
            groupedHistories = groupHistories(routineStore.userHistories)
        }
    }

    private func addRandomHistory() {
        let randomActivities = routineStore.allActivities.shuffled().prefix(Int.random(in: 1...3))

        let completedActivities = randomActivities.map { activity in
            CompletedActivityModel(activity: activity, isCompleted: Bool.random())
        }

        let randomDaysOffset = Int.random(in: -90...90)
        let randomDate = Calendar.current.date(byAdding: .day, value: randomDaysOffset, to: .now)!

        let now = randomDate
        let totalDuration = completedActivities.reduce(0) { $0 + $1.activity.duration }
        let endAt = now.addingTimeInterval(TimeInterval(totalDuration * 60))

        let newHistory = HistoryModel(
            date: now,
            completedActivities: completedActivities,
            startAt: now,
            endAt: endAt
        )

        print("Total allActivities: \(routineStore.allActivities.count)")
        print("Adding random history: \(newHistory)")
        routineStore.addDummyHistory(newHistory)
        print(routineStore.userHistories)
    }
    
    private func groupHistories(_ histories: [HistoryModel]) -> [Date: [HistoryModel]] {
        let sortedHistories = histories.sorted { $0.date > $1.date }

        let calendar = Calendar.current
        return Dictionary(grouping: sortedHistories) { history in
            calendar.date(from: calendar.dateComponents([.year, .month], from: history.date))!
        }
    }
}

struct HistoryRowView: View {
    var history: HistoryModel
    @Environment(HistoryRouter.self) var historyRouter

    var body: some View {
        Button {
            historyRouter.push(.historyDetailsView(history))
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(history.completedCount)/\(history.totalActivities) Activities")
                        .font(.headline)

                    HStack {
                        Image(systemName: "timer")
                        Text("\(history.totalActualDuration) min")
                            .font(.subheadline)
                    }
                    .foregroundStyle(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 6) {
                    Text(history.isComplete ? "Completed" : "Incomplete")
                        .foregroundColor(history.isComplete ? .green : .red)

                    Text(history.date.formatted(.dateTime.day().month().year()))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 10)
        }
        .tint(.primary)
    }
}

//#Preview {
//    NavigationStack {
//        HistoryListView()
//            .environment(RoutineStore(dataService: .shared))
//            .environment(HistoryRouter())
//        
//    }
//}
