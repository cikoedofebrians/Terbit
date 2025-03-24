//
//  TerbitTabBarView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

struct TerbitTabBarView: View {
    var body: some View {
        TabView {
            Tab("My Routine", systemImage: "sunrise.fill") {
                NavigationStack {
                    MyRoutineView()
                }
            }
            Tab("History", systemImage: "clock") {
                NavigationStack {
                    Text("History Page")
                }
            }
        }
    }
}

#Preview {
    TerbitTabBarView()
        .environment(AppRouter())
    
}
