//
//  EditRoutineView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

struct EditRoutineView: View {
    
    @State var editMode: EditMode = .inactive
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    
    var body: some View {
        List {
            ForEach(Array(routineStore.selectedActivities.enumerated()), id: \.1) { idx, routineActivity in
                Button {
                    if editMode == .inactive {
                        myRoutineRouter.push(.activityDetailsView(.viewOnly(routineActivity.activity)))
                    }
                    
                } label: {
                    HStack (spacing: 16){
                        Image(systemName: routineActivity.activity.logoImage)
                            .font(.system(size: 32))
                            .frame(width: 42, alignment: .center)
                            .padding(.trailing, 16)
                            .foregroundStyle(
                                LinearGradient(colors: [Color.red, Color.blue], startPoint: .leading, endPoint: .trailing)
                            )
                        VStack(alignment: .leading, spacing: 4) {
                            Text(routineActivity.activity.title)
                            HStack {
                                Image(systemName: "timer")
                                Text("\(routineActivity.activity.duration) min")
                            }
                            .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if !editMode.isEditing {
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                        
                    }
                    .tint(.primary)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button  (role: .destructive){
                        withAnimation {
                            routineStore.removeActivity(at: idx)
                        }
                        
                    } label: {
                        Image(systemName: "trash")
                            .foregroundStyle(.white)
                    }
                    .tint(.red)
                }
                .moveDisabled(!editMode.isEditing)
                
            }
            
            .onDelete { offsets in
                print(offsets)
            }
            .onMove { from, to in
                print(from)
                print(to)
            }
            
        }
        
        .environment(\.editMode, $editMode)
        .navigationTitle("Manage Routine")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 0) {
                    
                    Button {
                        withAnimation {
                            if editMode.isEditing {
                                editMode = .inactive
                            } else {
                                editMode = .active
                            }
                        }
                        
                    } label: {
                        Text(editMode.isEditing ? "Done" : "Edit")
                    }
                    .padding(.trailing, 8)
                    
                    
                    if !editMode.isEditing {
                        Button {
                            myRoutineRouter.push(.activityListView)
                        } label: {
                            Image(systemName: "plus")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(8)
                                .background {
                                    Circle()
                                        .fill(Color.accentColor)
                                }
                        }
                    }
                    
                    
                    
                    
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
