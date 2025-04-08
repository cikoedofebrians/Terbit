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
    @State var date: Date = Date()
    @State var maxDuration: Date = Date()
    
    var allowedRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date()) // 00:00
        let end = calendar.date(byAdding: .minute, value: 30, to: start)!
        return start...end
    }
    
    @State var timeStart = Calendar.current.startOfDay(for: Date())
    
    var body: some View {
//       // Allow only between 00:00 and 00:30

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
