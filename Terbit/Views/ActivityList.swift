//
//  ActivityList.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

import SwiftUI


struct ActivityList: View {
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    
    var body: some View {
        List {
            ForEach(constantMorningRoutine, id: \.self) { activity in
                Button {
                        myRoutineRouter.push(.activityDetailsView(ActivityDetailsType.add(activity)))
                    
                } label: {
                    HStack (spacing: 0) {
                        Rectangle()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(.gray.opacity(0.3))
                            .padding(.trailing, 16)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(activity.name)
                            HStack {
                                Image(systemName: "timer")
                                Text("\(activity.duration) min")
                            }
                            .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button {
                            myRoutineRouter.popUntil(.editRoutineView)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        routineStore.selectedActivities.append(
                                            ActivityRoutine(activity: activity, index: routineStore.selectedActivities.count)
                                        )
                        
                        
                            }
                        } label: {
                            Text("Add")
                        }
                        .disabled(routineStore.selectedActivities.contains(where: { $0.activity.id == activity.id}))
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .tint(.accentColor)
                        
                    }
                }
                .tint(.primary)
                
            }
        }
        .navigationTitle("Activity List")
    }
}

#Preview {
    NavigationStack {
        ActivityList()
            .environment(MyRoutineRouter())
            .environment(RoutineStore())
    }
}
