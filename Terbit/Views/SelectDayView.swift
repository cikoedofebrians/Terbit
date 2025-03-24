//
//  SelectDayView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

struct SelectDayView: View {
    
    @Environment(RoutineStore.self) var routineStore
    @State var selectedDays: [String] = []
    var body: some View {
        List {
            ForEach(constantDays, id: \.self) { day in
                Button {
                    if (routineStore.selectedDays.contains(day)) {
                        routineStore.selectedDays.removeAll { $0 == day }
                    } else {
                        routineStore.selectedDays.append(day)
                    }
                } label: {
                    HStack {
                        Text(day)
                        if routineStore.selectedDays.contains(day) {
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
    .environment(RoutineStore())

}
