//  ActivityRoutine.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

import SwiftData

@Model
class RoutineModel {
    @Relationship var activity: ActivityModel
    @Attribute var index: Int

    init(activity: ActivityModel, index: Int) {
        self.activity = activity
        self.index = index
    }
}
