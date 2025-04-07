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
    @StateObject private var viewModel = SelectDayViewModel()
    @Query private var preferenceModel: [PreferenceModel]
    
    @State private var selectedDays: [String] = []
   
//    @Environment(RoutineStore.self) var routineStore
    var body: some View {

            List {
                ForEach(constantDays, id: \.self) { day in
                    Button {
                        viewModel.toggleDay(day)
//                        preferenceModel.first!.daysRaw = "Monday,Tuesday,Wednesday,Thursday,Friday"
//                        do {
//                            try modelContext.save()
//                        } catch {
//                            print("ANJAY")
//                        }
                    } label: {
                        HStack {
                            Text(day)
                            if viewModel.selectedDays.contains(day) {
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
            .onAppear {
                viewModel.setContext(modelContext)
            }
        }
}

//#Preview {
//    NavigationStack {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//            let container = try! ModelContainer(for: PreferenceModel.self, configurations: config)
//            let vm = SelectDayViewModel(context: container.mainContext)
//        SelectDayView(viewModel: vm)
//        
//    }
//    .environment(RoutineStore())
//}
