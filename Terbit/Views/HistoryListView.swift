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

    var groupedHistories: [String: [HistoryModel]] {
        Dictionary(grouping: routineStore.userHistories) { history in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: history.date)
        }
    }

    var body: some View {
        Form {
            ForEach(groupedHistories.keys.sorted(by: >), id: \.self) { month in
                Section(header: Text(month)) {
                    ForEach(groupedHistories[month] ?? [], id: \.id) { history in
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
        routineStore.addHistory(newHistory)
        print(routineStore.userHistories)
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
