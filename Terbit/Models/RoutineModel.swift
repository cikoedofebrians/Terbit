//
//  Routine.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 05/04/25.
//

import SwiftData

@Model
class RoutineModel {
    @Relationship var selectedActiviies: [ActivityModel]
    var index: [Int]
    
    init(selectedActiviies: [ActivityModel], index: [Int] = []) {
        self.selectedActiviies = selectedActiviies
        self.index = index
    }
}
