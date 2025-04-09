//
//  BeginRoutineCompView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 05/04/25.
//


import SwiftUI

public struct BeginRoutineCompView: View {
    
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    
    public var body: some View {
        Section {
            Button {
                myRoutineRouter.push(.routineGuideView)
                
            } label: {
                Text("Begin Routine")
            }
            .gesture(DragGesture(minimumDistance: 0))
            .listRowInsets(EdgeInsets())
            .buttonStyle(ListButtonStyle())
            .disabled(routineStore.selectedActivities.isEmpty)
        }
        .listSectionSpacing(24)
    }
}


#Preview {
    List {
        BeginRoutineCompView()
    }
    .environment(MyRoutineRouter())
    .environment(RoutineStore(dataService: .shared))
}
