//
//  TerbitTabBarView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

struct TerbitTabBarView: View {
    @State var myRoutineRouter = MyRoutineRouter()
    @State var historyRouter = HistoryRouter()
    @State var routineStore: RoutineStore = RoutineStore()
    
    
    var body: some View {
        TabView {
            Tab("My Routine", systemImage: "sunrise.fill") {
                NavigationStack(path: $myRoutineRouter.path) {
                    MyRoutineView()

                        .navigationDestination(for: MyRoutineViewEnum.self) { screen in
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
                .environment(myRoutineRouter)
              
            }
            Tab("History", systemImage: "clock") {
                NavigationStack (path: $historyRouter.path) {
                    HistoryListView()

                        .navigationDestination(for: HistoryViewEnum.self) { screen in
                            switch screen {
                            case .historyDetailsView:
                                HistoryDetailsView()
                            }
                        }

                }
                .environment(routineStore)
                .environment(historyRouter)
                
            }
        }
    }
}

#Preview {
    TerbitTabBarView()
    
}
