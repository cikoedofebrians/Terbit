//
//  ActivityList.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

import SwiftUI

enum ActivityListType: Equatable, Hashable {
    case add
    case replace(Int)
}

struct ActivityList: View {
    let activityListType: ActivityListType
    
    @Environment(AppRouter.self) var appRouter
    var body: some View {
        List {
            ForEach(constantMorningRoutine, id: \.self) { activity in
                Button {
                    switch activityListType {
                    case .add:
                        appRouter.push(.activityDetailsView(ActivityDetailsType.add(activity)))
                    case .replace(let idx):
                        appRouter.push(.activityDetailsView(ActivityDetailsType.replace(activity, idx)))
                    }
                } label: {
                    HStack (spacing: 0) {
                        Rectangle()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(.gray.opacity(0.3))
                            .padding(.trailing, 16)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(activity.name)
                            HStack {
                                Image(systemName: "timer")
                                Text("\(activity.duration) min")
                            }
                            .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button {
                            
                        } label: {
                            Text(activityListType == ActivityListType.add ? "Add" : "Replace" )
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                        .tint(.accentColor)

                    }
                }
                .tint(.primary)

            }
        }
        .navigationTitle("Activity List")
    }
}

#Preview {
    NavigationStack {
        ActivityList(activityListType: .add)
            .environment(AppRouter())
    }
}
