//
//  Activity.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 05/04/25.
//
import SwiftData
import Foundation

@Model
class ActivityModel {
    var name: String
    var desc: String
    var instructions: [String]
    var duration: Int

    init(name: String, desc: String, instructions: [String], duration: Int) {
        self.name = name
        self.desc = desc
        self.instructions = instructions
        self.duration = duration
    }
}
