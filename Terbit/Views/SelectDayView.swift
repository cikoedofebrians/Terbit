//
//  SelectDayView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

struct SelectDayView: View {
    
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel: SelectDayViewModel
//    @Environment(RoutineStore.self) var routineStore
    @State var selectedDays: [String]
    
    init(viewModel: SelectDayViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _selectedDays = State(initialValue: viewModel.preference?.days ?? [])
    }
    
    var body: some View {
        List {
            ForEach(constantDays, id: \.self) { day in
                Button {
                    if selectedDays.contains(day) {
                        selectedDays.removeAll { $0 == day }
                    } else {
                        selectedDays.append(day)
                    }
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
        .onChange(of: selectedDays) { _, newDays in
            viewModel.updateDays(newDays)
        }
        .onAppear {
            viewModel.loadPreference()
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
