//
//  SwiftDataService.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 08/04/25.
//


import SwiftData
import Foundation

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
    
    
    func save() {
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
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving seeded activities: \(error)")
        }
    }
    
    // History
    
    func fetchHistoryModels() -> [HistoryModel] {
        do {
            let descriptor = FetchDescriptor<HistoryModel>(
                sortBy: [SortDescriptor(\.date, order: .reverse)]
            )
            return try modelContext.fetch(descriptor)
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
    
    func getOngoingHistoryModel() -> HistoryModel? {
        do {
            let today = Calendar.current.startOfDay(for: Date())
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!

            let descriptor = FetchDescriptor<HistoryModel>(
                predicate: #Predicate {
                    $0.endAt == nil &&
                    $0.date >= today && $0.date < tomorrow
                },
                sortBy: [SortDescriptor(\.startAt, order: .reverse)]
            )
            return try modelContext.fetch(descriptor).first
        } catch {
            print("Failed to fetch ongoing history: \(error)")
            return nil
        }
    }

    func startNewHistorySession(startAt: Date = Date()) -> HistoryModel {
        let today = Calendar.current.startOfDay(for: Date())
        let newHistory = HistoryModel(date: today, completedActivities: [], startAt: Date(), endAt: nil)
        modelContext.insert(newHistory)
        save()
        return newHistory
    }

    func appendCompletedActivity(_ completedActivity: CompletedActivityModel) {
        if let ongoing = getOngoingHistoryModel() {
            ongoing.completedActivities.append(completedActivity)
            save()
        } else {
            print("No ongoing history found. You should start a new history session first.")
        }
    }

    func completeOngoingHistorySession() {
        if let ongoing = getOngoingHistoryModel() {
            ongoing.endAt = Date()
            save()
        }
    }
    
    // Routine
    
    func updateRoutineModel(_ routineModel: RoutineModel, index: Int) {
        routineModel.index = index
        save()
    }
    
    func fetchRoutineModels()   -> [RoutineModel] {
        do {
            return try modelContext.fetch(FetchDescriptor<RoutineModel>(
                sortBy: [SortDescriptor(\.index)]
            ))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteRoutineModel(_ routineModel: RoutineModel) {
        modelContext.delete(routineModel)
        save()
    }
    
    func addRoutineModel(_ routineModel: RoutineModel) {
        modelContext.insert(routineModel)
        save()
    }
    
    //Schedule
    
    func fetchScheduleModel()  -> ScheduleModel {
        do {
            let scheduleModels = try modelContext.fetch(FetchDescriptor<ScheduleModel>())
            if scheduleModels.isEmpty {
                let scheduleModel = ScheduleModel(
                    hour: Date(), days: [], maxDuration: 0
                )
                addScheduleModel(scheduleModel)
                return scheduleModel
            } else {
                return scheduleModels[0]
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addScheduleModel(_ scheduleModel: ScheduleModel) {
        modelContext.insert(scheduleModel)
        save()
    }
    
}
