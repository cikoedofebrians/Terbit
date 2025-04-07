//
//  TerbitApp.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI
import SwiftData



@main
struct TerbitApp: App {

//        var sharedModelContainer: ModelContainer = {
//            let schema = Schema([
//                ActivityModel.self,
//                RoutineModel.self,
//                HistoryModel.self,
//                PreferenceModel.self
//            ])
//            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//    
//            do {
//                return try ModelContainer(for: schema, configurations: [modelConfiguration])
//            } catch {
//                fatalError("Could not create ModelContainer: \(error)")
//            }
//        }()
    
    
    
    
    var body: some Scene {
        WindowGroup {
            TerbitTabBarView()
        }
//        .modelContainer(sharedModelContainer)
    }
}
