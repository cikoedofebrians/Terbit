//  ActivityModel.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

import Foundation
import SwiftData

//
//struct ActivityModel: Identifiable, Hashable {
//    let id = UUID()
//    let title: String
//    let description: String
//    let instructions: [String]
//    let duration: Int
//}

@Model
class ActivityModel {
    var title: String
    var desc: String
    var instructionsString: String
    var duration: Int
    var logoImage: String
    var imagesString: String
    var instructionDurationsString: String
    
    init(title: String, desc: String, instructions: [String], duration: Int, logoImage: String, images: [String], instructionDurations: [Int]) {
        self.title = title
        self.desc = desc
        self.instructionsString = instructions.joined(separator: "|||")
        self.duration = duration
        self.logoImage = logoImage
        self.imagesString = images.joined(separator: "|||")
        self.instructionDurationsString = instructionDurations.map(String.init).joined(separator: ",")
    }
    
    
    var instructions: [String] {
        instructionsString.split(separator: "|||").map { String($0) }
    }
    
    var images: [String] {
        imagesString.split(separator: "|||").map { String($0) }
    }
    
    var instructionDurations: [Int] {
        instructionDurationsString.split(separator: ",").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
    }
}
