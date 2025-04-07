//
//  EditRoutineViewModel.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 07/04/25.
//
import Foundation
import SwiftData

@MainActor
class EditRoutineViewModel: ObservableObject {
    @Published var selectedActivities: [RoutineModel] = []
    private var context: ModelContext?
    
    init() {}
    
    func setContext(_ context: ModelContext) {
        self.context = context
        loadRoutine()
    }
    
    func loadRoutine() {
        guard let context else { return }

        let checkDescriptor = FetchDescriptor<RoutineModel>()
        let existingRoutines = try? context.fetch(checkDescriptor)

        if existingRoutines?.isEmpty ?? true {
            let existingActivities = try? context.fetch(FetchDescriptor<ActivityModel>())

            if existingActivities?.isEmpty ?? true {
                for constant in constantActivities {
                    let newActivity = ActivityModel(
                        name: constant.name,
                        desc: constant.desc,
                        instructions: constant.instructions,
                        duration: constant.duration
                    )
                    context.insert(newActivity)
                }
            }

            let savedActivities = (try? context.fetch(FetchDescriptor<ActivityModel>())) ?? []
            
            if savedActivities.count >= 2 {
                let routine1 = RoutineModel(activity: savedActivities[0], index: 0)
                let routine2 = RoutineModel(activity: savedActivities[1], index: 1)
                context.insert(routine1)
                context.insert(routine2)
            }

            try? context.save()
        }

        let sortedDescriptor = FetchDescriptor<RoutineModel>(sortBy: [SortDescriptor(\.index)])
        self.selectedActivities = (try? context.fetch(sortedDescriptor)) ?? []
    }
    
    func removeActivity(at index: Int) {
        guard let context else { return }
        let toRemove = selectedActivities[index]
        context.delete(toRemove)
        selectedActivities.remove(at: index)
        reindexRoutines()
        try? context.save()
    }

    private func reindexRoutines() {
        for (i, routine) in selectedActivities.enumerated() {
            routine.index = i
        }
    }
}


