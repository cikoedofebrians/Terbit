//  ScheduleModel.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 08/04/25.
//

import SwiftData
import Foundation

@Model
class ScheduleModel {
    @Attribute var hour: Date
    @Attribute var daysString: String
    @Attribute var maxDuration: Int

    init(hour: Date, days: [Int], maxDuration: Int) {
        self.hour = hour
        self.daysString = days.map(String.init).joined(separator: ",")
        self.maxDuration = maxDuration
    }

    var days: [Int] {
        daysString.split(separator: ",").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
    }
    
    func toggleDay(_ day: Int) {
        if days.contains(day) {
            daysString = days.filter { $0 != day }.map(String.init).joined(separator: ",")
        } else {
            daysString += ",\(day)"
        }
    }
}
