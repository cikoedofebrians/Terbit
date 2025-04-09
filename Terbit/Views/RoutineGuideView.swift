//
//  RoutineGuideView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 26/03/25.
//
import SwiftUI
import AudioToolbox

struct RoutineGuideView: View {
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    @Environment(RoutineStore.self) var routineStore
    
    @State private var isGuidingActive = false
    @State private var timeRemaining = 5
    @State private var currentActivityIndex: Int = 0
    @State private var nextActivityIndex: Int = 0
    @State private var timer: Timer?
    
    var selectedActivities: [RoutineModel] {
        routineStore.selectedActivities
    }
    
    func startTimer() {
        currentActivityIndex = nextActivityIndex
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if (timeRemaining == 0) {
                withAnimation {
                    isGuidingActive.toggle()
                    nextActivityIndex += 1
                    timeRemaining = 5
                    timer.invalidate()
                }
            } else {
                AudioServicesPlaySystemSound(1159) // countdown audio effect
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
                    Gauge(value: Double(timeRemaining), in: 0...5) {
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
                    Text(selectedActivities[nextActivityIndex].activity.title)
                        .font(.title)
                        .bold()
                    
                    HStack {
                        Image(systemName: "timer")
                        Text("\(selectedActivities[nextActivityIndex].activity.duration) min")
                    }
                    .font(.title3)
                    .foregroundStyle(.secondary)
                }
                .onAppear {
                    startTimer()
                    AudioServicesPlaySystemSound(1113) // audio effect
                }
                .onDisappear {
                    timer?.invalidate()
                    timer = nil
                }
            } else {
                ActivityGuideView(currentActivityIndex: $currentActivityIndex, isGuidingActive: $isGuidingActive, nextActivityIndex: $nextActivityIndex)
            }
        }
        .onAppear {
            myRoutineRouter.turnOffTabBar()
            routineStore.startNewHistory(startAt: .now)
        }
        .navigationTitle("Routine Guide")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RoutineGuideView()
            .environment(RoutineStore(dataService: .shared))
            .environment(MyRoutineRouter())
    }
    
}


struct ActivityGuideView: View {
    @Environment(RoutineStore.self) var routineStore
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    
    @Binding var currentActivityIndex: Int
    @Binding var isGuidingActive: Bool
    @Binding var nextActivityIndex: Int
    
    @State private var currentStepIndex: Int = 0
    @State private var timer: Timer?
    @State private var currentStepDuration = 0
    @State private var totalStepDuration = 0
    @State private var isComplete = false
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func startTimer() {
        currentStepDuration = routineStore.selectedActivities[currentActivityIndex].activity.instructionDurations[currentStepIndex]
        totalStepDuration = currentStepDuration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if (currentStepDuration == 0) {
                withAnimation {
                    if (currentStepIndex + 1 == routineStore.selectedActivities[currentActivityIndex].activity.instructions.count) {
                        invalidateTimer()
                        isComplete = true
                        AudioServicesPlaySystemSound(1025) // Completed audio effect
                        
                        let completedActivity = CompletedActivityModel(
                            activity: routineStore.selectedActivities[currentActivityIndex].activity,
                            isCompleted: true
                        )
                        routineStore.appendCompletedActivity(completedActivity: completedActivity)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                            withAnimation {
                            if (currentActivityIndex + 1 ==
                                routineStore.selectedActivities.count) {
                                myRoutineRouter.push(.routineGuideCompleteView)
                            } else {
                                    isGuidingActive = false
                                    nextActivityIndex += 1
                                }
                            }
                        })
                    } else {
                        AudioServicesPlaySystemSound(1113) // transition audio effect
                        currentStepIndex += 1
                        currentStepDuration = routineStore.selectedActivities[currentActivityIndex].activity.instructionDurations[currentStepIndex]
                        totalStepDuration = currentStepDuration
                    }
                }
            } else {
                withAnimation {
                    currentStepDuration -= 1
                }
                
            }
        }
    }
    
    var body: some View {
        VStack (spacing: 0) {
            Text(routineStore.selectedActivities[currentActivityIndex].activity.title)
                .font(.title)
                .bold()
            
            Image(routineStore.selectedActivities[currentActivityIndex].activity.images[currentStepIndex])
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.7)
                .padding(.vertical, 48)
            
            VStack {
                Text("\(routineStore.selectedActivities[currentActivityIndex].activity.instructions[currentStepIndex])...")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                
                ProgressView(value: Double(totalStepDuration-currentStepDuration)/Double(totalStepDuration))
                    .padding(.top, 16)
                
                HStack {
                    Text("Progress")
                    Spacer()
                    Text("\((totalStepDuration - currentStepDuration ).formatSecondsToTime())/\(totalStepDuration.formatSecondsToTime())")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
                HStack {
                    ForEach(Array(routineStore.selectedActivities[currentActivityIndex].activity.instructions.enumerated()), id: \.1) {
                        index, element in
                        Capsule()
                            .foregroundStyle(
                                index < currentStepIndex || isComplete ?
                                    .orange : .gray.opacity(0.3)
                            )
                            .frame(height: 4)
                    }
                    
                }
                .padding(.top, 8)
                HStack {
                    Text("Step")
                    Spacer()
                    Text("\(currentStepIndex)/\(routineStore.selectedActivities[currentActivityIndex].activity.instructions.count)")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 24)
            .onAppear {
                startTimer()
                AudioServicesPlaySystemSound(1113) // transition audio effect
            }.onDisappear {
                invalidateTimer()
            }
            
        }
    }
}

