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
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = MyRoutineViewModel()
    
    var body: some View {
        Form {
            Section("Schedule") {
                HStack {
                    DatePicker("Hour", selection: $viewModel.hour, displayedComponents: .hourAndMinute)
                        .onChange(of: viewModel.hour) { _, newValue in
                            viewModel.updateHour(newValue)
                    }
                }
                Button {
                    myRoutineRouter.push(.selectDayView)
                } label: {
                    HStack {
                        Text("Repeat")
                        Spacer()
                        Group {
                            
                            Text(viewModel.preference?.days.isEmpty ?? true ?
                                 "Never" :
                                 viewModel.preference?.days.count == constantDays.count ?
                                 "Every day" :
                                 viewModel.preference?.days.map({ String($0.prefix(3)) }).joined(separator: ", ") ?? "")
                            Image(systemName: "chevron.right")
                        }                    .foregroundStyle(.secondary)
                    }
                }
                .tint(.primary)
            }
            
            Section ("Today Activity (🔥 2 DAYS STREAK)"){
                HStack {
                    Text("Total Duration")
                    Spacer()
                    HStack {
                        Image(systemName: "timer")
                        Text("\(viewModel.getTotalDuration()) min")
                    }
                    .foregroundStyle(.secondary)
                }
                
                ForEach(viewModel.selectedActivities, id: \.self) { routineActivity in
                    Button {
//                        myRoutineRouter.push(.activityDetailsView(.viewOnly(routineActivity.activity)))
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
            Section ("ACTIONS") {
                Button {
                    myRoutineRouter.push(.routineGuideView)
                } label: {
                    Text("Start")
                }
                .disabled(viewModel.selectedActivities.isEmpty)
            }
        }
        .navigationTitle("My Routine")
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    myRoutineRouter.push(.editRoutineView)
                } label: {
                    Image(systemName: "pencil")
                }
                
            }
        }
        .onAppear {
            viewModel.setContext(modelContext)
        }
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
