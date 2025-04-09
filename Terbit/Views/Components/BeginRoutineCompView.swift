//
//  BeginRoutineCompView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 05/04/25.
//


import SwiftUI

public struct BeginRoutineCompView: View {
    
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    
    var hasStartedToday: Bool {
        guard let history = routineStore.onGoingActivities else { return false }
        let today = Calendar.current.startOfDay(for: Date())
        return Calendar.current.isDate(history.date, inSameDayAs: today)
    }
    
    public var body: some View {
        Section {
            Button {
                myRoutineRouter.push(.routineGuideView)
                
            } label: {
                Text(hasStartedToday ? "Nice work! Do it again tomorrow!" : "Begin Routine")
            }
            .gesture(DragGesture(minimumDistance: 0))
            .listRowInsets(EdgeInsets())
            .buttonStyle(ListButtonStyle())
            .disabled(routineStore.selectedActivities.isEmpty || hasStartedToday)
        }
        .listSectionSpacing(24)
    }
}


#Preview {
    List {
        BeginRoutineCompView()
    }
    .environment(MyRoutineRouter())
    .environment(RoutineStore(dataService: .shared))
}
