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
                        Image(systemName: activity.logoImage)
                            .font(.system(size: 32))
                            .frame(width: 42, alignment: .center)
                            .padding(.trailing, 16)
                            .foregroundStyle(
                                LinearGradient(colors: [Color.red, Color.blue], startPoint: .leading, endPoint: .trailing)
                            )
                        VStack(alignment: .leading, spacing: 4) {
                            Text(activity.title)
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
                                withAnimation {
                                    routineStore.addActivity(activity)
                                }
                            }
                        } label: {
                            Text("Add")
                                .fontWeight(.semibold)
                                .padding(.horizontal, 6)
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
            .environment(RoutineStore(dataService: .shared))
    }
}
