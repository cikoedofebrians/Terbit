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
                ForEach(constantDays, id: \.self) { day in
                    Button {
                        //
                    } label: {
                        HStack {
                            Text(day)
                            if selectedDays.contains(day) {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                    .tint(.primary)
                }
            }
            .navigationTitle("Day")
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    NavigationStack {
        SelectDayView()
        
    }
    .environment(RoutineStore(dataService: .shared))

}
