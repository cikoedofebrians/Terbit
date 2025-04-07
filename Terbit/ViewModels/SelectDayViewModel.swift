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
    @Published var selectedDays: [String] = []

    private var context: ModelContext?

    init() {}
    
    func setContext(_ context: ModelContext) {
            self.context = context
            loadPreference()
        }

    func loadPreference() {
            guard let context else { return }
            let descriptor = FetchDescriptor<PreferenceModel>()
            if let result = try? context.fetch(descriptor).first {
                self.preference = result
                self.selectedDays = result.days
            }
        }
    
    func toggleDay(_ day: String) {
            if selectedDays.contains(day) {
                selectedDays.removeAll { $0 == day }
            } else {
                selectedDays.append(day)
            }
            updateDays()
        }

    private func updateDays() {
            guard let context else { return }

            if let pref = preference {
                pref.days = selectedDays
            } else {
                let newPref = PreferenceModel(hour: Date(), days: selectedDays)
                context.insert(newPref)
                preference = newPref
            }

            try? context.save()
        }
}
