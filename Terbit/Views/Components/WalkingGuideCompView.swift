//
//  WalkingGuideCompView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 08/04/25.
//

import SwiftUI

struct WalkingGuideCompView: View {
    var body: some View {
        Image(systemName: "figure.walk")
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.width * 0.6)
            
    }
}


#Preview {
    WalkingGuideCompView()
}
