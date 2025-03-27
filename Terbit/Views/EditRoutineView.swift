//
//  EditRoutineView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

struct EditRoutineView: View {
    
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    
    var body: some View {
        Form {
            ForEach(Array(routineStore.selectedActivities.enumerated()), id: \.1) { idx, routineActivity in
                Button {
                    myRoutineRouter.push(.activityDetailsView(.viewOnly(routineActivity.activity)))
                } label: {
                    HStack (spacing: 16){
                        Rectangle()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(.gray.opacity(0.5))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(routineActivity.activity.name)
                            HStack {
                                Image(systemName: "timer")
                                Text("\(routineActivity.activity.duration) min")
                            }
                            .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .tint(.primary)
                }
                .swipeActions(edge: .trailing) {
                    Button {
                        myRoutineRouter.push(.activityListView(.replace(idx)))
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                    }
                    .tint(.green)
                    
                    Button (role: .destructive){
                        withAnimation {
                            if let index = routineStore.selectedActivities.firstIndex(where: { $0.activity.id == routineActivity.activity.id }) {
                                routineStore.removeActivityAt(index: index)
                                print(index)
                            }
                            
                        }
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    .tint(.red)
                    
                    
                }
            }
            .onMove { from, to in
                print(from)
                print(to)
            }
            
        }
        .navigationTitle("Manage Routine")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    myRoutineRouter.push(.activityListView(.add))
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditRoutineView()
            .environment(MyRoutineRouter())
            .environment(RoutineStore())
    }
}
