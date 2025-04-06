//
//  SelectDayViewModel.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 06/04/25.
//

import Foundation
import SwiftData

@MainActor
class SelectDayViewModel: ObservableObject {
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
    
    func getInitialDays() -> [String] {
        return preference?.days ?? []
    }

    func updateDays(_ days: [String]) {
        if let pref = preference {
            pref.days = days
        } else {
            let newPref = PreferenceModel(hour: Date(), days: days)
            context.insert(newPref)
            preference = newPref
        }
        try? context.save()
    }
}
