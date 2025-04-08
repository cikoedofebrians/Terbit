//
//  ActivityList.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

import SwiftUI
import SwiftData

struct ActivityList: View {
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    @Environment(\.modelContext) private var context
    
    @Query(sort: [SortDescriptor(\ActivityModel.name)]) private var activities: [ActivityModel]
    
    @Query(sort: [SortDescriptor(\RoutineModel.index)]) private var routine: [RoutineModel]
    
    var body: some View {
        List {
            ForEach(activities, id: \.self) { activity in
                Button {
                        myRoutineRouter.push(.activityDetailsView(ActivityDetailsType.add(activity)))
                } label: {
                    HStack(spacing: 0) {
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
                            addToRoutine(activity)
//                            myRoutineRouter.popUntil(.editRoutineView)
//                            
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//                                        routineStore.selectedActivities.append(
//                                            ActivityRoutine(activity: activity, index: routineStore.selectedActivities.count)
//                                        )
//                            }
                        } label: {
                            Text("Add")
                        }
                        .disabled(routine.contains(where: { $0.activity.id == activity.id }))
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .tint(.accentColor)
                    }
                }
                .tint(.primary)
            }
        }
        .navigationTitle("Activity List")
        .onAppear {
            seedActivitiesIfNeeded()
        }
    }
    
    private func seedActivitiesIfNeeded() {
        guard activities.isEmpty else { return }
        
        for item in constantActivities {
            let activity = ActivityModel(name: item.name, desc: item.desc, instructions: item.instructions, duration: item.duration)
            context.insert(activity)
            print(item.name)
        }
        try? context.save()
    }
    
    private func addToRoutine(_ activity: ActivityModel) {
            let newRoutine = RoutineModel(activity: activity, index: routine.count)
            context.insert(newRoutine)

            do {
                try context.save()
                myRoutineRouter.popUntil(.editRoutineView)
            } catch {
                print("Failed to save new routine: \(error)")
            }
        }
}

//#Preview {
//    NavigationStack {
//        ActivityList()
//            .environment(MyRoutineRouter())
//            .environment(RoutineStore())
//    }
//}
