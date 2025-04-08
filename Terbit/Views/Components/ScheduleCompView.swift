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
    
    let notify = NotificationHandler()

    // Create allowed max duration only between 00:00 and 00:30
    var allowedRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date()) // 00:00
        let end = calendar.date(byAdding: .minute, value: 30, to: start)!
        return start...end
    }
    
    // For date picker in Maximum Duration
    @State private var timeStart = Date()
    
    
    public var body: some View {
        @Bindable var routineStore = routineStore
        
        Section("Schedule") {
            HStack {
                DatePicker("Hour", selection: $routineStore.scheduleModel.hour, displayedComponents: .hourAndMinute)
                    .onChange(of: routineStore.scheduleModel.hour) { oldValue, newValue in
                        routineStore.dataService.save()
                        notify.removeAllNotifications()
                        let hour = Calendar.current.component(.hour, from: newValue)
                        let minutes = Calendar.current.component(.minute, from: newValue)
                        notify.scheduleNotification(hour: hour, minutes: minutes, weekdays: routineStore.scheduleModel.days)
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
            
            HStack {
                DatePicker("Max. Duration",
                           selection:$timeStart,
                           in: allowedRange,
                           displayedComponents: [.hourAndMinute])
                    .onChange(of: timeStart) { _, newValue in
                        let calendar = Calendar.current
                        let startOfDay = calendar.startOfDay(for: newValue)
                        let components = calendar.dateComponents([.minute], from: calendar.startOfDay(for: startOfDay), to: newValue)
                        routineStore.scheduleModel.maxDuration = components.minute ?? 0
                        routineStore.dataService.save()
                        
                    }
                    
            }
            
            .onAppear {
                let calendar = Calendar.current
                
                //Setup notification
                notify.askForNotificationPermission()
                let hour = calendar.component(.hour, from: routineStore.scheduleModel.hour)
                let minutes = calendar.component(.minute, from: routineStore.scheduleModel.hour)
                
                notify.removeAllNotifications()
                notify.scheduleNotification(hour: hour, minutes: minutes, weekdays: routineStore.scheduleModel.days)
                
                print("\(hour):\(minutes)")
                
                // Initialize timeStart based on the model value
                let start = calendar.startOfDay(for: Date())
                timeStart = calendar.date(byAdding: .minute,
                                         value: routineStore.scheduleModel.maxDuration,
                                         to: start) ?? start
                
                // for check activity duration
                if routineStore.getTotalDuration() > routineStore.scheduleModel.maxDuration {
                    print("You exceeded the maximum duration") // change this with alert or other action
                } else if routineStore.getTotalDuration() <= routineStore.scheduleModel.maxDuration {
                    print("still good") // only for testing
                }

            }
        }
    }
}
