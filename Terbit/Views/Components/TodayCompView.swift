//
//  TodayCompView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 05/04/25.
//


import SwiftUI

public struct TodayCompView: View {
    
    @Environment(RoutineStore.self) var routineStore
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    
    public var body: some View {
        Section ("Today Activities"){
            if routineStore.selectedActivities.isEmpty {
                    Text("You haven't set any activity yet.\nGo to 'Manage' to set your activity")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 12)
            } else {
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
                        myRoutineRouter.push(.activityDetailsView(.viewOnly(routineActivity.activity)))
                    } label: {
                        HStack {
                            Text("\(routineActivity.index + 1)")
                                .foregroundStyle(.secondary)
                                .padding(.trailing, 12)
                            VStack (alignment: .leading, spacing: 6){
                                Text(routineActivity.activity.title)
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
        }
    }
}


#Preview {
    TodayCompView()
        .environment(MyRoutineRouter())
        .environment(RoutineStore(dataService: .shared))
}
