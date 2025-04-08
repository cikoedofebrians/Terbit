//
//  ScheduleModel.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 08/04/25.
//



import SwiftData
import Foundation

@Model
class ScheduleModel {
    var hour: Date
    var daysRaw: String

    init(hour: Date, days: [String]) {
        self.hour = hour
        self.daysRaw = days.joined(separator: ", ")
    }

    var days: [String] {
        get {
            daysRaw.components(separatedBy: ", ").filter { !$0.isEmpty }
        }
        set {
            daysRaw = newValue.joined(separator: ", ")
        }
    }
}
