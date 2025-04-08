//
//  IntExtension.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 08/04/25.
//

import Foundation


extension Int {
    func formatSecondsToTime() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

}
