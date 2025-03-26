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
    @State var appRouter = AppRouter()
    @State var routineStore: RoutineStore = RoutineStore()
//
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//        
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack (path: $appRouter.path) {
                MyRoutineView()
                    .navigationDestination(for: TerbitScreenEnum.self) { screen in
                        switch screen {
                        case .activityListView (let activityListType):
                            ActivityList(activityListType: activityListType)
                        case .selectDayView:
                            SelectDayView()
                        case .editRoutineView:
                            EditRoutineView()
                        case .routineGuideView:
                            RoutineGuideView()
                        case .activityDetailsView(let activityDetailsType):
                            ActivityDetailsView(activityDetailsType: activityDetailsType)
                        case .routineGuideCompleteView:
                            RoutineGuideCompleteView()
                        }
                    }
                
            }
            .environment(routineStore)
            .environment(appRouter)
            
        }
//        .modelContainer(sharedModelContainer)
    }
}
