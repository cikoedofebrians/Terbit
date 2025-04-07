//
//  MyRoutineViewModel.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 06/04/25.
//

import Foundation
import SwiftData

@MainActor
class MyRoutineViewModel: ObservableObject {
    @Published var preference: PreferenceModel?
    
    @Published var selectedActivities: [RoutineModel] = []
    @Published var hour: Date = Date()

    private var routineRepository: RoutineRepositoryProtocol
    private var context: ModelContext?
    
    init(routineRepository: RoutineRepositoryProtocol = RoutineRepository()) {
            self.routineRepository = routineRepository
        }

    func setContext(_ context: ModelContext) {
        self.context = context
        routineRepository.setContext(_context: context)
        loadPreference()
        loadRoutine()
    }
    
    //Preference
    func loadPreference() {
        guard let context else { return }
        let descriptor = FetchDescriptor<PreferenceModel>()
        if let result = try? context.fetch(descriptor).first {
            self.preference = result
            self.hour = result.hour
        }
    }

    func updateHour(_ hour: Date) {
        guard let context else { return }

        self.hour = hour

        if let pref = preference {
            pref.hour = hour
        } else {
            let newPref = PreferenceModel(hour: hour, days: [])
            context.insert(newPref)
            preference = newPref
        }

        try? context.save()
    }
    
    //Routine
    
    func loadRoutine() {
        self.selectedActivities = routineRepository.loadRoutine()
    }
    
    func getTotalDuration() -> Int {
        return routineRepository.getTotalDuration(for: selectedActivities)
    }
    
//    func loadRoutine() {
//        guard let context else { return }
//
//        let checkDescriptor = FetchDescriptor<RoutineModel>()
//        let existingRoutines = try? context.fetch(checkDescriptor)
//
//        if existingRoutines?.isEmpty ?? true {            let existingActivities = try? context.fetch(FetchDescriptor<ActivityModel>())
//
//            if existingActivities?.isEmpty ?? true {
//                for constant in constantActivities {
//                    let newActivity = ActivityModel(
//                        name: constant.name,
//                        desc: constant.desc,
//                        instructions: constant.instructions,
//                        duration: constant.duration
//                    )
//                    context.insert(newActivity)
//                }
//            }
//
//            let savedActivities = (try? context.fetch(FetchDescriptor<ActivityModel>())) ?? []
//            
//            if savedActivities.count >= 2 {
//                let routine1 = RoutineModel(activity: savedActivities[0], index: 0)
//                let routine2 = RoutineModel(activity: savedActivities[1], index: 1)
//                context.insert(routine1)
//                context.insert(routine2)
//            }
//
//            try? context.save()
//        }
//
//        let sortedDescriptor = FetchDescriptor<RoutineModel>(sortBy: [SortDescriptor(\.index)])
//        self.selectedActivities = (try? context.fetch(sortedDescriptor)) ?? []
//    }
//
//    func getTotalDuration() -> Int {
//        return selectedActivities.reduce(0) { $0 + $1.activity.duration }
//    }
}
