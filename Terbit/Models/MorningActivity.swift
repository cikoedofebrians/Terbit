//
//  MorningActivity.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

import Foundation


struct MorningActivity: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let instructions: [String]
    let duration: Int
    
//    var durationString: String {
//        let formatter = DateComponentsFormatter()
//        formatter.unitsStyle = .abbreviated
//        formatter.allowedUnits = [.hour, .minute]
//        return formatter.string(from: duration * 60) ?? "\(duration) min"
//    }
}


