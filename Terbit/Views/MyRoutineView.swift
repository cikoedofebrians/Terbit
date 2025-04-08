//
//  MyRoutineView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//
import SwiftUI

struct MyRoutineView: View {
    
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    
    var body: some View {
        Form {
            ScheduleCompView()
            TodayCompView()
            BeginRoutineCompView()
        }
        .navigationTitle("My Routine")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    myRoutineRouter.push(.editRoutineView)
                } label: {
                    Text("Manage")
                }
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyRoutineView()
            .environment(RoutineStore(dataService: .shared))
            .environment(MyRoutineRouter())
    }
    
}
