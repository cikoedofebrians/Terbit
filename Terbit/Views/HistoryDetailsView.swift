//
//  HistoryDetails.swift
//  Terbit
//
//  Created by Syaoki Biek on 26/03/25.
//

import SwiftUI

struct HistoryDetailsView: View {
    @State var durationPerActivity: Int = 3
    @State var numberOfActivity: Int = 4

    
    var body: some View {
        List {
            // Section for activities
            Section(header :
                Text("mon, 26/3/2025")
                .font(.subheadline)
            ) {
                ForEach(Array(0..<numberOfActivity), id: \.self) { _ in
                    HStack {
                        
                        // Icon
                        Rectangle().frame(width: 44, height: 44).foregroundColor(.gray)
                        
                        // Name and Duration
                        VStack (alignment: .leading){
                            Text("Activity Name")
                            Text("\(durationPerActivity) mins")
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        // Status Checkmark
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.green)
                    }
                }
            }
            
            // Section for Information
            Section(header:
                Text("INFORMATION")
                .font(.subheadline)
                .foregroundStyle(.primary)
                
            ) {
                
                // Status
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    Text("Status")
                    .padding(.leading)
                    
                    Spacer()
                    Text("Completed")
                }
                
                    
                // Time
                HStack {
                    Image(systemName: "alarm")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    Text("Time")
                    .padding(.leading)
                    
                    Spacer()
                    Text("10:00 - 10:10")
                }
                
                // Duration
                HStack {
                    Image(systemName: "timer")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    Text("Duration")
                    .padding(.leading)
                    
                    Spacer()
                    Text("\(durationPerActivity * numberOfActivity) mins")
                    
                }
            }
            .listRowBackground(Color.clear)
            
        }
        
        .navigationTitle("Activities")
        
    }
}

#Preview {
    NavigationStack {
        HistoryDetailsView()
            .environment(RoutineStore(dataService: .shared))
            .environment(MyRoutineRouter())
    }
}
