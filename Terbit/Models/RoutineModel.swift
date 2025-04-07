//
//  Routine.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 05/04/25.
//
import Foundation
import SwiftData

@Model
class RoutineModel {
    @Relationship var activity: ActivityModel
    var index: Int

    init(activity: ActivityModel, index: Int) {
        self.activity = activity
        self.index = index
    }
}
