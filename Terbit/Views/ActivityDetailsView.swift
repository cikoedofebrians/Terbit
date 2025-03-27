//
//  ActivityDetailsView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

enum ActivityDetailsType: Hashable {
    case viewOnly(MorningActivity)
    case add(MorningActivity)
    case replace(MorningActivity, Int)
    
    var activity: MorningActivity {
        switch self {
        case    .viewOnly(let activity),
                .add(let activity),
                .replace(let activity, _):
            return activity
        }
    }
    
}

struct ActivityDetailsView: View {
    let activityDetailsType: ActivityDetailsType
    @Environment(RoutineStore.self) var routineStore
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    
    var activity: MorningActivity {
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
                        Text(activity.name)
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
                                            ActivityRoutine(activity: activity, index: routineStore.selectedActivities.count)
                                        )
                                    }
                                }
                            } label: {
                                Text("Add")
                            }
                            .buttonBorderShape(.capsule)
                            .buttonStyle(.borderedProminent)
                            .disabled(routineStore.selectedActivities.contains(where: { $0.activity.id == activity.id}))

                        case .replace(_, let index):
                            Button {
                                myRoutineRouter.popUntil(.editRoutineView)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    withAnimation {
                                        routineStore.selectedActivities[index] =
                                            ActivityRoutine(activity: activity, index: index)
                                    }
                                }
                            } label: {
                                Text("Replace")
                            }
                            .buttonBorderShape(.capsule)
                            .buttonStyle(.borderedProminent)
                            .disabled(routineStore.selectedActivities.contains(where: { $0.activity.id == activity.id}))
                        case .viewOnly(_):
                            EmptyView()
                        }
                    }
                    
                    Text(activity.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                    Text("Instructions")
                        .font(.title2)
                        .bold()
                        .padding(.top, 16)
                    ForEach(Array(activity.instructions.enumerated()), id: \.offset) { idx, instruction in
                        Text("\(idx + 1). \(instruction)")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(activity.name)
        
    }
}

#Preview {
    NavigationStack {
        ActivityDetailsView(activityDetailsType: .add(constantMorningRoutine[1]))
            .environment(RoutineStore())
            .environment(MyRoutineRouter())
    }
    
}
