//
//  History.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 05/04/25.
//

import SwiftData
import Foundation

@Model
class HistoryModel {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    var completedActivities: [CompletedActivityModel]
    var startAt: Date?
    var endAt: Date?

    init(date: Date, completedActivities: [CompletedActivityModel], startAt: Date? = nil, endAt: Date? = nil) {
        self.date = date
        self.completedActivities = completedActivities
        self.startAt = startAt
        self.endAt = endAt
    }
    
    var totalActualDuration: Int {
        guard let start = startAt, let end = endAt else { return 0 }
        return Int(end.timeIntervalSince(start) / 60)
    }
    
    var isComplete: Bool {
        !completedActivities.isEmpty && completedActivities.allSatisfy { $0.isCompleted }
    }

    var totalActivities: Int {
        completedActivities.count
    }

    var completedCount: Int {
        completedActivities.filter { $0.isCompleted }.count
    }
}

@Model
class CompletedActivityModel {
    @Relationship var activity: ActivityModel
    var isCompleted: Bool
    
    init(activity: ActivityModel, isCompleted: Bool) {
        self.activity = activity
        self.isCompleted = isCompleted
    }
}
