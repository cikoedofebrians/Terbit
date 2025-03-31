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
                    GeometryReader { proxy in
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
                                .font(.caption)
                                .fontWeight(.semibold)
                                .padding(.vertical, 6)
                                .foregroundStyle(.white)
                                .frame(width: proxy.size.width)
                                .background {
                                    Capsule()
                                        .fill(Color.accentColor)
                                }
                        }
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

                                .padding(6)
                                .background {
                                    Circle()
                                        .fill(Color.accentColor)
                                }
                        }
                    }
                   
    


                }
                .frame(width: 100)
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
