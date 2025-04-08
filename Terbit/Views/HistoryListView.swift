//
//  HistoryListView.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 26/03/25.
//
import SwiftUI

struct HistoryListView: View {
    
    var body: some View {
        Form{
            HistoryListSection(title: "MARCH 2025", historyList: [
                HistoryItemModel(completed: true, progress: "6/6", time: "10 min", date: "05/3/2025"),
                HistoryItemModel(completed: false, progress: "1/2", time: "2 min", date: "04/3/2025"),
                HistoryItemModel(completed: false, progress: "0/2", time: "0 min", date: "03/3/2025"),
                HistoryItemModel(completed: false, progress: "0/2", time: "0 min", date: "02/3/2025"),
                HistoryItemModel(completed: false, progress: "0/2", time: "0 min", date: "01/3/2025"),
                ])

            HistoryListSection(title: "February 2025", historyList: [
                HistoryItemModel(completed: false, progress: "3/6", time: "5 min", date: "28/3/2025"),
                HistoryItemModel(completed: false, progress: "0/2", time: "0 min", date: "27/2/2025")
                ])
        }
        .navigationTitle("History")
    }
}

struct HistoryListSection: View {
    let title: String
    let historyList: [HistoryItemModel]
    
    var body: some View {
        Section (title) {
            List(historyList, id: \.id) { activity in HistoryListCard(routineHistory: activity)
            }
        }
    }
}

struct HistoryListCard: View {
    let routineHistory: HistoryItemModel
    @Environment(HistoryRouter.self) var historyRouter
    
    var body: some View {
        Button(action: {
            historyRouter.push(.historyDetailsView)
            }) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(routineHistory.progress) Activities")
                        .font(.headline)
                    HStack {
                        Image(systemName: "timer")
                        Text(routineHistory.time)
                            .font(.subheadline)
                    
                    }
                    .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 6) {
                    Text(routineHistory.completed ? "Completed" : "Incomplete")
                        .foregroundColor(routineHistory.completed ? .green : .red)
                    Text(routineHistory.date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 10)
        }
        .tint(.primary)
    }
}

struct HistoryItemModel: (Identifiable) {
    let id: UUID = UUID()
    let completed: Bool
    let progress: String
    let time: String
    let date: String
}

#Preview {
    NavigationStack {
        HistoryListView()
            .environment(RoutineStore(dataService: .shared))
            .environment(MyRoutineRouter())
    }
}
