//
//  TodayCompView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 05/04/25.
//


import SwiftUI
import SwiftData

public struct TodayCompView: View {
    
    @Environment(RoutineStore.self) var routineStore
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(\.modelContext) private var context
    
    @Query(sort: [SortDescriptor(\RoutineModel.index)]) private var routine: [RoutineModel]
    
    public var body: some View {
        Section ("Today Activity (🔥 2 DAYS STREAK)"){
            HStack {
                Text("Total Duration")
                Spacer()
                HStack {
                    Image(systemName: "timer")
                    Text("\(totalDuration()) min")
                }
                .foregroundStyle(.secondary)
            }
            
            
            ForEach(routine, id: \.self) { routineActivity in
                Button {
//                    myRoutineRouter.push(.activityDetailsView(.viewOnly(routineActivity.activity)))
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
    }
    
    private func totalDuration() -> Int {
        routine.map { $0.activity.duration }.reduce(0, +)
    }
}
