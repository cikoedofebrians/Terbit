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
    var selectedActivities: [ActivityRoutine] = []
    
    func removeActivityAt(index: Int) {
        selectedActivities.remove(at: index)
    }
    
    var selectedDays: [String] = []
    
    var selectedTime: Date = Date()
    
    func addActivity(_ activity: ActivityRoutine) {
        selectedActivities.append(activity)
    }
    
    func removeActivity(at index: Int) {
        selectedActivities.remove(at: index)
    }
    
    func replaceActivity(at index: Int, with activity: ActivityRoutine) {
        selectedActivities[index] = activity
    }
    
    func getTotalDuration() -> Int {
        return selectedActivities.reduce(0) { $0 + $1.activity.duration }
    }
}
