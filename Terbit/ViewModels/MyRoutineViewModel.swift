//
//  MyRoutineViewModel.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 06/04/25.
//

import Foundation
import SwiftData

@MainActor
class MyRoutineViewModel: ObservableObject {
    @Published var preference: PreferenceModel?

    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        loadPreference()
    }

    func loadPreference() {
        let descriptor = FetchDescriptor<PreferenceModel>()
        if let result = try? context.fetch(descriptor).first {
            self.preference = result
        }
    }
    
    func getInitialHour() -> Date {
        return preference?.hour ?? Date()
    }

    func updateHour(_ hour: Date) {
        if let pref = preference {
            pref.hour = hour
        } else {
            let newPref = PreferenceModel(hour: hour, days: [])
            context.insert(newPref)
            preference = newPref
        }
        try? context.save()
    }
}
