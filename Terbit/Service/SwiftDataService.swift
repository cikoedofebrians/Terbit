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
        self.modelContainer = try! ModelContainer(for: ActivityModel.self, RoutineModel.self, ScheduleModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    
    
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
}
