//
//  RoutineStore.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//


import Observation
import SwiftUI

@Observable
class RoutineStore {
    
    let dataService: SwiftDataService
    
    init(dataService: SwiftDataService) {
        self.dataService = dataService
        self.scheduleModel = dataService.fetchScheduleModel()
        self.selectedActivities = dataService.fetchRoutineModels()
    }
    
    var selectedActivities: [RoutineModel] = []
    var scheduleModel: ScheduleModel
    
    func removeActivityAt(index: Int) {
        selectedActivities.remove(at: index)
    }
    
    func toggleDay(_ dayIndex: Int) {
        scheduleModel.toggleDay(dayIndex)
        dataService.save()
    }
    
    func toggleEveryDay() {
        if  scheduleModel.days.count == constantDaysInt.count {
            scheduleModel.daysString = ""
        } else {
            scheduleModel.daysString = "1,2,3,4,5,6,7"
        }
        dataService.save()
    }
        
    
    func addActivity(_ activity: ActivityModel) {
        let routineModel = RoutineModel(activity: activity, index: selectedActivities.count)
        dataService.addRoutineModel(routineModel)
        selectedActivities = dataService.fetchRoutineModels()
    }
    
    func deleteRoutineModel(routineModel: RoutineModel) {
        dataService.deleteRoutineModel(routineModel)
        selectedActivities = dataService.fetchRoutineModels()
    }
    
    func reorderRoutineModel(from sourceIndex: IndexSet, to destinationIndex: Int) {
        selectedActivities.move(fromOffsets: sourceIndex, toOffset: destinationIndex)
        for (i, routineModel) in selectedActivities.enumerated() {
            routineModel.index = i
            dataService.updateRoutineModel(routineModel, index: i)
        }
        dataService.save()
        selectedActivities = dataService.fetchRoutineModels()
    }
    
    
    func getTotalDuration() -> Int {
        return selectedActivities.reduce(0) { $0 + $1.activity.duration }
    }
}
