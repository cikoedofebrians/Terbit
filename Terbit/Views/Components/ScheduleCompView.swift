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
        Section("Schedule") {
            HStack {
                DatePicker("Hour", selection: $routineStore.scheduleModel.hour, displayedComponents: .hourAndMinute)
                    .onChange(of: routineStore.scheduleModel.hour) { oldValue, newValue in
                        routineStore.dataService.save()
                    }
            }
            
            Button {
                myRoutineRouter.push(.selectDayView)
            } label: {
                HStack {
                    Text("Repeat")
                    Spacer()
                    Group {
                        Text(routineStore.scheduleModel.days.count == 0 ?
                             "Never" :
                                routineStore.scheduleModel.days.count == constantDaysInt.count  ?
                             "Every day" :
                                routineStore.scheduleModel.days.indices.map { constantDays[$0].prefix(3) }.joined(separator: ", "))
                        Image(systemName: "chevron.right")
                    }                    .foregroundStyle(.secondary)
                }
            }
            .tint(.primary)
            
        }
    }
}
