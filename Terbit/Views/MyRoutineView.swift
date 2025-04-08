//
//  MyRoutineView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//
import SwiftUI


struct MyRoutineView: View {
    
    @Environment(AppRouter.self) var appRouter
    @Environment(RoutineStore.self) var routineStore
    @State var date: Date = Date()
    @State var maxDuration: Date = Date()
    
    

    
    var body: some View {
//       // Allow only between 00:00 and 00:30
        var allowedRange: ClosedRange<Date> {
            let calendar = Calendar.current
            let start = calendar.startOfDay(for: Date()) // 00:00
            let end = calendar.date(byAdding: .minute, value: 30, to: start)!
            return start...end
        }
        
        @State var timeStart = Calendar.current.startOfDay(for: Date())
        
        
        Form {
            Section("Schedule") {
                HStack {
                    DatePicker("Hour", selection: $date,
                               displayedComponents: .hourAndMinute)
                }
                Button {
                    appRouter.push(.selectDayView)
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
            Section ("Today Activity (🔥 2 DAYS STREAK)"){
                HStack {
                    Text("Total Duration")
                    Spacer()
                    HStack {
                        Image(systemName: "timer")
                        Text("\(routineStore.getTotalDuration()) min")
                    }
                    .foregroundStyle(.secondary)
                }
                
                
                ForEach(routineStore.selectedActivities, id: \.self) { routineActivity in
                    Button {
                        appRouter.push(.activityDetailsView(.viewOnly(routineActivity.activity)))
                        
                    } label: {
                        HStack {
                            Text("\(routineActivity.index + 1)")
                                .foregroundStyle(.secondary)
                                .padding(.trailing, 12)
                            VStack (alignment: .leading, spacing: 6){
                                Text(routineActivity.activity.name)
                                HStack {
                                    Image(systemName: "timer")
                                    Text("\(routineActivity.activity.duration) mins")
                                }
                                .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                            
                        }
                    }
                    .tint(.primary)
                }
                
            }
            Section ("ACTIONS") {
                Button {
                    appRouter.push(.routineGuideView)
                } label: {
                    Text("Start")
                }
                .disabled(routineStore.selectedActivities.isEmpty)
            }
        }
        .navigationTitle("My Routine")
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    appRouter.push(.editRoutineView)
                } label: {
                    Image(systemName: "pencil")
                }
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        MyRoutineView()
            .environment(RoutineStore())
            .environment(AppRouter())
    }
    
}
