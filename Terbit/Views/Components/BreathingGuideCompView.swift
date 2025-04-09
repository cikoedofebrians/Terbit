//
//  BreathingGuideCompView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 07/04/25.
//

import SwiftUI


enum BreathingState {
    case inhale
    case exhale
    case hold
    
    func getText() -> String {
        switch self {
        case .inhale:
            return "Breathe in"
        case .exhale:
            return "Breathe out"
        case .hold:
            return "Hold"
        }
    }
}

struct BreathingGuideCompView: View {
    @State var isScaled: Bool = false
    let breathingStates: [BreathingState] = [.inhale, .hold, .exhale]
    @Binding var breathingStepIndex: Int
    @State var breathingStateIndex: Int = 2
    @State var breathingText: String = ""
    
    public func moveToNextState() {
        if breathingStateIndex < breathingStates.count - 1 {
            breathingStateIndex += 1
        } else {
            breathingStateIndex = 0
        }
        
        switch breathingStates[breathingStateIndex] {
        case .inhale:
            withAnimation {
                breathingText = "Breathe in"
            }
            withAnimation (.easeInOut(duration: 4)) {
                isScaled = true
            }
        case .hold:
            withAnimation {
                breathingText = "Hold"
            }
        case .exhale:
            withAnimation {
                breathingText = "Breathe out"
            }
            withAnimation (.easeInOut(duration: 8)) {
                isScaled = false
            }
        }
    }
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 10)
            .frame(width: UIScreen.main.bounds.width * 0.5)
            .scaleEffect(isScaled ? 1.4 : 1)
            .padding(.vertical, 24)
            .overlay {
                Text(breathingText)
                    .font(.title2)
            }
            .onChange(of: breathingStepIndex) { oldValue, newValue in
                moveToNextState()
            }
            .onAppear {
                moveToNextState()
            }
    }
    
}

#Preview {
    BreathingGuideCompView(breathingStepIndex: .constant(0))
}
