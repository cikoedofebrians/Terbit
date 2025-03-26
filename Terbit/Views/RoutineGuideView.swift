//
//  RoutineGuideView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 26/03/25.
//

import SwiftUI

import SwiftUI

struct RoutineGuideView: View {
    @State private var isGuidingActive = false
    @State private var timeRemaining = 3
    @State private var currentActivityIndex: Int = 0
    @State private var nextActivityIndex: Int = 0
    
    
    @Environment(RoutineStore.self) var routineStore
    
    var selectedActivities:  [ActivityRoutine] {
        routineStore.selectedActivities
    }
    
    func startTimer() {
        currentActivityIndex = nextActivityIndex
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if (timeRemaining == 0) {
                withAnimation {
                    isGuidingActive.toggle()
                    nextActivityIndex += 1
                    timeRemaining = 3
                    timer.invalidate()
                }
                
            } else {
                withAnimation {
                    timeRemaining -= 1
                }
                
            }
            
        }
        
    }
    
    
    var body: some View {
        Group {
            if (!isGuidingActive) {
                VStack (spacing: 16){
                    Gauge(value: Double(timeRemaining), in: 0...3) {
                        Text("\(timeRemaining)")
                            .monospaced()
                    }
                    .padding(.top, 128)
                    .scaleEffect(4, anchor: .bottom)
                    .gaugeStyle(.accessoryCircularCapacity)
                    .tint(.blue)
                    
                    Text("Next Activity:")
                        .font(.headline)
                        .padding(.top, 32)
                    Text(selectedActivities[nextActivityIndex].activity.name)
                        .font(.title)
                        .bold()
                    
                    HStack {
                        Image(systemName: "timer")
                        Text("\(selectedActivities[nextActivityIndex].activity.duration) min")
                    }
                    .font(.title3)
                    .foregroundStyle(.secondary)
                }
                .task {
                    startTimer()
                }
            } else {
                ActivityGuideView(currentActivityIndex: $currentActivityIndex, isGuidingActive: $isGuidingActive, nextActivityIndex: $nextActivityIndex)
            }
        }
        .navigationTitle("Routine Guide")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationStack {
        RoutineGuideView()
            .environment(RoutineStore())
            .environment(AppRouter())
    }
    
}


struct ActivityGuideView: View {
    @Environment(RoutineStore.self) var routineStore
    @Environment(AppRouter.self) var appRouter
    
    @Binding var currentActivityIndex: Int
    @Binding var isGuidingActive: Bool
    @Binding var nextActivityIndex: Int
    
    @State var currentStepIndex: Int = 0
    @State var timeRemaining: Int = 4
    
    func startTimer() {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining > 0 {
                withAnimation {
                    self.timeRemaining -= 1
                }
            } else {
                self.timeRemaining = 4
                if (currentStepIndex == routineStore.selectedActivities[currentActivityIndex].activity.instructions.count - 1) {
                    timer.invalidate()
                    if (nextActivityIndex < routineStore.selectedActivities.count) {
                        withAnimation {
                            isGuidingActive.toggle()
                        }
                    } else {
                        appRouter.push(.routineGuideCompleteView)
                    }
                 
                } else {
                    withAnimation {
                        currentStepIndex += 1
                    }
                }
                
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(routineStore.selectedActivities[currentActivityIndex].activity.name)
                .font(.title)
                .bold()
            Rectangle()
                .frame(width: 240, height: 240)
                .foregroundStyle(.gray)
            
            VStack {
                Text("\(routineStore.selectedActivities[currentActivityIndex].activity.instructions[currentStepIndex])...")
                    .font(.title3)
                
                ProgressView(value: Double(Double(4-timeRemaining)/Double(4)))
                    .padding(.top, 16)
                
                HStack {
                    Text("Progress")
                    Spacer()
                    Text("00:0\(4-timeRemaining)/00:04")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
                HStack {
                    ForEach(Array(routineStore.selectedActivities[currentActivityIndex].activity.instructions.enumerated()), id: \.1) {
                        index, element in
                        Capsule()
                            .foregroundStyle(
                                index <= currentStepIndex ?
                                    .orange : .secondary
                            )
                            .frame(height: 4)
                    }
                    
                }
                .padding(.top, 8)
                HStack {
                    Text("Step")
                    Spacer()
                    Text("\(currentStepIndex+1)/\(routineStore.selectedActivities[currentActivityIndex].activity.instructions.count)")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.top, 32)
            .padding(.horizontal, 24)
            .task {
                startTimer()
            }
            
        }
    }
}

