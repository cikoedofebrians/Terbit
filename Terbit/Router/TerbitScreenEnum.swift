//
//  TerbitScreenEnum.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 26/03/25.
//


enum TerbitScreenEnum: Hashable {
    case editRoutineView
    case activityDetailsView(ActivityDetailsType)
    case selectDayView
    case activityListView(ActivityListType)
    case routineGuideView
    case routineGuideCompleteView
}
