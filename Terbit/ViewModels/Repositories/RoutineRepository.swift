//
//  RoutineRepository.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 07/04/25.
//
import Foundation
import SwiftData

protocol RoutineRepositoryProtocol {
    func setContext(_context: ModelContext)
    func loadRoutine() -> [RoutineModel]
    func saveRoutine(_ routine: RoutineModel) throws
    func createDefaultRoutinesIfNeeded() throws
    func getTotalDuration(for routines: [RoutineModel]) -> Int
}

class RoutineRepository: RoutineRepositoryProtocol {
    func saveRoutine(_ routine: RoutineModel) throws {
//      Code
    }
    
    private var context: ModelContext?
        
    init(context: ModelContext? = nil) {
        self.context = context
    }
    
    func setContext(_context context: ModelContext) {
        self.context = context
    }
    
    func loadRoutine() -> [RoutineModel] {
            guard let context else { return [] }
            
            do {
                try createDefaultRoutinesIfNeeded()
                
                let sortedDescriptor = FetchDescriptor<RoutineModel>(sortBy: [SortDescriptor(\.index)])
                return try context.fetch(sortedDescriptor)
            } catch {
                print("Error loading routines: \(error)")
                return []
            }
        }
    
    func createDefaultRoutinesIfNeeded() throws {
            guard let context else { throw RepositoryError.contextNotSet }
            
            let checkDescriptor = FetchDescriptor<RoutineModel>()
            let existingRoutines = try context.fetch(checkDescriptor)
            
            if existingRoutines.isEmpty {
                let existingActivities = try context.fetch(FetchDescriptor<ActivityModel>())
                
                if existingActivities.isEmpty {
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
                
                let savedActivities = try context.fetch(FetchDescriptor<ActivityModel>())
                
                if savedActivities.count >= 2 {
                    let routine1 = RoutineModel(activity: savedActivities[0], index: 0)
                    let routine2 = RoutineModel(activity: savedActivities[1], index: 1)
                    context.insert(routine1)
                    context.insert(routine2)
                }
                
                try context.save()
            }
        }
    
    func getTotalDuration(for routines: [RoutineModel]) -> Int {
        return routines.reduce(0) { $0 + $1.activity.duration }
    }
    
    enum RepositoryError: Error {
            case contextNotSet
        }
}
