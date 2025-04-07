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
    @State var breathingState: BreathingState = .inhale
    
    func startBreathingTimer() {
        startBreathing()
        Timer.scheduledTimer(withTimeInterval: 16, repeats: true) { timer in
            startBreathing()
        }
    }
    
    func startBreathing() {
        withAnimation {
            breathingState = .inhale
        }
        withAnimation(.easeInOut(duration: 4)) {
            isScaled = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation {
                breathingState = .hold
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            withAnimation {
                breathingState = .exhale
            }
            withAnimation(.easeInOut(duration: 4)) {
                isScaled = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            withAnimation {
                breathingState = .hold
            }
        }

    }
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 10)
            .frame(width: UIScreen.main.bounds.width * 0.5)
            .scaleEffect(isScaled ? 1.4 : 1)
            .overlay {
                Text(breathingState.getText())
                    .font(.title2)
            }
            .onAppear {
                startBreathingTimer()
            }
    }
}

#Preview {
    BreathingGuideCompView()
}
