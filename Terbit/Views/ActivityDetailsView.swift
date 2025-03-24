//
//  ActivityDetailsView.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 24/03/25.
//

import SwiftUI

enum ActivityDetailsAction : Hashable {
    case add
    case replace(Int)
}

struct ActivityDetailsView: View {
    let activity: MorningActivity
    let action: ActivityDetailsAction?
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 0){
        
                Rectangle()
                    .frame(height: 240)
                    .foregroundStyle(.gray)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Image(systemName: "timer")
                        Text("\(activity.duration) mins")
                    }
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    HStack {
                        Text(activity.name)
                            .font(.title)
                            .bold()
                        Spacer()
                        if action != nil {
                            Button {
                                
                            } label: {
                                if action == ActivityDetailsAction.add {
                                    Text("Add")
                                }
                                if action == ActivityDetailsAction.replace(0) {
                                    Text("Replace")
                                }
                            }
                            .buttonBorderShape(.capsule)
                            .buttonStyle(.borderedProminent)
                        }
                     

                    }
                 
                    Text(activity.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                    Text("Instructions")
                        .font(.title2)
                        .bold()
                        .padding(.top, 16)
                    ForEach(Array(activity.instructions.enumerated()), id: \.offset) { idx, instruction in
                        Text("\(idx + 1). \(instruction)")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)

            }
            
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(activity.name)
        
    }
}

#Preview {
    NavigationStack {
        ActivityDetailsView(activity: constantMorningRoutine[1], action: nil)
    }
    
}
