//
//  AppRouter.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import Foundation
import Observation

enum TerbitScreenEnum: Hashable {
    case editRoutineView
    case activityDetailsView(ActivityDetailsType)
    case selectDayView
    case activityListView(ActivityListType)
}

enum ActivityDetailsType: Hashable {
    case viewOnly(MorningActivity)
    case add(MorningActivity)
    case replace(MorningActivity, Int)
}

@Observable
class AppRouter {
    var path: [TerbitScreenEnum] = []
    
    func push(_ screen: TerbitScreenEnum) {
        path.append(screen)
    }
    
    func pop(_ screen: TerbitScreenEnum) {
        if (path.count > 1) {
            path.removeLast()
        }
    }
}
