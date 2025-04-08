//
//  TestSoundEffect.swift
//  Terbit
//
//  Created by Syaoki Biek on 07/04/25.
//

import SwiftUI
import AudioToolbox

struct TestSoundEffect: View {
    var body: some View {
        Button (action: {
            AudioServicesPlaySystemSound(1101)
        }){
            Text("Play Audio")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }

    }
}

#Preview {
    TestSoundEffect()
}
