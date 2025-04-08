//
//  MorningActivity.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

import Foundation
import SwiftData

//
//struct MorningActivity: Identifiable, Hashable {
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
    var instructions: [String]
    var duration: Int
    var logoImage: String
    var images: [String]
    var instructionDurations: [Int]

    init(title: String, desc: String, instructions: [String], duration: Int, logoImage: String, images: [String], instructionDurations: [Int]) {
        self.title = title
        self.desc = desc
        self.instructions = instructions
        self.duration = duration
        self.logoImage = logoImage
        self.images = images
        self.instructionDurations = instructionDurations
    }
}
