//
//  Activity.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 05/04/25.
//
import SwiftData
import Foundation

@Model
class ActivityModel: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var desc: String
    var instructions: [String]
    var duration: Int

    init(name: String, duration: Int, description: String, instructions: [String]) {
        self.name = name
        self.duration = duration
        self.desc = description
        self.instructions = instructions
    }
}
