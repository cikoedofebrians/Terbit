//
//  EditRoutineView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

struct EditRoutineView: View {
    
    @Environment(AppRouter.self) var appRouter
    @Environment(RoutineStore.self) var routineStore
    
    var body: some View {
        Form {
            ForEach(Array(routineStore.selectedActivities.enumerated()), id: \.0) { idx, routineActivity in
                Button {
                    appRouter.push(.activityDetailsView(.viewOnly(routineActivity.activity)))
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
                        appRouter.push(.activityListView(.replace(1)))
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                    }
                    .tint(.green)
                    
                    Button {
                        withAnimation {
                            routineStore.removeActivityAt(index: idx)
                        }
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    .tint(.red)
                    
                    
                }
                
            }
           
        }
        .navigationTitle("Manage Routine")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    appRouter.push(.activityListView(.add))
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
        
            .environment(AppRouter())
            .environment(RoutineStore())
    }
}
