//
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
    var repeatCount: Int
    var detailsImage: String
    
    init(title: String, desc: String, instructions: [String], duration: Int, logoImage: String, images: [String], instructionDurations: [Int], repeatCount: Int = 1, detailsImage: String) {
        self.title = title
        self.desc = desc
        self.instructionsString = instructions.joined(separator: "|||")
        self.duration = duration
        self.logoImage = logoImage
        self.imagesString = images.joined(separator: "|||")
        self.instructionDurationsString = instructionDurations.map(String.init).joined(separator: ",")
        self.repeatCount = repeatCount
        self.detailsImage = detailsImage
    }

    var instructionsWithRepeatCount: [String] {
        var result: [String] = []
        for _ in 0..<repeatCount {
            result.append(contentsOf: instructions)
        }
        return result
    }
    
    var durationsWithRepeatCount: [Int] {
        var result: [Int] = []
        for _ in 0..<repeatCount {
            result.append(contentsOf: instructionDurations)
        }
        return result
    }
    
    var imagesWithRepeatCount: [String] {
        var result: [String] = []
        for _ in 0..<repeatCount {
            result.append(contentsOf: images)
        }
        
        return result
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
