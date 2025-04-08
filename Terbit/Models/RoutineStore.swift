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
    }
    
    var selectedActivities: [RoutineModel] = [
//        RoutineModel(activity: constantMorningRoutine[0], index: 0),
//        RoutineModel(activity: constantMorningRoutine[2], index: 1),
    ]
    
    
    func fetchEverything()  {
        fetchActivities()
    }
    func removeActivityAt(index: Int) {
        selectedActivities.remove(at: index)
    }
    
    var selectedDays: [String] = []
    
    var selectedTime: Date = Date()
    
    func fetchActivities()  {
        selectedActivities = dataService.fetchRoutineModels()
        print(selectedActivities)
    }
    
    func addActivity(_ activity: ActivityModel) {
        print("TEST")
        let routineModel = RoutineModel(activity: activity, index: selectedActivities.count)
        dataService.addRoutineModel(routineModel)
        fetchActivities()
    }
    
    func removeActivity(at index: Int) {
        selectedActivities.remove(at: index)
    }
    
    func replaceActivity(at index: Int, with activity: RoutineModel) {
        selectedActivities[index] = activity
    }
    
    func getTotalDuration() -> Int {
        return selectedActivities.reduce(0) { $0 + $1.activity.duration }
    }
}
