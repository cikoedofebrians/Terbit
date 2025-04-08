//
//  MorningActivity.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

import Foundation


struct MorningActivity: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let instructions: [String]
    let duration: Int
    let logoImage: String
    let images: [String]
    let instructionDurations: [Int]
}


