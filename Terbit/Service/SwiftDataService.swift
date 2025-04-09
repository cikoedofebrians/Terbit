//
//  SwiftDataService.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 08/04/25.
//


import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        // Change isStoredInMemoryOnly to false if you would like to see the data persistance after kill/exit the app
        self.modelContainer = try! ModelContainer(for: ActivityModel.self, RoutineModel.self, ScheduleModel.self, HistoryModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    
    // Routine
    func fetchRoutineModels()   -> [RoutineModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<RoutineModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addRoutineModel(_ routineModel: RoutineModel) {
        modelContext.insert(routineModel)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // Activity
    
    func fetchActivityModels()   -> [ActivityModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<ActivityModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func seedConstantActivities(_ activities: [ActivityModel]) {
        
        let existingActivities = (try? modelContext.fetch(FetchDescriptor<ActivityModel>())) ?? []

        let existingTitles = Set(existingActivities.map { $0.title })

        for activity in activities {
            if !existingTitles.contains(activity.title) {
                modelContext.insert(activity)
            }
//            else {
//                print("'\(activity.title)' sudah ada, skip.")
//            }
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving seeded activities: \(error)")
        }
    }
    
    // History
    
    func fetchHistoryModels()   -> [HistoryModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<HistoryModel>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addHistoryModel(_ historyModel: HistoryModel) {
        modelContext.insert(historyModel)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
