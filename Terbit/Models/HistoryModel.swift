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
    var date: Date
    var duration: Int
    
    @Relationship var completedActivities: [ActivityModel]

    init(date: Date, completedActivities: [ActivityModel], duration: Int) {
        self.date = date
        self.completedActivities = completedActivities
        self.duration = duration
    }
}
