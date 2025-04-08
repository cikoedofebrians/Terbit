//
//  ScheduleCompView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 05/04/25.
//


import SwiftUI

public struct ScheduleCompView: View {
    @Environment(RoutineStore.self) var routineStore
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    
    public var body: some View {
        @Bindable var routineStore = routineStore
        //       // Allow only between 00:00 and 00:30
                var allowedRange: ClosedRange<Date> {
                    let calendar = Calendar.current
                    let start = calendar.startOfDay(for: Date()) // 00:00
                    let end = calendar.date(byAdding: .minute, value: 30, to: start)!
                    return start...end
                }
                
                @State var timeStart = Calendar.current.startOfDay(for: Date())
        
        Section("Schedule") {
            HStack {
                DatePicker("Hour", selection: $routineStore.selectedTime, displayedComponents: .hourAndMinute)
            }
            Button {
                myRoutineRouter.push(.selectDayView)
            } label: {
                HStack {
                    Text("Repeat")
                    Spacer()
                    Group {
                        Text(routineStore.selectedDays.count == 0 ?
                             "Never" :
                                routineStore.selectedDays.count == constantDays.count ?
                             "Every day" :
                                routineStore.selectedDays.map({ String($0.prefix(3)) }).joined(separator: ", "))
                        Image(systemName: "chevron.right")
                    }                    .foregroundStyle(.secondary)
                }
            }
            .tint(.primary)
            
            HStack {
                DatePicker("Max. Duration",
                           selection: $timeStart,
                           in: allowedRange,
                           displayedComponents: [.hourAndMinute])
                    
            }
        }
    }
}
