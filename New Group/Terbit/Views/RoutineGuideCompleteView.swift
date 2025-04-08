//
//  RoutineGuideCompleteView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 26/03/25.
//

import SwiftUI

struct RoutineGuideCompleteView: View {
    @Environment(MyRoutineRouter.self) var myRoutineRouter
    var body: some View {
        VStack (spacing:0){
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 160))
                .foregroundStyle(.green)
            
            Text("Congratulations!\nYou have completed the routine")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top, 24)
            Text("You extended your streak to 3 days!🔥")
                .font(.subheadline)
                .padding(.top, 8)
            
            
            Button {
                myRoutineRouter.popToRoot()
            } label: {
                Text("Done")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 64)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                    )
            }
            .padding(.top, 36)

        }
        .navigationTitle("Routine Guide")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        RoutineGuideCompleteView()
            .environment(MyRoutineRouter())
    }
}
