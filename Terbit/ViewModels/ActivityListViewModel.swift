//
//  ActivityListViewModel.swift
//  Terbit
//
//  Created by Umar Abdul Azis on 06/04/25.
//
import Foundation
import SwiftData

class ActivityViewModel: ObservableObject {
    @Published var activities: [ActivityModel] = []

    private var context: ModelContext?

    func setContext(_ context: ModelContext) {
        self.context = context
        fetchActivities()
    }

    func fetchActivities() {
        guard let context else { return }
        let descriptor = FetchDescriptor<ActivityModel>(
            sortBy: [SortDescriptor(\.name)]
        )

        do {
            self.activities = try context.fetch(descriptor)
        } catch {
            print("❌ Error fetching activities: \(error)")
        }
    }
}
