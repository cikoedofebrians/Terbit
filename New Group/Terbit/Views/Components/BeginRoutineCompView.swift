//
//  BeginRoutineCompView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 05/04/25.
//


import SwiftUI

public struct BeginRoutineCompView: View {
    
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    
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
        }
        .listSectionSpacing(24)
    }
}
