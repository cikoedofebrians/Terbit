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
    
    

    
    var body: some View {
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
                
            }
            Section ("Today Activity (🔥 2 DAYS STREAK)"){
                HStack {
                    Text("Total Duration")
                    Spacer()
                    HStack {
                        Image(systemName: "timer")
                        Text("8 mins")
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
                    print("acumalaka")
                } label: {
                    Text("Start")
                }
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
