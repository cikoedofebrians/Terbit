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
    case hold(Bool)
    
    func getText() -> String {
        switch self {
        case .inhale:
            return "Breathe in"
        case .exhale:
            return "Breathe out"
        case .hold (let isInhale):
            return "Hold"
        }
    }
}

struct BreathingGuideCompView: View {
    @State var isScaled: Bool = false
    let breathingStates: [BreathingState] = [.inhale, .hold(true), .exhale, .hold(false)]
    @State var breathingStateIndex: Int = 0
    
    func moveToNextState() {
        if breathingStateIndex < breathingStates.count - 1 {
            breathingStateIndex += 1
        } else {
            breathingStateIndex = 0
        }
        switch breathingStates[breathingStateIndex] {
        case .inhale:
            withAnimation (.easeInOut(duration: 4)) {
                isScaled = true
            }
        case .hold(let _):
        case .exhale:
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
            .overlay {
//                Text(breathingState.getText())
//                    .font(.title2)
            }
            .onAppear {
                //                startBreathingTimer()
            }
    }
    
}

#Preview {
    BreathingGuideCompView()
}
