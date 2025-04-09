//
//  HistoryDetails.swift
//  Terbit
//
//  Created by Syaoki Biek on 26/03/25.
//

import SwiftUI

struct HistoryDetailsView: View {
    @Environment(HistoryRouter.self) var historyRouter
    @Environment(RoutineStore.self) var routineStore
    
    var history: HistoryModel
    
    @State var durationPerActivity: Int = 3
    @State var numberOfActivity: Int = 4

    
    var body: some View {
        List {
            // Section for activities
            Section(header :
                Text(history.date.formatted(.dateTime.weekday(.abbreviated).day().month(.wide).year()))
                .font(.subheadline)
            ) {
                ForEach(history.completedActivities.indices, id: \.self) { index in
                    let completed = history.completedActivities[index]
                    HStack {
                        // Icon
                        Image(systemName: completed.activity.logoImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(
                                LinearGradient(colors: [Color.red, Color.blue], startPoint: .leading, endPoint: .trailing)
                            )

                        // Name and Duration
                        VStack(alignment: .leading) {
                            Text(completed.activity.title)
                            Text("\(completed.activity.duration) mins")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.leading)

                        Spacer()

                        // Status Checkmark
                        Image(systemName: completed.isCompleted ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(completed.isCompleted ? .green : .red)
                    }
                }
            }
            
            // Section for Information
            Section(header:
                Text("INFORMATION")
                .font(.subheadline)
                .foregroundStyle(.primary)
                
            ) {
                
                // Status
                HStack {
                    Image(systemName: history.isComplete ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    Text("Status")
                        .padding(.leading)

                    Spacer()
                    Text(history.isComplete ? "Completed" : "Incomplete")
                }
                
                    
                // Time
                HStack {
                    Image(systemName: "alarm")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    Text("Time")
                        .padding(.leading)

                    Spacer()
                    Text("\(formattedTime(history.startAt)) - \(formattedTime(history.endAt))")
                }
                
                // Duration
                HStack {
                    Image(systemName: "timer")
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    Text("Duration")
                        .padding(.leading)

                    Spacer()
                    Text("\(history.totalActualDuration) mins")
                }
            }
            .listRowBackground(Color.clear)
            
        }
        
        .navigationTitle("Activities")
        
    }
    
    private func formattedTime(_ date: Date?) -> String {
        guard let date = date else { return "-" }
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

//#Preview {
//    NavigationStack {
//        HistoryDetailsView()
//            .environment(RoutineStore(dataService: .shared))
//            .environment(MyRoutineRouter())
//    }
//}
