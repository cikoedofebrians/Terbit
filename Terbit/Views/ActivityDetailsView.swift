//
//  ActivityDetailsView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

enum ActivityDetailsType: Hashable {
    case viewOnly(ActivityModel)
    case add(ActivityModel)
    
    var activity: ActivityModel {
        switch self {
        case    .viewOnly(let activity),
                .add(let activity):
            return activity
        }
    }
    
}

struct ActivityDetailsView: View {
    let activityDetailsType: ActivityDetailsType
    @Environment(RoutineStore.self) var routineStore
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    
    var activity: ActivityModel {
        activityDetailsType.activity
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 0){
                
                Rectangle()
                    .frame(height: 240)
                    .foregroundStyle(.gray)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "timer")
                        Text("\(activity.duration) mins")
                    }
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    HStack {
                        Text(activity.title)
                            .font(.title)
                            .bold()
                        Spacer()
                        
                        switch activityDetailsType {
                        case .add:
                            Button {
                                myRoutineRouter.popUntil(.editRoutineView)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    withAnimation {
                                        routineStore.selectedActivities.append(
                                            RoutineModel(activity: activity, index: routineStore.selectedActivities.count)
                                        )
                                    }
                                }
                            } label: {
                                Text("Add")
                                    .fontWeight(.semibold)
                                    .font(.body)
                            }
                            .buttonBorderShape(.capsule)
                            .buttonStyle(.borderedProminent)
                            .disabled(routineStore.selectedActivities.contains(where: { $0.activity.id == activity.id}))
                            
                        case .viewOnly(_):
                            EmptyView()
                        }
                    }
                    
                    Text(activity.desc)
                        .font(.body)
                        .foregroundStyle(.secondary)
                    Text("Instructions")
                        .font(.title2)
                        .bold()
                        .padding(.top, 16)
                    if activity.instructions.count == 1 {
                        Text(activity.instructions[0])
                            .font(.body)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(Array(activity.instructions.enumerated()), id: \.offset) { idx, instruction in
                            Text("\(idx + 1). \(instruction)")
                                .font(.body)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(activity.title)
        
    }
}

#Preview {
    NavigationStack {
        ActivityDetailsView(activityDetailsType: .add(constantMorningRoutine[1]))
            .environment(RoutineStore(dataService: .shared))
            .environment(MyRoutineRouter())
    }
    
}
