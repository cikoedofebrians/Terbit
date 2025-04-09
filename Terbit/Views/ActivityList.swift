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
    
    @State var showLimitAlert: Bool = false
    
    var body: some View {
        List {
            ForEach(routineStore.allActivities, id: \.self) { activity in
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
                            .alert(isPresented: $showLimitAlert) {
                                Alert(title: Text("Limit Exceeded"), message: Text("Cannot add this activity. Max routine time reached."), dismissButton: .default(Text("Got it!")))
                            }
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
                            if routineStore.getTotalDuration() + activity.duration > routineStore.scheduleModel.maxDuration {
                                showLimitAlert = true
                                return
                            }
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
                        .disabled(routineStore.selectedActivities.contains(where: { $0.activity.id == activity.id }))
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
