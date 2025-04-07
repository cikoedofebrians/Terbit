//
//  MyRoutineView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//
import SwiftUI
import Foundation

struct MyRoutineView: View {
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    
//    @Environment(\.modelContext) private var modelContext
//    @StateObject private var viewModel = MyRoutineViewModel()
    
    var body: some View {
        Form {
            ScheduleCompView()
            TodayCompView()
            BeginRoutineCompView()
        }
        .navigationTitle("My Routine")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    myRoutineRouter.push(.editRoutineView)
                } label: {
                    Text("Manage Routine")
                }
                
            }
        }
//        .onAppear {
//            viewModel.setContext(modelContext)
//        }
    }
}

//#Preview {
//    let config = ModelConfiguration(isStoredInMemoryOnly: true)
//    let container = try! ModelContainer(for: PreferenceModel.self, configurations: config)
//    let vm = MyRoutineViewModel(context: container.mainContext)
//    
//    return NavigationStack {
//        MyRoutineView(viewModel: vm)
//            .environment(RoutineStore())
//            .environment(MyRoutineRouter())
//            .modelContainer(container)
//    }
//}
