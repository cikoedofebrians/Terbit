//
//  SelectDayView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI
import SwiftData

struct SelectDayView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(RoutineStore.self) var routineStore
    @Query private var ScheduleModel: [ScheduleModel]
    
    @State private var selectedDays: [String] = []
    
    var body: some View {
        List {
            ForEach(constantDaysInt.indices, id: \.self) { dayIndex in
                Button {
                    routineStore.toggleDay(constantDaysInt[dayIndex])
                } label: {
                    HStack {
                        Text(constantDays[dayIndex])
                        if routineStore.scheduleModel.days.contains(constantDaysInt[dayIndex]) {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundStyle(.green)
                            
                        }
                    }
                    .tint(.primary)
                }
                .tint(.primary)
                
                
            }
            Button {
                routineStore.toggleEveryDay()
            } label: {
                HStack {
                    Text("Every day")
                        .tint(.primary)
                    if routineStore.scheduleModel.days.count == constantDaysInt.count {
                        Spacer()
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                        
                    }
                }
            }
            .navigationTitle("Day")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//#Preview {
//    NavigationStack {
//        SelectDayView()
//        
//    }
//    .environment(RoutineStore(dataService: .shared))
//
//}
